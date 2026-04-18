import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
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
    final brightness = ref.watch(brightnessProvider);
    var savedState =
        await _load() ?? const MapConfiguration(theme: MapTheme.system);
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
    );

    return savedState.copyWith(styleString: styleString);
  }

  Future<MapConfiguration?> _load() async {
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    final json = await sharedPreferences.getString(
      key: SharedPreferencesKey.mapConfiguration,
    );
    if (json == null) {
      return null;
    }
    return MapConfiguration.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }
}
