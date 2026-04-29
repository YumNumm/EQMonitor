import 'dart:io';

import 'package:eqmonitor/core/component/widget/app_switch.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text('地震履歴設定')),
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
          trailing: AppSwitch(
            value: state.isFillBackground,
            onChanged: (value) async {
              final full = ref
                  .read(earthquakeHistoryConfigProvider)
                  .requireValue;
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
        color: Theme.of(context).colorScheme.onSurface,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );

    Future<void> saveDetail(EarthquakeHistoryDetailConfig next) async {
      final full = ref.read(earthquakeHistoryConfigProvider).requireValue;
      await ref
          .read(earthquakeHistoryConfigProvider.notifier)
          .save(full.copyWith(detail: next));
    }

    return Column(
      children: [
        // アイコン表示モード
        ListTile(
          title: const Text('アイコンの表示'),
          trailing: Text(state.iconMode.displayName),
          onTap: () async {
            final result = await showModalBottomSheet<EarthquakeHistoryIconMode>(
              context: context,
              clipBehavior: Clip.antiAlias,
              builder: (context) {
                return SafeArea(
                  child: RadioGroup(
                    onChanged: (value) => Navigator.pop(context, value),
                    groupValue: state.iconMode,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        sheetBar,
                        for (final mode in EarthquakeHistoryIconMode.values)
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
              await saveDetail(state.copyWith(iconMode: result));
            }
          },
        ),
        // 塗りつぶし表示モード
        ListTile(
          title: const Text('塗りつぶし'),
          trailing: Text(state.fillMode.displayName),
          onTap: () async {
            final result =
                await showModalBottomSheet<EarthquakeHistoryFillMode>(
              context: context,
              clipBehavior: Clip.antiAlias,
              builder: (context) {
                return SafeArea(
                  child: RadioGroup(
                    onChanged: (value) => Navigator.pop(context, value),
                    groupValue: state.fillMode,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        sheetBar,
                        for (final mode in EarthquakeHistoryFillMode.values)
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
              await saveDetail(state.copyWith(fillMode: result));
            }
          },
        ),
      ],
    );
  }
}

extension _IconModeEx on EarthquakeHistoryIconMode {
  String get displayName => switch (this) {
    EarthquakeHistoryIconMode.auto => '自動',
    EarthquakeHistoryIconMode.station => '観測点',
    EarthquakeHistoryIconMode.municipality => '市区町村',
    EarthquakeHistoryIconMode.region => '細分化地域',
    EarthquakeHistoryIconMode.none => 'なし',
  };
}

extension _FillModeEx on EarthquakeHistoryFillMode {
  String get displayName => switch (this) {
    EarthquakeHistoryFillMode.none => 'なし',
    EarthquakeHistoryFillMode.matchIcon => 'アイコンに合わせて塗りつぶし',
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
              text: showingLpgmIntensity ? '長周期地震動階級のアイコン' : '震度のアイコン',
            ),
          ),
          const Center(child: _IconModeSegmentedControl()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SettingsSectionHeader(
              text: showingLpgmIntensity ? '長周期地震動階級の塗りつぶし' : '震度の塗りつぶし',
            ),
          ),
          const Center(child: _FillModeSegmentedControl()),
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

class _IconModeSegmentedControl extends ConsumerStatefulWidget {
  const _IconModeSegmentedControl();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __IconModeSegmentedControlState();
}

class __IconModeSegmentedControlState
    extends ConsumerState<_IconModeSegmentedControl> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      earthquakeHistoryConfigProvider.select(
        (value) => value.requireValue.detail,
      ),
    );
    const choices = EarthquakeHistoryIconMode.values;

    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoSlidingSegmentedControl(
        groupValue: state.iconMode,
        padding: const EdgeInsets.all(4),
        children: {
          for (final mode in choices)
            mode: Text(
              switch (mode) {
                EarthquakeHistoryIconMode.auto => '自動',
                EarthquakeHistoryIconMode.station => '観測点',
                EarthquakeHistoryIconMode.municipality => '市区町村',
                EarthquakeHistoryIconMode.region => '地域',
                EarthquakeHistoryIconMode.none => 'なし',
              },
            ),
        },
        onValueChanged: (value) async {
          if (value != null) {
            final full =
                ref.read(earthquakeHistoryConfigProvider).requireValue;
            await ref
                .read(earthquakeHistoryConfigProvider.notifier)
                .save(full.copyWith.detail(iconMode: value));
          }
        },
      );
    } else {
      return SegmentedButton(
        selected: {state.iconMode},
        onSelectionChanged: (p0) async {
          final full = ref.read(earthquakeHistoryConfigProvider).requireValue;
          await ref
              .read(earthquakeHistoryConfigProvider.notifier)
              .save(full.copyWith.detail(iconMode: p0.first));
        },
        segments: [
          for (final mode in choices)
            ButtonSegment(
              label: Text(
                switch (mode) {
                  EarthquakeHistoryIconMode.auto => '自動',
                  EarthquakeHistoryIconMode.station => '観測点',
                  EarthquakeHistoryIconMode.municipality => '市区町村',
                  EarthquakeHistoryIconMode.region => '地域',
                  EarthquakeHistoryIconMode.none => 'なし',
                },
              ),
              value: mode,
            ),
        ],
      );
    }
  }
}

class _FillModeSegmentedControl extends ConsumerStatefulWidget {
  const _FillModeSegmentedControl();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __FillModeSegmentedControlState();
}

class __FillModeSegmentedControlState
    extends ConsumerState<_FillModeSegmentedControl> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      earthquakeHistoryConfigProvider.select(
        (value) => value.requireValue.detail,
      ),
    );
    const choices = EarthquakeHistoryFillMode.values;

    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoSlidingSegmentedControl(
        groupValue: state.fillMode,
        padding: const EdgeInsets.all(4),
        children: {
          for (final mode in choices)
            mode: Text(
              switch (mode) {
                EarthquakeHistoryFillMode.none => 'なし',
                EarthquakeHistoryFillMode.matchIcon => 'アイコンに合わせる',
              },
            ),
        },
        onValueChanged: (value) async {
          if (value != null) {
            final full =
                ref.read(earthquakeHistoryConfigProvider).requireValue;
            await ref
                .read(earthquakeHistoryConfigProvider.notifier)
                .save(full.copyWith.detail(fillMode: value));
          }
        },
      );
    } else {
      return SegmentedButton(
        selected: {state.fillMode},
        onSelectionChanged: (p0) async {
          final full = ref.read(earthquakeHistoryConfigProvider).requireValue;
          await ref
              .read(earthquakeHistoryConfigProvider.notifier)
              .save(full.copyWith.detail(fillMode: p0.first));
        },
        segments: [
          for (final mode in choices)
            ButtonSegment(
              label: Text(
                switch (mode) {
                  EarthquakeHistoryFillMode.none => 'なし',
                  EarthquakeHistoryFillMode.matchIcon => 'アイコンに合わせる',
                },
              ),
              value: mode,
            ),
        ],
      );
    }
  }
}

enum _IntensityMode {
  intensity('震度'),
  lpgm('長周期地震動階級');

  const _IntensityMode(this.name);
  final String name;
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
