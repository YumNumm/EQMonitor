import 'dart:async';

import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/core/theme/custom_colors.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/onboarding/ui/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('device registration gates the welcome next button', (
    tester,
  ) async {
    final notifier = _ControlledDeviceProvisioningNotifier();
    await tester.pumpWidget(_wrap(notifier: notifier));
    await tester.pump();

    expect(_nextButton(tester).onPressed, isNull);

    notifier.completeProvisioning();
    await tester.pumpAndSettle();

    expect(_nextButton(tester).onPressed, isNotNull);

    await tester.tap(find.widgetWithText(FilledButton, '次へ'));
    await tester.pumpAndSettle();

    expect(find.text('通知と\n位置情報'), findsOneWidget);
  });

  testWidgets('device registration errors are shown in a dialog', (
    tester,
  ) async {
    final notifier = _ControlledDeviceProvisioningNotifier();
    await tester.pumpWidget(_wrap(notifier: notifier));
    await tester.pump();

    notifier.failProvisioning();
    await tester.pumpAndSettle();

    expect(find.text('デバイスの登録に失敗しました'), findsOneWidget);
    expect(find.text('予期しないエラーが発生しました'), findsOneWidget);
    expect(_nextButton(tester).onPressed, isNull);
  });
}

FilledButton _nextButton(WidgetTester tester) =>
    tester.widget<FilledButton>(find.widgetWithText(FilledButton, '次へ'));

Widget _wrap({required _ControlledDeviceProvisioningNotifier notifier}) {
  const brandBlue = Color(0xFF1E88E5);
  final theme = buildTheme(
    colorScheme: ColorScheme.fromSeed(seedColor: brandBlue),
    customColors: const CustomColors(danger: Color(0xFFE53935)),
  );

  return ProviderScope(
    overrides: [
      deviceProvisioningProvider.overrideWith(() => notifier),
    ],
    child: MaterialApp(
      theme: theme,
      home: const OnboardingPage(),
    ),
  );
}

final class _ControlledDeviceProvisioningNotifier
    extends DeviceProvisioningNotifier {
  final _provisionCompleter = Completer<void>();

  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.required;

  @override
  Future<void> provision() async {
    await _provisionCompleter.future;
    state = const AsyncData(DeviceProvisioningStatus.notRequired);
  }

  void completeProvisioning() {
    _provisionCompleter.complete();
  }

  void failProvisioning() {
    _provisionCompleter.completeError(
      const UnexpectedProvisioningException(cause: 'test failure'),
    );
  }
}
