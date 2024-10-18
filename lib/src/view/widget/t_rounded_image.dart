import 'package:flutter/material.dart';

class TRoundedImage extends StatelessWidget {
  final double width;
  final double height;
  final String? imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  const TRoundedImage({
    super.key,
    this.width = 100.0,
    this.height = 100.0,
    this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: border,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image(
            fit: fit,
            width: width,
            height: height,
            image: isNetworkImage
                ? NetworkImage(imageUrl!)
                : AssetImage(imageUrl!) as ImageProvider,
          ),
        ),
      ),
    );
  }
}
