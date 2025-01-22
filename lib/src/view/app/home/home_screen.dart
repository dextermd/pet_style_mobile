import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/blocs/faq/faq_bloc.dart';
import 'package:pet_style_mobile/blocs/promotion/promotion_bloc.dart';
import 'package:pet_style_mobile/blocs/schedule/schedule_bloc.dart';
import 'package:pet_style_mobile/blocs/service/service_bloc.dart';
import 'package:pet_style_mobile/blocs/user/user_bloc.dart';
import 'package:pet_style_mobile/core/helpers/date_time_helper.dart';
import 'package:pet_style_mobile/core/services/firebase_messaging_services.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/view/app/home/widgets/appointment_card.dart';
import 'package:pet_style_mobile/src/view/app/home/widgets/exp_tile.dart';
import 'package:pet_style_mobile/src/view/app/home/widgets/home_title.dart';
import 'package:pet_style_mobile/src/view/app/home/widgets/pet_card.dart';
import 'package:pet_style_mobile/src/view/app/home/widgets/promo_card.dart';
import 'package:pet_style_mobile/src/view/router/app_routes.dart';
import 'package:pet_style_mobile/src/view/widget/base_container.dart';
import 'package:pet_style_mobile/src/view/widget/custom_sliver_appbar.dart';
import 'package:pet_style_mobile/src/view/widget/error_loading_text.dart';
import 'package:pet_style_mobile/src/view/widget/price_info_dialog.dart';
import 'package:pet_style_mobile/src/view/widget/t_rounded_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseMessagingServices _firebaseMessagingServices;
  bool _showFullServiceList = false;
  bool _showFullFaqList = false;

  @override
  void initState() {
    _firebaseMessagingServices = GetIt.I<FirebaseMessagingServices>();
    context.read<UserBloc>().add(const FetchUserData());
    context.read<ServiceBloc>().add(ServiceFetchEvent());
    context.read<PromotionBloc>().add(PromotionFetchEvent());
    context.read<FaqBloc>().add(FaqFetchEvent());
    _firebaseMessagingServices.requestPermission();

    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    return BlocBuilder<UserBloc, UserState>(
      buildWhen: (previous, current) {
        if (current is UpdateUserDataError ||
            current is UpdateImageError ||
            current is UserUpdated ||
            current is ImageUpdated) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Что-то пошло не так',
                  style: const TextStyle(color: AppColors.primaryText)
                      .copyWith(fontSize: 16),
                ),
                Text(
                  'Попробуйте чуть позже',
                  style: const TextStyle(color: AppColors.primaryText)
                      .copyWith(fontSize: 10),
                ),
                const SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                  onPressed: () async {
                    final completer = Completer();
                    BlocProvider.of<UserBloc>(context).add(
                      FetchUserData(completer: completer),
                    );
                    return completer.future;
                  },
                  child: const Text(
                    'Повторить попытку',
                  ),
                ),
              ],
            ),
          );
        }
        if (state is UserLoaded) {
          return CustomScrollView(
            slivers: [
              CustomSliverAppbar(user: state.user),
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  final userDataCompleter = Completer();
                  final sheduleDataCompleter = Completer();

                  context
                      .read<UserBloc>()
                      .add(FetchUserData(completer: userDataCompleter));

                  context
                      .read<ScheduleBloc>()
                      .add(ScheduleLoad(completer: sheduleDataCompleter));
                },
              ),
              const SliverPadding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                sliver: SliverToBoxAdapter(
                  child: AppointmentCard(
                    title: 'Запись на стрижку',
                    subtitle:
                        'Кишинёв, Рышкановка, улица Богдана Воевода 2, подъезд 7.',
                    imageRight: Image(
                      image: AssetImage('assets/images/pet2.png'),
                      height: 100,
                      width: 100,
                    ),
                    imageLeft: Image(
                      image: AssetImage('assets/images/paw-print.png'),
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: HomeTitle(
                  title: 'Мои питомцы',
                  icon: Icon(
                    Icons.pets,
                    color: AppColors.primaryElement,
                    size: 24,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.pets.length + 1,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 16,
                    ),
                    itemBuilder: (context, index) {
                      if (index == state.pets.length) {
                        return const AddPetCard();
                      } else {
                        return PetCard(
                          width: 300,
                          id: state.pets[index].id ?? '0',
                          name: state.pets[index].name ?? '',
                          photo: state.pets[index].photo ?? '',
                          breed: state.pets[index].breed ?? '',
                          age: DateTimeHelper.getAge(
                              state.pets[index].birthDate ?? DateTime.now()),
                          isNetworkImage: true,
                        );
                      }
                    },
                  ),
                ),
              ),
              BlocBuilder<ScheduleBloc, ScheduleState>(
                builder: (context, state) {
                  if (state is ScheduleLoaded) {
                    if (state.active.isNotEmpty) {
                      return SliverToBoxAdapter(
                        child: Column(
                          children: [
                            HomeTitle(
                              title: 'Предстоящие записи',
                              icon: Icon(
                                Icons.schedule,
                                color: AppColors.primaryElement,
                                size: 24,
                              ),
                            ),
                            SizedBox(
                              height: 120,
                              child: ListView.separated(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.active.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 16,
                                ),
                                itemBuilder: (context, index) {
                                  return BaseContainer(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Row(
                                      children: [
                                        TRoundedContainer(
                                          backgroundColor: AppColors
                                              .containerColor
                                              .withAlpha(75),
                                          width: 100,
                                          height: 100,
                                          radius: 10,
                                          margin: const EdgeInsets.all(10),
                                          child: Center(
                                            child: Text.rich(
                                              textAlign: TextAlign.center,
                                              TextSpan(
                                                text:
                                                    '${DateTimeHelper.getDay(state.active[index].appointmentDate!)}\n',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: AppColors.primaryIcon,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: DateTimeHelper
                                                        .getMonthName(
                                                      state.active[index]
                                                          .appointmentDate!,
                                                      'ru',
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          AppColors.primaryIcon,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.active[index].pet?.name ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Время: ${DateTimeHelper.getFormattedTime(state.active[index].appointmentDate!)}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.primaryElement,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Мастер: Катя',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.primaryElement,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                  return SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
              BlocBuilder<ServiceBloc, ServiceState>(
                builder: (context, state) {
                  if (state is ServiceLoaded && state.services.isNotEmpty) {
                    final visibleCount =
                        _showFullServiceList ? state.services.length : 5;
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          HomeTitle(
                            title: 'Цены на услуги',
                            icon: Icon(
                              Icons.attach_money,
                              color: AppColors.primaryElement,
                              size: 24,
                            ),
                          ),
                          // иконка с вопросом и текст для нажатия на нее и открытия диалога с информацией о ценах
                          IconButton(
                              onPressed: () {
                                showPriceInfoDialog(context);
                              },
                              icon: Icon(
                                Icons.help,
                                color: AppColors.primaryElement,
                              )),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: visibleCount,
                              itemBuilder: (context, index) {
                                final service = state.services[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        locale == 'ru'
                                            ? service.nameRu ?? 'Без названия'
                                            : service.nameRo ?? 'Без названия',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.primaryText,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Expanded(
                                          child: Text('.' * 50, maxLines: 1)),
                                      Text(
                                        '${service.price ?? '---'} MDL',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryElement,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          if (state.services.length > 3)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _showFullServiceList = !_showFullServiceList;
                                });
                              },
                              child: Text(
                                _showFullServiceList
                                    ? 'Свернуть'
                                    : 'Показать все',
                                style: TextStyle(
                                  color: AppColors.primaryElement,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                  return SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
              BlocBuilder<PromotionBloc, PromotionState>(
                builder: (context, state) {
                  if (state is PromotionLoaded && state.promotions.isNotEmpty) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          HomeTitle(
                            title: 'Акции и скидки',
                            icon: Icon(
                              Icons.local_offer,
                              color: AppColors.primaryElement,
                              size: 24,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: state.promotions.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return PromoCard(
                                  promo: state.promotions[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
              BlocBuilder<FaqBloc, FaqState>(
                builder: (context, state) {
                  if (state is FaqLoaded && state.faqs.isNotEmpty) {
                    final visibleCount =
                        _showFullFaqList ? state.faqs.length : 3;

                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          HomeTitle(
                            title: 'Вопросы и ответы',
                            icon: Icon(
                              Icons.help,
                              color: AppColors.primaryElement,
                              size: 24,
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: visibleCount,
                            itemBuilder: (context, index) {
                              return ExpTile(
                                title: locale == 'ru'
                                    ? state.faqs[index].questionRu ?? ''
                                    : state.faqs[index].questionRo ?? '',
                                text: locale == 'ru'
                                    ? state.faqs[index].answerRu ?? ''
                                    : state.faqs[index].answerRo ?? '',
                              );
                            },
                          ),
                          if (state.faqs.length > 3)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _showFullFaqList = !_showFullFaqList;
                                });
                              },
                              child: Text(
                                _showFullFaqList ? 'Свернуть' : 'Показать все',
                                style: TextStyle(
                                  color: AppColors.primaryElement,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                  return SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
            ],
          );
        }
        return ErrorLoadingText(
          onRetry: () {
            final completer = Completer();
            context.goNamed(AppRoutes.home);
            context.read<UserBloc>().add(FetchUserData(completer: completer));
          },
        );
      },
    );
  }
}
