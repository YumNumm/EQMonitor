import 'dart:async';

import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/onboarding/ui/onboarding_page.dart';
import 'package:eqmonitor/feature/permission/data/model/permission_state.dart';
import 'package:eqmonitor/feature/permission/data/notifier/permission_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  // デバイス登録の状態が確定するまでの間、「次へ」は押せてはならない。
  // 押せてしまうと onNext が未登録なのでタップが完全に無反応になり、
  // 「デバイス登録から進まない」という体験になる。
  testWidgets('welcome next button is disabled while the status is resolving', (
    tester,
  ) async {
    final notifier = _GatedStatusDeviceProvisioningNotifier();
    await tester.pumpWidget(_wrap(notifier: notifier));

    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 100));
      expect(_nextButton(tester).onPressed, isNull);
    }

    // 無反応タップが起きないことを、実際に押して確認する。
    expect(find.text('次へ'), findsOneWidget);
    await tester.tap(find.text('次へ'), warnIfMissed: false);
    await _pumpFrames(tester);
    expect(find.text('EQMonitor へ\nようこそ'), findsOneWidget);
    expect(find.text('通知と位置情報'), findsNothing);

    notifier.releaseStatus();
    await _pumpFrames(tester);
  });

  testWidgets('device registration gates the welcome next button', (
    tester,
  ) async {
    final notifier = _ControlledDeviceProvisioningNotifier();
    await tester.pumpWidget(_wrap(notifier: notifier));
    await _pumpFrames(tester, frames: 4);

    expect(_nextButton(tester).onPressed, isNull);
    expect(find.text('デバイスを登録しています...'), findsOneWidget);

    notifier.completeProvisioning();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(_nextButton(tester).onPressed, isNotNull);
  });

  testWidgets('device registration errors are shown in a dialog', (
    tester,
  ) async {
    final notifier = _ControlledDeviceProvisioningNotifier();
    await tester.pumpWidget(_wrap(notifier: notifier));
    await tester.pump();
    await tester.pump();

    notifier.failProvisioning();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('デバイスの登録に失敗しました'), findsWidgets);
    expect(find.text('予期しないエラーが発生しました'), findsWidgets);
    expect(_nextButton(tester).onPressed, isNull);
  });

  // 登録に失敗したままオンボーディングを進めてしまうと、デバイス未登録=通知が
  // 一切届かない状態で完了できてしまう。
  testWidgets('a failed registration cannot be skipped past', (tester) async {
    final notifier = _ControlledDeviceProvisioningNotifier();
    await tester.pumpWidget(_wrap(notifier: notifier));
    await tester.pump();
    await tester.pump();

    notifier.failProvisioning();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('閉じる'));
    await _pumpFrames(tester);

    expect(_nextButton(tester).onPressed, isNull);
    await tester.tap(find.text('次へ'), warnIfMissed: false);
    await _pumpFrames(tester);
    expect(find.text('通知と位置情報'), findsNothing);
    expect(find.text('EQMonitor へ\nようこそ'), findsOneWidget);
  });

  // ダイアログを閉じたあとも再試行できる導線が画面上に残っていること。
  // provisionMutation は MutationError のままなので自動再試行は発火しない。
  testWidgets('an inline retry stays available after closing the dialog', (
    tester,
  ) async {
    final notifier = _ControlledDeviceProvisioningNotifier();
    await tester.pumpWidget(_wrap(notifier: notifier));
    await tester.pump();
    await tester.pump();

    notifier.failProvisioning();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('閉じる'));
    await _pumpFrames(tester);

    expect(find.text('デバイスの登録に失敗しました'), findsOneWidget);
    expect(find.text('再試行'), findsOneWidget);

    await tester.tap(find.text('再試行'));
    await _pumpFrames(tester);
    expect(notifier.provisionCallCount, greaterThan(1));
  });

  // register → post-frame callback → useState 更新 → 再ビルド → register の
  // ループでフレームを永久にスケジュールし続けていた回帰のガード。
  testWidgets('the onboarding page settles instead of rebuilding forever', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(notifier: _ImmediateDeviceProvisioningNotifier()),
    );
    await tester.pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 5),
    );
    expect(tester.binding.hasScheduledFrame, isFalse);
  });

  testWidgets('権限のスキップ状態はオンボーディング画面内で管理する', (tester) async {
    await tester.pumpWidget(
      _wrap(notifier: _ImmediateDeviceProvisioningNotifier()),
    );
    await tester.pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 5),
    );

    await tester.tap(find.text('次へ'));
    await tester.pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 5),
    );

    // 通知をスキップすると「重大な通知」も併せてスキップ済みになる。
    await tester.tap(find.text('スキップ').first);
    await tester.pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 5),
    );
    expect(find.text('スキップしました'), findsNWidgets(2));
    // 位置情報がまだ未処理なので「次へ」は押せない。
    expect(_nextButton(tester).onPressed, isNull);

    // 位置情報のカードはビューポート外にあるのでスクロールしてから押す。
    // ListView は一度に全カードを保持しないため、全体の個数ではなく
    // 「スキップ待ちが無くなり次へ進めるか」で検証する。
    await tester.dragUntilVisible(
      find.text('スキップ').last,
      find.byType(ListView),
      const Offset(0, -80),
    );
    await tester.pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 5),
    );
    await tester.tap(find.text('スキップ').first);
    await tester.pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 5),
    );
    expect(find.text('スキップ'), findsNothing);
    expect(_nextButton(tester).onPressed, isNotNull);
  });
}

