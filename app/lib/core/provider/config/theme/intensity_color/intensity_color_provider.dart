
import 'dart:convert';

import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_configuration.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_scheme_type.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_color_provider.g.dart';

@Riverpod(keepAlive: true)
class IntensityColorConfiguration extends _$IntensityColorConfiguration {
  @override
  IntensityColorConfiguration build() {
    final result = loadConfiguration();
    if (result != null) {
      return result;
    }
    // Migrate from old format if exists
    final oldModel = loadLegacyModel();
    if (oldModel != null) {
      return IntensityColorConfiguration(
        schemeType: _detectSchemeType(oldModel),
        customColors: _isCustomScheme(oldModel) ? oldModel : null,
      );
    }
    return const IntensityColorConfiguration(
      schemeType: IntensityColorSchemeType.predefined(
        scheme: PredefinedScheme.eqmonitor,
      ),
    );
  }

  static const _configKey = 'intensity_color_configuration';
  static const _legacyKey = 'intensity_color';

  Future<void> updateConfiguration(
    IntensityColorConfiguration configuration,
  ) async {
    state = configuration;
    await ref.read(sharedPreferencesProvider).setString(
          _configKey,
          jsonEncode(configuration.toJson()),
        );
  }

  Future<void> updatePredefinedScheme(PredefinedScheme scheme) async {
    final newConfig = IntensityColorConfiguration(
      schemeType: IntensityColorSchemeType.predefined(scheme: scheme),
    );
    await updateConfiguration(newConfig);
  }

  Future<void> updateCustomColors(IntensityColorModel customColors) async {
    final newConfig = IntensityColorConfiguration(
      schemeType: const IntensityColorSchemeType.custom(),
      customColors: customColors,
    );
    await updateConfiguration(newConfig);
  }

  IntensityColorConfiguration? loadConfiguration() {
    final value = ref.read(sharedPreferencesProvider).getString(_configKey);
    if (value == null) {
      return null;
    }
    try {
      return IntensityColorConfiguration.fromJson(
        jsonDecode(value) as Map<String, dynamic>,
      );
    } on Exception catch (_) {
      return null;
    }
  }

  IntensityColorModel? loadLegacyModel() {
    final value = ref.read(sharedPreferencesProvider).getString(_legacyKey);
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

  IntensityColorSchemeType _detectSchemeType(IntensityColorModel model) {
    if (_modelsEqual(model, IntensityColorModel.eqmonitor())) {
      return const IntensityColorSchemeType.predefined(
        scheme: PredefinedScheme.eqmonitor,
      );
    }
    if (_modelsEqual(model, IntensityColorModel.jma())) {
      return const IntensityColorSchemeType.predefined(
        scheme: PredefinedScheme.jma,
      );
    }
    if (_modelsEqual(model, IntensityColorModel.earthQuickly())) {
      return const IntensityColorSchemeType.predefined(
        scheme: PredefinedScheme.earthQuickly,
      );
    }
    if (_modelsEqual(model, IntensityColorModel.nhk())) {
      return const IntensityColorSchemeType.predefined(
        scheme: PredefinedScheme.nhk,
      );
    }
    return const IntensityColorSchemeType.custom();
  }

  bool _isCustomScheme(IntensityColorModel model) {
    return !_modelsEqual(model, IntensityColorModel.eqmonitor()) &&
        !_modelsEqual(model, IntensityColorModel.jma()) &&
        !_modelsEqual(model, IntensityColorModel.earthQuickly()) &&
        !_modelsEqual(model, IntensityColorModel.nhk());
  }

  bool _modelsEqual(IntensityColorModel a, IntensityColorModel b) {
    return a.zero.background == b.zero.background &&
        a.one.background == b.one.background &&
        a.two.background == b.two.background &&
        a.three.background == b.three.background &&
        a.four.background == b.four.background &&
        a.fiveLower.background == b.fiveLower.background &&
        a.fiveUpper.background == b.fiveUpper.background &&
        a.sixLower.background == b.sixLower.background &&
        a.sixUpper.background == b.sixUpper.background &&
        a.seven.background == b.seven.background;
  }
}

@Riverpod(keepAlive: true)
class IntensityColor extends _$IntensityColor {
  @override
  IntensityColorModel build() {
    final configuration = ref.watch(intensityColorConfigurationProvider);
    return configuration.colorModel;
  }

  Future<void> update(IntensityColorModel model) async {
    await ref
        .read(intensityColorConfigurationProvider.notifier)
        .updateCustomColors(model);
  }
}
