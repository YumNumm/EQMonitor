import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/permission/data/notification_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/notifier/notification_permission_banner_dismissed_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_regions_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/shake_detection_settings_page.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class _Settings extends ShakeDetectionSettingsNotifier {
  var fail = false;
  List<ShakeDetectionEntry>? saved;
  @override
  Future<ShakeDetectionState> build() async => (
    entries: [
      const ShakeDetectionEntry(
        id: 'nationwide',
        targetType: ShakeDetectionTargetType.nationwide,
        regionCode: null,
        enabled: false,
        minLevel: ShakeDetectionLevel.medium,
      ),
      const ShakeDetectionEntry(
        id: 'tokyo',
        targetType: ShakeDetectionTargetType.region,
        regionCode: '350',
        enabled: true,
        minLevel: ShakeDetectionLevel.weak,
      ),
    ],
    requiresReconfiguration: true,
  );
  @override
  Future<void> save(List<ShakeDetectionEntry> entries) async {
    if (fail) throw StateError('offline');
    saved = entries;
    state = AsyncData((entries: entries, requiresReconfiguration: false));
  }
}

class _Dismissed extends NotificationPermissionBannerDismissed {
  @override
  Future<bool> build() async => false;
}

Widget app(_Settings settings) => ProviderScope(
  overrides: [
    shakeDetectionSettingsProvider.overrideWith(() => settings),
    backgroundLocationPermissionProvider.overrideWith(
      (ref) async => LocationPermission.always,
    ),
    isNotificationPermissionGrantedProvider.overrideWith((ref) async => true),
    notificationPermissionBannerDismissedProvider.overrideWith(_Dismissed.new),
    shakeDetectionRegionsProvider.overrideWith(
      (ref) async => [
        const EarthquakeParameterPrefectureItem(
          code: '13',
          name: LocalizedName(ja: '東京都'),
          regions: [
            EarthquakeParameterRegionItem(
              code: '350',
              name: LocalizedName(ja: '東京都23区'),
              kana: null,
              cities: [],
            ),
            EarthquakeParameterRegionItem(
              code: '351',
              name: LocalizedName(ja: '東京都多摩東部'),
              kana: null,
              cities: [],
            ),
          ],
        ),
      ],
    ),
  ],
  child: MaterialApp(
    theme: ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    ),
    home: const ShakeDetectionSettingsPage(),
  ),
);

void main() {
  testWidgets(
    'selects a subdivision under its prefecture and prevents duplicate selection',
    (tester) async {
      final settings = _Settings();
      await tester.pumpWidget(app(settings));
      await tester.pumpAndSettle();
      expect(find.text('通知地域を設定し直してください'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('都道府県から細分化地域を追加'), 300);
      await tester.pumpAndSettle();
      await tester.tap(find.text('都道府県から細分化地域を追加'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('東京都'));
      await tester.pumpAndSettle();
      final duplicate = tester.widget<ListTile>(
        find
            .ancestor(
              of: find.text('東京都23区').last,
              matching: find.byType(ListTile),
            )
            .first,
      );
      expect(duplicate.enabled, isFalse);
      await tester.tap(find.text('東京都多摩東部'));
      await tester.pumpAndSettle();
      expect(settings.saved?.last.regionCode, '351');
      expect(settings.saved?.last.targetType, ShakeDetectionTargetType.region);
      expect(find.text('通知地域を設定し直してください'), findsNothing);
    },
  );

  testWidgets('retains the saved toggle and reports a failed save', (
    tester,
  ) async {
    final settings = _Settings()..fail = true;
    await tester.pumpWidget(app(settings));
    await tester.pumpAndSettle();
    await tester.tap(find.text('全国'));
    await tester.pumpAndSettle();
    expect(find.text('設定を保存できませんでした。もう一度お試しください。'), findsOneWidget);
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile).first).value,
      isFalse,
    );
    expect(settings.saved, isNull);
  });
}
