import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/blocs/service/service_bloc.dart';
import 'package:pet_style_mobile/blocs/user/user_bloc.dart';
import 'package:pet_style_mobile/core/helpers/date_time_helper.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/core/services/firebase_messaging_services.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/view/app/home/widgets/appointment_card.dart';
import 'package:pet_style_mobile/src/view/app/home/widgets/home_title.dart';
import 'package:pet_style_mobile/src/view/app/home/widgets/pet_card.dart';
import 'package:pet_style_mobile/src/view/router/app_routes.dart';
import 'package:pet_style_mobile/src/view/widget/base_container.dart';
import 'package:pet_style_mobile/src/view/widget/error_loading_text.dart';
import 'package:pet_style_mobile/src/view/widget/t_rounded_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseMessagingServices _firebaseMessagingServices;
  bool _showFullServiceList = false;

  @override
  void initState() {
    _firebaseMessagingServices = GetIt.I<FirebaseMessagingServices>();
    context.read<UserBloc>().add(const FetchUserData());
    _firebaseMessagingServices.requestPermission();
    context.read<ServiceBloc>().add(ServiceFetchEvent());

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
                    BlocProvider.of<UserBloc>(context)
                        .add(FetchUserData(completer: completer));
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
              SliverAppBar(
                pinned: true,
                snap: true,
                floating: true,
                backgroundColor: AppColors.primarySecondElement,
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child:
                        state.user.image != null && state.user.image!.isNotEmpty
                            ? CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(state.user.image
                                            ?.contains('http') ==
                                        true
                                    ? state.user.image ?? ''
                                    : '${AppSecrets.baseUrl}/uploads/users/${state.user.image}'),
                              )
                            : CircleAvatar(
                                backgroundColor: AppColors.primaryElement,
                                radius: 20,
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.whiteText,
                                  size: 24,
                                ),
                              ),
                  ),
                ],
                title: Text(
                  'Привет, ${state.user.name}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText.withAlpha(160),
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                centerTitle: false,
              ),
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  final completer = Completer();
                  context
                      .read<UserBloc>()
                      .add(FetchUserData(completer: completer));
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
              if (state.activeAppointments.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: HomeTitle(
                    title: 'Предстоящие записи',
                    icon: Icon(
                      Icons.schedule,
                      color: AppColors.primaryElement,
                      size: 24,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 120,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.activeAppointments.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 16,
                      ),
                      itemBuilder: (context, index) {
                        return BaseContainer(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            children: [
                              TRoundedContainer(
                                backgroundColor:
                                    AppColors.containerColor.withAlpha(75),
                                width: 100,
                                height: 100,
                                radius: 10,
                                margin: const EdgeInsets.all(10),
                                child: Center(
                                  child: Text.rich(
                                    textAlign: TextAlign.center,
                                    TextSpan(
                                      text:
                                          '${DateTimeHelper.getDay(state.activeAppointments[index].appointmentDate!)}\n',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: AppColors.primaryIcon,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: DateTimeHelper.getMonthName(
                                            state.activeAppointments[index]
                                                .appointmentDate!,
                                            'ru',
                                          ),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.primaryIcon,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.activeAppointments[index].pet?.name ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Время: ${DateTimeHelper.getFormattedTime(state.activeAppointments[index].appointmentDate!)}',
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
                ),
              ],
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.containerColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Популярные породы собак и цена стрижки за полный комплекс, в леях.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          AppColors.primaryText.withAlpha(200),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Цена услуг варьируется ввиду:',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryText
                                                .withAlpha(200),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  _buildListItem('- Плохого поведения собаки'),
                                  _buildListItem(
                                      '- Запущенного состояния питомца'),
                                  _buildListItem('- Более сложной стрижки'),
                                  SizedBox(height: 12),
                                  Text(
                                    'Эти аспекты напрямую влияют на сложность и длительность стрижки.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                      color: AppColors.primaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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

Widget _buildListItem(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, size: 16, color: AppColors.primaryStatusOk),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primaryText.withAlpha(200),
            ),
          ),
        ),
      ],
    ),
  );
}
