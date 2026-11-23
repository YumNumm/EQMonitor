import 'package:eqmonitor/core/component/slider/accessible_slider.dart';

import 'dart:async';

import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_menu_availability_provider.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/page/home_map_bounds_selector_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_request_provider.dart';
import 'package:eqmonitor/feature/location/data/location_tracking_mode.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_tuning_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const HomeMapLayerPage({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShakeDetectionEnabled = ref.watch(
      isDeviceShakeDetectionEnabledProvider,
    );
    final isDebugMenuAvailable = ref.watch(isDebugMenuAvailableProvider);
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return Scaffold(
      backgroundColor: colorTheme.surfaceContainerLow,
      body: CustomScrollView(
        primary: true,
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: colorTheme.surfaceContainerLow,
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
                  const _SettingsSection(
                    title: '緊急地震速報',
                    description: 'EEW の塗りつぶし、アニメーション、自動追従を調整します。',
                    children: [
                      _EewFillModeTile(),
                      _EewPsWaveTile(),
                      _EewPsWaveTimeBaseTile(),
                      _EewAnimationTile(),
                      _EewAutoZoomTile(),
                    ],
                  ),
                  SizedBox(height: spacing.lg),
                  if (isShakeDetectionEnabled) ...[
                    _SettingsSection(
                      title: '揺れ検知',
                      description: '揺れ検知イベントの表示、アニメーション、自動追従を調整します。',
                      children: const [
                        _ShakeDetectionShowTile(),
                        _ShakeDetectionAnimationModeTile(),
                        _ShakeDetectionMinLevelTile(),
                        _ShakeDetectionAutoFocusTile(),
                      ],
                    ),
                    SizedBox(height: spacing.lg),
                  ],
                  _SettingsSection(
                    title: '現在地',
                    description: '位置情報の利用許可と、地図上での表示設定です。',
                    children: [
                      _LocationPermissionTile(),
                      _ShowLocationTile(),
                    ],
                  ),
                  SizedBox(height: spacing.lg),
                  const _SettingsSection(
                    title: '強震モニタ',
                    description: 'リアルタイム観測点の表示条件と見た目を変更します。',
                    children: [
                      _KyoshinMonitorEnabledTile(),
                      _KyoshinMonitorSourceTile(),
                      _KyoshinMonitorAboutTile(),
                      _KyoshinRealtimeDataTypeTile(),
                      _KyoshinRealtimeLayerTile(),
                      _KyoshinMarkerTypeTile(),
                      _KyoshinShowScaleTile(),
                      _KyoshinMinShindoTile(),
                      _KyoshinMarkerSizeTile(),
                      _KyoshinStationNameTile(),
                    ],
                  ),
                  SizedBox(height: spacing.lg),
                  const _SettingsSection(
                    title: 'マップ',
                    description: '地図の回転、ズーム、初期表示範囲を設定します。',
                    children: [
                      _MapLockBearingTile(),
                      _MapMaxZoomTile(),
                      _MapDefaultBoundsTile(),
                      _MapCustomBoundsButton(),
                    ],
                  ),
                  if (isDebugMenuAvailable) ...[
                    SizedBox(height: spacing.lg),
                    const _SettingsSection(
                      title: 'デバッグ',
                      description: '地図に重ねて表示する、機能ごとのデバッグ情報を切り替えます。',
                      children: [
                        _DebugOverlayShakeDetectionTile(),
                        _DebugOverlayKyoshinMonitorTile(),
                        _DebugOverlayEewTile(),
                        _DebugKyoshinIntensityIconTile(),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class const _SettingsSection({
  required final String title,
  required final String description,
  required final List<Widget> children,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
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
            color: colorTheme.outlineVariant,
          ),
        );
      }
      sectionChildren.add(child);
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: colorTheme.surfaceContainerLow,
      clipBehavior: .antiAlias,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.sheet),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              isExpanded.value = !isExpanded.value;
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                spacing.xl,
                spacing.lg,
                spacing.xl,
                spacing.lg,
              ),
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          title,
                          style: typography.titleMedium.copyWith(
                            fontWeight: .w700,
                          ),
                        ),
                        SizedBox(height: spacing.xs),
                        Text(description, style: typography.bodySmall),
                      ],
                    ),
                  ),
                  SizedBox(width: spacing.md),
                  AnimatedRotation(
                    turns: isExpanded.value ? 0 : -0.25,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: context.designSystem.colorTheme.onSurfaceVariant,
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
                      Divider(height: 1, color: colorTheme.outlineVariant),
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

class const _SettingSwitchTile({
  required final String title,
  required final String subtitle,
  required final bool value,
  // ignore: avoid_positional_boolean_parameters
  required final Future<void> Function(bool) onChanged,
}) extends StatelessWidget {
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
        style: typography.titleSmall.copyWith(fontWeight: .w600),
      ),
      subtitle: Text(subtitle, style: typography.bodySmall),
      trailing: AppSwitch(
        value: value,
        onChanged: (next) async {
          await onChanged(next);
        },
      ),
      onTap: () async {
        await onChanged(!value);
      },
    );
  }
}

