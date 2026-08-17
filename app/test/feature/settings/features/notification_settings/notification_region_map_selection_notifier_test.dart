import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_map_selection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_region_map_selection_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  const city = NotificationCityOption(
    code: '0110100',
    name: '札幌市',
    kana: 'さっぽろし',
  );
  final region = NotificationRegionOption(
    code: '9011',
    name: '北海道道央',
    kana: 'ほっかいどうどうおう',
    cities: const [city],
  );

  test('全国からregion、市区町村を選択し全国へ戻る', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(
      notificationRegionMapSelectionControllerProvider.notifier,
    );

    expect(
      container.read(notificationRegionMapSelectionControllerProvider),
      isA<NotificationRegionMapNationwide>(),
    );
    notifier.focusRegion(region);
    expect(notifier.selectCity(city), isTrue);
    final selected = container.read(
      notificationRegionMapSelectionControllerProvider,
    );
    expect(selected, isA<NotificationRegionMapCitySelected>());
    notifier.deselectCity();
    expect(
      container.read(notificationRegionMapSelectionControllerProvider),
      isA<NotificationRegionMapFocused>(),
    );
    notifier.reset();
    expect(
      container.read(notificationRegionMapSelectionControllerProvider),
      isA<NotificationRegionMapNationwide>(),
    );
  });

  test('フォーカス外の市区町村は選択しない', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(
      notificationRegionMapSelectionControllerProvider.notifier,
    )..focusRegion(region);

    expect(
      notifier.selectCity(
        const NotificationCityOption(code: '9999999', name: '地域外', kana: null),
      ),
      isFalse,
    );
    expect(
      container.read(notificationRegionMapSelectionControllerProvider),
      isA<NotificationRegionMapFocused>(),
    );
  });
}
