// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'intensity_color_provider.g.dart';

@Riverpod(keepAlive: true)
class IntensityColor extends _$IntensityColor {
  @override
  IntensityColorModel build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    return IntensityColorModel.eqmonitor();
  }

  static const _key = 'intensity_color';
  late final SharedPreferences _prefs;

  void update(IntensityColorModel model) {
    state = model;
  }

  IntensityColorModel? load() {
    final value = _prefs.getString(_key);
    if (value == null) {
      return null;
    }
    try {
      return IntensityColorModel.fromJson(
        jsonDecode(value) as Map<String, dynamic>,
      );
    } on Exception catch (_) {
      return null;
    }
  }
}
