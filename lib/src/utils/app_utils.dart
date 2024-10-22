import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:toastification/toastification.dart';

final class AppUtils {
  AppUtils._();

  static void showToastSuccess(
    BuildContext context,
    String title,
    String message, {
    void Function(ToastificationItem)? onTap,
    void Function(ToastificationItem)? onCloseButtonTap,
    void Function(ToastificationItem)? onAutoCompleteCompleted,
    void Function(ToastificationItem)? onDismissed,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w700,
            ),
      ),
      description: RichText(
        text: TextSpan(
          text: message,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      alignment: Alignment.topCenter,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(Icons.check),
      showIcon: true,
      primaryColor: AppColors.primaryLine,
      backgroundColor: AppColors.primaryLine.withOpacity(0.1),
      foregroundColor: AppColors.primaryBackground,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: AppColors.primaryLine.withOpacity(0.1),
          blurRadius: 16,
          offset: const Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: onTap,
        onCloseButtonTap: onCloseButtonTap,
        onAutoCompleteCompleted: onAutoCompleteCompleted,
        onDismissed: onDismissed,
      ),
    );
  }

  static void showToastError(
    BuildContext context,
    String title,
    String message, {
    void Function(ToastificationItem)? onTap,
    void Function(ToastificationItem)? onCloseButtonTap,
    void Function(ToastificationItem)? onAutoCompleteCompleted,
    void Function(ToastificationItem)? onDismissed,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: title.isNotEmpty
          ? Text(
              title,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColors.primaryBackground,
                    fontWeight: FontWeight.w700,
                  ),
            )
          : null,
      description: RichText(
        text: TextSpan(
          text: message,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      alignment: Alignment.topCenter,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(Icons.error_outline),
      showIcon: true,
      primaryColor: AppColors.primaryStatusError,
      backgroundColor: AppColors.primaryStatusError.withOpacity(0.1),
      foregroundColor: AppColors.primaryBackground,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: AppColors.primaryStatusError.withOpacity(0.1),
          blurRadius: 16,
          offset: const Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: onTap,
        onCloseButtonTap: onCloseButtonTap,
        onAutoCompleteCompleted: onAutoCompleteCompleted,
        onDismissed: onDismissed,
      ),
    );
  }
}
