import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class AppBarBack extends StatelessWidget implements PreferredSizeWidget {
  final Function() onPressed;
  final String? title;
  final Color? backgroundColor;

  const AppBarBack({
    super.key,
    required this.onPressed,
    this.title,
    this.backgroundColor = AppColors.primaryTransparent,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.containerBorder,
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                color: AppColors.whiteText,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
