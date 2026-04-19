import 'dart:async';
import 'dart:ui';

import 'package:eqmonitor/core/component/sheet/app_sheet_route.dart';
import 'package:eqmonitor/core/component/widget/app_list_tile.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/page/home_map_bounds_selector_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_settings_modal.dart';
import 'package:eqmonitor/feature/location/data/location_tracking_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeMapLayerModal extends HookConsumerWidget {
  const HomeMapLayerModal({super.key});

  static Future<void> show(BuildContext context) => Navigator.of(context).push(
    AppSheetRoute(
      builder: (context) => const ClipRRect(
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
          SliverList.list(
            children: const [
              _SectionHeader(label: '緊急地震速報'),
              _EewFillModeTile(),
              _EewPsWaveTile(),
              _EewAnimationTile(),
              _EewAutoZoomTile(),
              _SectionHeader(label: '現在地'),
              _LocationPermissionTile(),
              _ShowLocationTile(),
              _SectionHeader(label: '強震モニタ'),
              _KyoshinMonitorIsEnabledTile(),
              _KyoshinMinShindoTile(),
              _KyoshinMarkerSizeTile(),
              _SectionHeader(label: 'マップ'),
              _MapLockBearingTile(),
              _MapMaxZoomTile(),
              _MapDefaultBoundsTile(),
              _MapCustomBoundsButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        label,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _EewFillModeTile extends ConsumerWidget {
  const _EewFillModeTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    final mode = cfg.eew.fillMode;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '予想震度の塗りつぶし',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          SegmentedButton<HomeEewFillMode>(
            segments: const [
              ButtonSegment(
                value: HomeEewFillMode.intensity,
                label: Text('予想震度'),
              ),
              ButtonSegment(
                value: HomeEewFillMode.warning,
                label: Text('警報地域'),
              ),
              ButtonSegment(
                value: HomeEewFillMode.none,
                label: Text('なし'),
              ),
            ],
            selected: {mode},
            onSelectionChanged: (s) async {
              final next = s.first;
              await ref
                  .read(homeConfigurationProvider.notifier)
                  .updateEew(
                    cfg.eew.copyWith(fillMode: next),
                  );
            },
          ),
        ],
      ),
    );
  }
}

class _EewPsWaveTile extends ConsumerWidget {
  const _EewPsWaveTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    return AppListTile.listTile(
      title: 'P/S波の予報円',
      subtitle: cfg.eew.showPSWaveCircle ? '表示する' : '表示しない',
      trailing: Switch(
        value: cfg.eew.showPSWaveCircle,
        onChanged: (v) async {
          await ref
              .read(homeConfigurationProvider.notifier)
              .updateEew(
                cfg.eew.copyWith(showPSWaveCircle: v),
              );
        },
      ),
    );
  }
}

class _EewAnimationTile extends ConsumerWidget {
  const _EewAnimationTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    final rate = cfg.eew.animationRate;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'P/S波アニメーション',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          SegmentedButton<HomeEewAnimationRate>(
            segments: const [
              ButtonSegment(
                value: HomeEewAnimationRate.unlimited,
                label: Text('制限なし'),
              ),
              ButtonSegment(
                value: HomeEewAnimationRate.oneHz,
                label: Text('1Hz'),
              ),
            ],
            selected: {rate},
            onSelectionChanged: (s) async {
              await ref
                  .read(homeConfigurationProvider.notifier)
                  .updateEew(
                    cfg.eew.copyWith(animationRate: s.first),
                  );
            },
          ),
        ],
      ),
    );
  }
}

class _EewAutoZoomTile extends ConsumerWidget {
  const _EewAutoZoomTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    return AppListTile.listTile(
      title: 'EEW発生時に自動ズーム',
      subtitle: cfg.eew.autoZoom ? 'オン' : 'オフ',
      trailing: Switch(
        value: cfg.eew.autoZoom,
        onChanged: (v) async {
          await ref
              .read(homeConfigurationProvider.notifier)
              .updateEew(
                cfg.eew.copyWith(autoZoom: v),
              );
        },
      ),
    );
  }
}

class _LocationPermissionTile extends HookConsumerWidget {
  const _LocationPermissionTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refresh = useState(0);

    return FutureBuilder<LocationPermission>(
      key: ValueKey(refresh.value),
      future: Geolocator.checkPermission(),
      builder: (context, snap) {
        final p = snap.data;
        if (p == null ||
            p == LocationPermission.always ||
            p == LocationPermission.whileInUse) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FilledButton(
            onPressed: () async {
              await ref
                  .read(locationTrackingModeProvider.notifier)
                  .requestPermission();
              refresh.value++;
            },
            child: const Text('位置情報の使用を許可する'),
          ),
        );
      },
    );
  }
}

class _ShowLocationTile extends ConsumerWidget {
  const _ShowLocationTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    return AppListTile.listTile(
      title: '現在地を地図上に表示する',
      subtitle: '※マーカー表示は今後の対応',
      trailing: Switch(
        value: cfg.common.showLocation,
        onChanged: (v) async {
          if (v) {
            final p = await Geolocator.checkPermission();
            if (p == LocationPermission.denied) {
              final r = await Geolocator.requestPermission();
              if (r != LocationPermission.always &&
                  r != LocationPermission.whileInUse) {
                return;
              }
            } else if (p == LocationPermission.deniedForever) {
              await Geolocator.openAppSettings();
              return;
            }
          }
          await ref
              .read(homeConfigurationProvider.notifier)
              .updateCommon(
                cfg.common.copyWith(showLocation: v),
              );
        },
      ),
    );
  }
}