class const _SettingDropdownField<T>({
  required final String title,
  required final String subtitle,
  required final T value,
  // ignore: unsafe_variance
  required final Future<void> Function(T) onChanged,
  required final List<DropdownMenuEntry<T>> entries,
  final Widget? trailing,
  final M3EDropdownStyle dropdownStyle = const M3EDropdownStyle(),
}) extends StatelessWidget {
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
        crossAxisAlignment: .start,
        children: [
          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      title,
                      style: typography.titleSmall.copyWith(
                        fontWeight: .w600,
                      ),
                    ),
                    SizedBox(height: spacing.xs),
                    Text(subtitle, style: typography.bodySmall),
                  ],
                ),
              ),
              if (trailing case final trailing?) ...[
                SizedBox(width: spacing.sm),
                trailing,
              ],
            ],
          ),
          SizedBox(height: spacing.md),
          SizedBox(
            width: double.infinity,
            child: ControlledDropdown<T>(
              singleSelect: true,
              dropdownStyle: dropdownStyle,
              items:
                  (entries
                          .map(
                            (entry) => M3EDropdownItem(
                              value: entry.value,
                              label: entry.label,
                              disabled: !entry.enabled,
                            ),
                          )
                          .toList())
                      .map(
                        (item) => item.copyWith(selected: item.value == value),
                      )
                      .toList(),
              onSelectionChanged: (selection) async {
                if (selection.isEmpty) return;
                final next = selection.first.value;
                if (next != null) {
                  await onChanged(next);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class const _SettingSegmentedField<T>({
  required final String title,
  required final String subtitle,
  required final List<ButtonSegment<T>> segments,
  required final Set<T> selected,
  // ignore: unsafe_variance
  required final Future<void> Function(Set<T>) onSelectionChanged,
}) extends StatelessWidget {
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
        crossAxisAlignment: .start,
        children: [
          Text(
            title,
            style: typography.titleSmall.copyWith(fontWeight: .w600),
          ),
          SizedBox(height: spacing.xs),
          Text(subtitle, style: typography.bodySmall),
          SizedBox(height: spacing.md),
          M3EToggleButtonGroup(
            type: M3EButtonGroupType.connected,
            actions: segments
                .map(
                  (segment) => M3EToggleButtonGroupAction(
                    label: segment.label,
                    icon: segment.icon,
                    enabled: segment.enabled,
                    tooltip: segment.tooltip,
                  ),
                )
                .toList(),
            selectedIndex: (segments.map((segment) => segment.value).toList())
                .indexOf((selected).single),
            onSelectedIndexChanged: (index) async {
              if (index == null) return;
              final next = {
                segments.map((segment) => segment.value).toList()[index],
              };
              await onSelectionChanged(next);
            },
          ),
        ],
      ),
    );
  }
}

class const _SettingActionTile({
  required final String title,
  required final String subtitle,
  required final String actionLabel,
  required final Future<void> Function() onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
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
        crossAxisAlignment: .start,
        children: [
          Text(
            title,
            style: typography.titleSmall.copyWith(fontWeight: .w600),
          ),
          SizedBox(height: spacing.xs),
          Text(
            subtitle,
            style: typography.bodySmall.copyWith(
              color: context.designSystem.colorTheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: spacing.md),
          M3EFilledButton.tonal(
            onPressed: () async {
              await onPressed();
            },
            decoration: M3EButtonDecoration.styleFrom(
              backgroundColor: colorTheme.surfaceContainerHighest,
              foregroundColor:
                  context.designSystem.colorTheme.onPrimaryContainer,
            ),
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}

class const _EewFillModeTile() extends ConsumerWidget {
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
        ButtonSegment(value: HomeEewFillMode.intensity, label: Text('予想震度')),
        ButtonSegment(value: HomeEewFillMode.warning, label: Text('警報地域')),
        ButtonSegment(value: HomeEewFillMode.none, label: Text('なし')),
      ],
      selected: {mode},
      onSelectionChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateEew(cfg.eew.copyWith(fillMode: next.first)),
        );
      },
    );
  }
}

