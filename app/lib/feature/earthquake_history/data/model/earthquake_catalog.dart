import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_catalog.freezed.dart';

/// 震度データベース (i####.zip カタログ) 由来の詳細情報
@freezed
abstract class EarthquakeCatalog with _$EarthquakeCatalog {
  const factory EarthquakeCatalog({
    required List<EarthquakeCatalogHypocenter> hypocenters,
    required List<EarthquakeCatalogStationRecord> stationRecords,
    required String? damageScaleLabel,
    required String? tsunamiScaleLabel,
    required double? linkMatchConfidence,
  }) = _EarthquakeCatalog;
}

@freezed
abstract class EarthquakeCatalogHypocenter with _$EarthquakeCatalogHypocenter {
  const factory EarthquakeCatalogHypocenter({
    required int seq,
    required String epicenterName,
    required int stationCount,
    required String recordTypeLabel,
    required DateTime? originTime,
    required double? originTimeStderrSeconds,
    required double? latitude,
    required double? longitude,
    required double? depthKm,
    required bool depthIsFree,
    required double? depthStderrKm,
    required ShindoDbIntensityClass? maxIntensity,
    required String? determinationFlagLabel,
    required String? evaluationLabel,
    required List<EarthquakeCatalogMagnitude> magnitudes,
  }) = _EarthquakeCatalogHypocenter;
}

@freezed
abstract class EarthquakeCatalogMagnitude with _$EarthquakeCatalogMagnitude {
  const factory EarthquakeCatalogMagnitude({
    required String typeLabel,
    required double value,
  }) = _EarthquakeCatalogMagnitude;
}

@freezed
abstract class EarthquakeCatalogStationRecord
    with _$EarthquakeCatalogStationRecord {
  const factory EarthquakeCatalogStationRecord({
    required String stationCode,
    required ShindoDbIntensityClass intensityClass,
    required double? instrumentalIntensity,
    required DateTime? observedAt,
    required EarthquakeCatalogMaxAcceleration? maxAcceleration,
    required DateTime? maxAccelTime,
    required EarthquakeCatalogPeriods? periods,
    required int? observationCount,
  }) = _EarthquakeCatalogStationRecord;
}

@freezed
abstract class EarthquakeCatalogMaxAcceleration
    with _$EarthquakeCatalogMaxAcceleration {
  const factory EarthquakeCatalogMaxAcceleration({
    required double? synthesizedGal,
    required double? nsGal,
    required double? ewGal,
    required double? udGal,
  }) = _EarthquakeCatalogMaxAcceleration;
}

@freezed
abstract class EarthquakeCatalogPeriods with _$EarthquakeCatalogPeriods {
  const factory EarthquakeCatalogPeriods({
    required EarthquakeCatalogPeriodComponent? ns,
    required EarthquakeCatalogPeriodComponent? ew,
    required EarthquakeCatalogPeriodComponent? ud,
  }) = _EarthquakeCatalogPeriods;
}

@freezed
abstract class EarthquakeCatalogPeriodComponent
    with _$EarthquakeCatalogPeriodComponent {
  const factory EarthquakeCatalogPeriodComponent({
    required String? maxAccelPeriodText,
    required String? predominantPeriodText,
  }) = _EarthquakeCatalogPeriodComponent;
}

/// `CatalogPeriodValue` を表示文字列に変換する。
/// value が null の場合は '欠測'、FREQUENCY なら '${value}Hz'、PERIOD なら '${value}秒'。
String formatCatalogPeriodValue(api.CatalogPeriodValue value) {
  final rawValue = value.value;
  if (rawValue == null) {
    return '欠測';
  }
  return switch (value.kind) {
    api.CatalogPeriodKind.frequency => '${rawValue}Hz',
    api.CatalogPeriodKind.period => '${rawValue}秒',
  };
}

extension EarthquakeCatalogApiExtension on api.Catalog {
  EarthquakeCatalog get toEarthquakeCatalog => EarthquakeCatalog(
    hypocenters: hypocenters
        .map((e) => e._toEarthquakeCatalogHypocenter)
        .toList(),
    stationRecords: stationRecords
        .map((e) => e._toEarthquakeCatalogStationRecord)
        .toList(),
    damageScaleLabel: damageScale?._label,
    tsunamiScaleLabel: tsunamiScale?._label,
    linkMatchConfidence: link?.matchConfidence.toDouble(),
  );
}

