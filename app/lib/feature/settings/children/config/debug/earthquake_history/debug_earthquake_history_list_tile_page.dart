import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_area_info.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// [EarthquakeHistoryListTile] の各種デザインをプレビューするデバッグページ。
///
/// - 各種地震 (国内・各最大震度)
/// - 検索対象地域の震度情報
/// - 海外遠地地震情報
/// - 海外の大規模な火山の噴火
class DebugEarthquakeHistoryListTilePage extends ConsumerWidget {
  const DebugEarthquakeHistoryListTilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityColor = ref.watch(intensityColorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('地震履歴 ListTile Debug')),
      body: ListView(
        children: [
          const _SectionHeader('各種地震 (国内・最大震度別)'),
          for (final intensity in _domesticIntensities)
            EarthquakeHistoryListTile(
              item: _domesticEarthquake(maxIntensity: intensity),
              intensityColor: intensityColor,
              onTap: () {},
            ),
          const _SectionHeader('検索対象地域の震度情報'),
          for (final entry in _searchAreaSamples)
            EarthquakeHistoryListTile(
              item: _domesticEarthquake(maxIntensity: entry.maxIntensity),
              areaInfo: entry.areaInfo,
              areaName: entry.areaInfo.name,
              intensityColor: intensityColor,
              onTap: () {},
            ),
          const _SectionHeader('海外遠地地震情報'),
          EarthquakeHistoryListTile(
            item: EarthquakePartial(
              eventId: 'debug-foreign-earthquake',
              status: .normal,
              originTime: DateTime(2024, 1, 1, 3, 24),
              originTimePrecision: .second,
              arrivalTime: null,
              dataSource: .jmaDisasterInformationXml,
              hypocenter: const EarthquakeHypocenter(
                code: '955',
                name: 'ニューギニア付近',
                coordinates: .latLng(latitude: -5, longitude: 145),
                magnitude: .value(value: 7.2),
                depth: .value(value: 30),
                detailedCode: null,
                detailedName: null,
              ),
              intensity: null,
              earthquakeType: .distant,
              estimatedIntensityTileUrl: null,
            ),
            intensityColor: intensityColor,
            onTap: () {},
          ),
          const _SectionHeader('海外の大規模な火山の噴火'),
          EarthquakeHistoryListTile(
            item: _foreignVolcanoEruption(),
            intensityColor: intensityColor,
            onTap: () {},
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

/// 各種地震プレビューで表示する最大震度のバリエーション。
const List<JmaIntensity> _domesticIntensities = [
  JmaIntensity.one,
  JmaIntensity.three,
  JmaIntensity.four,
  JmaIntensity.fiveLower,
  JmaIntensity.fiveUpper,
  JmaIntensity.sixLower,
  JmaIntensity.sixUpper,
  JmaIntensity.seven,
];

/// 国内地震 (震源・最大震度あり) のダミーデータを生成する。
EarthquakePartial _domesticEarthquake({required JmaIntensity maxIntensity}) {
  return EarthquakePartial(
    eventId: 'debug-domestic-${maxIntensity.name}',
    status: TelegramStatus.normal,
    originTime: DateTime(2024, 1, 1, 12),
    originTimePrecision: OriginTimePrecision.second,
    arrivalTime: null,
    dataSource: EarthquakeDataSource.jmaDisasterInformationXml,
    hypocenter: const EarthquakeHypocenter(
      code: '330',
      name: '東京都',
      coordinates: Coordinate.latLng(latitude: 35.689, longitude: 139.692),
      magnitude: EarthquakeMagnitude.value(value: 5.5),
      depth: EarthquakeDepth.value(value: 10),
      detailedCode: null,
      detailedName: null,
    ),
    intensity: EarthquakeIntensityPartial(
      maxIntensity: maxIntensity,
      maxLpgmIntensity: null,
    ),
    earthquakeType: EarthquakeType.normal,
    estimatedIntensityTileUrl: null,
  );
}

/// 検索対象地域の震度情報サンプル。
final List<({JmaIntensity maxIntensity, IntensityAreaInfo areaInfo})>
_searchAreaSamples = [
  (
    maxIntensity: JmaIntensity.fiveLower,
    areaInfo: const IntensityAreaInfo(
      code: '330',
      name: '東京都23区',
      intensity: JmaIntensity.four,
      lpgmIntensity: null,
    ),
  ),
  (
    maxIntensity: JmaIntensity.sixUpper,
    areaInfo: const IntensityAreaInfo(
      code: '270',
      name: '大阪府',
      intensity: JmaIntensity.fiveUpper,
      lpgmIntensity: null,
    ),
  ),
];

/// 海外の大規模な火山の噴火 (遠地・国内震度なし) のダミーデータ。
EarthquakePartial _foreignVolcanoEruption() {
  return EarthquakePartial(
    eventId: 'debug-foreign-volcano',
    status: TelegramStatus.normal,
    originTime: DateTime(2024, 1, 1, 13, 10),
    originTimePrecision: OriginTimePrecision.second,
    arrivalTime: null,
    dataSource: EarthquakeDataSource.jmaDisasterInformationXml,
    hypocenter: const EarthquakeHypocenter(
      code: '999',
      name: 'トンガ諸島',
      coordinates: Coordinate.latLng(latitude: -20.5, longitude: -175.4),
      magnitude: EarthquakeMagnitude.unknown(),
      depth: EarthquakeDepth.shallow(),
      detailedCode: null,
      detailedName: null,
    ),
    intensity: null,
    earthquakeType: EarthquakeType.volcano,
    estimatedIntensityTileUrl: null,
  );
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: theme.textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
