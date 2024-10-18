import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryEnabledBorder),
        borderRadius: BorderRadius.circular(16),
        color:  AppColors.primarySecondBackground,
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}