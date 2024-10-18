import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class TRoundedContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = 10.0,
    this.child,
    this.showBorder = false,
    this.borderColor = AppColors.containerBorder,
    this.backgroundColor = AppColors.containerColor,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        border: showBorder
            ? Border.all(
                color: borderColor,
              )
            : null,
      ),
      child: child,
    );
  }
}
