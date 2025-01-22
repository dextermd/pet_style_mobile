import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class SquareTile extends StatelessWidget {
  final Widget image;
  const SquareTile({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.containerColor.withAlpha(100)),
        borderRadius: BorderRadius.circular(16),
        color: AppColors.containerColor.withAlpha(50),
      ),
      child: image,
    );
  }
}
