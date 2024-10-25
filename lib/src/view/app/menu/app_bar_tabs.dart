import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class AppBarTabs extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TabBar bottomTabs;

  const AppBarTabs({
    super.key,
    required this.title,
    required this.bottomTabs,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primarySecondElement,
      foregroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 80,
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.primaryText.withOpacity(0.6),
            ),
      ),
      bottom: bottomTabs,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
