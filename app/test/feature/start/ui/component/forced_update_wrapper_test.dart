import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:eqmonitor/feature/start/ui/component/forced_update_dialog.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// `ForcedUpdateWrapper`(StatefulWidget)のダイアログ表示振る舞いを、
/// HookWidget化前に固定するテスト。
void main() {
  testWidgets('強制アップデートが必要な場合は非解除可能なダイアログを表示する', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          packageInfoProvider.overrideWithValue(_packageInfo(version: '1.0.0')),
          startProvider.overrideWith(
            () => _FakeStartNotifier(requiredVersion: '2.0.0'),
          ),
        ],
        child: const MaterialApp(
          home: ForcedUpdateWrapper(child: Scaffold(body: Text('home'))),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('アップデートが必要です'), findsOneWidget);
    expect(find.text('home'), findsOneWidget);

    // barrierDismissible: false のため、バリアタップでは閉じない。
    await tester.tapAt(const Offset(1, 1));
    await tester.pumpAndSettle();
    expect(find.text('アップデートが必要です'), findsOneWidget);
  });

  testWidgets('強制アップデートが不要な場合はダイアログを表示しない', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          packageInfoProvider.overrideWithValue(_packageInfo(version: '2.0.0')),
          startProvider.overrideWith(
            () => _FakeStartNotifier(requiredVersion: '2.0.0'),
          ),
        ],
        child: const MaterialApp(
          home: ForcedUpdateWrapper(child: Scaffold(body: Text('home'))),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('アップデートが必要です'), findsNothing);
    expect(find.text('home'), findsOneWidget);
  });
}

PackageInfo _packageInfo({required String version}) => PackageInfo(
  appName: 'EQMonitor',
  packageName: 'net.yumnumm.eqmonitor',
  version: version,
  buildNumber: '1',
);

class _FakeStartNotifier extends StartNotifier {
  new({required this.requiredVersion});

  final String requiredVersion;

  @override
  Future<api.StartResponse> build() async => api.StartResponse(
    flags: const api.StartFlags(
      adsEnabled: false,
      maintenance: api.MaintenanceInfo(enabled: false),
    ),
    app: api.StartApp(
      version: api.StartAppVersion(
        requiredVersions: [api.RequiredVersion(version: requiredVersion)],
      ),
      storeUrl: const api.StoreUrl(
        ios: 'https://apps.apple.com/app/id0000000000',
        android: 'https://play.google.com/store/apps/details?id=net.yumnumm.eqmonitor',
      ),
    ),
    planConstraints: const api.PlanConstraintVariants(
      free: _freeConstraints,
      subscription: _subscriptionConstraints,
    ),
  );
}

const _freeConstraints = api.PlanConstraints(
  isPro: false,
  maxRegions: 1,
  eewWarningNationwide: false,
  shakeDetection: false,
  overridesAllowed: false,
  earthquakeDefaultInterruptionLevel: 'active',
  eewDefaultInterruptionLevel: 'active',
);

const _subscriptionConstraints = api.PlanConstraints(
  isPro: true,
  maxRegions: 10,
  eewWarningNationwide: true,
  shakeDetection: true,
  overridesAllowed: true,
  earthquakeDefaultInterruptionLevel: 'timeSensitive',
  eewDefaultInterruptionLevel: 'timeSensitive',
);
