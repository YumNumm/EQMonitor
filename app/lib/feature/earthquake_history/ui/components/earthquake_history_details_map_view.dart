import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryDetailsMapView extends HookConsumerWidget {
  const EarthquakeHistoryDetailsMapView({required this.earthquake, super.key});

  final Earthquake earthquake;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => LayoutBuilder(
        builder: (context, constraints) {
          return const Placeholder();
        },
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

// class _MapHeader extends ConsumerWidget {
//   const _MapHeader({required this.initialPosition});

//   final MapCameraPosition initialPosition;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox.shrink(),
//         const Column(),
//         EarthquakeHistoryControllerCard(
//           onLayerButtonTap: () async =>
//               EarthquakeHistoryDetailsMapLayerModal.show(context),
//           onLocationButtonTap: () async => throw UnimplementedError(),
//         ),
//       ],
//     );
//   }
// }
