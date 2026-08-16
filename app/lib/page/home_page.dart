import 'dart:async';

import 'package:eqmonitor/core/component/banner/app_banner.dart';
import 'package:eqmonitor/core/component/scroll/bottom_bouncing_scroll_physics.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/asset_pack/ui/component/asset_pack_update_card.dart';
import 'package:eqmonitor/feature/devices/ui/component/device_provisioning_banner.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/home_eew_card.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_view.dart';
import 'package:eqmonitor/feature/home/ui/component/shake_detection/shake_detection_card.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_sheet_card.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/home_feed_sheet.dart';
import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/location/data/notifier/location_permission_banner_dismissed_notifier.dart';
import 'package:eqmonitor/feature/permission/data/notification_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/notifier/notification_permission_banner_dismissed_notifier.dart';
import 'package:eqmonitor/feature/permission/ui/component/notification_permission_banner.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:eqmonitor/feature/start/ui/component/maintenance_banner.dart';
import 'package:eqmonitor/feature/start/ui/component/whats_new_banner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class HomePage extends HookConsumerWidget {
  const new({super.key});

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
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eewAliveTelegramProvider) ?? [];
    final shakeEvents = ref.watch(shakeDetectionVisibleProvider);
    final spacing = context.designSystem.spacing;

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

    final isNotificationGranted =
        ref.watch(isNotificationPermissionGrantedProvider).value ?? true;
    final isNotificationBannerDismissed =
        ref.watch(notificationPermissionBannerDismissedProvider).value ?? false;
    final showNotificationBanner =
        !isNotificationGranted && !isNotificationBannerDismissed;

    final isInMaintenance = ref.watch(
      startProvider.select((v) => v.value?.flags.maintenance.enabled ?? false),
    );

    return SingleChildScrollView(
      physics: const BottomBouncingScrollPhysics(),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.fromLTRB(spacing.md, 0, spacing.md, spacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: .stretch,
          children: [
            // バナー・EEW カードは表示条件を満たさないとき何も描画しないため、
            // 間隔は Column の spacing ではなく各 Widget 側の下余白で確保する
            for (final (index, eew) in state.reversed.indexed)
              Padding(
                padding: EdgeInsets.only(bottom: spacing.md),
                child: HomeEewCard(
                  eew: eew,
                  index: (state.length > 1) ? '${index + 1}' : null,
                ),
              ),
            if (isInMaintenance) MaintenanceBanner(),
            WhatsNewBanner(),
            const AssetPackUpdateCard(),
            if (showNotificationBanner) NotificationPermissionBanner(),
            const DeviceProvisioningBanner(),
            if (showPermissionBanner) _LocationPermissionBanner(),
            for (final event in shakeEvents)
              Padding(
                padding: EdgeInsets.only(bottom: spacing.md),
                child: ShakeDetectionCard(event: event),
              ),
            // const LiveMonitorEntryCard(), // TODO(YumNumm): 後で戻す
            Column(
              crossAxisAlignment: .stretch,
              spacing: spacing.md,
              children: const [
                HomeEarthquakeHistorySheet(),
                HomeFeedSheet(),
                _HomeActionsCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ホームシート下部の各画面への導線カード。
class _HomeActionsCard extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final divider = Divider(
      height: 1,
      indent: spacing.lg,
      endIndent: spacing.lg,
    );
    final isDebugMenuVisible =
        ref.watch(buildConfigProvider).isDeveloperUiEnabled &&
        (ref.watch(debugProvider).value ?? false);

    return HomeSheetCard(
      children: [
        Theme(
          data: Theme.of(context).copyWith(visualDensity: .compact),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Stack(
                children: [
                  ListTile(
                    title: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '都道府県別 ',
                            style: typography.bodySmall.copyWith(
                              fontWeight: .bold,
                            ),
                          ),
                          TextSpan(text: '最大震度', style: typography.titleSmall),
                        ],
                      ),
                    ),
                    onTap: null,
                    // TODO(YumNumm): 後で戻す
                    // onTap: () async =>
                    //     const IntensityHistoryRoute().push<void>(context),
                  ),
                  Positioned.fill(
                    child: ColoredBox(
                      color: context.designSystem.colorTheme.surface.withValues(
                        alpha: 0.8,
                      ),
                      child: Center(
                        child: Text(
                          'このビルドではこの機能は利用できません',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              divider,
              ListTile(
                title: Text('緊急地震速報の履歴', style: typography.titleSmall),
                onTap: () async => const EewHistoryRoute().push<void>(context),
              ),
              divider,
              ListTile(
                title: Text('設定', style: typography.titleSmall),
                onTap: () async => const SettingsRoute().push<void>(context),
              ),
              if (isDebugMenuVisible) ...[
                divider,
                ListTile(
                  title: Text('デバッグページ', style: typography.titleSmall),
                  onTap: () async => const DebugRoute().push<void>(context),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _LocationPermissionBanner extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = context.designSystem.colorTheme;

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

    return AppBanner(
      icon: Icons.info_rounded,
      title: message.$1,
      description: message.$2,
      backgroundColor: colorTheme.primaryContainer,
      foregroundColor: colorTheme.onPrimaryContainer,
      onTap: () async {
        final result = await Geolocator.requestPermission();
        if (result == .deniedForever ||
            result == .denied ||
            result == .whileInUse) {
          await Geolocator.openLocationSettings();
        }
      },
      onDismiss: () => unawaited(
        ref.read(locationPermissionBannerDismissedProvider.notifier).dismiss(),
      ),
    );
  }
}
