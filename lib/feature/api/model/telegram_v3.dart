import 'package:eqmonitor/feature/api/model/components/accuracy.dart';
import 'package:eqmonitor/feature/api/model/components/comments.dart';
import 'package:eqmonitor/feature/api/model/components/earthquake.dart';
import 'package:eqmonitor/feature/api/model/components/eew_hypocenter.dart';
import 'package:eqmonitor/feature/api/model/components/eew_intensity.dart';
import 'package:eqmonitor/feature/api/model/components/eew_region.dart';
import 'package:eqmonitor/feature/api/model/components/intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_v3.freezed.dart';
part 'telegram_v3.g.dart';

class TelegramV3 {
  /*     id?: number
    hash?: string
    eventId: number
    type:
      | '緊急地震速報（地震動予報）'
      | '津波警報・注意報・予報a'
      | '津波情報a'
      | '各地の満潮時刻・津波到達予想時刻に関する情報'
      | '津波観測に関する情報'
      | '沖合の津波観測に関する情報'
      | '震度速報' // VXSE51
      | '震源に関する情報' // VXSE52
      | '震源・震度に関する情報' // VXSE53
      | '遠地地震に関する情報' // VXSE53
      | '地震の活動状況等に関する情報'
      | '地震回数に関する情報'
      | '顕著な地震の震源要素更新のお知らせ'
      | '長周期地震動に関する観測情報'
      | '南海トラフ地震臨時情報'
    schemaType:
      | 'eew-information'
      | 'earthquake-information'
      | 'earthquake-explanation'
      | 'earthquake-counts'
      | 'earthquake-hypocenter-update'
      | 'earthquake-nankai'
      | 'tsunami-information'
    status: '通常' | '訓練' | '試験'
    infoType: '発表' | '訂正' | '遅延' | '取消'
    pressTime: string
    reportTime?: string
    validTime?: string
    serialNo?: number
    headline?: string
    body: Object*/

  const TelegramV3({
    this.id,
    this.hash,
    required this.eventId,
    required this.type,
    required this.schemaType,
    required this.status,
    required this.infoType,
    required this.pressTime,
    this.reportTime,
    this.validTime,
    this.serialNo,
    this.headline,
    required this.body,
  });

  factory TelegramV3.fromJson(Map<String, dynamic> json) {
    final base = TelegramV3Base.fromJson(json);
    late final TelegramV3Body body;
    switch (base.type) {
      //* earthquake-information
      case TelegramType.vxse51:
        body = TelegramVxse51Body.fromJson(base.body);
      case TelegramType.vxse52:
        body = TelegramVxse52Body.fromJson(base.body);
      case TelegramType.vxse53:
        body = TelegramVxse53Body.fromJson(base.body);
      case TelegramType.vxse62:
        body = TelegramVxse62Body.fromJson(base.body);
      //* eew-information
      case TelegramType.vxse45:
        // 取消報の場合
        if (base.infoType == TelegramInfoType.cancel) {
          body = TelegramVxse45Cancel.fromJson(base.body);
        } else {
          body = TelegramVxse45Body.fromJson(base.body);
        }
      case TelegramType.vtse41:
      case TelegramType.vtse51:
      case TelegramType.vtse52:
      case TelegramType.vxse56:
      case TelegramType.vxse60:
      case TelegramType.vxse61:
      case TelegramType.vyse50:
        throw UnimplementedError();
    }

    return TelegramV3.fromTelegramV3Base(base, body);
  }

  factory TelegramV3.fromTelegramV3Base(
    TelegramV3Base base,
    TelegramV3Body body,
  ) =>
      TelegramV3(
        eventId: base.eventId,
        type: base.type,
        infoType: base.infoType,
        pressTime: base.pressTime,
        schemaType: base.schemaType,
        status: base.status,
        hash: base.hash,
        headline: base.headline,
        id: base.id,
        reportTime: base.reportTime,
        serialNo: base.serialNo,
        validTime: base.validTime,
        body: body,
      );

  final int? id;
  final String? hash;
  final int eventId;
  final TelegramType type;
  final SchemaType schemaType;
  final TelegramStatus status;
  final TelegramInfoType infoType;
  final DateTime pressTime;
  final DateTime? reportTime;
  final DateTime? validTime;
  final int? serialNo;
  final String? headline;
  final TelegramV3Body body;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TelegramV3 &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hash == other.hash &&
          eventId == other.eventId &&
          type == other.type &&
          schemaType == other.schemaType &&
          status == other.status &&
          infoType == other.infoType &&
          pressTime == other.pressTime &&
          reportTime == other.reportTime &&
          validTime == other.validTime &&
          serialNo == other.serialNo &&
          headline == other.headline &&
          body == other.body;

