import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final StateProvider<ThemeMode> themeModeProvider =
    StateProvider<ThemeMode>((StateProviderRef<ThemeMode> ref) {
  return ThemeMode.system;
});

final lightTheme = FlexThemeData.light(scheme: FlexScheme.bahamaBlue);
final darkTheme = FlexThemeData.dark(scheme: FlexScheme.bahamaBlue);

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(lightTheme);
  void switchTheme() => state = state == lightTheme ? darkTheme : lightTheme;
}
