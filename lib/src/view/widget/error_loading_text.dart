import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class ErrorLoadingText extends StatelessWidget {
  final void Function()? onRetry;

  const ErrorLoadingText({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Что-то пошло не так',
            style: const TextStyle(color: AppColors.primaryText)
                .copyWith(fontSize: 16),
          ),
          Text(
            'Попробуйте чуть позже',
            style: const TextStyle(color: AppColors.primaryText)
                .copyWith(fontSize: 10),
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton(
            onPressed: onRetry,
            child: const Text(
              'Повторить попытку',
            ),
          ),
        ],
      ),
    );
  }
}