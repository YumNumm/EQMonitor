import 'package:eqapi_types/eqapi_types.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_icon_render.g.dart';

@Riverpod(keepAlive: true)
class IntensityIconRender extends _$IntensityIconRender {
  void onRendered(Uint8List data, JmaIntensity intensity) {
    state = {...state, intensity: data};
  }

  Uint8List? get(JmaIntensity intensity) => state.getOrNull(intensity);

  @override
  Map<JmaIntensity, Uint8List> build() => {};
}

@Riverpod(keepAlive: true)
class IntensityIconFillRender extends _$IntensityIconFillRender {
  void onRendered(Uint8List data, JmaIntensity intensity) {
    state = {...state, intensity: data};
  }

  Uint8List? get(JmaIntensity intensity) => state.getOrNull(intensity);

  @override
  Map<JmaIntensity, Uint8List> build() => {};
}

@Riverpod(keepAlive: true)
class LpgmIntensityIconRender extends _$LpgmIntensityIconRender {
  void onRendered(Uint8List data, JmaLgIntensity intensity) {
    state = {...state, intensity: data};
  }

  Uint8List? get(JmaLgIntensity intensity) => state.getOrNull(intensity);

  @override
  Map<JmaLgIntensity, Uint8List> build() => {};
}

@Riverpod(keepAlive: true)
class LpgmIntensityIconFillRender extends _$LpgmIntensityIconFillRender {
  void onRendered(Uint8List data, JmaLgIntensity intensity) {
    state = {...state, intensity: data};
  }

  Uint8List? get(JmaLgIntensity intensity) => state.getOrNull(intensity);

  @override
  Map<JmaLgIntensity, Uint8List> build() => {};
}

@Riverpod(keepAlive: true)
class HypocenterIconRender extends _$HypocenterIconRender {
  @override
  Uint8List? build() => null;

  // ignore: use_setters_to_change_properties
  void onRendered(Uint8List data) => state = data;
}

@Riverpod(keepAlive: true)
class HypocenterLowPreciseIconRender extends _$HypocenterLowPreciseIconRender {
  @override
  Uint8List? build() => null;

  // ignore: use_setters_to_change_properties
  void onRendered(Uint8List data) => state = data;
}

extension IntensityIconRenderEx on Map<JmaIntensity, Uint8List> {
  bool isAllRendered() => length == JmaIntensity.values.length;
}

extension LpgmIntensityIconRenderEx on Map<JmaLgIntensity, Uint8List> {
  bool isAllRendered() => length == JmaLgIntensity.values.length;
}