class const _EewPsWaveTile() extends ConsumerWidget {
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
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateEew(cfg.eew.copyWith(showPSWaveCircle: next)),
        );
      },
    );
  }
}

class const _EewPsWaveTimeBaseTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null || !cfg.eew.showPSWaveCircle) {
      return const SizedBox.shrink();
    }
    return _SettingSwitchTile(
      title: 'P/S波の予報円を強震モニタに合わせる',
      subtitle: cfg.eew.alignPSWaveCircleToKyoshinMonitor
          ? '観測点の色と予報円が同期しますが、予報円はサーバの公開遅延ぶん過去になります。'
          : 'NTPで補正した正確な現在時刻で予報円を描画します。',
      value: cfg.eew.alignPSWaveCircleToKyoshinMonitor,
      onChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateEew(
                cfg.eew.copyWith(alignPSWaveCircleToKyoshinMonitor: next),
              ),
        );
      },
    );
  }
}

class const _EewAnimationTile() extends ConsumerWidget {
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
        ButtonSegment(value: HomeEewAnimationRate.oneHz, label: Text('1Hz')),
      ],
      selected: {rate},
      onSelectionChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateEew(cfg.eew.copyWith(animationRate: next.first)),
        );
      },
    );
  }
}

class const _EewAutoZoomTile() extends ConsumerWidget {
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
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateEew(cfg.eew.copyWith(autoZoom: next)),
        );
      },
    );
  }
}

class const _LocationPermissionTile() extends HookConsumerWidget {
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

class const _ShowLocationTile() extends ConsumerWidget {
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
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateCommon(cfg.common.copyWith(showLocation: next)),
        );
      },
    );
  }
}

class const _KyoshinMonitorEnabledTile() extends ConsumerWidget {
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

class const _KyoshinMonitorSourceTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    if (!setting.useKmoni) {
      return const SizedBox.shrink();
    }
    return _SettingSegmentedField<KyoshinMonitorSource>(
      title: 'データソース',
      subtitle:
          '強震モニタか長周期地震動モニタを選択します。\n'
          '長周期地震動モニタでは長周期地震動階級などの追加データ種別が利用できます。',
      segments: const [
        ButtonSegment(value: .kmoni, label: Text('強震モニタ')),
        ButtonSegment(value: .lmoni, label: Text('長周期地震動')),
      ],
      selected: {setting.monitorSource},
      onSelectionChanged: (next) async {
        final newSource = next.first;
        var newDataType = setting.realtimeDataType;
        // kmoniに切り替えた場合、LPGMデータ種別が選択されていたらshindoにリセット
        if (newSource == .kmoni && newDataType.isLpgm) {
          newDataType = .shindo;
        }
        await ref
            .read(kyoshinMonitorSettingsProvider.notifier)
            .save(
              setting.copyWith(
                monitorSource: newSource,
                realtimeDataType: newDataType,
              ),
            );
      },
    );
  }
}

class const _KyoshinMonitorAboutTile() extends StatelessWidget {
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

class const _KyoshinRealtimeDataTypeTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    if (!setting.useKmoni) {
      return const SizedBox.shrink();
    }
    // LMoniのときはLPGMデータ種別も含む全種別を表示
    final isLmoni = setting.monitorSource == KyoshinMonitorSource.lmoni;
    final availableTypes = RealtimeDataType.values
        .where((value) => isLmoni || !value.isLpgm)
        .toList();

