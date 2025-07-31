import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami.freezed.dart';
part 'tsunami.g.dart';

class TsunamiV1 implements V1Database {
  const TsunamiV1({
    required this.eventId,
    required this.headline,
    required this.id,
    required this.infoType,
    required this.pressAt,
    required this.reportAt,
    required this.serialNo,
    required this.status,
    required this.type,
    required this.validAt,
    required this.body,
  });

  factory TsunamiV1.fromJson(Map<String, dynamic> json) {
    final base = TsunamiV1Base.fromJson(json);
    final body = TsunamiBody.fromJson(json, base);
    return TsunamiV1(
      eventId: base.eventId,
      headline: base.headline,
      id: base.id,
      infoType: base.infoType,
      pressAt: base.pressAt,
      reportAt: base.reportAt,
      serialNo: base.serialNo,
      status: base.status,
      type: base.type,
      validAt: base.validAt,
      body: body,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'eventId': eventId,
    'headline': headline,
    'id': id,
    'infoType': infoType,
    'pressAt': pressAt.toIso8601String(),
    'reportAt': reportAt.toIso8601String(),
    'serialNo': serialNo,
    'status': status,
    'type': type,
    'validAt': validAt?.toIso8601String(),
    'body': body.toJson(),
  };

  final int eventId;
  final String? headline;
  final int id;
  final String infoType;
  final DateTime pressAt;
  final DateTime reportAt;
  final int? serialNo;
  final String status;
  final String type;
  final DateTime? validAt;
  final TsunamiBody body;
}

@freezed
abstract class TsunamiV1Base with _$TsunamiV1Base {
  const factory TsunamiV1Base({
    required int eventId,
    required String? headline,
    required int id,
    required String infoType,
    required DateTime pressAt,
    required DateTime reportAt,
    required int? serialNo,
    required String status,
    required String type,
    required DateTime? validAt,
  }) = _TsunamiV1Base;

  factory TsunamiV1Base.fromJson(Map<String, dynamic> json) =>
      _$TsunamiV1BaseFromJson(json);
}

sealed class TsunamiBody {
  factory TsunamiBody.fromJson(Map<String, dynamic> json, TsunamiV1Base base) {
    final infoTypeStr = base.infoType;
    final typeStr = base.type;
    final type = TsunamiBodyType.values.firstWhereOrNull(
      (e) => e.value == typeStr,
    );
    return switch (infoTypeStr) {
      '取消' => CancelBody.fromJson(json),
      '発表' || '訂正' => switch (type) {
        TsunamiBodyType.vtse41 => PublicBodyVTSE41.fromJson(json),
        TsunamiBodyType.vtse51 => PublicBodyVTSE51.fromJson(json),
        TsunamiBodyType.vtse52 => PublicBodyVTSE52.fromJson(json),
        null => throw ArgumentError('Unknown type: $typeStr'),
      },
      _ => throw ArgumentError('Unknown infoType: $infoTypeStr'),
    };
  }
  Map<String, dynamic> toJson();
}

enum TsunamiBodyType {
  vtse41('津波警報・注意報・予報a'),
  vtse51('津波情報a'),
  vtse52('沖合の津波観測に関する情報');

  const TsunamiBodyType(this.value);
  final String value;
}

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required String? free,
    required CommentWarning? warning,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

@freezed
abstract class CommentWarning with _$CommentWarning {
  const factory CommentWarning({
    required String text,
    required List<String> codes,
  }) = _CommentWarning;

  factory CommentWarning.fromJson(Map<String, dynamic> json) =>
      _$CommentWarningFromJson(json);
}

@freezed
abstract class CancelBody with _$CancelBody implements TsunamiBody {
  const factory CancelBody({required String text}) = _CancelBody;

  factory CancelBody.fromJson(Map<String, dynamic> json) =>
      _$CancelBodyFromJson(json);
}

@freezed
abstract class PublicBodyVTSE41Tsunami with _$PublicBodyVTSE41Tsunami {
  const factory PublicBodyVTSE41Tsunami({
    required List<TsunamiForecast> forecasts,
  }) = _PublicBodyVTSE41Tsunami;

