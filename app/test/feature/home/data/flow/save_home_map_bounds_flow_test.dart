import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/home/data/flow/save_home_map_bounds_flow.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MapController extends Mock implements MapController {
  new({required this.visibleRegion});

  final LngLatBounds visibleRegion;

  @override
  LngLatBounds getVisibleRegion() => visibleRegion;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('表示範囲をcustomとして保存し前画面へ戻る', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final firstContainer = ProviderContainer();
    addTearDown(firstContainer.dispose);
    const visible = LngLatBounds(
      longitudeWest: 129.25,
      longitudeEast: 145.75,
      latitudeSouth: 30.5,
      latitudeNorth: 44.25,
    );
    final controller = _MapController(visibleRegion: visible);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: firstContainer,
        child: MaterialApp(
          initialRoute: '/selector',
          routes: {
            '/': (_) => const Scaffold(body: Text('ホーム')),
            '/selector': (_) => Consumer(
              builder: (context, ref, _) => Scaffold(
                body: FilledButton(
                  onPressed: () => ref
                      .read(saveHomeMapBoundsFlowProvider)
                      .save(
                        context: context,
                        ref: ref,
                        controller: controller,
                      ),
                  child: const Text('保存'),
                ),
              ),
            ),
          },
        ),
      ),
    );

    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    final updated = await firstContainer.read(homeConfigurationProvider.future);
    expect(updated.map.defaultBounds, HomeMapDefaultBounds.custom);
    expect(updated.map.customBounds?.southWest.lat, 30.5);
    expect(updated.map.customBounds?.southWest.lon, 129.25);
    expect(updated.map.customBounds?.northEast.lat, 44.25);
    expect(updated.map.customBounds?.northEast.lon, 145.75);

    final preferences = await SharedPreferences.getInstance();
    final savedJson = preferences.getString(
      SharedPreferencesKey.homeConfiguration.key,
    );
    if (savedJson == null) {
      fail('home_configuration was not saved');
    }
    final savedConfiguration = jsonDecode(savedJson) as Map<String, dynamic>;
    final savedMap = savedConfiguration['map'] as Map<String, dynamic>;
    expect(savedMap['default_bounds'], 'custom');
    expect(savedMap['custom_bounds'], <String, dynamic>{
      'northEast': <String, dynamic>{'latitude': 44.25, 'longitude': 145.75},
      'southWest': <String, dynamic>{'latitude': 30.5, 'longitude': 129.25},
    });

    final secondContainer = ProviderContainer();
    final restored = await secondContainer.read(
      homeConfigurationProvider.future,
    );
    await tester.pump();
    expect(restored.map.defaultBounds, HomeMapDefaultBounds.custom);
    expect(restored.map.customBounds?.southWest.lat, 30.5);
    expect(restored.map.customBounds?.southWest.lon, 129.25);
    expect(restored.map.customBounds?.northEast.lat, 44.25);
    expect(restored.map.customBounds?.northEast.lon, 145.75);
    secondContainer.dispose();

    expect(find.text('ホーム'), findsOneWidget);
    expect(find.text('保存'), findsNothing);
  });
}
