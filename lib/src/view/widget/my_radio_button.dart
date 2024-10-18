import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class MyRadioButton extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final Function(String?)? onChanged;

  const MyRadioButton({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryElement.withOpacity(0.7),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: RadioListTile(
          dense: true,
          contentPadding: const EdgeInsets.all(0.0),
          value: value,
          groupValue: groupValue,
          title: Transform.translate(
            offset: const Offset(-20, 0),
            child: Text(title),
          ),
          tileColor: AppColors.containerColor.withOpacity(0.2),
          onChanged: onChanged,
          activeColor: AppColors.primaryText,
          
        ),
      ),
    );
  }
}
