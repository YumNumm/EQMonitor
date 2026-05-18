import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_display_mode.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_forecast_region_layer.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_static_ps_wave_layer.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_options.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_hypocenter_layer.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewDetailsMapView extends HookConsumerWidget {
  const EewDetailsMapView({
    required this.selectedEew,
    required this.displayMode,
    required this.initialCenter,
    required this.initZoom,
    super.key,
  });

  final EewTelegramItem? selectedEew;
  final Geographic initialCenter;
  final double initZoom;
  final EewDisplayMode displayMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => _MapContent(
        styleString: value.styleString!,
        selectedEew: selectedEew,
        initialCenter: initialCenter,
        initZoom: initZoom,
        displayMode: displayMode,
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _MapContent extends ConsumerWidget {
  const _MapContent({
    required this.styleString,
    required this.selectedEew,
    required this.displayMode,
    required this.initialCenter,
    required this.initZoom,
  });

  final String styleString;
  final EewTelegramItem? selectedEew;
  final Geographic initialCenter;
  final double initZoom;
  final EewDisplayMode displayMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSettings = ref.watch(
      homeConfigurationProvider.select(
        (v) => v.value?.map ?? const HomeMapSettings(),
      ),
    );
    final (:maxZoom, :gestures) = sharedMapOptionsFromSettings(mapSettings);
    final mapOptions = MapOptions(
      initCenter: initialCenter,
      initZoom: initZoom,
      initStyle: styleString,
      maxZoom: maxZoom,
      gestures: gestures,
    );

    return MapLibreMap(
      options: mapOptions,
      children: [
        EewForecastRegionLayer(eew: selectedEew, displayMode: displayMode),
        EewStaticPsWaveLayer(eew: selectedEew),
        if (selectedEew case final eew?)
          EewHypocenterLayer(eews: [eew])
        else
          const EewHypocenterLayer(eews: []),
      ],
    );
  }
}