    return _SettingDropdownField<RealtimeDataType>(
      title: 'リアルタイムデータの種類',
      subtitle: '観測点が示す値を切り替えます。',
      value: setting.realtimeDataType,
      trailing: IconButton(
        onPressed: () async =>
            const KyoshinMonitorDataTypeRoute().push<void>(context),
        icon: const Icon(Icons.info_outline_rounded),
      ),
      entries: availableTypes
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

class const _KyoshinRealtimeLayerTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
    final request = ref.watch(kyoshinMonitorImageRequestProvider);
    if (!request.canSelectRealtimeLayer) {
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

class const _KyoshinMarkerTypeTile() extends ConsumerWidget {
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

class const _KyoshinShowScaleTile() extends ConsumerWidget {
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

class const _KyoshinMinShindoTile() extends ConsumerWidget {
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
        crossAxisAlignment: .start,
        children: [
          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      '観測点フィルター',
                      style: typography.titleSmall.copyWith(
                        fontWeight: .w600,
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
                  await HomeConfigurationNotifier.saveMutation.run(
                    ref,
                    (tsx) async => tsx
                        .get(homeConfigurationProvider.notifier)
                        .updateKyoshinMonitor(
                          homeConfig.kyoshinMonitor.copyWith(
                            minRealtimeShindo: next ? -1.0 : null,
                          ),
                        ),
                  );
                },
              ),
            ],
          ),
          if (min != null) ...[
            SizedBox(height: context.designSystem.spacing.md),
            AccessibleSlider(
              value: min.clamp(-3, 7),
              min: -3,
              max: 7,
              divisions: 20,
              label: min.toStringAsFixed(1),
              onChanged: (next) async {
                await HomeConfigurationNotifier.saveMutation.run(
                  ref,
                  (tsx) async => tsx
                      .get(homeConfigurationProvider.notifier)
                      .updateKyoshinMonitor(
                        homeConfig.kyoshinMonitor.copyWith(
                          minRealtimeShindo: next,
                        ),
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

class const _KyoshinMarkerSizeTile() extends ConsumerWidget {
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
        ButtonSegment(value: HomeKmoniMarkerSize.small, label: Text('小')),
        ButtonSegment(value: HomeKmoniMarkerSize.medium, label: Text('中')),
        ButtonSegment(value: HomeKmoniMarkerSize.large, label: Text('大')),
      ],
      selected: {size},
      onSelectionChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateKyoshinMonitor(
                homeConfig.kyoshinMonitor.copyWith(markerSize: next.first),
              ),
        );
      },
    );
  }
}

class const _KyoshinStationNameTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeConfig = ref.watch(homeConfigurationProvider).value;
    final kmoniConfig = ref.watch(kyoshinMonitorSettingsProvider).value;
    if (homeConfig == null || kmoniConfig == null || !kmoniConfig.useKmoni) {
      return const SizedBox.shrink();
    }
    return _SettingSwitchTile(
      title: '観測点名',
      subtitle: '地図を拡大したとき、強震モニタの観測点の横に観測点名を表示します。',
      value: homeConfig.kyoshinMonitor.showStationName,
      onChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateKyoshinMonitor(
                homeConfig.kyoshinMonitor.copyWith(showStationName: next),
              ),
        );
      },
    );
  }
}

class const _MapLockBearingTile() extends ConsumerWidget {
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
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateMap(cfg.map.copyWith(lockBearing: next)),
        );
      },
    );
  }
}

class const _MapMaxZoomTile() extends ConsumerWidget {
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
        crossAxisAlignment: .start,
        children: [
          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      '最大ズームを制限',
                      style: typography.titleSmall.copyWith(
                        fontWeight: .w600,
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
                  await HomeConfigurationNotifier.saveMutation.run(
                    ref,
                    (tsx) async => tsx
                        .get(homeConfigurationProvider.notifier)
                        .updateMap(
                          cfg.map.copyWith(maxZoom: next ? 12.0 : null),
                        ),
                  );
                },
              ),
            ],
          ),
          if (maxZoom != null) ...[
            SizedBox(height: context.designSystem.spacing.md),
            AccessibleSlider(
              value: maxZoom.clamp(4, 18),
              min: 4,
              max: 18,
              divisions: 14,
              label: maxZoom.toStringAsFixed(0),
              onChanged: (next) async {
                await HomeConfigurationNotifier.saveMutation.run(
                  ref,
                  (tsx) async => tsx
                      .get(homeConfigurationProvider.notifier)
                      .updateMap(cfg.map.copyWith(maxZoom: next)),
                );
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

class const _MapDefaultBoundsTile() extends ConsumerWidget {
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
        ButtonSegment(value: HomeMapDefaultBounds.all, label: Text('全体')),
        ButtonSegment(value: HomeMapDefaultBounds.custom, label: Text('カスタム')),
      ],
      selected: {bounds},
      onSelectionChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateMap(cfg.map.copyWith(defaultBounds: next.first)),
        );
      },
    );
  }
}

