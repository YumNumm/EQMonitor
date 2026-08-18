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
  testWidgets('device registration gates the welcome next button', (
    tester,
  ) async {
    final notifier = _ControlledDeviceProvisioningNotifier();
    await tester.pumpWidget(_wrap(notifier: notifier));
    await tester.pump();
    await tester.pump();

    expect(_nextButton(tester).onPressed, isNull);

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

    expect(find.text('デバイスの登録に失敗しました'), findsOneWidget);
    expect(find.text('予期しないエラーが発生しました'), findsOneWidget);
    expect(_nextButton(tester).onPressed, isNull);
  });

  testWidgets('権限のスキップ状態はオンボーディング画面内で管理する', (tester) async {
    await tester.pumpWidget(
      _wrap(notifier: _ImmediateDeviceProvisioningNotifier()),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('次へ'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('スキップ').first);
    await tester.pump();
    expect(find.text('スキップしました'), findsNWidgets(2));

    await tester.tap(find.text('スキップ').first);
    await tester.pump();
    expect(find.text('スキップしました'), findsNWidgets(4));
    expect(_nextButton(tester).onPressed, isNotNull);
  });
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

final class _ControlledDeviceProvisioningNotifier
    extends DeviceProvisioningNotifier {
  final _provisionCompleter = Completer<void>();
  UnexpectedProvisioningException? _provisioningError;

  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.required;

  @override
  Future<void> provision() async {
    await _provisionCompleter.future;
    final error = _provisioningError;
    if (error != null) {
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
