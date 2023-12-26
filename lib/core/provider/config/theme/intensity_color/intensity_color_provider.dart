// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_color_provider.g.dart';

@Riverpod(keepAlive: true)
class IntensityColor extends _$IntensityColor {
  @override
  IntensityColorModel build() {
    final result = load();
    if (result != null) {
      return result;
    }
    return IntensityColorModel.eqmonitor();
  }

  static const _key = 'intensity_color';

  // ignore: use_setters_to_change_properties
  void update(IntensityColorModel model) {
    state = model;
  }

  IntensityColorModel? load() {
    final value = ref.read(sharedPreferencesProvider).getString(_key);
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
