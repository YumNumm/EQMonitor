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
    final color = context.designSystem.color;

    return Scaffold(
      backgroundColor: color.backgroundDefault,
      body: const Stack(
        children: [
          HomeMapView(),
          BasicModalSheet(
            child: _SheetBody(),
          ),
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
    final color = designSystem.color;
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
    final showPermissionBanner =
        hasCurrentLocationRegion &&
        permission != null &&
        permission != LocationPermission.always;

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
      color: color.surfaceCard,
      clipBehavior: Clip.antiAlias,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(designSystem.shape.card),
        side: BorderSide(color: color.outlineSoft),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          visualDensity: .compact,
        ),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.bar_chart_outlined),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '都道府県別 ',
                      style: typography.bodySmall.copyWith(
                        fontWeight: .bold,
                      ),
                    ),
                    TextSpan(
                      text: '最大震度',
                      style: typography.titleSmall,
                    ),
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
                    _BackgroundLocationPermissionBanner(
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
            if (state.isEmpty)
              SizedBox(
                height: spacing.sm,
              ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundLocationPermissionBanner extends StatelessWidget {
  const _BackgroundLocationPermissionBanner({required this.bottomSpacing});

  final double bottomSpacing;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Material(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async => Geolocator.openAppSettings(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  Icons.location_off_outlined,
                  color: colorScheme.onErrorContainer,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '位置情報の「常に許可」が必要です',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: colorScheme.onErrorContainer,
                        ),
                      ),
                      Text(
                        'バックグラウンド位置更新が無効のため、通知は過去の位置情報を使用しています',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onErrorContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: colorScheme.onErrorContainer,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
