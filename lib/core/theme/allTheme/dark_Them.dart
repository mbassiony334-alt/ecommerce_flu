import 'package:e_commarcae/core/theme/appColors/app_color_dark.dart';
import 'package:flutter/material.dart';

ThemeData GetDarkThem() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColorDark.primaryColor,
    scaffoldBackgroundColor: AppColorDark.socendColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColorDark.socendColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColorDark.boldFontcolor),
      titleTextStyle: TextStyle(
        color: AppColorDark.boldFontcolor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColorDark.primaryColor,
      surface: AppColorDark.socendColor,
      onSurface: AppColorDark.boldFontcolor,
    ),
    cardTheme: const CardThemeData(
      color: AppColorDark.cardBackground,
      elevation: 2,
      shadowColor: Colors.black45,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColorDark.boldFontcolor,
      ),
      bodyLarge: TextStyle(
        color: AppColorDark.noramlFontcolor,
      ),
      bodyMedium: TextStyle(
        color: AppColorDark.noramlFontcolor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(AppColorDark.primaryColor),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(color: AppColorDark.socendColor, fontWeight: FontWeight.bold),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(AppColorDark.socendColor),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(color: AppColorDark.primaryColor, fontWeight: FontWeight.bold),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: AppColorDark.primaryColor,
            ),
          ),
        ),
      ),
    ),
  );
}
