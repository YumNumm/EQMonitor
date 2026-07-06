// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_options.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:maplibre/maplibre.dart';

class ShakeDetectionHistoryDetailsPage extends ConsumerWidget {
  const ShakeDetectionHistoryDetailsPage({required this.event, super.key});

  final ShakeDetectionEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => _PageContent(
        styleString: value.styleString!,
        event: event,
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(),
        body: Center(child: ErrorCard(error: error)),
      ),
      _ => const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
    };
  }
}

class _PageContent extends HookConsumerWidget {
  const _PageContent({required this.styleString, required this.event});

  final String styleString;
  final ShakeDetectionEvent event;

  static const _sourceId = 'shake-history-detail';
  static const _fillLayerId = 'shake-history-detail-fill';
  static const _lineLayerId = 'shake-history-detail-line';

  String _color() {
    return switch (event.level) {
      ShakeDetectionLevel.weaker => '#88CCFF',
      ShakeDetectionLevel.weak => '#44AAFF',
      ShakeDetectionLevel.medium => '#FFDD44',
      ShakeDetectionLevel.strong => '#FF8800',
      ShakeDetectionLevel.stronger => '#FF2200',
    };
  }

  String _buildGeoJson() {
    final color = _color();
    return jsonEncode({
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'geometry': {
            'type': 'Polygon',
            'coordinates': [
              [
                [event.minLng, event.maxLat],
                [event.maxLng, event.maxLat],
                [event.maxLng, event.minLat],
                [event.minLng, event.minLat],
                [event.minLng, event.maxLat],
              ],
            ],
          },
          'properties': {'fillColor': color, 'lineColor': color},
        },
      ],
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = context.designSystem.colorTheme;

    final center = Geographic(
      lat: (event.minLat + event.maxLat) / 2,
      lon: (event.minLng + event.maxLng) / 2,
    );
    final mapSettings = ref.watch(
      homeConfigurationProvider.select(
        (v) => v.value?.map ?? const HomeMapSettings(),
      ),
    );
    final (:maxZoom, :gestures) = sharedMapOptionsFromSettings(mapSettings);

    final mapOptions = MapOptions(
      initCenter: center,
      initZoom: 5,
      initStyle: styleString,
      maxZoom: maxZoom,
      gestures: gestures,
    );

    final isInitialized = useRef(false);
    final mapController = useState<MapController?>(null);
    final geoJson = _buildGeoJson();

    return Scaffold(
      body: Stack(
        children: [
          MapLibreMap(
            options: mapOptions,
            onMapCreated: (controller) {
              mapController.value = controller;
            },
            onEvent: (mapEvent) async {
              if (mapEvent is! MapEventStyleLoaded) {
                return;
              }
              final controller = mapController.value;
              final style = controller?.style;
              if (style == null || controller == null || isInitialized.value) {
                return;
              }
              isInitialized.value = true;
              await style.addSource(
                GeoJsonSource(id: _sourceId, data: geoJson),
              );
              await (
                style.addLayer(
                  const FillStyleLayer(
                    id: _fillLayerId,
                    sourceId: _sourceId,
                    paint: {
                      'fill-color': ['get', 'fillColor'],
                      'fill-opacity': 0.25,
                    },
                  ),
                ),
                style.addLayer(
                  const LineStyleLayer(
                    id: _lineLayerId,
                    sourceId: _sourceId,
                    paint: {
                      'line-color': ['get', 'lineColor'],
                      'line-width': 2,
                      'line-opacity': 1.0,
                    },
                  ),
                ),
              ).wait;

              final bounds = LngLatBounds.fromPoints([
                Geographic(lat: event.minLat, lon: event.minLng),
                Geographic(lat: event.maxLat, lon: event.maxLng),
              ]);
              await controller.fitBounds(
                bounds: bounds,
                padding: const EdgeInsets.all(64),
                webMaxZoom: 10,
              );
            },
          ),
          _Sheet(event: event),
          if (Navigator.canPop(context))
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton.filledTonal(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedSuperellipseBorder(
                        side: BorderSide(
                          color: colorTheme.primary.withValues(alpha: 0.2),
                        ),
                        borderRadius: BorderRadius.circular(128),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                  color: colorTheme.primary,
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet({required this.event});

  final ShakeDetectionEvent event;

  static final _timeFormat = DateFormat('yyyy/MM/dd HH:mm:ss', 'ja');

  static String _levelLabel(ShakeDetectionLevel level) {
    return switch (level) {
      ShakeDetectionLevel.weaker => '微弱 (Weaker)',
      ShakeDetectionLevel.weak => '弱 (Weak)',
      ShakeDetectionLevel.medium => '中 (Medium)',
      ShakeDetectionLevel.strong => '強 (Strong)',
      ShakeDetectionLevel.stronger => '強烈 (Stronger)',
    };
  }

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          decoration: BoxDecoration(
            color: designSystem.colorTheme.surface,
            borderRadius: BorderRadius.circular(designSystem.shape.sheet),
            border: Border.all(color: designSystem.colorTheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _LevelIndicator(level: event.level),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '揺れ検知イベント',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color: designSystem.colorTheme.onSurface,
                                ),
                          ),
                          Text(
                            _levelLabel(event.level),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color:
                                      designSystem.colorTheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                    if (event.isReplay)
                      _TagBadge(
                        label: 'リプレイ',
                        color: designSystem.colorTheme.surfaceContainerHighest,
                        textColor: designSystem.colorTheme.onSurfaceVariant,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                _InfoRow(
                  label: '検知日時',
                  value: _timeFormat.format(event.createdAt.toLocal()),
                  mono: true,
                  designSystem: designSystem,
                ),
                _InfoRow(
                  label: '観測点数',
                  value: '${event.pointCount} 点',
                  mono: true,
                  designSystem: designSystem,
                ),
                _InfoRow(
                  label: '緯度範囲',
                  value:
                      '${event.minLat.toStringAsFixed(3)}° – ${event.maxLat.toStringAsFixed(3)}°N',
                  mono: true,
                  designSystem: designSystem,
                ),
                _InfoRow(
                  label: '経度範囲',
                  value:
                      '${event.minLng.toStringAsFixed(3)}° – ${event.maxLng.toStringAsFixed(3)}°E',
                  mono: true,
                  designSystem: designSystem,
                ),
                if (event.mergedEewEventId != null)
                  _InfoRow(
                    label: 'EEW結合',
                    value: event.mergedEewEventId!,
                    mono: true,
                    designSystem: designSystem,
                  ),
                _InfoRow(
                  label: 'イベントID',
                  value: event.eventId,
                  mono: true,
                  designSystem: designSystem,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LevelIndicator extends StatelessWidget {
  const _LevelIndicator({required this.level});

  final ShakeDetectionLevel level;

  static Color _colorForLevel(ShakeDetectionLevel level) {
    return switch (level) {
      ShakeDetectionLevel.weaker => const Color(0xFF88CCFF),
      ShakeDetectionLevel.weak => const Color(0xFF44AAFF),
      ShakeDetectionLevel.medium => const Color(0xFFFFDD44),
      ShakeDetectionLevel.strong => const Color(0xFFFF8800),
      ShakeDetectionLevel.stronger => const Color(0xFFFF2200),
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorForLevel(level);
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Icon(Icons.sensors_rounded, color: color, size: 22),
    );
  }
}

class _TagBadge extends StatelessWidget {
  const _TagBadge({
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: textColor),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.designSystem,
    this.mono = false,
  });

  final String label;
  final String value;
  final bool mono;
  final dynamic designSystem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: designSystem.colorTheme.outline,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodySmall?.copyWith(
                color: designSystem.colorTheme.onSurface,
                fontFamily: mono ? FontFamily.googleSansCode : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