  factory PublicBodyVTSE41Tsunami.fromJson(Map<String, dynamic> json) =>
      _$PublicBodyVTSE41TsunamiFromJson(json);
}

@freezed
abstract class PublicBodyVTSE51Tsunami with _$PublicBodyVTSE51Tsunami {
  const factory PublicBodyVTSE51Tsunami({
    required List<TsunamiForecast> forecasts,
    required List<TsunamiObservation>? observations,
  }) = _PublicBodyVTSE51Tsunami;

  factory PublicBodyVTSE51Tsunami.fromJson(Map<String, dynamic> json) =>
      _$PublicBodyVTSE51TsunamiFromJson(json);
}

@freezed
abstract class PublicBodyVTSE52Tsunami with _$PublicBodyVTSE52Tsunami {
  const factory PublicBodyVTSE52Tsunami({
    required List<TsunamiObservation>? observations,
    required List<TsunamiEstimation> estimations,
  }) = _PublicBodyVTSE52Tsunami;

  factory PublicBodyVTSE52Tsunami.fromJson(Map<String, dynamic> json) =>
      _$PublicBodyVTSE52TsunamiFromJson(json);
}

@freezed
abstract class TsunamiForecast with _$TsunamiForecast {
  const factory TsunamiForecast({
    required String code,
    required String name,
    required String kind,
    required String lastKind,
    required TsunamiForecastFirstHeight? firstHeight,
    required TsunamiForecastMaxHeight? maxHeight,
    required List<TsunamiForecastStation>? stations,
  }) = _TsunamiForecast;

  factory TsunamiForecast.fromJson(Map<String, dynamic> json) =>
      _$TsunamiForecastFromJson(json);
}

@JsonEnum(valueField: 'value')
enum TsunamiForecastFirstHeightCondition {
  /// "津波到達中と推測"
  arrival('津波到達中と推測'),

  /// "第１波の到達を確認"
  firstTideDetected('第１波の到達を確認'),

  /// "ただちに津波来襲と予測"
  immediately('ただちに津波来襲と予測');

  const TsunamiForecastFirstHeightCondition(this.value);
  final String value;
}

@freezed
abstract class TsunamiForecastFirstHeight with _$TsunamiForecastFirstHeight {
  const factory TsunamiForecastFirstHeight({
    required DateTime? arrivalTime,
    required TsunamiForecastFirstHeightCondition? condition,
  }) = _TsunamiForecastFirstHeight;

  factory TsunamiForecastFirstHeight.fromJson(Map<String, dynamic> json) =>
      _$TsunamiForecastFirstHeightFromJson(json);
}

@JsonEnum(valueField: 'value')
enum TsunamiMaxHeightCondition {
  /// 高い
  high('高い'),

  /// 巨大
  huge('巨大');

  const TsunamiMaxHeightCondition(this.value);
  final String value;
}

@freezed
abstract class TsunamiForecastMaxHeight with _$TsunamiForecastMaxHeight {
  const factory TsunamiForecastMaxHeight({
    /// 定量表現
    required double? value,
    required bool? isOver,

    /// 定性表現
    required TsunamiMaxHeightCondition? condition,
  }) = _TsunamiForecastMaxHeight;

  factory TsunamiForecastMaxHeight.fromJson(Map<String, dynamic> json) =>
      _$TsunamiForecastMaxHeightFromJson(json);
}

@freezed
abstract class TsunamiForecastStation with _$TsunamiForecastStation {
  const factory TsunamiForecastStation({
    required String code,
    required String name,
    required DateTime highTideTime,
    required DateTime? firstHeightTime,
    required TsunamiForecastFirstHeightCondition? condition,
  }) = _TsunamiForecastStation;

  factory TsunamiForecastStation.fromJson(Map<String, dynamic> json) =>
      _$TsunamiForecastStationFromJson(json);
}

@freezed
abstract class TsunamiObservation with _$TsunamiObservation {
  const factory TsunamiObservation({
    required String? code,
    required String? name,
    required List<TsunamiObservationStation> stations,
  }) = _TsunamiObservation;

  factory TsunamiObservation.fromJson(Map<String, dynamic> json) =>
      _$TsunamiObservationFromJson(json);
}

@freezed
abstract class TsunamiObservationStation with _$TsunamiObservationStation {
  const factory TsunamiObservationStation({
    required String code,
    required String name,

    /// null: `識別不能`
    required DateTime? firstHeightArrivalTime,
    required TsunamiObservationStationFirstHeightIntial? firstHeightInitial,
    required DateTime? maxHeightTime,
    required double? maxHeightValue,
    required bool? maxHeightIsOver,

    /// 上昇中かどうか
    required bool? maxHeightIsRising,
    required TsunamiObservationStationCondition? condition,
  }) = _TsunamiObservationStation;

