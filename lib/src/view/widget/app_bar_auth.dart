import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class AppBarAuth extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarAuth({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.primaryBackground.withOpacity(0.5),
          height: 1.0,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
