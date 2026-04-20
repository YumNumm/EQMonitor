import 'dart:async';

import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_layer_hero_illustration.dart';
import 'package:eqmonitor/feature/home/ui/page/home_map_bounds_selector_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_layer_information_dialog.dart';
import 'package:eqmonitor/feature/location/data/location_tracking_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

class HomeMapLayerPage extends HookConsumerWidget {
  const HomeMapLayerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final typography = designSystem.typography;
    final expandedSection = useState<_MapLayerSection?>(_MapLayerSection.eew);

    return Scaffold(
      backgroundColor: color.backgroundDefault,
      body: CustomScrollView(
        primary: true,
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: color.backgroundDefault,
            surfaceTintColor: Colors.transparent,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            title: Text('マップレイヤー', style: typography.titleLarge),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: EdgeInsets.fromLTRB(
                spacing.lg,
                spacing.sm,
                spacing.lg,
                spacing.xxxl,
              ),
              sliver: SliverList.list(
                children: [
                  Container(
                    padding: EdgeInsets.all(spacing.xl),
                    decoration: BoxDecoration(
                      color: color.surfaceRaised,
                      borderRadius: BorderRadius.circular(shape.sheet),
                      border: Border.all(color: color.outlineSoft),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spacing.md,
                            vertical: spacing.xs + 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.surfaceEmphasis,
                            borderRadius: BorderRadius.circular(shape.pill),
                          ),
                          child: Text(
                            'Map style',
                            style: typography.labelMedium.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: spacing.lg),
                        Text(
                          '見たい情報だけを\n素早く切り替える',
                          style: typography.headlineSmall.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: spacing.sm),
                        Text(
                          '緊急地震速報、現在地、強震モニタ、地図の表示範囲をひとつのページで調整できます。',
                          style: typography.bodyMedium,
                        ),
                        SizedBox(height: spacing.xl),
                        const HomeMapLayerHeroIllustration(),
                      ],
                    ),
                  ),
                  SizedBox(height: spacing.lg),
                  _SettingsSection(
                    icon: Icons.emergency_rounded,
                    title: '緊急地震速報',
                    description: 'EEW の塗りつぶし、アニメーション、自動追従を調整します。',
                    isExpanded: expandedSection.value == _MapLayerSection.eew,
                    onTap: () {
                      expandedSection.value =
                          expandedSection.value == _MapLayerSection.eew
                          ? null
                          : _MapLayerSection.eew;
                    },
                    children: const [
                      _EewFillModeTile(),
                      _EewPsWaveTile(),
                      _EewAnimationTile(),
                      _EewAutoZoomTile(),
                    ],
                  ),
                  SizedBox(height: spacing.lg),
                  _SettingsSection(
                    icon: Icons.my_location_rounded,
                    title: '現在地',
                    description: '位置情報の利用許可と、地図上での表示設定です。',
                    isExpanded:
                        expandedSection.value == _MapLayerSection.location,
                    onTap: () {
                      expandedSection.value =
                          expandedSection.value == _MapLayerSection.location
                          ? null
                          : _MapLayerSection.location;
                    },
                    children: const [
                      _LocationPermissionTile(),
                      _ShowLocationTile(),
                    ],
                  ),
                  SizedBox(height: spacing.lg),
                  _SettingsSection(
                    icon: Icons.sensors_rounded,
                    title: '強震モニタ',
                    description: 'リアルタイム観測点の表示条件と見た目を変更します。',
                    isExpanded:
                        expandedSection.value ==
                        _MapLayerSection.kyoshinMonitor,
                    onTap: () {
                      expandedSection.value =
                          expandedSection.value ==
                              _MapLayerSection.kyoshinMonitor
                          ? null
                          : _MapLayerSection.kyoshinMonitor;
                    },
                    children: const [
                      _KyoshinMonitorEnabledTile(),
                      _KyoshinMonitorAboutTile(),
                      _KyoshinRealtimeDataTypeTile(),
                      _KyoshinRealtimeLayerTile(),
                      _KyoshinMarkerTypeTile(),
                      _KyoshinShowScaleTile(),
                      _KyoshinMinShindoTile(),
                      _KyoshinMarkerSizeTile(),
                    ],
                  ),
                  SizedBox(height: spacing.lg),
                  _SettingsSection(
                    icon: Icons.map_rounded,
                    title: 'マップ',
                    description: '地図の回転、ズーム、初期表示範囲を設定します。',
                    isExpanded: expandedSection.value == _MapLayerSection.map,
                    onTap: () {
                      expandedSection.value =
                          expandedSection.value == _MapLayerSection.map
                          ? null
                          : _MapLayerSection.map;
                    },
                    children: const [
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

enum _MapLayerSection { eew, location, kyoshinMonitor, map }

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.icon,
    required this.title,
    required this.description,
    required this.isExpanded,
    required this.onTap,
    required this.children,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool isExpanded;
  final VoidCallback onTap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final typography = designSystem.typography;
    final sectionChildren = <Widget>[];

    for (final child in children) {
      if (sectionChildren.isNotEmpty) {
        sectionChildren.add(
          Divider(
            height: 1,
            indent: spacing.xl,
            endIndent: spacing.xl,
            color: color.outlineSoft,
          ),
        );
      }
      sectionChildren.add(child);
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: color.surfaceRaised,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(shape.sheet),
        side: BorderSide(color: color.outlineSoft),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                spacing.xl,
                spacing.lg,
                spacing.xl,
                spacing.lg,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.surfaceEmphasis,
                      borderRadius: BorderRadius.circular(shape.md),
                    ),
                    child: Icon(
                      icon,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: spacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: typography.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: spacing.xs),
                        Text(description, style: typography.bodySmall),
                      ],
                    ),
                  ),
                  SizedBox(width: spacing.md),
                  AnimatedRotation(
                    turns: isExpanded ? 0 : -0.25,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            child: isExpanded
                ? Column(
                    children: [
                      Divider(height: 1, color: color.outlineSoft),
                      Column(children: sectionChildren),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
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
  // ignore: avoid_positional_boolean_parameters
  final Future<void> Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(
        spacing.xl,
        spacing.sm + 2,
        spacing.lg,
        spacing.sm + 2,
      ),
      title: Text(
        title,
        style: typography.titleSmall.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle, style: typography.bodySmall),
      trailing: AppSwitch(
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

class _SettingDropdownField<T> extends StatelessWidget {
  const _SettingDropdownField({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.entries,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final T value;
  // ignore: unsafe_variance
  final Future<void> Function(T) onChanged;
  final List<DropdownMenuEntry<T>> entries;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        spacing.xl,
        spacing.lg,
        spacing.xl,
        spacing.lg,
      ),
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
                      title,
                      style: typography.titleSmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spacing.xs),
                    Text(subtitle, style: typography.bodySmall),
                  ],
                ),
              ),
              if (trailing != null) ...[
                SizedBox(width: spacing.sm),
                trailing!,
              ],
            ],
          ),
          SizedBox(height: spacing.md),
          DropdownMenu<T>(
            width: double.infinity,
            initialSelection: value,
            onSelected: (next) {
              if (next != null) {
                unawaited(
                  Future<void>.sync(() async {
                    await onChanged(next);
                  }),
                );
              }
            },
            dropdownMenuEntries: entries,
          ),
        ],
      ),
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
  // ignore: unsafe_variance
  final Future<void> Function(Set<T>) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        spacing.xl,
        spacing.lg,
        spacing.xl,
        spacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: typography.titleSmall.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: spacing.xs),
          Text(subtitle, style: typography.bodySmall),
          SizedBox(height: spacing.md),
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
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        spacing.xl,
        spacing.lg,
        spacing.xl,
        spacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: typography.titleSmall.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: spacing.xs),
          Text(
            subtitle,
            style: typography.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: spacing.md),
          FilledButton.tonal(
            onPressed: () {
              unawaited(
                Future<void>.sync(() async {
                  await onPressed();
                }),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: color.surfaceEmphasis,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
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
      onSelectionChanged: (next) async {
        await ref
            .read(homeConfigurationProvider.notifier)
            .updateEew(cfg.eew.copyWith(fillMode: next.first));
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
      onChanged: (next) async {
        await ref
            .read(homeConfigurationProvider.notifier)
            .updateEew(cfg.eew.copyWith(showPSWaveCircle: next));
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
      onSelectionChanged: (next) async {
        await ref
            .read(homeConfigurationProvider.notifier)
            .updateEew(cfg.eew.copyWith(animationRate: next.first));
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
      onChanged: (next) async {
        await ref
            .read(homeConfigurationProvider.notifier)
            .updateEew(cfg.eew.copyWith(autoZoom: next));
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
      builder: (context, snapshot) {
        final permission = snapshot.data;
        if (permission == null ||
            permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse) {
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
      onChanged: (next) async {
        if (next) {
          final permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            final requested = await Geolocator.requestPermission();
            if (requested != LocationPermission.always &&
                requested != LocationPermission.whileInUse) {
              return;
            }
          } else if (permission == LocationPermission.deniedForever) {
            await Geolocator.openAppSettings();
            return;
          }
        }
        await ref
            .read(homeConfigurationProvider.notifier)
            .updateCommon(cfg.common.copyWith(showLocation: next));
      },
    );
  }
}

class _KyoshinMonitorEnabledTile extends ConsumerWidget {
  const _KyoshinMonitorEnabledTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    final subtitle = setting.useKmoni
        ? 'リアルタイム観測点を地図上に表示します。'
        : '強震モニタを地図上に表示しません。';

    return _SettingSwitchTile(
      title: '強震モニタを利用する',
      subtitle: subtitle,
      value: setting.useKmoni,
      onChanged: (next) async {
        await ref
            .read(kyoshinMonitorSettingsProvider.notifier)
            .save(setting.copyWith(useKmoni: next));
      },
    );
  }
}

class _KyoshinMonitorAboutTile extends StatelessWidget {
  const _KyoshinMonitorAboutTile();

  @override
  Widget build(BuildContext context) {
    return _SettingActionTile(
      title: '強震モニタについて',
      subtitle: 'データの見方や観測網の説明を確認できます。',
      actionLabel: '詳しく見る',
      onPressed: () async {
        await const KyoshinMonitorAboutRoute().push<void>(context);
      },
    );
  }
}

class _KyoshinRealtimeDataTypeTile extends ConsumerWidget {
  const _KyoshinRealtimeDataTypeTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    if (!setting.useKmoni) {
      return const SizedBox.shrink();
    }
    return _SettingDropdownField<RealtimeDataType>(
      title: 'リアルタイムデータの種類',
      subtitle: '観測点が示す値を切り替えます。',
      value: setting.realtimeDataType,
      trailing: IconButton(
        onPressed: () async => RealtimeDataTypeInfoDialog.show(context),
        icon: const Icon(Icons.info_outline_rounded),
      ),
      entries: RealtimeDataType.values
          .where((value) => !value.isLpgm)
          .map(
            (value) => DropdownMenuEntry<RealtimeDataType>(
              value: value,
              label: value.displayName,
            ),
          )
          .toList(),
      onChanged: (next) async {
        await ref
            .read(kyoshinMonitorSettingsProvider.notifier)
            .save(setting.copyWith(realtimeDataType: next));
      },
    );
  }
}

class _KyoshinRealtimeLayerTile extends ConsumerWidget {
  const _KyoshinRealtimeLayerTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    if (!setting.useKmoni) {
      return const SizedBox.shrink();
    }
    return _SettingDropdownField<RealtimeLayer>(
      title: 'リアルタイムデータのレイヤー',
      subtitle: '観測点の深さを地表・地中から選択します。',
      value: setting.realtimeLayer,
      entries: const [
        DropdownMenuEntry(value: RealtimeLayer.surface, label: '地表'),
        DropdownMenuEntry(value: RealtimeLayer.underground, label: '地中'),
      ],
      onChanged: (next) async {
        await ref
            .read(kyoshinMonitorSettingsProvider.notifier)
            .save(setting.copyWith(realtimeLayer: next));
      },
    );
  }
}

class _KyoshinMarkerTypeTile extends ConsumerWidget {
  const _KyoshinMarkerTypeTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    if (!setting.useKmoni) {
      return const SizedBox.shrink();
    }
    return _SettingDropdownField<KyoshinMonitorMarkerType>(
      title: '観測点の枠',
      subtitle: '観測点の円の周りに補助枠を表示します。',
      value: setting.kmoniMarkerType,
      entries: KyoshinMonitorMarkerType.values
          .map(
            (value) => DropdownMenuEntry<KyoshinMonitorMarkerType>(
              value: value,
              label: switch (value) {
                KyoshinMonitorMarkerType.always => '常に表示',
                KyoshinMonitorMarkerType.onlyEew => 'EEW時のみ',
                KyoshinMonitorMarkerType.never => '表示しない',
              },
            ),
          )
          .toList(),
      onChanged: (next) async {
        await ref
            .read(kyoshinMonitorSettingsProvider.notifier)
            .save(setting.copyWith(kmoniMarkerType: next));
      },
    );
  }
}

class _KyoshinShowScaleTile extends ConsumerWidget {
  const _KyoshinShowScaleTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    if (!setting.useKmoni) {
      return const SizedBox.shrink();
    }
    return _SettingSwitchTile(
      title: 'スケールを表示',
      subtitle: '地図左上の時刻表示をタップしても切り替えられます。',
      value: setting.showScale,
      onChanged: (next) async {
        await ref
            .read(kyoshinMonitorSettingsProvider.notifier)
            .save(setting.copyWith(showScale: next));
      },
    );
  }
}

