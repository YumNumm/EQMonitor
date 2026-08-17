import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/onboarding/data/notifier/onboarding_notifier.dart';
import 'package:eqmonitor/feature/onboarding/ui/page/onboarding_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _app(Widget child) => MaterialApp(
  theme: ThemeData.light().copyWith(
    extensions: [DesignSystemThemeExtension.light()],
  ),
  home: child,
);

// `_WelcomeStepPage.completeAndGoHome` は成功後に `HomeRoute().go(context)`
// (= `context.go('/')`) を呼ぶ。実際の `HomeRoute`/`HomePage` は多数の
// provider に依存するため、テストでは同じパス `'/'` に軽量なプレースホルダーを
// 割り当てた最小限の `GoRouter` を用意し、遷移そのものが例外にならないようにする。
Widget _appWithRouter(Widget onboarding) {
  final router = GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => const Scaffold(body: Text('Home')),
      ),
      GoRoute(path: '/onboarding', builder: (_, _) => onboarding),
    ],
  );
  return MaterialApp.router(
    theme: ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    ),
    routerConfig: router,
  );
}

class _FakeDeviceProvisioningNotifier extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.notRequired;
}

// `OnboardingPage` の `useEffect` は、毎ビルドで新規生成される
// `_OnboardingStepNavigation` を依存配列に含んでいるため、
// register() -> postFrameCallback -> setState -> rebuild が
// 際限なく繰り返され `SchedulerBinding.hasScheduledFrame` が常に true
// のままになる（既存の実装上の挙動であり、本タスクの変更とは無関係）。
// そのため `pumpAndSettle` は永久に終了せずタイムアウトする。
// 代わりに固定回数の `pump` でプロバイダの非同期解決とフックの再ビルドを
// 待ち合わせる。
Future<void> _pumpFrames(WidgetTester tester, {int times = 10}) async {
  for (var i = 0; i < times; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('移行済みなら welcome の次へボタンが「はじめる」になる', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deviceProvisioningProvider.overrideWith(
            _FakeDeviceProvisioningNotifier.new,
          ),
          deviceMigratedFromLegacyProvider.overrideWith((ref) async => true),
        ],
        child: _app(const OnboardingPage()),
      ),
    );
    await _pumpFrames(tester);

    expect(find.widgetWithText(FilledButton, 'はじめる'), findsOneWidget);
  });

  testWidgets('移行済みで「はじめる」押下すると onboardingCompleted が true', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer(
      overrides: [
        deviceProvisioningProvider.overrideWith(
          _FakeDeviceProvisioningNotifier.new,
        ),
        deviceMigratedFromLegacyProvider.overrideWith((ref) async => true),
      ],
    );
    addTearDown(container.dispose);
    // `OnboardingCompleted.build()` を先に解決させておく。未解決のまま
    // `complete()` で `state` を手動 true にすると、後から初回 build() の
    // Future が解決した際に `state` が上書きされてしまうため。
    await container.read(onboardingCompletedProvider.future);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _appWithRouter(const OnboardingPage()),
      ),
    );
    await _pumpFrames(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'はじめる'));
    await _pumpFrames(tester, times: 5);

    expect(container.read(onboardingCompletedProvider).value, isTrue);
  });
}
