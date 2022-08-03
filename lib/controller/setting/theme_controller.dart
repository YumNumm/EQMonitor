import 'package:eqmonitor/model/setting/theme_model.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeController extends StateNotifier<ThemeModel> {
  ThemeController(): super(
    ThemeModel(
      themeMode: ThemeMode.system,
      colorScheme: FlexColorScheme.light(),
    ),
  );

  /// 
}