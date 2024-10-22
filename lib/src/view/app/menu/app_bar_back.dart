import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class AppBarBack extends StatelessWidget implements PreferredSizeWidget {
  final Function() onPressed;
  final String? title;
  final double toolbarHeight;

  const AppBarBack({
    super.key,
    required this.onPressed,
    this.title,
    this.toolbarHeight = 60,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 10,
      toolbarHeight: toolbarHeight,
      leadingWidth: 80,
      leading: InkWell(
        onTap: onPressed,
        child: Container(
          height: 40,
          width: 40,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
