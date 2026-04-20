import 'dart:io';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryConfigPage extends StatelessWidget {
  const EarthquakeHistoryConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: const AdaptiveAppBar(title: '地震履歴設定'),
      body: ListView(
        children: const [
          SettingsSectionHeader(text: '地震履歴一覧'),
          _EarthquakeHistoryListConfigWidget(),
          Divider(),
          SettingsSectionHeader(text: '地震履歴詳細'),
          _EarthquakeHistoryDetailConfigWidget(),
        ],
      ),
    );
  }
}

class _EarthquakeHistoryListConfigWidget extends ConsumerWidget {
  const _EarthquakeHistoryListConfigWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      earthquakeHistoryConfigProvider.select(
        (value) => value.requireValue.list,
      ),
    );
    return Column(
      children: [
        ListTile(
          title: const Text('最大震度ごとの背景塗りつぶし'),
          trailing: AdaptiveSwitch(
            value: state.isFillBackground,
            onChanged: (value) async {
              final full =
                  ref.read(earthquakeHistoryConfigProvider).requireValue;
              await ref
                  .read(earthquakeHistoryConfigProvider.notifier)
                  .save(
                    full.copyWith.list(isFillBackground: value),
                  );
            },
          ),
          onTap: () async {
            final full = ref.read(earthquakeHistoryConfigProvider).requireValue;
            await ref
                .read(earthquakeHistoryConfigProvider.notifier)
                .save(
                  full.copyWith.list(
                    isFillBackground: !state.isFillBackground,
                  ),
                );
          },
        ),
      ],
    );
  }
}