/// アニメーションと post-frame callback を消化するのに十分なフレームを進める。
Future<void> _pumpFrames(WidgetTester tester, {int frames = 40}) async {
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 16));
  }
}

FilledButton _nextButton(WidgetTester tester) =>
    tester.widget<FilledButton>(find.byType(FilledButton).last);

Widget _wrap({required DeviceProvisioningNotifier notifier}) {
  final theme = AppThemeDataBuilder.build(
    colorSet: AppTheme.eqmonitorDefault().light!,
    brightness: Brightness.light,
  );

  return ProviderScope(
    overrides: [
      deviceProvisioningProvider.overrideWith(() => notifier),
      permissionProvider.overrideWith(_DeniedPermissionNotifier.new),
    ],
    child: MaterialApp(
      theme: theme,
      builder: (context, child) => DefaultAssetBundle(
        bundle: _OnboardingTestAssetBundle(),
        child: child ?? const SizedBox.shrink(),
      ),
      home: const OnboardingPage(),
    ),
  );
}

final class _ImmediateDeviceProvisioningNotifier
    extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.notRequired;
}

final class _DeniedPermissionNotifier extends PermissionNotifier {
  @override
  Future<PermissionState> build() async => const PermissionState(
    isNotificationGranted: false,
    isCriticalAlertSupported: true,
    isCriticalAlertGranted: false,
    isForegroundLocationGranted: false,
    isBackgroundLocationGranted: false,
  );
}

/// `build()` が解決するまで待たせて、状態確認中のウィンドウを再現する。
final class _GatedStatusDeviceProvisioningNotifier
    extends DeviceProvisioningNotifier {
  final _statusGate = Completer<void>();

  @override
  Future<DeviceProvisioningStatus> build() async {
    await _statusGate.future;
    return DeviceProvisioningStatus.required;
  }

  @override
  Future<void> provision() async {
    state = const AsyncData(DeviceProvisioningStatus.notRequired);
  }

  void releaseStatus() => _statusGate.complete();
}

final class _ControlledDeviceProvisioningNotifier
    extends DeviceProvisioningNotifier {
  var _provisionCompleter = Completer<void>();
  UnexpectedProvisioningException? _provisioningError;
  var provisionCallCount = 0;

  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.required;

  @override
  Future<void> provision() async {
    provisionCallCount += 1;
    await _provisionCompleter.future;
    final error = _provisioningError;
    if (error != null) {
      // 次の試行のためにゲートを張り直す。
      _provisionCompleter = Completer<void>();
      _provisioningError = null;
      throw error;
    }
    state = const AsyncData(DeviceProvisioningStatus.notRequired);
  }

  void completeProvisioning() {
    _provisionCompleter.complete();
  }

  void failProvisioning() {
    _provisioningError = const UnexpectedProvisioningException(
      cause: 'test failure',
    );
    _provisionCompleter.complete();
  }
}

final class _OnboardingTestAssetBundle extends CachingAssetBundle {
  static final _transparentPng = Uint8List.fromList([
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
    0x42,
    0x60,
    0x82,
  ]);

  @override
  Future<ByteData> load(String key) async {
    if (key == 'AssetManifest.bin') {
      final data = const StandardMessageCodec().encodeMessage({
        'assets/images/icon.png': [
          {'asset': 'assets/images/icon.png'},
        ],
      });
      if (data != null) {
        return data;
      }
    }
    return ByteData.view(_transparentPng.buffer);
  }
}
