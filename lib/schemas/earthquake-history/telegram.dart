import 'dart:convert';

import 'package:eqmonitor/utils/KyoshinMonitorlib/JmaIntensity.dart';

import '../dmdata/alphabet_extension.dart';
import '../dmdata/commonHeader.dart';
import '../dmdata/eq-information/earthquake-information.dart';
import '../dmdata/websocketv2/websocketv2.dart';

//                                   Table "public.telegrams"
//        Column        |           Type           | Collation | Nullable |      Default
// ---------------------+--------------------------+-----------+----------+--------------------
//  hash                | text                     |           | not null |
//  uuid                | uuid                     |           | not null | uuid_generate_v4()
//  type                | text                     |           | not null |
//  time                | timestamp with time zone |           | not null |
//  url                 | text                     |           | not null |
//  imageurl            | text                     |           |          |
//  headline            | text                     |           | not null |
//  data                | jsonb                    |           |          |
//  maxint              | text                     |           |          |
//  magnitude           | real                     |           |          |
//  magnitude_condition | text                     |           |          |
//  depth               | smallint                 |           |          |
//  lat                 | real                     |           |          |
//  lon                 | real                     |           |          |
//  serialno            | smallint                 |           |          |

/// 過去の電文データを管理
class Schema {
  Schema({
    required this.hash,
    required this.type,
    required this.time,
    required this.url,
    required this.imageUrl,
    required this.headline,
    required this.data,
    required this.uuid,
    required this.maxint,
    required this.magnitude,
    required this.magnitudeCondition,
    required this.depth,
    required this.lat,
    required this.lon,
    required this.serialNo,
    required this.hypoName,
  });

  /// VXSE53電文からTelegram型へ変換
  factory Schema.fromVXSE53({
    required String imageUrl,
    required EarthquakeInformation eqInfo,
    required CommonHead commonHead,
    required String url,
    required Map<String, dynamic> j,
    required WebSocketv2Data wsdata,
  }) =>
      Schema(
        hash: commonHead.originalId,
        type: wsdata.head.type.name,
        time: (eqInfo.earthquake != null)
            ? eqInfo.earthquake!.originTime
            : commonHead.reportDateTime,
        url: url,
        imageUrl: imageUrl,
        headline: commonHead.headline
            .toString()
            .replaceAll('　', '')
            .alphanumericToHalfLength(),
        data: j,
        uuid: '',
        maxint: eqInfo.intensity?.maxInt,
        depth: eqInfo.earthquake?.hypoCenter.depth.value?.toDouble(),
        lat: eqInfo.earthquake?.hypoCenter.coordinateComponent.latitude?.value,
        lon: eqInfo.earthquake?.hypoCenter.coordinateComponent.longitude?.value,
        magnitude: eqInfo.earthquake?.magnitude.value,
        magnitudeCondition: eqInfo.earthquake?.magnitude.condition?.description,
        serialNo: int.tryParse(commonHead.serialNo.toString()),
        hypoName: eqInfo.earthquake?.hypoCenter.name,
      );

  factory Schema.fromJson(Map<String, dynamic> j) => Schema(
        hash: ['hash'].toString(),
        type: j['type'].toString(),
        time: DateTime.parse(j['time'].toString()),
        url: j['url'].toString(),
        imageUrl: j['imageurl'] as String?,
        headline: j['headline'].toString(),
        data: j['data'] as Map<String, dynamic>?,
        uuid: j['uuid'].toString(),
        maxint: j['maxint'] as String?,
        magnitude: double.tryParse(j['magnitude'].toString()),
        magnitudeCondition: j['magnitude_condition']?.toString(),
        depth: double.tryParse(j['depth'].toString()),
        lat: double.tryParse(j['lat'].toString()),
        lon: double.tryParse(j['lon'].toString()),
        serialNo: int.tryParse(j['serialno'].toString()),
        hypoName: j['hyponame']?.toString(),
      );

  Map<String, dynamic> toSqlBody() => <String, dynamic>{
        'hash': hash,
        'type': type,
        'time': time.toIso8601String(),
        'url': url,
        'imageUrl': imageUrl,
        'headline': headline,
        'data': jsonEncode(data),
        'maxint': maxint,
        'magnitude': magnitude,
        'magnitude_condition': magnitudeCondition,
        'depth': depth,
        'lat': lat,
        'lon': lon,
        'serialno': serialNo,
        'hyponame': hypoName
      };

  final String hash;
  final String type;
  final DateTime time;
  final String url;
  final String? imageUrl;
  final String headline;
  final Map<String, dynamic>? data;
  final String uuid;
  final String? maxint;
  final double? magnitude;
  final String? magnitudeCondition;
  final double? depth;
  final double? lat;
  final double? lon;
  final int? serialNo;
  final String? hypoName;

  JmaIntensity get toMaxIntensity => JmaIntensity.values
      .firstWhere((e) => e.name == maxint, orElse: () => JmaIntensity.Unknown);
}
