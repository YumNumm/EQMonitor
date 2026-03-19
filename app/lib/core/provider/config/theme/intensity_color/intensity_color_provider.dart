import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_color_provider.g.dart';

@Riverpod(keepAlive: true)
class IntensityColor extends _$IntensityColor {
  @override
  Future<IntensityColorModel> build() async => load();

  Future<IntensityColorModel> load() async {
    final ds = ref.read(sharedPreferencesDataSourceProvider);
    final value =
        await ds.getString(key: SharedPreferencesKey.intensityColor);
    if (value == null) {
      return IntensityColorModel.eqmonitor();
    }
    try {
      return IntensityColorModel.fromJson(
        jsonDecode(value) as Map<String, dynamic>,
      );
    } on Exception catch (_) {
      return IntensityColorModel.eqmonitor();
    }
  }

  Future<void> setModel(IntensityColorModel model) async {
    state = AsyncValue.data(model);
    final ds = ref.read(sharedPreferencesDataSourceProvider);
    await ds.setString(
      key: SharedPreferencesKey.intensityColor,
      value: jsonEncode(model.toJson()),
    );
  }
}
