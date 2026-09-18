import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/region_name_resolver.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/page/home_designated_region_picker_page.dart';
import 'package:eqmonitor/feature/settings/children/config/earthquake_history/earthquake_history_list_config_view.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryConfigPage extends StatelessWidget {
  const new({super.key});

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
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeConfigurationProvider);
    final parameter = homeAsync.value?.common.parameter;
    final regionSelection = switch (parameter) {
      EarthquakeHistoryParameterAll() => null,
      EarthquakeHistoryParameterRegion(:final regionCode) => (
        RegionSearchType.region,
        regionCode,
      ),
      EarthquakeHistoryParameterPrefecture(:final prefectureCode) => (
        RegionSearchType.prefecture,
        prefectureCode,
      ),
      EarthquakeHistoryParameterCity(:final cityCode) => (
        RegionSearchType.city,
        cityCode,
      ),
      EarthquakeHistoryParameterStation(:final stationCode) => (
        RegionSearchType.station,
        stationCode,
      ),
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
    final regionName = switch (regionSelection) {
      (final searchType, final code) => ref.watch(
        regionNameProvider(searchType, code),
      ),
      null => null,
    };

    return ListTile(
      title: const Text('指定地域'),
      subtitle: switch (regionName) {
        AsyncData(:final value) when value != null && value.isNotEmpty => Text(
          '$searchTypeLabel: $value',
        ),
        AsyncData() || AsyncError() => Text('$searchTypeLabel: 地域名を取得できません'),
        AsyncLoading() => Text('$searchTypeLabel: 地域名を読み込み中'),
        null => const Text('未設定（タップして設定）'),
      },
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
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      earthquakeHistoryConfigProvider.select(
        (value) => value.requireValue.list,
      ),
    );
    return EarthquakeHistoryListConfigView(
      config: state,
      onChanged: (value) async {
        final full = ref.read(earthquakeHistoryConfigProvider).requireValue;
        await ref
            .read(earthquakeHistoryConfigProvider.notifier)
            .save(full.copyWith(list: value));
      },
    );
  }
}
