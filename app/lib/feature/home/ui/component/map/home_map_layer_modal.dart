import 'dart:async';

import 'package:eqmonitor/core/component/sheet/app_sheet_route.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        primary: true,
        slivers: [
          const SliverToBoxAdapter(child: _ModalHeader()),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverList.list(
                children: const [
                  _SettingsSection(
                    icon: Icons.emergency_rounded,
                    title: '緊急地震速報',
                    description: 'EEW の塗りつぶし、アニメーション、自動追従を調整します。',
                    initiallyExpanded: true,
                    children: [
                      _EewFillModeTile(),
                      _EewPsWaveTile(),
                      _EewAnimationTile(),
                      _EewAutoZoomTile(),
                    ],
                  ),
                  SizedBox(height: 16),
                  _SettingsSection(
                    icon: Icons.my_location_rounded,
                    title: '現在地',
                    description: '位置情報の利用許可と、地図上での表示設定です。',
                    children: [
                      _LocationPermissionTile(),
                      _ShowLocationTile(),
                    ],
                  ),
                  SizedBox(height: 16),
                  _SettingsSection(
                    icon: Icons.sensors_rounded,
                    title: '強震モニタ',
                    description: 'リアルタイム観測点の表示条件と見た目を変更します。',
                    children: [
                      _KyoshinMonitorIsEnabledTile(),
                      _KyoshinMinShindoTile(),
                      _KyoshinMarkerSizeTile(),
                    ],
                  ),
                  SizedBox(height: 16),
                  _SettingsSection(
                    icon: Icons.map_rounded,
                    title: 'マップ',
                    description: '地図の回転、ズーム、初期表示範囲を設定します。',
                    children: [
                      _MapLockBearingTile(),
                      _MapMaxZoomTile(),
                      _MapDefaultBoundsTile(),
                      _MapCustomBoundsButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModalHeader extends StatelessWidget {
  const _ModalHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final handle = Container(
      width: 36,
      height: 4,
      decoration: BoxDecoration(
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(999),
      ),
    );

    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Map style',
        style: theme.textTheme.labelMedium?.copyWith(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: handle),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      badge,
                      const SizedBox(height: 12),
                      Text(
                        'マップレイヤー',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '必要な情報だけを素早く見られるように、地図の表現をセクションごとに調整できます。',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                IconButton.filledTonal(
                  onPressed: () {
                    unawaited(HapticFeedback.lightImpact());
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends HookWidget {
  const _SettingsSection({
    required this.icon,
    required this.title,
    required this.description,
    required this.children,
    this.initiallyExpanded = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final List<Widget> children;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(initiallyExpanded);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final sectionChildren = <Widget>[];

    for (final child in children) {
      if (sectionChildren.isNotEmpty) {
        sectionChildren.add(
          Divider(
            height: 1,
            indent: 20,
            endIndent: 20,
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        );
      }
      sectionChildren.add(child);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: colorScheme.surfaceContainerHigh,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.35),
          ),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                isExpanded.value = !isExpanded.value;
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        icon,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            description,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    AnimatedRotation(
                      turns: isExpanded.value ? 0 : -0.25,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: isExpanded.value
                  ? Column(
                      children: [
                        Divider(
                          height: 1,
                          color: colorScheme.outlineVariant.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        Column(children: sectionChildren),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingSwitchTile extends StatelessWidget {
  const _SettingSwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final FutureOr<void> Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Switch.adaptive(
        value: value,
        onChanged: (next) {
          unawaited(
            Future<void>.sync(() async {
              await onChanged(next);
            }),
          );
        },
      ),
      onTap: () {
        unawaited(
          Future<void>.sync(() async {
            await onChanged(!value);
          }),
        );
      },
    );
  }
}

class _SettingNavigationTile extends StatelessWidget {
  const _SettingNavigationTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final FutureOr<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {
        unawaited(
          Future<void>.sync(() async {
            await onTap();
          }),
        );
      },
    );
  }
}

class _SettingSegmentedField<T> extends StatelessWidget {
  const _SettingSegmentedField({
    required this.title,
    required this.subtitle,
    required this.segments,
    required this.selected,
    required this.onSelectionChanged,
  });

  final String title;
  final String subtitle;
  final List<ButtonSegment<T>> segments;
  final Set<T> selected;
  final FutureOr<void> Function(Set<T>) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: theme.textTheme.bodySmall),
          const SizedBox(height: 14),
          SegmentedButton<T>(
            segments: segments,
            selected: selected,
            onSelectionChanged: (next) {
              unawaited(
                Future<void>.sync(() async {
                  await onSelectionChanged(next);
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SettingActionTile extends StatelessWidget {
  const _SettingActionTile({
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final String actionLabel;
  final FutureOr<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          FilledButton.tonal(
            onPressed: () {
              unawaited(
                Future<void>.sync(() async {
                  await onPressed();
                }),
              );
            },
            child: Text(actionLabel),
          ),
        ],
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

    return _SettingSegmentedField<HomeEewFillMode>(
      title: '予想震度の塗りつぶし',
      subtitle: '塗りつぶし方法を予想震度、警報地域、非表示から選びます。',
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
    return _SettingSwitchTile(
      title: 'P/S波の予報円',
      subtitle: cfg.eew.showPSWaveCircle ? '地図上に表示します。' : '地図上に表示しません。',
      value: cfg.eew.showPSWaveCircle,
      onChanged: (v) async {
        await ref
            .read(homeConfigurationProvider.notifier)
            .updateEew(
              cfg.eew.copyWith(showPSWaveCircle: v),
            );
      },
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

    return _SettingSegmentedField<HomeEewAnimationRate>(
      title: 'P/S波アニメーション',
      subtitle: '更新頻度を調整して見やすさと負荷のバランスを取ります。',
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
    return _SettingSwitchTile(
      title: 'EEW発生時に自動ズーム',
      subtitle: cfg.eew.autoZoom ? '発生時に自動で注視します。' : '現在のズームを維持します。',
      value: cfg.eew.autoZoom,
      onChanged: (v) async {
        await ref
            .read(homeConfigurationProvider.notifier)
            .updateEew(
              cfg.eew.copyWith(autoZoom: v),
            );
      },
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
        return _SettingActionTile(
          title: '位置情報の利用許可',
          subtitle: '現在地関連の機能を使うには、まず権限を許可してください。',
          actionLabel: '位置情報の使用を許可する',
          onPressed: () async {
            await ref
                .read(locationTrackingModeProvider.notifier)
                .requestPermission();
            refresh.value++;
          },
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
    return _SettingSwitchTile(
      title: '現在地を地図上に表示する',
      subtitle: '位置追従や現在地中心の操作に利用します。',
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

    return _SettingNavigationTile(
      title: '強震モニタ',
      subtitle: subtitle,
      onTap: () => KyoshinMonitorSettingsModal.show(context),
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
    final theme = Theme.of(context);
    final min = cfg.kyoshinMonitor.minRealtimeShindo;
    final enabled = min != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '観測点フィルター',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      enabled ? 'この値未満の観測点を地図に表示しません。' : 'すべての観測点を表示します。',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Switch.adaptive(
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
          if (min != null) ...[
            const SizedBox(height: 12),
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
              '現在のしきい値: ${min.toStringAsFixed(1)}',
              style: theme.textTheme.bodySmall,
            ),
          ],
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

    return _SettingSegmentedField<HomeKmoniMarkerSize>(
      title: '観測点サイズ',
      subtitle: '強震モニタの観測点アイコンの大きさを変更します。',
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
    return _SettingSwitchTile(
      title: '方位ロック（常に北向き）',
      subtitle: '地図の回転を無効にします',
      value: cfg.map.lockBearing,
      onChanged: (v) async {
        await ref
            .read(homeConfigurationProvider.notifier)
            .updateMap(
              cfg.map.copyWith(lockBearing: v),
            );
      },
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
    final theme = Theme.of(context);
    final maxZ = cfg.map.maxZoom;
    final enabled = maxZ != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '最大ズームを制限',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      enabled ? '細かく拡大しすぎないよう最大値を設定します。' : 'ズーム制限をかけずに使用します。',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Switch.adaptive(
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
          if (maxZ != null) ...[
            const SizedBox(height: 12),
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
            Text(
              '現在の最大ズーム: ${maxZ.toStringAsFixed(0)}',
              style: theme.textTheme.bodySmall,
            ),
          ],
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

    return _SettingSegmentedField<HomeMapDefaultBounds>(
      title: 'デフォルトの表示範囲',
      subtitle: 'ホームを開いたときに最初に表示するエリアを選択します。',
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
    return _SettingActionTile(
      title: 'カスタム範囲を編集',
      subtitle: '現在表示している地図の範囲を、ホーム画面の初期表示として保存します。',
      actionLabel: '地図上で範囲を選択',
      onPressed: () async {
        await HomeMapBoundsSelectorPage.open(context);
      },
    );
  }
}
