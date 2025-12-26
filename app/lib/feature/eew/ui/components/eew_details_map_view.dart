import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_display_mode.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_forecast_region_layer.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_static_ps_wave_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_hypocenter_layer.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewDetailsMapView extends HookConsumerWidget {
  const EewDetailsMapView({
    required this.eew,
    required this.displayMode,
    super.key,
  });

  final EewItemWithRelations? eew;
  final EewDisplayMode displayMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => _MapContent(
        styleString: value.styleString!,
        eew: eew,
        displayMode: displayMode,
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _MapContent extends StatelessWidget {
  const _MapContent({
    required this.styleString,
    required this.eew,
    required this.displayMode,
  });

  final String styleString;
  final EewItemWithRelations? eew;
  final EewDisplayMode displayMode;

  @override
  Widget build(BuildContext context) {
    final initialCenter = _getInitialCenter();

    final mapOptions = MapOptions(
      initCenter: initialCenter,
      initZoom: 5,
      initStyle: styleString,
    );

    return MapLibreMap(
      options: mapOptions,
      children: [
        EewForecastRegionLayer(eew: eew, displayMode: displayMode),
        EewStaticPsWaveLayer(eew: eew),
        EewHypocenterLayer(eews: eew != null ? [eew!] : []),
      ],
    );
  }

  Geographic _getInitialCenter() {
    if (eew == null) {
      return const Geographic(lon: 138, lat: 36);
    }

    final coords = eew!.hypocenter?.coordinates;
    if (coords case CoordinateLatLng(:final latitude, :final longitude)) {
      return Geographic(lon: longitude, lat: latitude);
    }

    return const Geographic(lon: 138, lat: 36);
  }
}
