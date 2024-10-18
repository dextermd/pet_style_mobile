import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_style_mobile/blocs/user/user_bloc.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/services/storage_services.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/view/app/home/widgets/appointment_card.dart';
import 'package:pet_style_mobile/src/view/app/home/widgets/pet_card.dart';
import 'package:pet_style_mobile/src/view/widget/base_container.dart';
import 'package:pet_style_mobile/src/view/widget/t_rounded_container.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StorageServices storageServices;

  @override
  void initState() {
    super.initState();
    storageServices = GetIt.I<StorageServices>();
    context.read<UserBloc>().add(const FetchUserData());
    logDebug(storageServices.getString('access_token').toString());
    logDebug(storageServices.getString('user_id').toString());
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
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
                    child: CircleAvatar(
                        radius: 20,
                        backgroundImage: state.user.image != null
                            ? NetworkImage(state.user.image ?? '')
                            : const AssetImage(
                                    'assets/images/default_profile.png')
                                as ImageProvider),
                  ),
                ],
                // text
                title: Text(
                  'Привет, ${state.user.name}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText.withOpacity(0.6),
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
                  return completer.future;
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.pets,
                        color: AppColors.primaryElement,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Мои питомцы',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryElement,
                                ),
                      ),
                    ],
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
                          width: 250,
                          id: state.pets[index].id ?? '0',
                          name: state.pets[index].name ?? '',
                          photo: state.pets[index].photo ?? '',
                          isNetworkImage: true,
                        );
                      }
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        color: AppColors.primaryElement,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Предстоящие записи',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryElement,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 120,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.pets.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 16,
                    ),
                    itemBuilder: (context, index) {
                      return BaseContainer(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          children: [
                            TRoundedContainer(
                              width: 100,
                              height: 100,
                              radius: 25,
                              margin: const EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  '12\nАвгуста',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryElement),
                                ),
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Салон красоты',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.primaryElement,
                                  ),
                                ),
                                Text(
                                  '12:00 - 13:00',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.primaryElement,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '12:00 - 13:00',
                                  style: TextStyle(
                                    fontSize: 14,
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
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
            ],
          );
        }
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
                onPressed: () {
                  BlocProvider.of<UserBloc>(context)
                      .add(const FetchUserData(completer: null));
                },
                child: const Text(
                  'Повторить попытку',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
