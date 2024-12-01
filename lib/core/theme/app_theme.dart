import 'package:charify_front/core/theme/app_colors.dart';
import 'package:charify_front/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      textTheme: const TextTheme(
          bodySmall: TextStyle(
              fontFamily: AppFonts.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(
              fontFamily: AppFonts.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          bodyLarge: TextStyle(
              fontFamily: AppFonts.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w400),
          headlineSmall: TextStyle(
              fontFamily: AppFonts.fontFamily,
              fontSize: 20,
              fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(
              fontFamily: AppFonts.fontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w600),
          headlineLarge: TextStyle(
              fontFamily: AppFonts.fontFamily,
              fontSize: 32,
              fontWeight: FontWeight.w700)),
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.surface,
          secondary: AppColors.secondary,
          onSecondary: AppColors.surface,
          error: Colors.redAccent,
          onError: AppColors.surface,
          surface: AppColors.surface,
          onSurface: AppColors.text),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          elevation: 0,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.3),
          textStyle: const TextStyle(
            fontFamily: AppFonts.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w500
          )
        )
      )
    );
  }
}
