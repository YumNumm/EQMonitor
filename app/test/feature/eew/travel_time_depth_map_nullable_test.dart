import 'dart:async';

import 'package:eqmonitor/core/provider/travel_time/model/travel_time_table.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test(
    'travelTimeDepthMapProvider returns null when travelTimeInternalProvider is still loading',
    () {
      final container = ProviderContainer(
        overrides: [
          travelTimeInternalProvider.overrideWith(
            // never-completing future keeps the internal provider in loading state
            (ref) => Completer<TravelTimeTables>().future,
          ),
        ],
      );
      addTearDown(container.dispose);

      final result = container.read(travelTimeDepthMapProvider);
      expect(result, isNull);
    },
  );
}
