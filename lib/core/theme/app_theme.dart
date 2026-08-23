import 'app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // LIGHT THEME
  static ThemeData lightMode = ThemeData(
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionHandleColor: AppColors.primary,
    ),

    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF7F8F9),
    primaryColor: AppColors.primary,
    fontFamily: 'DM',

    cardColor: AppColors.white,
    highlightColor: AppColors.lightHintColor,

    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkText,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkText,
      ),
      bodyMedium: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFFF7F8F9),
      filled: true,
      hintStyle: TextStyle(color: const Color(0xFF8391A1), fontSize: 15.sp),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    ),
  );

  // DARK THEME
  static ThemeData darkMode = ThemeData(
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionHandleColor: AppColors.primary,
    ),

    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: AppColors.primary,
    fontFamily: 'DM',

    cardColor: AppColors.darkText,
    highlightColor: AppColors.darkHintColor,

    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(fontSize: 14.sp, color: Colors.grey.shade400),
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFF1E1E1E),
      filled: true,
      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15.sp),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Color(0xFF2C2C2C)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Color(0xFF2C2C2C)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    ),
  );
}
