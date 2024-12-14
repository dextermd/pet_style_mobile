import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_style_mobile/blocs/localization/localization_bloc.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/l10n/l10n.dart';
import 'package:pet_style_mobile/src/data/model/language/language.dart';
import 'package:pet_style_mobile/src/view/widget/my_list_tile.dart';
import 'package:toastification/toastification.dart';

final class AppUtils {
  AppUtils._();

  static void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            height: 200.h,
            width: 300.w,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryBackground,
                    AppColors.primarySecondBackground
                  ],
                  radius: 1.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.change_language,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: BlocBuilder<LocalizationBloc, LocalizationState>(
                      buildWhen: (previous, current) =>
                          previous.selectedLanguage != current.selectedLanguage,
                      builder: (context, state) {
                        return SizedBox(
                          height: 120.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (ctx, i) {
                              final bool isLanguageChosen =
                                  Language.values[i] == state.selectedLanguage;
                              return MyListTile(
                                addBorderBottom: false,
                                onTap: () {
                                  context.read<LocalizationBloc>().add(
                                        ChangeLanguage(Language.values[i]),
                                      );
                                  Navigator.of(context).pop();
                                },
                                title: Language.values[i].text,
                                leading: SvgPicture.asset(
                                  Language.values[i].iconPath,
                                  width: 14,
                                  height: 14,
                                ),
                                trailing: isLanguageChosen
                                    ? Icon(Icons.check,
                                        color: AppColors.primaryText)
                                    : const Icon(
                                        Icons.chevron_right,
                                        color: AppColors.primaryText,
                                      ),
                              );
                            },
                            separatorBuilder: (ctx, i) => const Divider(
                              height: 5,
                            ),
                            itemCount: Language.values.length,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