class _KyoshinMonitorIsEnabledTile extends ConsumerWidget {
  const _KyoshinMonitorIsEnabledTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(kyoshinMonitorSettingsProvider).requireValue;

    final subtitle = setting.useKmoni
        ? '強震モニタのリアルタイムデータを表示します \n'
              '(${setting.realtimeDataType.displayName}: ${setting.realtimeLayer.displayName})'
        : '強震モニタを利用していません';

    return Padding(
      padding: const EdgeInsets.all(8),
      child: AppListTile.listTile(
        title: '強震モニタ',
        subtitle: subtitle,
        trailing: const Icon(Icons.chevron_right),
        onTap: () => KyoshinMonitorSettingsModal.show(context),
      ),
    );
  }
}

class _KyoshinMinShindoTile extends ConsumerWidget {
  const _KyoshinMinShindoTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    final min = cfg.kyoshinMonitor.minRealtimeShindo;
    final enabled = min != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '観測点フィルター（最低リアルタイム震度）',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Switch(
                value: enabled,
                onChanged: (v) async {
                  await ref
                      .read(homeConfigurationProvider.notifier)
                      .updateKyoshinMonitor(
                        cfg.kyoshinMonitor.copyWith(
                          minRealtimeShindo: v ? -1.0 : null,
                        ),
                      );
                },
              ),
            ],
          ),
          if (min != null)
            Slider(
              value: min.clamp(-3, 7),
              min: -3,
              max: 7,
              divisions: 20,
              label: min.toStringAsFixed(1),
              onChanged: (v) async {
                await ref
                    .read(homeConfigurationProvider.notifier)
                    .updateKyoshinMonitor(
                      cfg.kyoshinMonitor.copyWith(minRealtimeShindo: v),
                    );
              },
            ),
          Text(
            enabled ? 'この値以下の観測点は表示しません（現在: $min）' : '全ての観測点を表示します',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _KyoshinMarkerSizeTile extends ConsumerWidget {
  const _KyoshinMarkerSizeTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    final size = cfg.kyoshinMonitor.markerSize;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '観測点サイズ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          SegmentedButton<HomeKmoniMarkerSize>(
            segments: const [
              ButtonSegment(
                value: HomeKmoniMarkerSize.small,
                label: Text('小'),
              ),
              ButtonSegment(
                value: HomeKmoniMarkerSize.medium,
                label: Text('中'),
              ),
              ButtonSegment(
                value: HomeKmoniMarkerSize.large,
                label: Text('大'),
              ),
            ],
            selected: {size},
            onSelectionChanged: (s) async {
              await ref
                  .read(homeConfigurationProvider.notifier)
                  .updateKyoshinMonitor(
                    cfg.kyoshinMonitor.copyWith(markerSize: s.first),
                  );
            },
          ),
        ],
      ),
    );
  }
}

class _MapLockBearingTile extends ConsumerWidget {
  const _MapLockBearingTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    return AppListTile.listTile(
      title: '方位ロック（常に北向き）',
      subtitle: '地図の回転を無効にします',
      trailing: Switch(
        value: cfg.map.lockBearing,
        onChanged: (v) async {
          await ref
              .read(homeConfigurationProvider.notifier)
              .updateMap(
                cfg.map.copyWith(lockBearing: v),
              );
        },
      ),
    );
  }
}

class _MapMaxZoomTile extends ConsumerWidget {
  const _MapMaxZoomTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    final maxZ = cfg.map.maxZoom;
    final enabled = maxZ != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '最大ズームを制限',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Switch(
                value: enabled,
                onChanged: (v) async {
                  await ref
                      .read(homeConfigurationProvider.notifier)
                      .updateMap(
                        cfg.map.copyWith(maxZoom: v ? 12.0 : null),
                      );
                },
              ),
            ],
          ),
          if (maxZ != null)
            Slider(
              value: maxZ.clamp(4, 18),
              min: 4,
              max: 18,
              divisions: 14,
              label: maxZ.toStringAsFixed(0),
              onChanged: (v) async {
                await ref
                    .read(homeConfigurationProvider.notifier)
                    .updateMap(
                      cfg.map.copyWith(maxZoom: v),
                    );
              },
            ),
        ],
      ),
    );
  }
}

class _MapDefaultBoundsTile extends ConsumerWidget {
  const _MapDefaultBoundsTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    final b = cfg.map.defaultBounds;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'デフォルトの表示範囲',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          SegmentedButton<HomeMapDefaultBounds>(
            segments: const [
              ButtonSegment(
                value: HomeMapDefaultBounds.mainIsland,
                label: Text('本州〜'),
              ),
              ButtonSegment(
                value: HomeMapDefaultBounds.all,
                label: Text('全体'),
              ),
              ButtonSegment(
                value: HomeMapDefaultBounds.custom,
                label: Text('カスタム'),
              ),
            ],
            selected: {b},
            onSelectionChanged: (s) async {
              await ref
                  .read(homeConfigurationProvider.notifier)
                  .updateMap(
                    cfg.map.copyWith(defaultBounds: s.first),
                  );
            },
          ),
        ],
      ),
    );
  }
}

class _MapCustomBoundsButton extends ConsumerWidget {
  const _MapCustomBoundsButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    if (cfg.map.defaultBounds != HomeMapDefaultBounds.custom) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: FilledButton.tonal(
        onPressed: () async {
          await HomeMapBoundsSelectorPage.open(context);
        },
        child: const Text('地図上で範囲を選択'),
      ),
    );
  }
}
