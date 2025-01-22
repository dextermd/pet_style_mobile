import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';
import 'package:pet_style_mobile/src/view/router/app_routes.dart';

class CustomSliverAppbar extends StatelessWidget {
  final User user;
  const CustomSliverAppbar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: true,
      floating: true,
      backgroundColor: AppColors.primarySecondElement,
      shadowColor: AppColors.primarySecondElement,
      foregroundColor: AppColors.primarySecondElement,
      surfaceTintColor: AppColors.primarySecondElement,
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRoutes.setting);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: user.image != null && user.image!.isNotEmpty
                ? CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(user.image
                                ?.contains('http') ==
                            true
                        ? user.image ?? ''
                        : '${AppSecrets.baseUrl}/uploads/users/${user.image}'),
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
        ),
      ],
      title: Text(
        'Привет, ${user.name}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText.withAlpha(160),
          letterSpacing: 1.2,
        ),
        textAlign: TextAlign.center,
      ),
      centerTitle: false,
    );
  }
}
