import 'dart:async';
import 'dart:ui';

import 'package:eqmonitor/core/component/sheet/app_sheet_route.dart';
import 'package:eqmonitor/core/component/widget/app_list_tile.dart';
import 'package:eqmonitor/core/provider/config/permission/permission_notifier.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_settings_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeMapLayerModal extends HookConsumerWidget {
  const HomeMapLayerModal({super.key});

  static Future<void> show(BuildContext context) => Navigator.of(context).push(
    AppSheetRoute(
      builder:
          (context) => const ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: HomeMapLayerModal(),
          ),
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = colorScheme.surfaceContainerLow;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: BackdropFilter(
              filter: ImageFilter.compose(
                outer: ImageFilter.blur(
                  sigmaX: 8,
                  sigmaY: 8,
                  tileMode: TileMode.mirror,
                ),
                inner: ColorFilter.mode(
                  colorScheme.surfaceContainerLow.withValues(alpha: 0.7),
                  BlendMode.srcATop,
                ),
              ),
              child: const Text(
                'マップレイヤー',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton.filledTonal(
                onPressed: () {
                  unawaited(HapticFeedback.lightImpact());
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: _KyoshinMonitorIsEnabledTile()),
          const SliverToBoxAdapter(child: _LocationSettingCards()),
        ],
      ),
    );
  }
}

class _LocationSettingCards extends ConsumerWidget {
  const _LocationSettingCards();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final config = ref.watch(homeConfigurationNotifierProvider);
    final permissionState = ref.watch(permissionNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '現在位置マーカー',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _LocationCard(
                  title: '非表示',
                  icon: Icons.location_off_outlined,
                  isSelected: !config.showLocation,
                  onTap:
                      () async => lightHapticFunction(
                        () async => ref
                            .read(homeConfigurationNotifierProvider.notifier)
                            .save(config.copyWith(showLocation: false)),
                      ),
                ),
              ),
              Expanded(
                child: _LocationCard(
                  title: '表示',
                  icon: Icons.location_on_outlined,
                  isSelected: config.showLocation,
                  subtitle: !permissionState.location ? '位置情報が許可されていません' : null,
                  onTap:
                      () async => lightHapticFunction(() async {
                        // 位置情報の権限がない場合は要求する
                        if (!permissionState.location) {
                          await ref
                              .read(permissionNotifierProvider.notifier)
                              .requestLocationWhenInUsePermission();
                          // 権限が付与されなかった場合は早期リターン
                          if (!ref.read(permissionNotifierProvider).location) {
                            return;
                          }
                        }
                        // 権限がある場合は位置情報表示を有効化
                        await ref
                            .read(homeConfigurationNotifierProvider.notifier)
                            .save(config.copyWith(showLocation: true));
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.subtitle,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card.outlined(
      elevation: 0,
      color:
          isSelected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainer,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color:
                        isSelected
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color:
                          isSelected
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _KyoshinMonitorIsEnabledTile extends ConsumerWidget {
  const _KyoshinMonitorIsEnabledTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(kyoshinMonitorSettingsProvider);

    final subtitle =
        setting.useKmoni
            ? '強震モニタのリアルタイムデータを表示します \n'
                '(${setting.realtimeDataType.displayName}: ${setting.realtimeLayer.displayName})'
            : '強震モニタを利用していません';

    return Padding(
      padding: const EdgeInsets.all(8),
      child: AppListTile.listTile(
        title: '強震モニタ',
        subtitle: subtitle,
        trailing: const Icon(Icons.chevron_right),
        onTap: () async => KyoshinMonitorSettingsModal.show(context),
      ),
    );
  }
}