  factory TsunamiObservationStation.fromJson(Map<String, dynamic> json) =>
      _$TsunamiObservationStationFromJson(json);
}

@JsonEnum(valueField: 'value')
enum TsunamiObservationStationFirstHeightIntial {
  push('押し'),
  pull('引き');

  const TsunamiObservationStationFirstHeightIntial(this.value);
  final String value;
}

@JsonEnum(valueField: 'value')
enum TsunamiObservationStationCondition {
  /// 微弱
  weak('微弱'),

  /// 観測中
  observing('観測中'),

  /// 重要
  important('重要');

  const TsunamiObservationStationCondition(this.value);
  final String value;
}

@freezed
abstract class TsunamiEstimation with _$TsunamiEstimation {
  const factory TsunamiEstimation({
    required String code,
    required String name,
    required DateTime? firstHeightTime,
    required TsunamiEstimationFirstHeightCondition? firstHeightCondition,
    required DateTime? maxHeightTime,
    required double? maxHeightValue,
    required bool? maxHeightIsOver,
    required TsunamiMaxHeightCondition? maxHeightCondition,

    // 津波警報以上でまだ津波の観測値が小さい場合に出現する
    // *津波観測中*
    required bool? isObserving,
  }) = _TsunamiEstimation;

  factory TsunamiEstimation.fromJson(Map<String, dynamic> json) =>
      _$TsunamiEstimationFromJson(json);
}

@JsonEnum(valueField: 'value')
enum TsunamiEstimationFirstHeightCondition {
  /// 早いところでは既に津波到達と推定
  alreadyArrived('早いところでは既に津波到達と推定');

  const TsunamiEstimationFirstHeightCondition(this.value);
  final String value;
}

@freezed
abstract class PublicBodyVTSE41 with _$PublicBodyVTSE41 implements TsunamiBody {
  const factory PublicBodyVTSE41({
    required PublicBodyVTSE41Tsunami tsunami,
    required List<Earthquake> earthquakes,
    required String? text,
    required Comment? comment,
  }) = _PublicBodyVTSE41;

  factory PublicBodyVTSE41.fromJson(Map<String, dynamic> json) =>
      _$PublicBodyVTSE41FromJson(json);
}

@freezed
abstract class PublicBodyVTSE51 with _$PublicBodyVTSE51 implements TsunamiBody {
  const factory PublicBodyVTSE51({
    required PublicBodyVTSE51Tsunami tsunami,
    required List<Earthquake> earthquakes,
    required String? text,
    required Comment? comment,
  }) = _PublicBodyVTSE51;

  factory PublicBodyVTSE51.fromJson(Map<String, dynamic> json) =>
      _$PublicBodyVTSE51FromJson(json);
}

@freezed
abstract class PublicBodyVTSE52 with _$PublicBodyVTSE52 implements TsunamiBody {
  const factory PublicBodyVTSE52({
    required PublicBodyVTSE52Tsunami tsunami,
    required List<Earthquake> earthquakes,
    required String? text,
    required Comment? comment,
  }) = _PublicBodyVTSE52;

  factory PublicBodyVTSE52.fromJson(Map<String, dynamic> json) =>
      _$PublicBodyVTSE52FromJson(json);
}

// ------------------ Earthquake ------------------ //
@freezed
abstract class Earthquake with _$Earthquake {
  const factory Earthquake({
    required DateTime originTime,
    required DateTime arrivalTime,
    required EarthquakeHypocenter hypocenter,
    required EarthquakeMagnitude magnitude,
  }) = _Earthquake;

  factory Earthquake.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeFromJson(json);
}

@freezed
abstract class EarthquakeHypocenter with _$EarthquakeHypocenter {
  const factory EarthquakeHypocenter({
    required String name,
    required String code,
    required int? depth,
    required EarthquakeHypocenterDetailed? detailed,
    required EarthquakeHypocenterCoordinate? coordinate,
  }) = _EarthquakeHypocenter;

