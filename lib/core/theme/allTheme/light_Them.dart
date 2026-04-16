import 'package:e_commarcae/core/theme/appColors/app_color_light.dart';
import 'package:flutter/material.dart';

ThemeData GetLightThem() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColorLight.primaryColor,
    scaffoldBackgroundColor: AppColorLight.socendColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColorLight.socendColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColorLight.boldFontcolor),
      titleTextStyle: TextStyle(
        color: AppColorLight.boldFontcolor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColorLight.primaryColor,
      surface: AppColorLight.socendColor,
      onSurface: AppColorLight.boldFontcolor,
    ),
    cardTheme: const CardThemeData(
      color: AppColorLight.cardBackground,
      elevation: 2,
      shadowColor: Colors.black45,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColorLight.boldFontcolor,
      ),
      bodyLarge: TextStyle(color: AppColorLight.noramlFontcolor),
      bodyMedium: TextStyle(color: AppColorLight.noramlFontcolor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(
          AppColorLight.primaryColor,
        ),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            color: AppColorLight.socendColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(
          AppColorLight.socendColor,
        ),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            color: AppColorLight.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColorLight.primaryColor),
          ),
        ),
      ),
    ),
  );
}