class const _MapCustomBoundsButton() extends ConsumerWidget {
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

class const _ShakeDetectionShowTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    return _SettingSwitchTile(
      title: '揺れ検知を地図上に表示',
      subtitle: cfg.shakeDetection.show
          ? '検知イベントを約 0.5° のグリッドで表示します。'
          : '揺れ検知を表示しません。',
      value: cfg.shakeDetection.show,
      onChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateShakeDetection(cfg.shakeDetection.copyWith(show: next)),
        );
      },
    );
  }
}

class const _ShakeDetectionAnimationModeTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null || !cfg.shakeDetection.show) {
      return const SizedBox.shrink();
    }
    final mode = cfg.shakeDetection.animationMode;

    return _SettingSegmentedField<HomeShakeDetectionAnimationMode>(
      title: 'アニメーション',
      subtitle: '点滅・明滅・常時点灯から表示方法を選びます。',
      segments: const [
        ButtonSegment(
          value: HomeShakeDetectionAnimationMode.blink,
          label: Text('点滅'),
        ),
        ButtonSegment(
          value: HomeShakeDetectionAnimationMode.fade,
          label: Text('明滅'),
        ),
        ButtonSegment(
          value: HomeShakeDetectionAnimationMode.solid,
          label: Text('点灯'),
        ),
      ],
      selected: {mode},
      onSelectionChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateShakeDetection(
                cfg.shakeDetection.copyWith(animationMode: next.first),
              ),
        );
      },
    );
  }
}

class const _ShakeDetectionMinLevelTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }

    return _SettingDropdownField<ShakeDetectionLevel>(
      title: '表示する揺れの強さ',
      subtitle: 'この強さに満たない揺れ検知は、地図とカードに表示しません。',
      value: cfg.shakeDetection.minLevel,
      // 二行の項目が 5 件あり、既定の高さでは最後の項目が隠れる。
      dropdownStyle: const M3EDropdownStyle(maxHeight: 420),
      entries: [
        for (final level in ShakeDetectionLevel.values)
          DropdownMenuEntry(value: level, label: level.minLevelDropdownLabel),
      ],
      onChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateShakeDetection(
                cfg.shakeDetection.copyWith(minLevel: next),
              ),
        );
      },
    );
  }
}

class const _ShakeDetectionAutoFocusTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    return _SettingSwitchTile(
      title: '揺れ検知時に自動ズーム',
      subtitle: cfg.shakeDetection.autoFocus
          ? '検知した範囲を自動で注視します。'
          : '現在のズームを維持します。',
      value: cfg.shakeDetection.autoFocus,
      onChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateShakeDetection(
                cfg.shakeDetection.copyWith(autoFocus: next),
              ),
        );
      },
    );
  }
}

class const _DebugOverlayShakeDetectionTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    return _SettingSwitchTile(
      title: '揺れ検知',
      subtitle: '検知の状態、イベントの時刻、EEW との結合判定を表示します。',
      value: cfg.debugOverlay.shakeDetection,
      onChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateDebugOverlay(
                cfg.debugOverlay.copyWith(shakeDetection: next),
              ),
        );
      },
    );
  }
}

class const _DebugOverlayKyoshinMonitorTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    return _SettingSwitchTile(
      title: '強震モニタ',
      subtitle: '画像の時刻と遅れ、種別、観測点数、取得時間を表示します。',
      value: cfg.debugOverlay.kyoshinMonitor,
      onChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateDebugOverlay(
                cfg.debugOverlay.copyWith(kyoshinMonitor: next),
              ),
        );
      },
    );
  }
}

class const _DebugKyoshinIntensityIconTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    return _SettingSwitchTile(
      title: '強震モニタの震度アイコン',
      subtitle: 'リアルタイム震度が 0 以上の観測点を震度アイコンで表示します。',
      value: cfg.kyoshinMonitor.showIntensityIcon,
      onChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateKyoshinMonitor(
                cfg.kyoshinMonitor.copyWith(showIntensityIcon: next),
              ),
        );
      },
    );
  }
}

class const _DebugOverlayEewTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(homeConfigurationProvider).value;
    if (cfg == null) {
      return const SizedBox.shrink();
    }
    return _SettingSwitchTile(
      title: '緊急地震速報',
      subtitle: '表示中の EEW の報番号、規模、発表・発生時刻を表示します。',
      value: cfg.debugOverlay.eew,
      onChanged: (next) async {
        await HomeConfigurationNotifier.saveMutation.run(
          ref,
          (tsx) async => tsx
              .get(homeConfigurationProvider.notifier)
              .updateDebugOverlay(cfg.debugOverlay.copyWith(eew: next)),
        );
      },
    );
  }
}