class _KyoshinMinShindoTile extends ConsumerWidget {
  const _KyoshinMinShindoTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeConfig = ref.watch(homeConfigurationProvider).value;
    final kmoniConfig = ref.watch(kyoshinMonitorSettingsProvider).value;
    if (homeConfig == null || kmoniConfig == null || !kmoniConfig.useKmoni) {
      return const SizedBox.shrink();
    }
    final typography = context.designSystem.typography;
    final min = homeConfig.kyoshinMonitor.minRealtimeShindo;
    final isEnabled = min != null;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.designSystem.spacing.xl,
        context.designSystem.spacing.lg,
        context.designSystem.spacing.xl,
        context.designSystem.spacing.lg,
      ),
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
                      style: typography.titleSmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: context.designSystem.spacing.xs),
                    Text(
                      isEnabled ? 'この値未満の観測点を地図に表示しません。' : 'すべての観測点を表示します。',
                      style: typography.bodySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.designSystem.spacing.md),
              AppSwitch(
                value: isEnabled,
                onChanged: (next) async {
                  await ref
                      .read(homeConfigurationProvider.notifier)
                      .updateKyoshinMonitor(
                        homeConfig.kyoshinMonitor.copyWith(
                          minRealtimeShindo: next ? -1.0 : null,
                        ),
                      );
                },
              ),
            ],
          ),
          if (min != null) ...[
            SizedBox(height: context.designSystem.spacing.md),
            Slider(
              value: min.clamp(-3, 7),
              min: -3,
              max: 7,
              divisions: 20,
              label: min.toStringAsFixed(1),
              onChanged: (next) async {
                await ref
                    .read(homeConfigurationProvider.notifier)
                    .updateKyoshinMonitor(
                      homeConfig.kyoshinMonitor.copyWith(
                        minRealtimeShindo: next,
                      ),
                    );
              },
            ),
            Text(
              '現在のしきい値: ${min.toStringAsFixed(1)}',
              style: typography.bodySmall,
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
    final homeConfig = ref.watch(homeConfigurationProvider).value;
    final kmoniConfig = ref.watch(kyoshinMonitorSettingsProvider).value;
    if (homeConfig == null || kmoniConfig == null || !kmoniConfig.useKmoni) {
      return const SizedBox.shrink();
    }
    final size = homeConfig.kyoshinMonitor.markerSize;

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
      onSelectionChanged: (next) async {
        await ref
            .read(homeConfigurationProvider.notifier)
            .updateKyoshinMonitor(
              homeConfig.kyoshinMonitor.copyWith(markerSize: next.first),
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
      subtitle: '地図の回転を無効にします。',
      value: cfg.map.lockBearing,
      onChanged: (next) async {
        await ref
            .read(homeConfigurationProvider.notifier)
            .updateMap(cfg.map.copyWith(lockBearing: next));
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
    final typography = context.designSystem.typography;
    final maxZoom = cfg.map.maxZoom;
    final isEnabled = maxZoom != null;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.designSystem.spacing.xl,
        context.designSystem.spacing.lg,
        context.designSystem.spacing.xl,
        context.designSystem.spacing.lg,
      ),
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
                      style: typography.titleSmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: context.designSystem.spacing.xs),
                    Text(
                      isEnabled ? '細かく拡大しすぎないよう最大値を設定します。' : 'ズーム制限をかけずに使用します。',
                      style: typography.bodySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.designSystem.spacing.md),
              AppSwitch(
                value: isEnabled,
                onChanged: (next) async {
                  await ref
                      .read(homeConfigurationProvider.notifier)
                      .updateMap(
                        cfg.map.copyWith(maxZoom: next ? 12.0 : null),
                      );
                },
              ),
            ],
          ),
          if (maxZoom != null) ...[
            SizedBox(height: context.designSystem.spacing.md),
            Slider(
              value: maxZoom.clamp(4, 18),
              min: 4,
              max: 18,
              divisions: 14,
              label: maxZoom.toStringAsFixed(0),
              onChanged: (next) async {
                await ref
                    .read(homeConfigurationProvider.notifier)
                    .updateMap(cfg.map.copyWith(maxZoom: next));
              },
            ),
            Text(
              '現在の最大ズーム: ${maxZoom.toStringAsFixed(0)}',
              style: typography.bodySmall,
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
    final bounds = cfg.map.defaultBounds;

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
      selected: {bounds},
      onSelectionChanged: (next) async {
        await ref
            .read(homeConfigurationProvider.notifier)
            .updateMap(cfg.map.copyWith(defaultBounds: next.first));
      },
    );
  }
}

class _MapCustomBoundsButton extends ConsumerWidget {
  const _MapCustomBoundsButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null || cfg.map.defaultBounds != HomeMapDefaultBounds.custom) {
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
