import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:intl/intl.dart';

class EarthquakeCatalog {
  const EarthquakeCatalog({required this.sections});

  final List<EarthquakeCatalogSection> sections;
}

class EarthquakeCatalogSection {
  const EarthquakeCatalogSection({required this.title, required this.rows});

  final String title;
  final List<EarthquakeCatalogRow> rows;
}

class EarthquakeCatalogRow {
  const EarthquakeCatalogRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  bool operator ==(Object other) {
    return other is EarthquakeCatalogRow &&
        other.label == label &&
        other.value == value;
  }

  @override
  int get hashCode => Object.hash(label, value);

  @override
  String toString() => 'EarthquakeCatalogRow(label: $label, value: $value)';
}

extension EarthquakeCatalogApiExtension on api.Catalog {
  EarthquakeCatalog get toEarthquakeCatalog {
    final sections = [
      EarthquakeCatalogSection(
        title: '震度データベース概要',
        rows: buildCatalogSummaryRows(catalog: this),
      ),
      for (final hypocenter in hypocenters)
        EarthquakeCatalogSection(
          title: '震源 ${hypocenter.seq + 1}',
          rows: buildCatalogHypocenterRows(hypocenter: hypocenter),
        ),
      for (final station in stationRecords) ...[
        EarthquakeCatalogSection(
          title: '観測点 ${station.stationCode}',
          rows: buildCatalogStationRows(station: station),
        ),
        if (station.maxAcceleration != null)
          EarthquakeCatalogSection(
            title: '観測点 ${station.stationCode} 最大加速度',
            rows: buildCatalogMaxAccelerationRows(
              maxAcceleration: station.maxAcceleration,
            ),
          ),
        ...buildCatalogPeriodSections(station: station),
      ],
      if (link != null)
        EarthquakeCatalogSection(
          title: '震度データベース照合',
          rows: buildCatalogLinkRows(link: link),
        ),
    ];
    return EarthquakeCatalog(sections: sections);
  }
}

List<EarthquakeCatalogRow> buildCatalogSummaryRows({
  required api.Catalog catalog,
}) {
  return [
    EarthquakeCatalogRow(
      label: '震源レコード数',
      value: catalog.hypocenters.length.toString(),
    ),
    EarthquakeCatalogRow(
      label: '観測点レコード数',
      value: catalog.stationRecords.length.toString(),
    ),
    if (catalog.damageScale != null)
      EarthquakeCatalogRow(label: '被害規模', value: catalog.damageScale!.toJson()),
    if (catalog.tsunamiScale != null)
      EarthquakeCatalogRow(
        label: '津波規模',
        value: catalog.tsunamiScale!.toJson(),
      ),
  ];
}

List<EarthquakeCatalogRow> buildCatalogHypocenterRows({
  required api.CatalogHypocenter hypocenter,
}) {
  return [
    EarthquakeCatalogRow(
      label: 'レコード種別',
      value: hypocenter.recordType.toJson(),
    ),
    EarthquakeCatalogRow(label: '震源地名', value: hypocenter.epicenterName),
    EarthquakeCatalogRow(
      label: '観測点数',
      value: hypocenter.stationCount.toString(),
    ),
    if (hypocenter.originTime != null)
      EarthquakeCatalogRow(
        label: '発震時刻',
        value: formatCatalogDateTime(dateTime: hypocenter.originTime!),
      ),
    if (hypocenter.originTimeStderrSeconds != null)
      EarthquakeCatalogRow(
        label: '発震時刻 標準誤差',
        value:
            '${formatCatalogNumber(value: hypocenter.originTimeStderrSeconds!)}秒',
      ),
    if (hypocenter.coordinates != null) ...[
      EarthquakeCatalogRow(
        label: '緯度',
        value: formatCatalogNumber(value: hypocenter.coordinates!.latitude),
      ),
      EarthquakeCatalogRow(
        label: '経度',
        value: formatCatalogNumber(value: hypocenter.coordinates!.longitude),
      ),
    ],
    if (hypocenter.depth != null) ...[
      EarthquakeCatalogRow(
        label: '深さ',
        value: '${formatCatalogNumber(value: hypocenter.depth!.value)}km',
      ),
      EarthquakeCatalogRow(
        label: '深さフリー条件',
        value: formatCatalogBool(value: hypocenter.depth!.isFree),
      ),
      if (hypocenter.depth!.stderr != null)
        EarthquakeCatalogRow(
          label: '深さ 標準誤差',
          value: '${formatCatalogNumber(value: hypocenter.depth!.stderr!)}km',
        ),
    ],
    if (hypocenter.maxIntensity != null)
      EarthquakeCatalogRow(
        label: '最大震度階級',
        value: hypocenter.maxIntensity!.toJson(),
      ),
    if (hypocenter.largeAreaCode != null)
      EarthquakeCatalogRow(
        label: '大区域コード',
        value: hypocenter.largeAreaCode.toString(),
      ),
    if (hypocenter.smallAreaCode != null)
      EarthquakeCatalogRow(
        label: '小区域コード',
        value: hypocenter.smallAreaCode.toString(),
      ),
    if (hypocenter.determinationFlag != null)
      EarthquakeCatalogRow(
        label: '震源決定フラグ',
        value: hypocenter.determinationFlag!.toJson(),
      ),
    if (hypocenter.evaluation != null)
      EarthquakeCatalogRow(
        label: '震源評価',
        value: hypocenter.evaluation!.toJson(),
      ),
    if (hypocenter.auxiliaryInfo != null)
      EarthquakeCatalogRow(
        label: '震源補助情報',
        value: hypocenter.auxiliaryInfo!.toJson(),
      ),
    if (hypocenter.travelTimeTable != null)
      EarthquakeCatalogRow(
        label: '走時表',
        value: hypocenter.travelTimeTable!.toJson(),
      ),
    for (final entry in hypocenter.magnitudes.indexed)
      EarthquakeCatalogRow(
        label: 'マグニチュード${entry.$1 + 1}',
        value:
            '${entry.$2.type.toJson()} ${formatCatalogNumber(value: entry.$2.value)}',
      ),
  ];
}

