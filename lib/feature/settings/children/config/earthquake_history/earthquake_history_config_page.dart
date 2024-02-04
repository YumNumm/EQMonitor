import 'dart:io';

import 'package:eqmonitor/core/provider/config/earthquake_history/earthquake_history_config_provider.dart';
import 'package:eqmonitor/core/provider/config/earthquake_history/model/earthquake_history_config_model.dart';
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
      appBar: AppBar(
        title: const Text('地震履歴設定'),
      ),
      body: ListView(
        children: const [
          SettingsSectionHeader(
            text: '地震履歴一覧',
          ),
          _EarthquakeHistoryListConfigWidget(),
          Divider(),
          SettingsSectionHeader(
            text: '地震履歴詳細',
          ),
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
      earthquakeHistoryConfigProvider.select((value) => value.list),
    );
    return Column(
      children: [
        SwitchListTile.adaptive(
          title: const Text('最大震度ごとの背景塗りつぶし'),
          value: state.isFillBackground,
          onChanged: (value) => ref
              .read(earthquakeHistoryConfigProvider.notifier)
              .updateListConfig(
                state.copyWith(
                  isFillBackground: value,
                ),
              ),
        ),

        /// includeTest
        SwitchListTile.adaptive(
          title: const Text('訓練・試験報の情報を表示する'),
          subtitle: const Text('気象庁により作成された、訓練・試験用の緊急地震速報の情報を表示します。※非推奨'),
          value: state.includeTestTelegrams,
          onChanged: (value) => ref
              .read(earthquakeHistoryConfigProvider.notifier)
              .updateListConfig(
                state.copyWith(
                  includeTestTelegrams: value,
                ),
              ),
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
      earthquakeHistoryConfigProvider.select((value) => value.detail),
    );
    final sheetBar = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.onBackground,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );
    return Column(
      children: [
        ListTile(
          title: const Text('震度の表示方法'),
          trailing: Text(state.intensityFillMode.name),
          onTap: () async {
            //bottomSheetで選択する
            final result = await showModalBottomSheet<IntensityFillMode>(
              context: context,
              clipBehavior: Clip.antiAlias,
              builder: (context) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      sheetBar,
                      for (final mode in IntensityFillMode.values)
                        RadioListTile.adaptive(
                          title: Text(mode.name),
                          value: mode,
                          groupValue: state.intensityFillMode,
                          onChanged: (value) => Navigator.pop(context, value),
                        ),
                    ],
                  ),
                );
              },
            );
            if (result != null) {
              await ref
                  .read(earthquakeHistoryConfigProvider.notifier)
                  .updateDetailConfig(
                    state.copyWith(
                      intensityFillMode: result,
                    ),
                  );
            }
          },
        ),
      ],
    );
  }
}

extension _IntensityDisplayModeEx on IntensityFillMode {
  String get name => switch (this) {
        IntensityFillMode.fillCity => '市区町村',
        IntensityFillMode.fillRegion => '細分化地域',
        IntensityFillMode.none => '塗りつぶしなし',
      };
}

Future<EarthquakeHistoryDetailConfig?> showEarthquakeHistoryDetailConfigDialog(
  BuildContext context, {
  required bool showCitySelector,
  required bool hasLpgmIntensity,
}) async {
  final result = await showModalBottomSheet<EarthquakeHistoryDetailConfig>(
    context: context,
    clipBehavior: Clip.antiAlias,
    builder: (context) => _EarthquakeHistoryDetailConfigBody(
      showCitySelector: showCitySelector,
      hasLpgmIntensity: hasLpgmIntensity,
    ),
  );
  return result;
}

