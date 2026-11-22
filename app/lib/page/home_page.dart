import 'dart:async';

import 'package:eqmonitor/core/component/banner/app_banner.dart';
import 'package:eqmonitor/core/component/scroll/bottom_bouncing_scroll_physics.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/asset_pack/ui/component/asset_pack_update_card.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_menu_availability_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/home_eew_card.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_view.dart';
import 'package:eqmonitor/feature/home/ui/component/shake_detection/shake_detection_card.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_sheet_card.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/home_feed_sheet.dart';
import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/location/data/notifier/location_permission_banner_dismissed_notifier.dart';
import 'package:eqmonitor/feature/permission/ui/component/notification_permission_banner.dart';
import 'package:eqmonitor/feature/release_highlight/ui/component/release_highlight_card.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/current_location_permission_action.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/current_location_permission_missing_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:eqmonitor/feature/start/ui/component/maintenance_banner.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const HomePage({super.key}) extends HookConsumerWidget {
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

class const _SheetBody() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eewAliveTelegramProvider) ?? [];
    final shakeEvents = ref.watch(shakeDetectionVisibleProvider);
    final spacing = context.designSystem.spacing;

    final showLocationPermissionBanner =
        ref.watch(isCurrentLocationPermissionMissingProvider) &&
        !(ref.watch(locationPermissionBannerDismissedProvider).value ?? false);

    return SingleChildScrollView(
      physics: const BottomBouncingScrollPhysics(),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.fromLTRB(spacing.md, 0, spacing.md, spacing.md),
        child: Column(
          mainAxisSize: .min,
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
            for (final event in shakeEvents)
              Padding(
                padding: EdgeInsets.only(bottom: spacing.md),
                child: ShakeDetectionCard(
                  event: event,
                  outerPadding: EdgeInsets.zero,
                ),
              ),
            const MaintenanceBanner(),
            const NotificationPermissionBanner(),
            if (showLocationPermissionBanner) const _LocationPermissionBanner(),
            const AssetPackUpdateCard(),
            ReleaseHighlightCard(
              isCompact: state.isNotEmpty || shakeEvents.isNotEmpty,
            ),
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
class const _HomeActionsCard() extends ConsumerWidget {
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
    final isDebugMenuVisible = ref.watch(isDebugMenuAvailableProvider);

    return HomeSheetCard(
      children: [
        Theme(
          data: Theme.of(context).copyWith(visualDensity: .compact),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              ListTile(
                title: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '市区町村別 ',
                        style: typography.bodySmall.copyWith(
                          fontWeight: .bold,
                        ),
                      ),
                      TextSpan(
                        text: '最大観測震度',
                        style: typography.titleSmall,
                      ),
                    ],
                  ),
                ),
                onTap: () async =>
                    const IntensityHistoryRoute().push<void>(context),
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

class const _LocationPermissionBanner() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = context.designSystem.colorTheme;
    final isForegroundOnly =
        ref.watch(backgroundLocationPermissionProvider).value == .whileInUse;
    final isPending = ref
        .watch(CurrentLocationPermissionAction.requestMutation)
        .isPending;

    return AppBanner(
      icon: Icons.location_off_rounded,
      title: isForegroundOnly ? '位置情報が「常に許可」になっていません' : '位置情報が許可されていません',
      description: isForegroundOnly
          ? 'アプリを開いていない間は現在地を更新できません。タップして権限を変更'
          : '現在地に基づく通知は届きません。タップして許可',
      backgroundColor: colorTheme.primaryContainer,
      foregroundColor: colorTheme.onPrimaryContainer,
      onTap: isPending
          ? null
          : () async => const CurrentLocationPermissionAction().request(ref),
      onDismiss: () => unawaited(
        ref.read(locationPermissionBannerDismissedProvider.notifier).dismiss(),
      ),
    );
  }
}
