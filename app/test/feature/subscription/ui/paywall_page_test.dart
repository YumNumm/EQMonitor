import 'dart:async';

import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/flow/paywall_flow.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/provider/monthly_subscription_package_provider.dart';
import 'package:eqmonitor/feature/subscription/ui/page/paywall_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;

void main() {
  testWidgets('uses the returned localized price and enables purchase', (
    tester,
  ) async {
    await pumpPaywall(tester, loadPackage: () async => _package);
    expect(find.text(r'$4.99 / 月'), findsOneWidget);
    expect(find.textContaining('320'), findsNothing);
    expect(
      tester
          .widget<M3EButton>(find.widgetWithText(M3EButton, 'Pro にアップグレード'))
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('loading package disables purchase without a fallback price', (
    tester,
  ) async {
    final pending = Completer<rc.Package?>();
    await pumpPaywall(tester, loadPackage: () => pending.future);
    expect(find.textContaining(' / 月'), findsNothing);
    expect(
      tester
          .widget<M3EButton>(find.widgetWithText(M3EButton, 'Pro にアップグレード'))
          .onPressed,
      isNull,
    );
    pending.complete(_package);
    await tester.pumpAndSettle();
    expect(find.text(r'$4.99 / 月'), findsOneWidget);
  });

  testWidgets('package error disables purchase and retry reloads offerings', (
    tester,
  ) async {
    var attempts = 0;
    await pumpPaywall(
      tester,
      loadPackage: () async {
        attempts++;
        if (attempts == 1) {
          throw StateError('offerings unavailable');
        }
        return _package;
      },
    );
    expect(find.text('プラン情報を取得できませんでした。通信状況を確認して再試行してください。'), findsOneWidget);
    expect(
      tester
          .widget<M3EButton>(find.widgetWithText(M3EButton, 'Pro にアップグレード'))
          .onPressed,
      isNull,
    );
    await tester.tap(find.text('再試行'));
    await tester.pumpAndSettle();
    expect(attempts, 2);
    expect(find.text(r'$4.99 / 月'), findsOneWidget);
    expect(
      tester
          .widget<M3EButton>(find.widgetWithText(M3EButton, 'Pro にアップグレード'))
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('unavailable package remains disabled', (tester) async {
    await pumpPaywall(tester, loadPackage: () async => null);
    expect(find.textContaining(' / 月'), findsNothing);
    expect(find.text('再試行'), findsOneWidget);
    expect(
      tester
          .widget<M3EButton>(find.widgetWithText(M3EButton, 'Pro にアップグレード'))
          .onPressed,
      isNull,
    );
  });

  for (final status in [
    const SubscriptionStatus.active(productId: 'pro'),
    const SubscriptionStatus.inactive(syncPhase: SubscriptionSyncPhase.pending),
    const SubscriptionStatus.inactive(
      syncPhase: SubscriptionSyncPhase.authenticationRequired,
    ),
  ]) {
    testWidgets('purchase is disabled while subscription is $status', (
      tester,
    ) async {
      await pumpPaywall(
        tester,
        loadPackage: () async => _package,
        subscription: Future.value(status),
      );
      expect(
        tester
            .widget<M3EButton>(find.widgetWithText(M3EButton, 'Pro にアップグレード'))
            .onPressed,
        isNull,
      );
    });
  }

  testWidgets(
    'authentication failure offers device recovery without purchasing',
    (tester) async {
      final flow = _RecordingFlow();
      await pumpPaywall(
        tester,
        loadPackage: () async => _package,
        subscription: Future.value(
          const SubscriptionStatus.inactive(
            syncPhase: SubscriptionSyncPhase.authenticationRequired,
          ),
        ),
        flow: flow,
      );
      await tester.ensureVisible(find.text('デバイス登録を再試行'));
      await tester.tap(find.text('デバイス登録を再試行'));
      await tester.pump();
      expect(flow.recoveries, 1);
    },
  );

  testWidgets('unknown subscription disables purchase', (tester) async {
    final pending = Completer<SubscriptionStatus>();
    await pumpPaywall(
      tester,
      loadPackage: () async => _package,
      subscription: pending.future,
    );
    expect(
      tester
          .widget<M3EButton>(find.widgetWithText(M3EButton, 'Pro にアップグレード'))
          .onPressed,
      isNull,
    );
    pending.complete(const SubscriptionStatus.inactive());
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<M3EButton>(find.widgetWithText(M3EButton, 'Pro にアップグレード'))
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('large text keeps the price and purchase control usable', (
    tester,
  ) async {
    await pumpPaywall(tester, loadPackage: () async => _package, textScale: 2);
    expect(find.text(r'$4.99 / 月'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<void> pumpPaywall(
  WidgetTester tester, {
  required Future<rc.Package?> Function() loadPackage,
  Future<SubscriptionStatus>? subscription,
  double textScale = 1,
  PaywallFlow? flow,
}) async {
  await tester.binding.setSurfaceSize(const Size(430, 2600));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        if (flow != null) paywallFlowProvider.overrideWithValue(flow),
        monthlySubscriptionPackageProvider.overrideWith((ref) => loadPackage()),
        subscriptionProvider.overrideWith(
          () => _SubscriptionNotifier(
            subscription ?? Future.value(const SubscriptionStatus.inactive()),
          ),
        ),
        deviceProvisioningProvider.overrideWith(_ProvisionedNotifier.new),
        pushTokenSyncProvider.overrideWith(_IdlePushTokenNotifier.new),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [DesignSystemThemeExtension.light()],
        ),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(textScale)),
          child: child ?? const SizedBox.shrink(),
        ),
        home: const PaywallPage(),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
  await tester.scrollUntilVisible(find.text('Pro にアップグレード'), 300);
  await tester.pump();
}

class _SubscriptionNotifier extends SubscriptionNotifier {
  new(this.initial);

  final Future<SubscriptionStatus> initial;

  @override
  Future<SubscriptionStatus> build() => initial;
}

class _ProvisionedNotifier extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.notRequired;
}

class _IdlePushTokenNotifier extends PushTokenSyncNotifier {
  @override
  Future<PushTokenSyncSnapshot> build() async => const PushTokenSyncSnapshot(
    fcm: NotApplicableTokenState(),
    apnsNotification: NotApplicableTokenState(),
    apnsPushToStart: NotApplicableTokenState(),
  );
}

const _package = rc.Package(
  r'$rc_monthly',
  rc.PackageType.monthly,
  rc.StoreProduct(
    'pro_monthly',
    'Monthly subscription',
    'Pro',
    4.99,
    r'$4.99',
    'USD',
    subscriptionPeriod: 'P1M',
  ),
  rc.PresentedOfferingContext('current', null, null),
);

class _RecordingFlow extends PaywallFlow {
  var recoveries = 0;
  @override
  Future<void> recoverDevice(WidgetRef ref, BuildContext context) async {
    recoveries++;
  }
}
