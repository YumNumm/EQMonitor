import 'package:flutter/material.dart';

extension ThemeModeExt on ThemeMode {
  String get title {
    switch (this) {
      case ThemeMode.system:
        return 'システム設定';
      case ThemeMode.dark:
        return 'ダークテーマ';
      case ThemeMode.light:
        return 'ライトテーマ';
    }
  }

  String get description {
    switch (this) {
      case ThemeMode.system:
        return 'システム設定に合わせて自動でライトテーマとダークテーマが切り替わります';
      case ThemeMode.light:
        return '白を基調としたテーマ';
      case ThemeMode.dark:
        return '黒を基調としたテーマ';
    }
  }
}
