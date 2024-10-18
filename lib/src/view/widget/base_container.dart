import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    required this.child,
    required this.width,
    this.margin,
    this.height = 40,
  });

  final double width;
  final double? height;
  final EdgeInsets? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.containerColor.withOpacity(0.2),
      ),
      //padding: const EdgeInsets.only(left: 10),
      child: child,
    );
  }
}
