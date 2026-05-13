import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_display_mode.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// EEW震度予報区域レイヤー
///
/// `displayMode` に応じて、府県地震予報区（areaForecastLocalEew）を
/// 予想震度別 or 警報発表区域として塗りつぶす。
class EewForecastRegionLayer extends HookConsumerWidget {
  const EewForecastRegionLayer({
    required this.eew,
    required this.displayMode,
    super.key,
  });

  final EewTelegramItem? eew;
  final EewDisplayMode displayMode;

  static const _sourceId = 'eqmonitor_map';
  static const _sourceLayerId = 'areaForecastLocalEew';
  static const _warningLayerId = 'eew-details-warning-fill';
  static const _emptyFilter = <Object>['==', '1', '2'];

  static String _intensityLayerId(JmaIntensity intensity) {
    final base = intensity.label
        .replaceAll('-', 'low')
        .replaceAll('+', 'high')
        .replaceAll('不明', 'unknown');
    return 'eew-details-intensity-fill-$base';
  }

  static const List<JmaIntensity> _intensityLevels = [
    JmaIntensity.one,
    JmaIntensity.two,
    JmaIntensity.three,
    JmaIntensity.four,
    JmaIntensity.fiveLower,
    JmaIntensity.fiveUpper,
    JmaIntensity.sixLower,
    JmaIntensity.sixUpper,
    JmaIntensity.seven,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(intensityColorProvider);

    // 震度別の region code 一覧
    final intensityCodes = useMemoized(() {
      final regions = eew?.forecastIntensity?.regions ?? const [];
      final maxByRegion = regions
          .groupListsBy((e) => e.code)
          .map(
            (key, values) => MapEntry(
              key,
              values.sortedBy((e) => e.intensity.orderIndex).last,
            ),
          )
          .values
          .toList();
      return {
        for (final intensity in _intensityLevels)
          intensity: maxByRegion
              .where((r) => r.intensity == intensity)
              .map((r) => r.code)
              .toList(),
      };
    }, [eew]);

    // 警報発表区域の region code 一覧
    final warningCodes = useMemoized(() {
      final zones = eew?.warning?.regions ?? const [];
      return zones.where((z) => z.hadWarning).map((z) => z.code).toList();
    }, [eew]);

    final isInitialized = useRef(false);

    // 震度別レイヤーの初期化（intensity モードのみ）
    useEffect(
      () {
        if (styleController == null ||
            displayMode != EewDisplayMode.intensity) {
          return null;
        }

        var disposed = false;
        final addedIds = <String>[];

        unawaited(() async {
          for (final intensity in _intensityLevels) {
            if (disposed) {
              return;
            }
            final color = colorModel.fromJmaIntensity(intensity).background;
            final layerId = _intensityLayerId(intensity);
            final codes = intensityCodes[intensity] ?? const [];
            final initialFilter = codes.isEmpty
                ? _emptyFilter
                : <Object>[
                    'in',
                    ['get', 'code'],
                    ['literal', codes],
                  ];
            await styleController.addLayer(
              FillStyleLayer(
                id: layerId,
                sourceId: _sourceId,
                sourceLayerId: _sourceLayerId,
                filter: initialFilter,
                paint: {
                  'fill-color': color.toHexString(),
                  'fill-opacity': 0.7,
                },
              ),
            );
            addedIds.add(layerId);
          }
          isInitialized.value = true;
        }());

        return () {
          disposed = true;
          isInitialized.value = false;
          unawaited(() async {
            for (final id in addedIds.reversed) {
              try {
                await styleController.removeLayer(id);
              } on Exception {
                // ignore
              }
            }
          }());
        };
      },
      [styleController, displayMode, colorModel],
    );

    // 警報レイヤーの初期化（warning モードのみ）
    useEffect(
      () {
        if (styleController == null || displayMode != EewDisplayMode.warning) {
          return null;
        }

        var disposed = false;

        unawaited(() async {
          final initialWarningFilter = warningCodes.isEmpty
              ? _emptyFilter
              : <Object>[
                  'in',
                  ['get', 'code'],
                  ['literal', warningCodes],
                ];
          await styleController.addLayer(
            FillStyleLayer(
              id: _warningLayerId,
              sourceId: _sourceId,
              sourceLayerId: _sourceLayerId,
              filter: initialWarningFilter,
              paint: const {
                'fill-color': '#FF0000',
                'fill-opacity': 0.4,
              },
            ),
          );
          if (!disposed) {
            isInitialized.value = true;
          }
        }());

        return () {
          disposed = true;
          isInitialized.value = false;
          unawaited(() async {
            try {
              await styleController.removeLayer(_warningLayerId);
            } on Exception {
              // ignore
            }
          }());
        };
      },
      [styleController, displayMode],
    );

    // 震度モード: フィルター更新
    useEffect(
      () {
        if (styleController == null ||
            displayMode != EewDisplayMode.intensity ||
            !isInitialized.value) {
          return null;
        }

        unawaited(() async {
          for (final intensity in _intensityLevels) {
            final codes = intensityCodes[intensity] ?? const [];
            final filter = codes.isEmpty
                ? _emptyFilter
                : <Object>[
                    'in',
                    ['get', 'code'],
                    ['literal', codes],
                  ];
            await styleController.updateFilter(
              id: _intensityLayerId(intensity),
              filter: filter,
            );
          }
        }());

        return null;
      },
      [styleController, displayMode, intensityCodes, isInitialized.value],
    );

    // 警報モード: フィルター更新
    useEffect(
      () {
        if (styleController == null ||
            displayMode != EewDisplayMode.warning ||
            !isInitialized.value) {
          return null;
        }

        final filter = warningCodes.isEmpty
            ? _emptyFilter
            : <Object>[
                'in',
                ['get', 'code'],
                ['literal', warningCodes],
              ];
        unawaited(
          styleController.updateFilter(id: _warningLayerId, filter: filter),
        );

        return null;
      },
      [styleController, displayMode, warningCodes, isInitialized.value],
    );

    return const SizedBox.shrink();
  }
}
