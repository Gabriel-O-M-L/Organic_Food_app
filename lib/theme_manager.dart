import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xff388E3C);
  static const primaryDark = Color(0xff008f81);
  static const primaryLight = Color(0xffE64A19);
  static const textLight = Color(0xFFFFFFFF);
  static const text = Color(0xFF000000);
  static const accent = Color(0xFFBDBDBD);
  static const secondary = Color(0xFF757575);
  static const divider = Color(0xFFBdBdBd);
}

String _themeMode = "light";

changeTheme() {
  if (_themeMode == "light") {
    _themeMode = "dark";
    print("dark");
  } else {
    _themeMode = "light";
    print("light");
  }
}

String getThemeMode() {
  return _themeMode;
}

ThemeData getTheme() {
  ThemeData theme = ThemeData.light().copyWith(
      colorScheme: const ColorScheme.light().copyWith(
    primary: AppColors.primary,
    onPrimary: AppColors.textLight,
    primaryContainer: Color(0xffffffff),
    onPrimaryContainer: const Color(0xff000000),
    secondary: Color(0xffff2525),
    onSecondary: Color(0xffffffff),
    tertiary: AppColors.accent,
    onTertiary: AppColors.textLight,
  ));
  switch (_themeMode) {
    case "dark":
      theme = ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(
        primary: Color(0xff388E3C),
        onPrimary: Color(0xff000000),
        primaryContainer: Colors.black,
        onPrimaryContainer: const Color(0xffffffff),
        secondary: Color(0xffa72525),
        onSecondary: Color(0xffffffff),
        tertiary: Color(0xff333333),
        onTertiary: AppColors.textLight,
      ));
  }
  ;

  return theme;
}
