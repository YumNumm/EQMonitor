import 'package:eqmonitor/core/provider/config/earthquake_history/earthquake_history_config_provider.dart';
import 'package:eqmonitor/core/provider/config/earthquake_history/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
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
          trailing: Text(state.intensityDisplayMode.name),
          onTap: () async {
            //bottomSheetで選択する
            final result = await showModalBottomSheet<IntensityDisplayMode>(
              context: context,
              clipBehavior: Clip.antiAlias,
              builder: (context) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      sheetBar,
                      for (final mode in IntensityDisplayMode.values)
                        RadioListTile.adaptive(
                          title: Text(mode.name),
                          value: mode,
                          groupValue: state.intensityDisplayMode,
                          onChanged: (value) => Navigator.pop(context, value),
                        ),
                    ],
                  ),
                );
              },
            );
            if (result != null) {
              ref
                  .read(earthquakeHistoryConfigProvider.notifier)
                  .updateDetailConfig(
                    state.copyWith(
                      intensityDisplayMode: result,
                    ),
                  );
            }
          },
        ),
      ],
    );
  }
}

extension _IntensityDisplayModeEx on IntensityDisplayMode {
  String get name => switch (this) {
        IntensityDisplayMode.icon => '震度アイコン',
        IntensityDisplayMode.fillCity => '市区町村を塗りつぶし',
        IntensityDisplayMode.fillPrefecture => '都道府県を塗りつぶし',
        IntensityDisplayMode.iconAndFillPrefecture => '震度アイコンと市区町村を塗りつぶし',
      };
}
