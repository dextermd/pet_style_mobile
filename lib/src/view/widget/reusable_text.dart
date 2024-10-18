import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class ReusableText extends StatelessWidget {
  final String text;

  const ReusableText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.primarySecondText),
      ),
    );
  }
}
