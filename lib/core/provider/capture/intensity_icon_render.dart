import 'package:eqapi_types/eqapi_types.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_icon_render.g.dart';

@Riverpod(keepAlive: true)
class IntensityIconRender extends _$IntensityIconRender {
  @override
  Map<JmaIntensity, Uint8List> build() => {};

  void onRendered(Uint8List data, JmaIntensity intensity) {
    state = {...state, intensity: data};
  }

  Uint8List? get(JmaIntensity intensity) => state.getOrNull(intensity);
}

@Riverpod(keepAlive: true)
class IntensityIconFillRender extends _$IntensityIconFillRender {
  @override
  Map<JmaIntensity, Uint8List> build() => {};

  void onRendered(Uint8List data, JmaIntensity intensity) {
    state = {...state, intensity: data};
  }

  Uint8List? get(JmaIntensity intensity) => state.getOrNull(intensity);
}

extension IntensityIconRenderEx on Map<JmaIntensity, Uint8List> {
  bool isAllRendered() => length == JmaIntensity.values.length;
}