class _EarthquakeHistoryDetailConfigBody extends HookConsumerWidget {
  const _EarthquakeHistoryDetailConfigBody({
    required this.showCitySelector,
    required this.hasLpgmIntensity,
  });
  final bool showCitySelector;
  final bool hasLpgmIntensity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showingLpgmIntensity = ref.watch(
      earthquakeHistoryConfigProvider
          .select((value) => value.detail.showingLpgmIntensity),
    );
    final theme = Theme.of(context);
    final sheetBar = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.onBackground,
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
          Center(
            child: _IntensityFillModeSegmentedControl(
              showCitySelector: showCitySelector && !showingLpgmIntensity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SettingsSectionHeader(
              text: showingLpgmIntensity ? '長周期地震動階級のアイコン' : '震度のアイコン',
            ),
          ),
          const _IntensityStationIconModeSegmentedButton(),
          if (hasLpgmIntensity) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SettingsSectionHeader(
                text: '震度・長周期地震動階級の表示切り替え',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: _IntensityModeSegmentedControl(
                selected: showingLpgmIntensity
                    ? _IntensityMode.lpgm
                    : _IntensityMode.intensity,
                onSelected: (value) => ref
                    .read(earthquakeHistoryConfigProvider.notifier)
                    .updateDetailConfig(
                      ref
                          .watch(earthquakeHistoryConfigProvider)
                          .detail
                          .copyWith(
                            showingLpgmIntensity: value == _IntensityMode.lpgm,
                          ),
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _IntensityFillModeSegmentedControl extends ConsumerStatefulWidget {
  const _IntensityFillModeSegmentedControl({
    required this.showCitySelector,
  });
  final bool showCitySelector;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __IntensityFillModeSegmentedControlState();
}

class __IntensityFillModeSegmentedControlState
    extends ConsumerState<_IntensityFillModeSegmentedControl> {
  @override
  Widget build(BuildContext context) {
    final state = ref
        .watch(earthquakeHistoryConfigProvider.select((value) => value.detail));
    final showCitySelector = widget.showCitySelector;
    const choices = IntensityFillMode.values;

    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoSlidingSegmentedControl(
        groupValue: state.intensityFillMode,
        padding: const EdgeInsets.all(4),
        children: {
          for (final mode in choices)
            mode: Text(
              mode.name,
              style: showCitySelector || mode != IntensityFillMode.fillCity
                  ? null
                  : const TextStyle(color: Colors.grey),
            ),
        },
        onValueChanged: (value) {
          if (value != null) {
            final isAllowed =
                showCitySelector || value != IntensityFillMode.fillCity;
            if (!isAllowed) {
              // treeの再構築をトリガーすることで、
              // 選択できない選択肢が選択されている状態を解除する
              // (CupertinoSlidingSegmentedControlが内部的に管理している選択状況を、
              // groupValueから再取得させることで、想定された状態に戻す)
              setState(() {});
              return;
            }
            ref
                .read(earthquakeHistoryConfigProvider.notifier)
                .updateDetailConfig(
                  state.copyWith(intensityFillMode: value),
                );
          }
        },
      );
    } else {
      return SegmentedButton(
        selected: {state.intensityFillMode},
        onSelectionChanged: (p0) => ref
            .read(earthquakeHistoryConfigProvider.notifier)
            .updateDetailConfig(
              state.copyWith(intensityFillMode: p0.first),
            ),
        segments: [
          for (final mode in choices)
            ButtonSegment(
              label: Text(mode.name),
              value: mode,
              enabled: showCitySelector || mode != IntensityFillMode.fillCity,
            ),
        ],
      );
    }
  }
}

enum _IntensityMode {
  intensity('震度'),
  lpgm('長周期地震動階級'),
  ;

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
            ButtonSegment(
              label: Text(mode.name),
              value: mode,
            ),
        ],
      );
    }
  }
}

class _IntensityStationIconModeSegmentedButton extends ConsumerWidget {
  const _IntensityStationIconModeSegmentedButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref
        .watch(earthquakeHistoryConfigProvider.select((value) => value.detail));
    final isShowingLpgmIntensity = state.showingLpgmIntensity;
    return SwitchListTile.adaptive(
      title: Text(isShowingLpgmIntensity ? '長周期地震動階級アイコンを表示する' : '震度アイコンを表示する'),
      value: state.showIntensityIcon,
      onChanged: (value) =>
          ref.read(earthquakeHistoryConfigProvider.notifier).updateDetailConfig(
                state.copyWith(showIntensityIcon: value),
              ),
    );
  }
}
