import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class AppTheme {
  static _border([Color color = AppColors.primaryText]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5.r),
      );
  static final whiteThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.primaryBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBackground,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        AppColors.primaryBackground,
      ),
      side: BorderSide.none,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'Jost',
          fontSize: 50,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryText),
      displayMedium: TextStyle(
        fontFamily: 'Jost',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryText,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Jost',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Jost',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Jost',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Jost',
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Jost',
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Jost',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryLinkActive,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12),
      border: _border(),
      enabledBorder: _border(AppColors.primaryEnabledBorder),
      focusedBorder: _border(AppColors.primaryFocusBorder),
      errorBorder: _border(AppColors.primaryStatusError),
    ),
    splashColor: AppColors.containerBorder.withOpacity(0.1),
    highlightColor: AppColors.containerBorder.withOpacity(0.1),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: AppColors.primarySecondElement,
      headerForegroundColor: AppColors.primaryText.withOpacity(0.7),
      backgroundColor: AppColors.primaryBackground,
      elevation: 1,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryText.withOpacity(0.5),
      onPrimary: Colors.white,
      onSurface: AppColors.primaryText,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primarySecondElement.withOpacity(0.2),
      ),
    ),
  );
}