  @override
  int get hashCode =>
      id.hashCode ^
      hash.hashCode ^
      eventId.hashCode ^
      type.hashCode ^
      schemaType.hashCode ^
      status.hashCode ^
      infoType.hashCode ^
      pressTime.hashCode ^
      reportTime.hashCode ^
      validTime.hashCode ^
      serialNo.hashCode ^
      headline.hashCode ^
      body.hashCode;
}

@freezed
class TelegramV3Base with _$TelegramV3Base {
  const factory TelegramV3Base({
    required int? id,
    required String? hash,
    required int eventId,
    required TelegramType type,
    required SchemaType schemaType,
    required TelegramStatus status,
    required TelegramInfoType infoType,
    required DateTime pressTime,
    required DateTime? reportTime,
    required DateTime? validTime,
    required int? serialNo,
    required String? headline,
    required Map<String, dynamic> body,
  }) = _TelegramV3Base;

  factory TelegramV3Base.fromJson(Map<String, dynamic> json) =>
      _$TelegramV3BaseFromJson(json);
}

sealed class TelegramV3Body {}

@freezed
class TelegramVxse51Body with _$TelegramVxse51Body implements TelegramV3Body {
  const factory TelegramVxse51Body({
    required Intensity? intensity,
    required String text,
    required CommentsOmitVar comment,
  }) = _TelegramVxse51Body;

  factory TelegramVxse51Body.fromJson(Map<String, dynamic> json) =>
      _$TelegramVxse51BodyFromJson(json);
}

@freezed
class TelegramVxse52Body with _$TelegramVxse52Body implements TelegramV3Body {
  const factory TelegramVxse52Body({
    required Earthquake earthquake,
    required String text,
    required CommentsOmitVar comment,
  }) = _TelegramVxse52Body;

  factory TelegramVxse52Body.fromJson(Map<String, dynamic> json) =>
      _$TelegramVxse52BodyFromJson(json);
}

@freezed
class TelegramVxse53Body with _$TelegramVxse53Body implements TelegramV3Body {
  const factory TelegramVxse53Body({
    required Earthquake earthquake,
    required Intensity? intensity,
    required String text,
    required CommentsOmitVar comment,
  }) = _TelegramVxse53Body;

  factory TelegramVxse53Body.fromJson(Map<String, dynamic> json) =>
      _$TelegramVxse53BodyFromJson(json);
}

@freezed
class TelegramVxse62Body with _$TelegramVxse62Body implements TelegramV3Body {
  const factory TelegramVxse62Body({
    required Earthquake earthquake,
    required Intensity? intensity,
    required String text,
    required CommentsOmitVar comment,
  }) = _TelegramVxse62Body;

  factory TelegramVxse62Body.fromJson(Map<String, dynamic> json) =>
      _$TelegramVxse62BodyFromJson(json);
}

sealed class Vxse45 {}

@freezed
class TelegramVxse45Body
    with _$TelegramVxse45Body
    implements TelegramV3Body, Vxse45 {
  const factory TelegramVxse45Body({
    required double? magnitude,
    required EewHypocenter? hypocenter,
    required int? depth,
    required ForecastMaxInt? forecastMaxInt,
    required ForecastMaxLgInt? forecastMaxLgInt,
    required List<EewRegion>? regions,
    required DateTime? originTime,
    required DateTime arrivalTime,
    required EewAccuracy accuracy,
    required bool isPlum,
    required bool isLastInfo,
  }) = _TelegramVxse45Body;

  factory TelegramVxse45Body.fromJson(Map<String, dynamic> json) =>
      _$TelegramVxse45BodyFromJson(json);
}

@freezed
class TelegramVxse45Cancel
    with _$TelegramVxse45Cancel
    implements TelegramV3Body, Vxse45 {
  const factory TelegramVxse45Cancel({
    required bool isLastInfo,
    required bool isCanceled,
    required String text,
  }) = _EarthquakeInformationBody;

  factory TelegramVxse45Cancel.fromJson(Map<String, dynamic> json) =>
      _$TelegramVxse45CancelFromJson(json);
}

