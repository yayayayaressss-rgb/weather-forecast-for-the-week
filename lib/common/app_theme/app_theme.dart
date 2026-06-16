import 'package:flutter/material.dart';
import 'colors_first.dart';
import 'colors_second.dart';

class AppTheme {
  static ThemeData desertLight = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorSystem.COLOR_BACKGROUND,
    primaryColor: ColorSystem.COLOR_PRIMARY,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorSystem.COLOR_APPBAR,
      foregroundColor: Colors.white,
      elevation: 4,
      centerTitle: true,
    ),
    cardTheme: const CardThemeData(color: ColorSystem.COLOR_CARD, elevation: 2),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: ColorSystem.COLOR_TEXT_PRIMARY),
      bodyMedium: TextStyle(color: ColorSystem.COLOR_TEXT_SECONDARY),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorSystem.COLOR_SURFACE,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorSystem.COLOR_APPBAR),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorSystem.COLOR_ACCENT, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorSystem.COLOR_ERROR),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorSystem.COLOR_PRIMARY,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    iconTheme: const IconThemeData(color: ColorSystem.COLOR_PRIMARY),
    dividerColor: ColorSystem.COLOR_DIVIDER,
  );

  static ThemeData forestDark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorSystemForestRain.COLOR_BACKGROUND,
    primaryColor: ColorSystemForestRain.COLOR_PRIMARY,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorSystemForestRain.COLOR_APPBAR,
      foregroundColor: ColorSystemForestRain.COLOR_APPBAR_TXT,
      elevation: 4,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: ColorSystemForestRain.COLOR_CARD,
      elevation: 2,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: ColorSystemForestRain.COLOR_TEXT_PRIMARY),
      bodyMedium: TextStyle(color: ColorSystemForestRain.COLOR_TEXT_SECONDARY),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorSystemForestRain.COLOR_SURFACE,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorSystemForestRain.COLOR_APPBAR),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: ColorSystemForestRain.COLOR_ACCENT,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorSystemForestRain.COLOR_ERROR),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorSystemForestRain.COLOR_PRIMARY,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    iconTheme: IconThemeData(color: ColorSystemForestRain.COLOR_WEATHER_ICON),
    dividerColor: ColorSystemForestRain.COLOR_DIVIDER,
  );
}
