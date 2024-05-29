import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();

  // Wait for loading
  setUp(() async {
    await container.read(travelTimeDepthMapProvider.future);
  });

  test('travelTimeDepthMap', () {
    final travelTimeDepthMap = container.read(travelTimeDepthMapProvider);
    expect(travelTimeDepthMap, isNotNull);
  });

  group(
    'TravelTimeDepthMapCalc',
    () {
      // https://zenn.dev/boocsan/articles/travel-time-table-converter-adcal2020?#%E5%8B%95%E4%BD%9C%E7%A2%BA%E8%AA%8D より
      test(
        '20km 20sec',
        () async {
          final travelMap =
              await container.read(travelTimeDepthMapProvider.future);
          final result = travelMap.getTravelTime(20, 20);
          expect(result.pDistance, 122.35900962861072);
          expect(result.sDistance, 67.68853695324285);
        },
      );
      test(
        '100km 200sec',
        () async {
          final travelMap =
              await container.read(travelTimeDepthMapProvider.future);
          final result = travelMap.getTravelTime(100, 200);
          expect(result.pDistance, 1603.2552083333333);
          expect(result.sDistance, 868.2417083144026);
        },
      );
      test(
        '200km 200sec',
        () async {
          final travelMap =
              await container.read(travelTimeDepthMapProvider.future);
          final result = travelMap.getTravelTime(200, 200);
          expect(result.pDistance, 1639.8745519713261);
          expect(result.sDistance, 874.7576045627376);
        },
      );
      test(
        '300km 200sec',
        () async {
          final travelMap =
              await container.read(travelTimeDepthMapProvider.future);
          final result = travelMap.getTravelTime(300, 200);
          expect(result.pDistance, 1672.7323943661972);
          expect(result.sDistance, 869.2659627953747);
        },
      );
    },
  );
}
