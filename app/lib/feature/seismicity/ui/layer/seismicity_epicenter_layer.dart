import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 震央分布図(MapLibre circle レイヤー、data-driven styling)。
///
/// [colorMode] に応じて `circle-color` の式を切り替える。円サイズは常に
/// マグニチュードへ連動する(`circle-radius`)。
class SeismicityEpicenterLayer extends HookConsumerWidget {
  const SeismicityEpicenterLayer({
    required this.events,
    required this.colorMode,
    super.key,
  });

  final List<SeismicityEvent> events;
  final SeismicityColorMode colorMode;

  static const _sourceId = 'seismicity-epicenter';
  static const _layerId = 'seismicity-epicenter-circle';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      unawaited(
        enqueue(() async {
          try {
            await styleController.addSource(
              GeoJsonSource(
                id: _sourceId,
                data: jsonEncode(_toGeoJson(events)),
              ),
            );
            await styleController.addLayer(
              CircleStyleLayer(
                id: _layerId,
                sourceId: _sourceId,
                paint: {
                  'circle-color': _colorExpression(colorMode),
                  'circle-radius': _radiusExpression(),
                  'circle-opacity': 0.75,
                  'circle-stroke-width': 0.5,
                  'circle-stroke-color': '#00000080',
                },
              ),
            );
          } on Exception catch (e) {
            talker.log(e);
          }
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            try {
              await styleController.removeLayer(_layerId);
              await styleController.removeSource(_sourceId);
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );
      };
    }, [styleController, events, colorMode]);

    return const SizedBox.shrink();
  }

  Map<String, dynamic> _toGeoJson(List<SeismicityEvent> events) {
    final now = DateTime.now().toUtc();
    return {
      'type': 'FeatureCollection',
      'features': [
        for (final event in events)
          {
            'type': 'Feature',
            'geometry': {
              'type': 'Point',
              'coordinates': [event.longitude, event.latitude],
            },
            'properties': {
              'event_id': event.eventId,
              'magnitude': event.magnitude ?? 0.0,
              'elapsed_hours': now
                  .difference(event.originTime.toUtc())
                  .inHours
                  .toDouble(),
            },
          },
      ],
    };
  }

  /// マグニチュードに応じた円半径(px)。M2〜M7 を 3px〜18px へ線形補間。
  List<dynamic> _radiusExpression() => [
    'interpolate',
    ['linear'],
    ['get', 'magnitude'],
    2,
    3,
    7,
    18,
  ];

  List<dynamic> _colorExpression(SeismicityColorMode mode) => switch (mode) {
    SeismicityColorMode.magnitude => [
      'interpolate',
      ['linear'],
      ['get', 'magnitude'],
      2,
      '#9e9e9e',
      4,
      '#ffca28',
      6,
      '#e53935',
    ],
    SeismicityColorMode.elapsedTime => [
      'interpolate',
      ['linear'],
      ['get', 'elapsed_hours'],
      0,
      '#e53935',
      24 * 30,
      '#9e9e9e',
    ],
  };
}
