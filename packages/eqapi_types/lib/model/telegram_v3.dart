import 'package:eqapi_types/model/components/accuracy.dart';
import 'package:eqapi_types/model/components/comments.dart';
import 'package:eqapi_types/model/components/earthquake-explanation/naming.dart';
import 'package:eqapi_types/model/components/earthquake-nankai/earthquake_info.dart';
import 'package:eqapi_types/model/components/earthquake.dart';
import 'package:eqapi_types/model/components/eew_hypocenter.dart';
import 'package:eqapi_types/model/components/eew_intensity.dart';
import 'package:eqapi_types/model/components/eew_region.dart';
import 'package:eqapi_types/model/components/intensity.dart';
import 'package:eqapi_types/model/components/tsunami-information/comments.dart';
import 'package:eqapi_types/model/components/tsunami-information/vtse41.dart';
import 'package:eqapi_types/model/components/tsunami-information/vtse51.dart';
import 'package:eqapi_types/model/components/tsunami-information/vtse52.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_v3.freezed.dart';
part 'telegram_v3.g.dart';

class TelegramV3 {
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

  factory TelegramV3.fromJsonAndEventID(
    Map<String, dynamic> json,
    int eventId,
  ) =>
      TelegramV3.fromJson({
        ...json,
        'eventId': eventId,
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
      case TelegramType.vxse53distant:
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
        if (base.infoType == TelegramInfoType.cancel) {
          body = TelegramCancelBody.fromJson(base.body);
        } else {
          body = TelegramVtse41Body.fromJson(base.body);
        }
      case TelegramType.vtse51:
        if (base.infoType == TelegramInfoType.cancel) {
          body = TelegramCancelBody.fromJson(base.body);
        } else {
          body = TelegramVtse51Body.fromJson(base.body);
        }
      case TelegramType.vtse52:
        if (base.infoType == TelegramInfoType.cancel) {
          body = TelegramCancelBody.fromJson(base.body);
        } else {
          body = TelegramVtse52Body.fromJson(base.body);
        }
      case TelegramType.vtse52Cancel:
      case TelegramType.vtse52Cancel2:
        body = TelegramCancelBody.fromJson(base.body);
      // 顕著な地震の震源要素更新のお知らせ
      case TelegramType.vxse61:
        if (base.infoType == TelegramInfoType.cancel) {
          body = TelegramCancelBody.fromJson(base.body);
        } else {
          body = TelegramVxse61Body.fromJson(base.body);
        }

      /// 南海トラフ地震臨時情報
      case TelegramType.vyse50:
      case TelegramType.vyse51:
      case TelegramType.vyse52:
        if (base.infoType == TelegramInfoType.cancel) {
          body = TelegramCancelBody.fromJson(base.body);
        } else {
          body = EarthquakeNankaiBody.fromJson(base.body);
        }
      case TelegramType.vxse56:
        if (base.infoType == TelegramInfoType.cancel) {
          body = TelegramCancelBody.fromJson(base.body);
        } else {
          body = TelegramVxse56Body.fromJson(base.body);
        }
      case TelegramType.vxse60:
        throw UnimplementedError();
    }

    return TelegramV3._merge(base, body);
  }

  factory TelegramV3._merge(
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'hash': hash,
        'eventId': eventId,
        'type': type.type,
        'schemaType': schemaType.type,
        'status': status.type,
        'infoType': infoType.type,
        'pressTime': pressTime.toIso8601String(),
        'reportTime': reportTime?.toIso8601String(),
        'validTime': validTime?.toIso8601String(),
        'serialNo': serialNo,
        'headline': headline,
        'body': body.toJson(),
      };

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
    // ignore: invalid_annotation_target
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

sealed class TelegramV3Body {
  Map<String, dynamic> toJson();
}

@freezed
class TelegramVxse51Body with _$TelegramVxse51Body implements TelegramV3Body {
  const factory TelegramVxse51Body({
    required Intensity? intensity,
    required String? text,
    required CommentsOmitVar comment,
  }) = _TelegramVxse51Body;

  factory TelegramVxse51Body.fromJson(Map<String, dynamic> json) =>
      _$TelegramVxse51BodyFromJson(json);
}

@freezed
class TelegramVxse52Body with _$TelegramVxse52Body implements TelegramV3Body {
  const factory TelegramVxse52Body({
    required Earthquake earthquake,
    required String? text,
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
    required String? text,
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
    required String? text,
    required CommentsOmitVar comment,
  }) = _TelegramVxse62Body;

  factory TelegramVxse62Body.fromJson(Map<String, dynamic> json) =>
      _$TelegramVxse62BodyFromJson(json);
}

@freezed
class TelegramVtse41Body with _$TelegramVtse41Body implements TelegramV3Body {
  const factory TelegramVtse41Body({
    required PublicBodyVtse41Tsunami tsunami,
    required List<Earthquake> earthquakes,
    required String? text,
    required TsunamiComments? comments,
  }) = _TelegramVtse41Body;