extension on api.CatalogHypocenter {
  EarthquakeCatalogHypocenter get _toEarthquakeCatalogHypocenter =>
      EarthquakeCatalogHypocenter(
        seq: seq,
        epicenterName: epicenterName,
        stationCount: stationCount,
        recordTypeLabel: recordType._label,
        originTime: originTime,
        originTimeStderrSeconds: originTimeStderrSeconds?.toDouble(),
        latitude: coordinates?.latitude.toDouble(),
        longitude: coordinates?.longitude.toDouble(),
        depthKm: depth?.value.toDouble(),
        depthIsFree: depth?.isFree ?? false,
        depthStderrKm: depth?.stderr?.toDouble(),
        maxIntensity: maxIntensity?.toShindoDbIntensityClass,
        determinationFlagLabel: determinationFlag?._label,
        evaluationLabel: evaluation?._label,
        magnitudes: magnitudes
            .map(
              (m) => EarthquakeCatalogMagnitude(
                typeLabel: m.type._label,
                value: m.value.toDouble(),
              ),
            )
            .toList(),
      );
}

extension on api.CatalogStationRecord {
  EarthquakeCatalogStationRecord get _toEarthquakeCatalogStationRecord =>
      EarthquakeCatalogStationRecord(
        stationCode: stationCode,
        intensityClass: intensity.classValue.toShindoDbIntensityClass,
        instrumentalIntensity: intensity.instrumental?.toDouble(),
        observedAt: observedAt,
        maxAcceleration: maxAcceleration?._toDomain,
        maxAccelTime: maxAccelTime,
        periods: periods == null
            ? null
            : EarthquakeCatalogPeriods(
                ns: periods!.ns?._toDomain,
                ew: periods!.ew?._toDomain,
                ud: periods!.ud?._toDomain,
              ),
        observationCount: observationCount,
      );
}

extension on api.CatalogStationMaxAcceleration {
  EarthquakeCatalogMaxAcceleration get _toDomain =>
      EarthquakeCatalogMaxAcceleration(
        synthesizedGal: synthesizedGal?.toDouble(),
        nsGal: nsGal?.toDouble(),
        ewGal: ewGal?.toDouble(),
        udGal: udGal?.toDouble(),
      );
}

extension on api.CatalogStationPeriodComponent {
  EarthquakeCatalogPeriodComponent get _toDomain =>
      EarthquakeCatalogPeriodComponent(
        maxAccelPeriodText: maxAccelPeriod != null
            ? formatCatalogPeriodValue(maxAccelPeriod!)
            : null,
        predominantPeriodText: predominantPeriod != null
            ? formatCatalogPeriodValue(predominantPeriod!)
            : null,
      );
}

extension on api.CatalogHypocenterRecordType {
  String get _label => switch (this) {
    .a => '震源',
    .b => '群発地震の震源',
    .d => '震源が離れた地震の組の震源',
  };
}

extension on api.CatalogDeterminationFlag {
  String get _label => switch (this) {
    .upperK => '気象庁震源',
    .upperS => '気象庁参考震源',
    .lowerK => '簡易気象庁震源',
    .lowerS => '簡易参考震源',
    .upperA => '自動処理震源',
    .lowerA => '自動処理参考震源',
    .n => '震源固定・不定・未計算',
    .u => 'USGS震源',
    .i => 'ISC震源',
    .h => '観測時刻が時間単位',
    .d => '観測時刻が日単位',
    .m => '観測時刻が月単位',
  };
}

extension on api.CatalogHypocenterEvaluation {
  String get _label => switch (this) {
    .value1 => '深さフリー',
    .value2 => '深さ刻み',
    .value3 => '人の判断(深さ固定等)',
    .value4 => 'Depth phase使用',
    .value5 => 'S-P使用',
    .value7 => '参考',
    .value8 => '決定不能・不採用',
  };
}

extension on api.CatalogMagnitudeType {
  String get _label => switch (this) {
    .j => '坪井変位M(旧観測網)',
    .upperD => '変位M',
    .lowerD => '変位M(観測点少)',
    .upperV => '速度M',
    .lowerV => '速度M(観測点少)',
    .w => 'モーメントM',
    .b => '実体波M',
    .s => '表面波M',
  };
}

extension on api.CatalogDamageScale {
  String get _label => switch (this) {
    .value1 => '1: 壁や地面の亀裂程度の微小被害',
    .value2 => '2: 家屋・道路の破損など小被害',
    .value3 => '3: 複数の死者または複数の全壊家屋',
    .value4 => '4: 死者20人以上または全壊1千戸以上',
    .value5 => '5: 死者200人以上または全壊1万戸以上',
    .value6 => '6: 死者2千人以上または全壊10万戸以上',
    .value7 => '7: 死者2万人以上または全壊100万戸以上',
    .x => '被害あり(程度不明)',
    .y => '前後の地震の被害と区別不能',
  };
}

extension on api.CatalogTsunamiScale {
  String get _label => switch (this) {
    .value1 => '1: 波高50cm以下または被害なし',
    .value2 => '2: 波高1m前後',
    .value3 => '3: 波高2m前後',
    .value4 => '4: 波高4〜6m程度',
    .value5 => '5: 波高10〜20m程度',
    .value6 => '6: 波高30m以上',
    .t => '津波あり',
  };
}
