import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/page/home_designated_region_picker_page.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
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
          SettingsSectionHeader(text: 'ホーム地震履歴カード'),
          _HomeDesignatedRegionConfigTile(),
          Divider(),
          SettingsSectionHeader(text: '地震履歴一覧'),
          _EarthquakeHistoryListConfigWidget(),
        ],
      ),
    );
  }
}

class _HomeDesignatedRegionConfigTile extends ConsumerWidget {
  const _HomeDesignatedRegionConfigTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeConfigurationProvider);
    final parameter = homeAsync.value?.common.parameter;
    final regionName = switch (parameter) {
      EarthquakeHistoryParameterAll() => null,
      EarthquakeHistoryParameterRegion(:final regionCode) => regionCode,
      EarthquakeHistoryParameterPrefecture(:final prefectureCode) =>
        prefectureCode,
      EarthquakeHistoryParameterCity(:final cityCode) => cityCode,
      EarthquakeHistoryParameterStation(:final stationCode) => stationCode,
      null => null,
    };
    final searchTypeLabel = switch (parameter) {
      EarthquakeHistoryParameterAll() => '全国',
      EarthquakeHistoryParameterPrefecture() => '都道府県',
      EarthquakeHistoryParameterRegion() => '細分化地域',
      EarthquakeHistoryParameterCity() => '市区町村',
      EarthquakeHistoryParameterStation() => '観測点',
      null => null,
    };

    return ListTile(
      title: const Text('指定地域'),
      subtitle: regionName != null
          ? Text('$searchTypeLabel: $regionName')
          : const Text('未設定（タップして設定）'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final result = await HomeDesignatedRegionPickerPage.show(
          context,
          initialParameter: parameter,
        );
        if (result == null) {
          return;
        }
        await HomeConfigurationNotifier.saveMutation.run(ref, (tsx) async {
          final notifier = tsx.get(homeConfigurationProvider.notifier);
          if (result is EarthquakeHistoryParameterAll) {
            await notifier.clearCustomEarthquakeHistoryParameter();
          } else {
            await notifier.setCustomEarthquakeHistoryParameter(result);
          }
        });
      },
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
                  .save(full.copyWith.list(isFillBackground: value));
            },
          ),
          onTap: () async {
            final full = ref.read(earthquakeHistoryConfigProvider).requireValue;
            await ref
                .read(earthquakeHistoryConfigProvider.notifier)
                .save(
                  full.copyWith.list(isFillBackground: !state.isFillBackground),
                );
          },
        ),
      ],
    );
  }
}
