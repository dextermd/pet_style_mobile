import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class MyElevatedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double radius;
  final void Function()? onPressed;
  final double width;
  final double height;

  const MyElevatedButton({
    super.key,
    required this.text,
    this.textColor = AppColors.whiteText,
    this.backgroundColor = AppColors.containerBorder,
    this.radius = 5,
    this.onPressed,
    this.width = 0,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        foregroundColor: textColor,
        shadowColor: AppColors.primaryTransparent,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Text(text),
    );
  }
}
