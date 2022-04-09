import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xffE64A19);
  static const primaryDark = Color(0xff008f81);
  static const primaryLight = Color(0xffE64A19);
  static const textLight = Color(0xFFFFFFFF);
  static const text = Color(0xFF000000);
  static const accent = Color(0xFF536dfe);
  static const secondary = Color(0xFF757575);
  static const divider = Color(0xFFBdBdBd);
}

ThemeData getTheme() {
  final theme = ThemeData.light().copyWith(
      colorScheme: const ColorScheme.light().copyWith(
    primary: AppColors.primary,
    onPrimary: AppColors.textLight,
    primaryContainer: AppColors.primaryDark,
    onPrimaryContainer: AppColors.text,
    secondary: AppColors.secondary,
    tertiary: AppColors.accent,
    onTertiary: AppColors.textLight,
  ));

  var darkTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  var lightTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  return theme;
}
