import 'package:flutter/material.dart';

final ColorScheme appColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF62444E),
  onPrimary: Color(0xFFF5F0EC),
  secondary: Color(0xFF7C5A5B),
  onSecondary: Color(0xFFFBF8F6),
  onSurface: Color(0xFF62444E),
  error: Color(0xFFB00020),
  onError: Color(0xFFFFFFFF), surface: Colors.white,
);

final ThemeData appTheme = ThemeData.from(colorScheme: appColorScheme).copyWith(
  scaffoldBackgroundColor: appColorScheme.surface,
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: appColorScheme.onSurface,
    displayColor: appColorScheme.onSurface,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: appColorScheme.primary,
      foregroundColor: appColorScheme.onPrimary,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
);