@JsonEnum(valueField: 'type')
enum TelegramType {
  /*
      | '緊急地震速報（地震動予報）' // vxse45
      | '津波警報・注意報・予報a' // vtse41
      | '津波情報a' // vtse51
      | '沖合の津波観測に関する情報' // vtse52
      | '震度速報' // VXSE51
      | '震源に関する情報' // VXSE52
      | '震源・震度に関する情報' // VXSE53
      | '遠地地震に関する情報' // VXSE53
      | '地震の活動状況等に関する情報' // vxse56
      | '地震回数に関する情報' // vxse60
      | '顕著な地震の震源要素更新のお知らせ' // vxse61
      | '長周期地震動に関する観測情報' // vxse62
      | '南海トラフ地震臨時情報' // vyse50,51,52
   */
  vxse45('緊急地震速報（地震動予報）'),
  vtse41('津波警報・注意報・予報a'),
  vtse51('津波情報a'),
  vtse52('沖合の津波観測に関する情報'),
  vxse51('震度速報'),
  vxse52('震源に関する情報'),
  vxse53('震源・震度に関する情報'),
  vxse56('地震の活動状況等に関する情報'),
  vxse60('地震回数に関する情報'),
  vxse61('顕著な地震の震源要素更新のお知らせ'),
  vxse62('長周期地震動に関する観測情報'),
  vyse50('南海トラフ地震臨時情報');

  const TelegramType(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum SchemaType {
  eewInformation('eew-information'),
  earthquakeInformation('earthquake-information'),
  earthquakeExplanation('earthquake-explanation'),
  earthquakeCounts('earthquake-counts'),
  earthquakeHypocenterUpdate('earthquake-hypocenter-update'),
  earthquakeNankai('earthquake-nankai'),
  tsunamiInformation('tsunami-information');

  const SchemaType(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum TelegramStatus {
  normal('通常'),
  cancel('取消'),
  test('試験');

  const TelegramStatus(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum TelegramInfoType {
  issue('発表'),
  correction('訂正'),
  delay('遅延'),
  cancel('取消');

  const TelegramInfoType(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum JmaIntensity {
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  fiveLower('5-'),
  fiveUpper('5+'),
  sixLower('6-'),
  sixUpper('6+'),
  seven('7'),

  /// 震度5弱以上未入電
  fiveUpperNoInput('!5-');

  const JmaIntensity(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum JmaForecastIntensity {
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  fiveLower('5-'),
  fiveUpper('5+'),
  sixLower('6-'),
  sixUpper('6+'),
  seven('7'),
  unknown('不明');

  const JmaForecastIntensity(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum JmaForecastIntensityOver {
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  fiveLower('5-'),
  fiveUpper('5+'),
  sixLower('6-'),
  sixUpper('6+'),
  seven('7'),
  unknown('不明'),
  over('over');

  const JmaForecastIntensityOver(this.type);
  final String type;

  /// `over`の場合は`unknown`に変換されます
  JmaForecastIntensity get toJmaForecastIntensity => switch (this) {
        JmaForecastIntensityOver.zero => JmaForecastIntensity.zero,
        JmaForecastIntensityOver.one => JmaForecastIntensity.one,
        JmaForecastIntensityOver.two => JmaForecastIntensity.two,
        JmaForecastIntensityOver.three => JmaForecastIntensity.three,
        JmaForecastIntensityOver.four => JmaForecastIntensity.four,
        JmaForecastIntensityOver.fiveLower => JmaForecastIntensity.fiveLower,
        JmaForecastIntensityOver.fiveUpper => JmaForecastIntensity.fiveUpper,
        JmaForecastIntensityOver.sixLower => JmaForecastIntensity.sixLower,
        JmaForecastIntensityOver.sixUpper => JmaForecastIntensity.sixUpper,
        JmaForecastIntensityOver.seven => JmaForecastIntensity.seven,
        JmaForecastIntensityOver.unknown => JmaForecastIntensity.unknown,
        JmaForecastIntensityOver.over => JmaForecastIntensity.unknown,
      };
}

@JsonEnum(valueField: 'type')
enum JmaLgIntensity {
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4');

  const JmaLgIntensity(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum JmaForecastLgIntensity {
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  unknown('不明');

  const JmaForecastLgIntensity(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum JmaForecastLgIntensityOver {
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  unknown('不明'),
  over('over');

  const JmaForecastLgIntensityOver(this.type);
  final String type;

  /// `over`の場合は`unknown`に変換されます
  JmaForecastLgIntensity get toJmaForecastLgIntensity => switch (this) {
        JmaForecastLgIntensityOver.zero => JmaForecastLgIntensity.zero,
        JmaForecastLgIntensityOver.one => JmaForecastLgIntensity.one,
        JmaForecastLgIntensityOver.two => JmaForecastLgIntensity.two,
        JmaForecastLgIntensityOver.three => JmaForecastLgIntensity.three,
        JmaForecastLgIntensityOver.four => JmaForecastLgIntensity.four,
        JmaForecastLgIntensityOver.unknown => JmaForecastLgIntensity.unknown,
        JmaForecastLgIntensityOver.over => JmaForecastLgIntensity.unknown,
      };
}

@JsonEnum(valueField: 'type')
enum LgType {
  one('1'),
  two('2'),
  three('3'),
  four('4');

  const LgType(this.type);
  final String type;
}
