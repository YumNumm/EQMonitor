import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/map/data/layer/eew_ps_wave/eew_ps_wave_layer.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_ps_wave_controller.g.dart';

@Riverpod(keepAlive: true)
class EewPsWaveFillLayerController extends _$EewPsWaveFillLayerController {
  @override
  List<EewWaveFillLayer> build() => [
        EewWaveFillLayer.sWaveWarning(
          color: Colors.redAccent,
        ),
        EewWaveFillLayer.sWaveNotWarning(
          color: Colors.orangeAccent,
        ),
        EewWaveFillLayer.pWave(
          color: Colors.blue,
        ),
      ];
}

@Riverpod(keepAlive: true)
class EewPsWaveLineLayerController extends _$EewPsWaveLineLayerController {
  @override
  List<EewWaveLineLayer> build() => [
        EewWaveLineLayer.sWaveWarning(
          color: Colors.redAccent,
        ),
        EewWaveLineLayer.sWaveNotWarning(
          color: Colors.orangeAccent,
        ),
        EewWaveLineLayer.pWave(
          color: Colors.blue,
        ),
      ];
}

@Riverpod(keepAlive: true)
class EewPsWaveSourceLayerController extends _$EewPsWaveSourceLayerController {
  @override
  EewPsWaveSourceLayer build() {
    final travelTime = ref.watch(travelTimeDepthMapProvider);
    final now = ref
            .watch(
              timeTickerProvider(
                const Duration(milliseconds: 100),
              ),
            )
            .valueOrNull ??
        DateTime.now();

    final aliveEews = ref.watch(eewAliveTelegramProvider);
    final items = (aliveEews ?? [])
        .whereNot(
          (eew) => eew.isIpfOnePoint || eew.isLevelEew || (eew.isPlum ?? false),
        )
        .map((eew) {
          final latitude = eew.latitude;
          final longitude = eew.longitude;
          final depth = eew.depth;
          final originTime = eew.originTime;
          if (latitude == null ||
              longitude == null ||
              depth == null ||
              originTime == null) {
            print(
              'latitude: $latitude, longitude: $longitude, depth: $depth, originTime: $originTime',
            );
            return null;
          }
          final time = now.difference(originTime).inMilliseconds / 1000;
          final result = travelTime.getTravelTime(depth ~/ 10 * 10, time);
          return EewPsWaveLayerItem(
            latitude: latitude,
            longitude: longitude,
            travelTime: result,
            isWarning: eew.isWarning ?? false,
          );
        })
        .nonNulls
        .toList();

    return EewPsWaveSourceLayer(
      id: 'eew_ps_wave_source',
      items: items,
    );
  }
}
