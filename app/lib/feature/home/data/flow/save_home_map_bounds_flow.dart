import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:maplibre/maplibre.dart';

Future<void> saveHomeMapBoundsFlow({
  required BuildContext context,
  required WidgetRef ref,
  required MapController controller,
}) async {
  final region = controller.getVisibleRegion();
  final current = await ref.read(homeConfigurationProvider.future);
  await HomeConfigurationNotifier.saveMutation.run(
    ref,
    (tsx) async => tsx
        .get(homeConfigurationProvider.notifier)
        .updateMap(
          current.map.copyWith(
            defaultBounds: HomeMapDefaultBounds.custom,
            customBounds: LatLngBoundary.fromTwo(
              LatLng(region.latitudeSouth, region.longitudeWest),
              LatLng(region.latitudeNorth, region.longitudeEast),
            ),
          ),
        ),
  );
  if (context.mounted) {
    Navigator.of(context).pop();
  }
}
