import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/blocs/sign_in/sign_in_bloc.dart';
import 'package:pet_style_mobile/blocs/user/user_bloc.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/core/services/media_services.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/utils/app_utils.dart';
import 'package:pet_style_mobile/src/view/app/menu/app_bar_back.dart';
import 'package:pet_style_mobile/src/view/router/app_routes.dart';
import 'package:pet_style_mobile/src/view/widget/my_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late MediaServices _mediaServices;

  File? image;

  @override
  void initState() {
    super.initState();
    _mediaServices = GetIt.I<MediaServices>();
    //context.read<UserBloc>().add(const FetchUserData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBack(
        onPressed: () {
          context.pop();
        },
        title: 'Настройки',
      ),
      body: SingleChildScrollView(
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UpdateUserDataError) {
              AppUtils.showToastError(context, '', state.message);
            }
            if (state is UserUpdated) {
              context.pop();
              context.read<UserBloc>().add(FetchUserData());
              AppUtils.showToastSuccess(context, 'Успешно', 'Профиль обновлен');
            }
            if (state is ImageUpdated) {
              context.read<UserBloc>().add(FetchUserData());

              AppUtils.showToastSuccess(
                  context, 'Успешно', 'Изображение обновлено');
            }
            if (state is UpdateImageError) {
              AppUtils.showToastError(context, '', state.message);
            }
          },
          child: BlocBuilder<UserBloc, UserState>(
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
              if (state is UserLoaded) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      InkWell(
                        onTap: () async {
                          _mediaServices.getImageFromGallery().then((value) {
                            if (value != null) {
                              setState(() {
                                image = value;
                              });
                              if (context.mounted) {
                                context
                                    .read<UserBloc>()
                                    .add(UpdateImageEvent(image!));
                              }
                            }
                          });
                        },
                        child: image == null
                            ? state.user.image == null ||
                                    state.user.image!.isEmpty
                                ? CircleAvatar(
                                    backgroundColor: AppColors.primaryElement,
                                    radius: 75,
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.whiteText,
                                      size: 75,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(state
                                                .user.image
                                                ?.contains('http') ==
                                            true
                                        ? state.user.image ?? ''
                                        : '${AppSecrets.baseUrl}/${state.user.image}'),
                                    radius: 75,
                                  )
                            : CircleAvatar(
                                backgroundImage: FileImage(image!),
                                radius: 75,
                              ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        state.user.name ?? '',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.primaryText.withOpacity(0.8),
                                ),
                      ),
                      Text(
                        state.user.email ?? '',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.primaryText.withOpacity(0.8),
                            ),
                      ),
                      SizedBox(height: 20.h),
                      MyButton(
                        width: 200.w,
                        text: 'Edit Profile',
                        onPressed: () {
                          context.pushNamed(AppRoutes.editProfile);
                        },
                      ),
                      SizedBox(height: 20.h),
                      const Divider(
                          color: AppColors.containerBorder,
                          height: 1,
                          thickness: 1),
                      SizedBox(height: 20.h),
                      ListTileMenu(
                        title: 'Выход',
                        icon: Icon(
                          Icons.logout,
                          color: AppColors.whiteText,
                          size: 18,
                        ),
                        onPress: () {
                          context
                              .read<SignInBloc>()
                              .add(const SignOutRequired());
                          const Duration(seconds: 1);
                          context.go('/onboarding');
                        },
                        textColor: AppColors.primaryText,
                        endIcon: false,
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class ListTileMenu extends StatelessWidget {
  const ListTileMenu({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.textColor,
    this.endIcon = true,
  });

  final String title;
  final Icon icon;
  final VoidCallback onPress;
  final Color? textColor;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      onTap: onPress,
      tileColor: AppColors.containerColor.withOpacity(0.2),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primaryElement,
        ),
        child: icon,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryEnabledBorder.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.primaryText,
              ),
            )
          : null,
    );
  }
}