class _EarthquakeHistoryDetailConfigWidget extends ConsumerWidget {
  const _EarthquakeHistoryDetailConfigWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(
      earthquakeHistoryConfigProvider.select(
        (value) => value.requireValue.detail,
      ),
    );
    final sheetBar = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.onSurface,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );
    return Column(
      children: [
        ListTile(
          title: const Text('震度の表示方法'),
          trailing: Text(state.intensityFillMode.displayName),
          onTap: () async {
            //bottomSheetで選択する
            final result = await showModalBottomSheet<IntensityFillMode>(
              context: context,
              clipBehavior: Clip.antiAlias,
              builder: (context) {
                return SafeArea(
                  child: RadioGroup(
                    onChanged: (value) => Navigator.pop(context, value),
                    groupValue: state.intensityFillMode,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        sheetBar,
                        for (final mode in IntensityFillMode.values)
                          RadioListTile.adaptive(
                            title: Text(mode.displayName),
                            value: mode,
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
            if (result != null) {
              final full = ref
                  .read(earthquakeHistoryConfigProvider)
                  .requireValue;
              await ref
                  .read(earthquakeHistoryConfigProvider.notifier)
                  .save(
                    full.copyWith.detail(intensityFillMode: result),
                  );
            }
          },
        ),
      ],
    );
  }
}

extension _IntensityDisplayModeEx on IntensityFillMode {
  String get displayName => switch (this) {
    IntensityFillMode.stationOnly => '観測点のみ',
    IntensityFillMode.fill => '塗りつぶし',
    IntensityFillMode.fillWithIcon => '塗りつぶし+アイコン',
  };
}

Future<EarthquakeHistoryDetailConfig?> showEarthquakeHistoryDetailConfigDialog(
  BuildContext context, {
  required bool hasLpgmIntensity,
}) async {
  final result = await showModalBottomSheet<EarthquakeHistoryDetailConfig>(
    context: context,
    clipBehavior: Clip.antiAlias,
    builder: (context) => _EarthquakeHistoryDetailConfigBody(
      hasLpgmIntensity: hasLpgmIntensity,
    ),
  );
  return result;
}

class _EarthquakeHistoryDetailConfigBody extends HookConsumerWidget {
  const _EarthquakeHistoryDetailConfigBody({
    required this.hasLpgmIntensity,
  });

  final bool hasLpgmIntensity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showingLpgmIntensity = ref.watch(
      earthquakeHistoryConfigProvider.select(
        (value) => value.requireValue.detail.showingLpgmIntensity,
      ),
    );
    final theme = Theme.of(context);
    final sheetBar = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.onSurface,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(child: sheetBar),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SettingsSectionHeader(
              text: showingLpgmIntensity ? '長周期地震動階級の塗りつぶし' : '震度の塗りつぶし',
            ),
          ),
          const Center(child: _IntensityFillModeSegmentedControl()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SettingsSectionHeader(
              text: showingLpgmIntensity ? '長周期地震動階級のアイコン' : '震度のアイコン',
            ),
          ),
          _ShowIntensityIconToggle(
            showingLpgmIntensity: showingLpgmIntensity,
          ),
          if (hasLpgmIntensity) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SettingsSectionHeader(text: '震度・長周期地震動階級の表示切り替え'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: _IntensityModeSegmentedControl(
                selected: showingLpgmIntensity
                    ? _IntensityMode.lpgm
                    : _IntensityMode.intensity,
                onSelected: (value) async {
                  final full = ref
                      .read(earthquakeHistoryConfigProvider)
                      .requireValue;
                  await ref
                      .read(earthquakeHistoryConfigProvider.notifier)
                      .save(
                        full.copyWith.detail(
                          showingLpgmIntensity: value == _IntensityMode.lpgm,
                        ),
                      );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _IntensityFillModeSegmentedControl extends ConsumerStatefulWidget {
  const _IntensityFillModeSegmentedControl();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __IntensityFillModeSegmentedControlState();
}

class __IntensityFillModeSegmentedControlState
    extends ConsumerState<_IntensityFillModeSegmentedControl> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      earthquakeHistoryConfigProvider.select(
        (value) => value.requireValue.detail,
      ),
    );
    const choices = IntensityFillMode.values;

    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoSlidingSegmentedControl(
        groupValue: state.intensityFillMode,
        padding: const EdgeInsets.all(4),
        children: {
          for (final mode in choices) mode: Text(mode.displayName),
        },
        onValueChanged: (value) async {
          if (value != null) {
            final full = ref.read(earthquakeHistoryConfigProvider).requireValue;
            await ref
                .read(earthquakeHistoryConfigProvider.notifier)
                .save(
                  full.copyWith.detail(intensityFillMode: value),
                );
          }
        },
      );
    } else {
      return SegmentedButton(
        selected: {state.intensityFillMode},
        onSelectionChanged: (p0) async {
          final full = ref.read(earthquakeHistoryConfigProvider).requireValue;
          await ref
              .read(earthquakeHistoryConfigProvider.notifier)
              .save(
                full.copyWith.detail(intensityFillMode: p0.first),
              );
        },
        segments: [
          for (final mode in choices)
            ButtonSegment(label: Text(mode.displayName), value: mode),
        ],
      );
    }
  }
}

enum _IntensityMode {
  intensity('震度'),
  lpgm('長周期地震動階級')
  ;

  const _IntensityMode(this.name);
  final String name;
}

class _ShowIntensityIconToggle extends ConsumerWidget {
  const _ShowIntensityIconToggle({required this.showingLpgmIntensity});

  final bool showingLpgmIntensity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      earthquakeHistoryConfigProvider.select(
        (value) => value.requireValue.detail,
      ),
    );
    return ListTile(
      title: Text(
        showingLpgmIntensity ? '観測点に長周期地震動階級アイコンを表示' : '観測点に震度アイコンを表示',
      ),
      trailing: AdaptiveSwitch(
        value: state.showIntensityIcon,
        onChanged: (v) async {
          final full = ref.read(earthquakeHistoryConfigProvider).requireValue;
          await ref
              .read(earthquakeHistoryConfigProvider.notifier)
              .save(
                full.copyWith.detail(showIntensityIcon: v),
              );
        },
      ),
      onTap: () async {
        final full = ref.read(earthquakeHistoryConfigProvider).requireValue;
        await ref
            .read(earthquakeHistoryConfigProvider.notifier)
            .save(
              full.copyWith.detail(
                showIntensityIcon: !state.showIntensityIcon,
              ),
            );
      },
    );
  }
}

class _IntensityModeSegmentedControl extends StatelessWidget {
  const _IntensityModeSegmentedControl({
    required this.onSelected,
    required this.selected,
  });

  final void Function(_IntensityMode) onSelected;
  final _IntensityMode selected;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoSlidingSegmentedControl(
        groupValue: selected,
        children: {
          for (final mode in _IntensityMode.values) mode: Text(mode.name),
        },
        onValueChanged: (value) {
          if (value != null) {
            onSelected(value);
          }
        },
      );
    } else {
      return SegmentedButton(
        selected: {selected},
        onSelectionChanged: (p0) => onSelected(p0.first),
        segments: [
          for (final mode in _IntensityMode.values)
            ButtonSegment(label: Text(mode.name), value: mode),
        ],
      );
    }
  }
}
