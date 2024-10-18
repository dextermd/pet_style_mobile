import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final ValueChanged<String>? onChanged;
  final double contentPadding;
  final bool readOnly;
  final int minLines;
  final int maxLines;
  final TextStyle? style;
  final int maxLenght;
  final bool shouldShowCounter;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    this.contentPadding = 18,
    this.readOnly = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.style = const TextStyle(
      color: AppColors.primaryText,
      fontSize: 13,
    ),
    this.maxLenght = 500,
    this.shouldShowCounter = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      readOnly: readOnly,
      minLines: minLines,
      maxLines: maxLines,
      style: style,
      maxLength: maxLenght,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(contentPadding),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: AppColors.containerColor.withOpacity(0.2),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.primaryText.withOpacity(0.5),
          fontSize: 13,
        ),
        errorText: errorMsg,
      ),
      buildCounter: (BuildContext context,
          {int? currentLength, bool? isFocused, int? maxLength}) {
        if (shouldShowCounter) {
          return Text(
            '$currentLength/$maxLength',
            style: const TextStyle(color: Colors.grey),
          );
        } else {
          return null; // Скрываем счетчик
        }
      },
    );
  }
}
