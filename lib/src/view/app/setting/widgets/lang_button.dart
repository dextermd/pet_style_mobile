import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class LangButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color textColor;

  const LangButton({
    super.key,
    this.onTap,
    required this.text,
    this.textColor = AppColors.primaryText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Container(
          height: 40.h,
          width: 118.w,
          decoration: BoxDecoration(
            color: AppColors.containerColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: textColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