  factory EarthquakeHypocenter.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHypocenterFromJson(json);
}

@freezed
abstract class EarthquakeHypocenterDetailed
    with _$EarthquakeHypocenterDetailed {
  const factory EarthquakeHypocenterDetailed({
    required String code,
    required String name,
  }) = _EarthquakeHypocenterDetailed;

  factory EarthquakeHypocenterDetailed.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHypocenterDetailedFromJson(json);
}

@freezed
abstract class EarthquakeHypocenterCoordinate
    with _$EarthquakeHypocenterCoordinate {
  const factory EarthquakeHypocenterCoordinate({
    required double lat,
    required double lon,
  }) = _EarthquakeHypocenterCoordinate;

  factory EarthquakeHypocenterCoordinate.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHypocenterCoordinateFromJson(json);
}

@freezed
abstract class EarthquakeMagnitude with _$EarthquakeMagnitude {
  const factory EarthquakeMagnitude({
    required double? value,
    required EarthquakeMagnitudeCondition? condition,
  }) = _EarthquakeMagnitude;

  factory EarthquakeMagnitude.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeMagnitudeFromJson(json);
}

@JsonEnum(valueField: 'value')
enum EarthquakeMagnitudeCondition {
  /// Ｍ不明
  unknown('Ｍ不明'),

  /// Ｍ８を超える巨大地震
  huge('Ｍ８を超える巨大地震');

  const EarthquakeMagnitudeCondition(this.value);
  final String value;
}

// ------------------ New Tsunami API Response Types ------------------ //

/// 津波データ（全タイプのUnion）
@Freezed(unionKey: 'type')
sealed class TsunamiData with _$TsunamiData {
  @FreezedUnionValue('津波警報・注意報・予報a')
  const factory TsunamiData.vtse41({
    required int id,
    required int eventId,
    required int? serialNo,
    @JsonKey(name: 'body') required PublicBodyVTSE41 bodyVtse41,
    required String status,
    required String? headline,
    required String infoType,
    required DateTime pressAt,
    required DateTime reportAt,
    required DateTime? validAt,
  }) = TsunamiDataVTSE41;

  @FreezedUnionValue('津波情報a')
  const factory TsunamiData.vtse51({
    required int id,
    required int eventId,
    required int? serialNo,
    @JsonKey(name: 'body') required PublicBodyVTSE51 bodyVtse51,
    required String status,
    required String? headline,
    required String infoType,
    required DateTime pressAt,
    required DateTime reportAt,
    required DateTime? validAt,
  }) = TsunamiDataVTSE51;

  @FreezedUnionValue('沖合の津波観測に関する情報')
  const factory TsunamiData.vtse52({
    required int id,
    required int eventId,
    required int? serialNo,
    @JsonKey(name: 'body') required PublicBodyVTSE52 bodyVtse52,
    required String status,
    required String? headline,
  }) = TsunamiDataVTSE52;

  factory TsunamiData.fromJson(Map<String, dynamic> json) =>
      _$TsunamiDataFromJson(json);
}

/// eventIdごとにグループ化された津波情報
@freezed
abstract class TsunamiGroupedByEvent with _$TsunamiGroupedByEvent {
  const factory TsunamiGroupedByEvent({
    @JsonKey(name: 'event_id') required String eventId,
    required TsunamiDataVTSE41? vtse41,
    required TsunamiDataVTSE51? vtse51,
    required TsunamiDataVTSE52? vtse52,
  }) = _TsunamiGroupedByEvent;

  factory TsunamiGroupedByEvent.fromJson(Map<String, dynamic> json) =>
      _$TsunamiGroupedByEventFromJson(json);
}

/// 津波情報一覧レスポンス（eventIdでグループ化）
@freezed
abstract class TsunamiSummaryResponse with _$TsunamiSummaryResponse {
  const factory TsunamiSummaryResponse({
    required List<TsunamiGroupedByEvent> data,
  }) = _TsunamiSummaryResponse;

  factory TsunamiSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$TsunamiSummaryResponseFromJson(json);
}

/// 特定eventIdの津波情報詳細レスポンス
@freezed
abstract class TsunamiDetailResponse with _$TsunamiDetailResponse {
  const factory TsunamiDetailResponse({
    @JsonKey(name: 'event_id') required int eventId,
    required List<TsunamiData> data,
    required int count,
  }) = _TsunamiDetailResponse;

  factory TsunamiDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TsunamiDetailResponseFromJson(json);
}
