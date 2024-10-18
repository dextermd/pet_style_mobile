import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_style_mobile/blocs/sign_in/sign_in_bloc.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/view/app/menu/app_bar_back.dart';
import 'package:pet_style_mobile/src/view/widget/my_button.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  File? image;

  void selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              InkWell(
                onTap: () => selectImage(),
                child: image == null
                    ? SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                                'assets/images/default_profile.png')),
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(image!),
                        radius: 50,
                      ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Profile Name',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'profileemail@gmail.com',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 20.h),
              MyButton(
                width: 200.w,
                text: 'Edit Profile',
                onPressed: () {},
              ),
              SizedBox(height: 20.h),
              const Divider(
                  color: AppColors.containerBorder, height: 1, thickness: 1),
              SizedBox(height: 20.h),
              ListTileMenu(
                title: 'Settings',
                icon: Icon(Icons.logout,
                    color: AppColors.whiteText.withOpacity(0.8)),
                onPress: () {},
              ),
              const SizedBox(height: 5),
              ListTileMenu(
                title: 'Settings',
                icon: Icon(Icons.logout,
                    color: AppColors.whiteText.withOpacity(0.8)),
                onPress: () {},
              ),
              const SizedBox(height: 5),
              ListTileMenu(
                title: 'Settings',
                icon: Icon(Icons.logout,
                    color: AppColors.whiteText.withOpacity(0.8)),
                onPress: () {},
              ),
              const SizedBox(height: 20),
              const Divider(
                  color: AppColors.containerBorder, height: 1, thickness: 1),
              const SizedBox(height: 20),
              ListTileMenu(
                title: 'Выход',
                icon: Icon(Icons.logout,
                    color: AppColors.whiteText.withOpacity(0.8)),
                onPress: () {
                  context.read<SignInBloc>().add(const SignOutRequired());
                  const Duration(seconds: 1);
                  context.go('/onboarding');
                },
                textColor: AppColors.primaryStatusError,
                endIcon: false,
              ),
            ],
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
        style: Theme.of(context).textTheme.titleMedium?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryEnabledBorder.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: AppColors.primaryText,
              ))
          : null,
    );
  }
}
