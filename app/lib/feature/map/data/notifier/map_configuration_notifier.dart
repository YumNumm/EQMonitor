import 'dart:convert';

import 'package:eqmonitor/core/provider/map/map_pmtiles_util.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/core/theme/theme_provider.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_configuration_notifier.g.dart';

@Riverpod(keepAlive: true)
class MapConfigurationNotifier extends _$MapConfigurationNotifier {
  @override
  Future<MapConfiguration> build() async {
    final brightness = ref.watch(brightnessNotifierProvider);
    var savedState = _load() ?? const MapConfiguration(theme: MapTheme.system);
    if (savedState.theme == MapTheme.system) {
      savedState = savedState.copyWith(
        theme: brightness == Brightness.dark ? MapTheme.dark : MapTheme.light,
      );
    }

    final util = ref.watch(mapStyleUtilProvider);
    final styleString = await util.getStyle(
      colorScheme:
          savedState.colorScheme ??
          switch (savedState.theme) {
            MapTheme.light => MapColorScheme.light(),
            MapTheme.dark => MapColorScheme.dark(),
            _ => throw UnimplementedError(),
          },
      overviewAssetPath: await ref.watch(overviewPmtilesPathProvider.future),
    );

    return savedState.copyWith(styleString: styleString);
  }

  static const _prefsKey = 'map_configuration';

  MapConfiguration? _load() {
    final prefs = ref.read(sharedPreferencesProvider);
    final json = prefs.getString(_prefsKey);
    if (json == null) {
      return null;
    }
    return MapConfiguration.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }
}