List<EarthquakeCatalogRow> buildCatalogStationRows({
  required api.CatalogStationRecord station,
}) {
  return [
    EarthquakeCatalogRow(label: '観測点コード', value: station.stationCode),
    EarthquakeCatalogRow(
      label: '震度階級',
      value: station.intensity.classValue.toJson(),
    ),
    if (station.intensity.instrumental != null)
      EarthquakeCatalogRow(
        label: '計測震度',
        value: formatCatalogNumber(value: station.intensity.instrumental!),
      ),
    if (station.observedAt != null)
      EarthquakeCatalogRow(
        label: '観測時刻',
        value: formatCatalogDateTime(dateTime: station.observedAt!),
      ),
    if (station.maxAccelTime != null)
      EarthquakeCatalogRow(
        label: '最大加速度時刻',
        value: formatCatalogDateTime(dateTime: station.maxAccelTime!),
      ),
    if (station.observationCount != null)
      EarthquakeCatalogRow(
        label: '観測回数',
        value: station.observationCount.toString(),
      ),
  ];
}

List<EarthquakeCatalogRow> buildCatalogMaxAccelerationRows({
  required api.CatalogStationMaxAcceleration? maxAcceleration,
}) {
  if (maxAcceleration == null) {
    return const [];
  }

  return [
    if (maxAcceleration.synthesizedGal != null)
      EarthquakeCatalogRow(
        label: '合成',
        value:
            '${formatCatalogNumber(value: maxAcceleration.synthesizedGal!)}gal',
      ),
    if (maxAcceleration.nsGal != null)
      EarthquakeCatalogRow(
        label: '南北',
        value: '${formatCatalogNumber(value: maxAcceleration.nsGal!)}gal',
      ),
    if (maxAcceleration.ewGal != null)
      EarthquakeCatalogRow(
        label: '東西',
        value: '${formatCatalogNumber(value: maxAcceleration.ewGal!)}gal',
      ),
    if (maxAcceleration.udGal != null)
      EarthquakeCatalogRow(
        label: '上下',
        value: '${formatCatalogNumber(value: maxAcceleration.udGal!)}gal',
      ),
  ];
}

List<EarthquakeCatalogSection> buildCatalogPeriodSections({
  required api.CatalogStationRecord station,
}) {
  final periods = station.periods;
  if (periods == null) {
    return const [];
  }

  return [
    if (periods.ns != null)
      EarthquakeCatalogSection(
        title: '観測点 ${station.stationCode} 周期 NS',
        rows: buildCatalogPeriodRows(component: periods.ns!),
      ),
    if (periods.ew != null)
      EarthquakeCatalogSection(
        title: '観測点 ${station.stationCode} 周期 EW',
        rows: buildCatalogPeriodRows(component: periods.ew!),
      ),
    if (periods.ud != null)
      EarthquakeCatalogSection(
        title: '観測点 ${station.stationCode} 周期 UD',
        rows: buildCatalogPeriodRows(component: periods.ud!),
      ),
  ];
}

List<EarthquakeCatalogRow> buildCatalogPeriodRows({
  required api.CatalogStationPeriodComponent component,
}) {
  return [
    if (component.maxAccelPeriod != null)
      EarthquakeCatalogRow(
        label: '最大加速度周期',
        value: formatCatalogPeriodValue(value: component.maxAccelPeriod!),
      ),
    if (component.predominantPeriod != null)
      EarthquakeCatalogRow(
        label: '卓越周期',
        value: formatCatalogPeriodValue(value: component.predominantPeriod!),
      ),
  ];
}

List<EarthquakeCatalogRow> buildCatalogLinkRows({
  required api.CatalogLink? link,
}) {
  if (link == null) {
    return const [];
  }

  return [
    EarthquakeCatalogRow(
      label: '照合信頼度',
      value: formatCatalogNumber(value: link.matchConfidence),
    ),
    EarthquakeCatalogRow(label: '照合方法', value: link.matchMethod.toJson()),
    EarthquakeCatalogRow(
      label: '時刻差',
      value: '${formatCatalogNumber(value: link.timeDiffSeconds)}秒',
    ),
    EarthquakeCatalogRow(
      label: '距離',
      value: link.distanceKm == null
          ? 'なし'
          : '${formatCatalogNumber(value: link.distanceKm!)}km',
    ),
  ];
}

String formatCatalogDateTime({required DateTime dateTime}) {
  return DateFormat('yyyy/MM/dd HH:mm:ss').format(dateTime);
}

String formatCatalogNumber({required num value}) {
  if (value is int) {
    return value.toString();
  }
  final normalized = value.toDouble();
  if (normalized == normalized.truncateToDouble()) {
    return normalized.toInt().toString();
  }
  return normalized.toString();
}

String formatCatalogBool({required bool value}) => value ? 'はい' : 'いいえ';

String formatCatalogPeriodValue({required api.CatalogPeriodValue value}) {
  final rawValue = value.value;
  if (rawValue == null) {
    return '${value.kind.toJson()} 欠測';
  }
  return '${value.kind.toJson()} ${formatCatalogNumber(value: rawValue)}';
}
