import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class HomeTitle extends StatelessWidget {
  final String title;
  final Widget? icon;

  const HomeTitle({super.key, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          icon ?? const SizedBox(),
          const SizedBox(width: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryElement,
                ),
          ),
        ],
      ),
    );
  }
}
