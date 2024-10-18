import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double width;
  final double? fontSize;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.containerBorder,
    this.textColor = AppColors.whiteText,
    this.borderColor = AppColors.primaryTransparent,
    required this.width,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 40.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(color),
          foregroundColor: WidgetStateProperty.all(color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
              side: BorderSide(
                color: borderColor,
                width: 1.w,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
