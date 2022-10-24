import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_model.freezed.dart';

@freezed
class ThemeModel with _$ThemeModel {
  const factory ThemeModel({
    /// テーマモード
    @Default(ThemeMode.system) ThemeMode themeMode,

    /// 可能な場合、ダイナミックカラーを利用するか
    @Default(true) bool useDynamicColor,
  }) = _ThemeModel;
}
