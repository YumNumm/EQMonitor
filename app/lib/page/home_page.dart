import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/ui/component/device_provisioning_banner.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_view.dart';
import 'package:eqmonitor/feature/home/ui/component/shake_detection/shake_detection_card.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/home_feed_sheet.dart';
import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/location/data/notifier/location_permission_banner_dismissed_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:eqmonitor/feature/start/ui/component/maintenance_banner.dart';
import 'package:eqmonitor/feature/start/ui/component/whats_new_banner.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = context.designSystem.colorTheme;

    return Scaffold(
      backgroundColor: colorTheme.surfaceContainerLow,
      body: const Stack(
        children: [
          HomeMapView(),
          BasicModalSheet(child: _SheetBody()),
        ],
      ),
    );
  }
}

class _SheetBody extends ConsumerWidget {
  const _SheetBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eewAliveTelegramProvider) ?? [];
    final shakeEvents = ref.watch(shakeDetectionVisibleProvider);
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    // プロビジョニング未完了なら自動開始
    ref.listen(deviceProvisioningProvider, (_, next) {
      if (next.value == DeviceProvisioningStatus.required) {
        final mutation = DeviceProvisioningNotifier.provisionMutation;
        if (ref.read(mutation) is! MutationPending) {
          unawaited(
            mutation.run(
              ref,
              (tsx) async =>
                  tsx.get(deviceProvisioningProvider.notifier).provision(),
            ),
          );
        }
      }
    });

    // プロビジョニング完了後にトークン同期を自動開始
    ref.listen(deviceProvisioningProvider, (_, next) {
      if (next.value == DeviceProvisioningStatus.notRequired) {
        final mutation = PushTokenSyncNotifier.syncMutation;
        if (ref.read(mutation) is! MutationPending) {
          unawaited(
            mutation.run(
              ref,
              (tsx) async => tsx.get(pushTokenSyncProvider.notifier).sync(),
            ),
          );
        }
      }
    });

    final hasCurrentLocationRegion = ref.watch(
      notificationSlotsProvider.select(
        (s) =>
            s.value?.any(
              (slot) => slot.slotType == NotificationSlotType.currentLocation,
            ) ??
            false,
      ),
    );
    final permission = ref.watch(backgroundLocationPermissionProvider).value;
    final isPermissionBannerDismissed =
        ref.watch(locationPermissionBannerDismissedProvider).value ?? false;
    final showPermissionBanner =
        hasCurrentLocationRegion &&
        permission != null &&
        permission != .always &&
        !isPermissionBannerDismissed;

    final eewCards = Column(
      children: state.reversed
          .mapIndexed(
            (index, element) => Padding(
              padding: EdgeInsets.only(bottom: spacing.md),
              child: EewCard(
                eew: element,
                index: (state.length > 1) ? '${index + 1}' : null,
              ),
            ),
          )
          .toList(),
    );

    final actionsCard = Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: colorTheme.surfaceContainerHigh,
      clipBehavior: .antiAlias,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(designSystem.shape.card),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(visualDensity: .compact),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.bar_chart_outlined),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '都道府県別 ',
                      style: typography.bodySmall.copyWith(fontWeight: .bold),
                    ),
                    TextSpan(text: '最大震度', style: typography.titleSmall),
                  ],
                ),
              ),
              onTap: () async =>
                  const IntensityHistoryRoute().push<void>(context),
            ),
            Divider(height: 1, indent: spacing.xl, endIndent: spacing.xl),
            ListTile(
              title: Text('緊急地震速報の履歴', style: typography.titleSmall),
              onTap: () async => const EewHistoryRoute().push<void>(context),
            ),
            Divider(height: 1, indent: spacing.xl, endIndent: spacing.xl),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: Text('設定', style: typography.titleSmall),
              onTap: () async => const SettingsRoute().push<void>(context),
            ),
            Divider(height: 1, indent: spacing.xl, endIndent: spacing.xl),
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: Text('デバッグページ', style: typography.titleSmall),
              onTap: () async => const DebugRoute().push<void>(context),
            ),
          ],
        ),
      ),
    );

    final padding = MediaQuery.paddingOf(context);
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                spacing.sm + padding.left,
                0,
                spacing.sm + padding.right,
                padding.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.isNotEmpty) eewCards,
                  MaintenanceBanner(bottomSpacing: spacing.md),
                  WhatsNewBanner(bottomSpacing: spacing.md),
                  DeviceProvisioningBanner(bottomSpacing: spacing.md),
                  if (showPermissionBanner) ...[
                    _LocationPermissionBanner(
                      bottomSpacing: spacing.md,
                    ),
                  ],
                  if (shakeEvents.isNotEmpty)
                    Column(
                      children: shakeEvents
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(bottom: spacing.md),
                              child: ShakeDetectionCard(event: e),
                            ),
                          )
                          .toList(),
                    ),
                  const HomeEarthquakeHistorySheet(),
                  SizedBox(height: spacing.md),
                  const HomeFeedSheet(),
                  SizedBox(height: spacing.lg),
                  actionsCard,
                ],
              ),
            ),
            if (state.isEmpty) SizedBox(height: spacing.sm),
          ],
        ),
      ),
    );
  }
}

class _LocationPermissionBanner extends ConsumerWidget {
  const _LocationPermissionBanner({required this.bottomSpacing});

  final double bottomSpacing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;

    final permission = ref.watch(backgroundLocationPermissionProvider).value;

    final message = switch (permission) {
      .denied || .deniedForever => (
        '位置情報権限が許可されていません',
        '位置情報の権限が許可されていません。\n'
            '現在地の緊急地震速報の表示や、現在地に基づく通知が行われません',
      ),
      .whileInUse => ('現在地のバックグラウンド取得が許可されていません', ''),
      .unableToDetermine => throw UnimplementedError('Web platform?'),
      .always => throw UnimplementedError('Already granted'),
      null => throw UnimplementedError('Not determined'),
    };

    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Material(
        color: colorTheme.primaryContainer,
        borderRadius: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(designSystem.shape.card),
        ).borderRadius,
        clipBehavior: .antiAlias,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.md,
            vertical: spacing.sm,
          ),
          child: Row(
            spacing: spacing.md,
            children: [
              Icon(
                Icons.info_rounded,
                color: colorTheme.onPrimaryContainer,
                size: 24,
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final result = await Geolocator.requestPermission();
                    if (result == .deniedForever ||
                        result == .denied ||
                        result == .whileInUse) {
                      await Geolocator.openLocationSettings();
                    }
                  },
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        message.$1,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: colorTheme.onPrimaryContainer,
                        ),
                      ),
                      if (message.$2.isNotEmpty)
                        Text(
                          message.$2,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: colorTheme.onPrimaryContainer,
                              ),
                        ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: colorTheme.onPrimaryContainer,
                  size: 20,
                ),
                tooltip: '閉じる',
                onPressed: () => unawaited(
                  ref
                      .read(locationPermissionBannerDismissedProvider.notifier)
                      .dismiss(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