  factory TelegramVtse41Body.fromJson(Map<String, dynamic> json) =>
      _$TelegramVtse41BodyFromJson(json);
}

@freezed
class TelegramVtse51Body with _$TelegramVtse51Body implements TelegramV3Body {
  const factory TelegramVtse51Body({
    required PublicBodyVtse51Tsunami tsunami,
    required List<Earthquake> earthquakes,
    required String? text,
    required TsunamiComments? comments,
  }) = _TelegramVtse51Body;

  factory TelegramVtse51Body.fromJson(Map<String, dynamic> json) =>
      _$TelegramVtse51BodyFromJson(json);
}

@freezed
class TelegramVtse52Body with _$TelegramVtse52Body implements TelegramV3Body {
  const factory TelegramVtse52Body({
    required PublicBodyVtse52Tsunami tsunami,
    required List<Earthquake> earthquakes,
    required String? text,
    required TsunamiComments? comments,
  }) = _TelegramVtse52Body;

  factory TelegramVtse52Body.fromJson(Map<String, dynamic> json) =>
      _$TelegramVtse52BodyFromJson(json);
}

@freezed
class TelegramVxse61Body with _$TelegramVxse61Body implements TelegramV3Body {
  const factory TelegramVxse61Body({
    required Earthquake earthquake,
    required String? text,
    required CommentsOnlyFree? comments,
  }) = _TelegramVxse61Body;

  factory TelegramVxse61Body.fromJson(Map<String, dynamic> json) =>
      _$TelegramVxse61BodyFromJson(json);
}

@freezed
class EarthquakeNankaiBody
    with _$EarthquakeNankaiBody
    implements TelegramV3Body {
  const factory EarthquakeNankaiBody({
    required EarthquakeNankaiInfo? earthquakeInfo,
    required String? nextAdvisory,
    required String? text,
  }) = _EarthquakeNankaiBody;

  factory EarthquakeNankaiBody.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeNankaiBodyFromJson(json);
}

@freezed
class TelegramVxse56Body with _$TelegramVxse56Body implements TelegramV3Body {
  const factory TelegramVxse56Body({
    required Naming? naming,
    required String text,
    required CommentsOnlyFree? comments,
  }) = _TelegramVxse56Body;

  factory TelegramVxse56Body.fromJson(Map<String, dynamic> json) =>
      _$TelegramVxse56BodyFromJson(json);
}

@freezed
class TelegramCancelBody with _$TelegramCancelBody implements TelegramV3Body {
  const factory TelegramCancelBody({
    required String text,
  }) = _TelegramCancelBody;

  factory TelegramCancelBody.fromJson(Map<String, dynamic> json) =>
      _$TelegramCancelBodyFromJson(json);
}

sealed class Vxse45 {
  factory Vxse45.fromJson(Map<String, dynamic> _) {
    throw UnimplementedError();
  }
  Map<String, dynamic> toJson();
}

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
  vxse45('緊急地震速報（地震動予報）'),
  vtse41('津波警報・注意報・予報a'),
  vtse51('津波情報a'),
  vtse52('沖合の津波観測に関する情報'),
  vtse52Cancel('各地の満潮時刻・津波到達予想時刻に関する情報'),
  vtse52Cancel2('津波観測に関する情報'),
  vxse51('震度速報'),
  vxse52('震源に関する情報'),
  vxse53('震源・震度に関する情報'),
  vxse53distant('遠地地震に関する情報'),
  vxse56('地震の活動状況等に関する情報'),
  vxse60('地震回数に関する情報'),
  vxse61('顕著な地震の震源要素更新のお知らせ'),
  vxse62('長周期地震動に関する観測情報'),
  vyse50('南海トラフ地震臨時情報'),
  vyse51('南海トラフ地震関連解説情報'),
  vyse52('南海トラフ地震関連解説情報');

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
  training('訓練'),
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

  @override
  String toString() => type.replaceAll('+', '強').replaceAll('-', '弱');

  bool operator >(JmaIntensity other) {
    return type.compareTo(other.type) > 0;
  }
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

  // compare to JmaIntensity
  bool operator >(JmaIntensity other) {
    return type.compareTo(other.type) > 0;
  }

  int compareTo(JmaForecastIntensity other) {
    return index.compareTo(other.index);
  }
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

  @override
  String toString() => type;
  bool operator <(JmaLgIntensity other) {
    return index < other.index;
  }

  bool operator <=(JmaLgIntensity other) {
    return index <= other.index;
  }

  bool operator >(JmaLgIntensity other) {
    return index > other.index;
  }

  bool operator >=(JmaLgIntensity other) {
    return index >= other.index;
  }
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

  bool operator >(JmaLgIntensity other) {
    return type.compareTo(other.type) > 0;
  }
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
