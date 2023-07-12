import 'package:eqmonitor/core/component/map/model/map_config.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_config.g.dart';

@Riverpod(keepAlive: true)
class MapConfigState extends _$MapConfigState {
  @override
  MapConfig build(ThemeMode themeMode) {
    return switch (themeMode) {
      ThemeMode.light => MapConfig(
          colorScheme: MapColorScheme.light(),
        ),
      _ => MapConfig(
          colorScheme: MapColorScheme.light(),
        ),
    };
  }
}
