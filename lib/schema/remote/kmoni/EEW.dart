import 'package:eqmonitor/ui/theme/jma_intensity.dart';
import 'package:intl/intl.dart';

import '../dmdata/commonHeader.dart';
import '../dmdata/eew-information/earthquake.dart';
import '../dmdata/eew-information/earthquake/accuracy.dart';
import '../dmdata/eew-information/earthquake/accuracy/depth_calculation.dart';
import '../dmdata/eew-information/earthquake/accuracy/epicCenterAccuracy.dart';
import '../dmdata/eew-information/earthquake/accuracy/magnitude_calculation.dart';
import '../dmdata/eew-information/earthquake/accuracy/number_of_magnitude_calculation.dart';
import '../dmdata/eew-information/earthquake/depth.dart';
import '../dmdata/eew-information/earthquake/hypocenter.dart';
import '../dmdata/eew-information/earthquake/reduce.dart';
import '../dmdata/eew-information/eew-infomation.dart';
import '../dmdata/eew-information/intensity/forecast_max_int.dart';
import '../dmdata/eew-information/intensity/intensity.dart';
import '../dmdata/eq-information/earthquake-information/hypocenter/coordinate_component.dart';
import '../dmdata/eq-information/earthquake-information/hypocenter/coordinate_component/latitude.dart';
import '../dmdata/eq-information/earthquake-information/hypocenter/coordinate_component/longitude.dart';
import '../dmdata/eq-information/earthquake-information/magnitude.dart';
import 'EEWResult.dart';

// GET http://www.kmoni.bosai.go.jp/webservice/hypo/eew/${timestamp}.json
// {timestamp} = YYYYMMDDhhmmss
// https://qiita.com/smmy/items/78c77e5fa24245f202af
class KyoshinEEW {
  KyoshinEEW({
    required this.result,
    required this.reportTime,
    required this.regionCode,
    required this.requestTime,
    required this.regionName,
    required this.longitude,
    required this.isCancel,
    required this.depth,
    required this.calcintensity,
    required this.isFinal,
    required this.isTraining,
    required this.latitude,
    required this.originTime,
    required this.magnitude,
    required this.reportNum,
    required this.requestHypoType,
    required this.reportId,
  });
  KyoshinEEW.fromJson(Map<String, dynamic> json)
      : result = EEWResult.fromJson(json['result'] as Map<String, dynamic>),
        reportTime = (json['report_time'].toString() == '')
            ? null
            : DateFormat('yyyy/MM/dd HH:mm:ss')
                .parseStrict(json['report_time'].toString()),
        regionCode = (json['region_code'].toString() == '')
            ? null
            : json['region_code'].toString(),
        requestTime = yyyyMMddHHmmss(json['request_time'].toString()),
        regionName = (json['region_name'].toString() == '')
            ? null
            : json['region_name'].toString(),
        longitude = (json['longitude'].toString() == '')
            ? null
            : double.parse(json['longitude'].toString()),
        latitude = (json['latitude'].toString() == '')
            ? null
            : double.parse(json['latitude'].toString()),
        isCancel = (json['is_cancel'].toString() == '')
            ? null
            : bool.fromEnvironment(json['is_cancel'].toString()),
        depth =
            (json['depth'].toString() == '') ? null : json['depth'].toString(),
        calcintensity = (json['calcintensity'].toString() == '')
            ? null
            : json['calcintensity'].toString(),
        isFinal = (json['is_final'].toString() == '')
            ? null
            : bool.fromEnvironment(json['is_final'].toString()),
        isTraining = (json['is_training'].toString() == '')
            ? null
            : bool.fromEnvironment(json['is_training'].toString()),
        originTime = (json['origin_time'].toString() == '')
            ? null
            : yyyyMMddHHmmss(json['origin_time'].toString()),
        magnitude = (json['magunitude'].toString() == '')
            ? null
            : double.parse(json['magunitude'].toString()),
        reportNum = (json['report_num'].toString() == '')
            ? null
            : int.parse(json['report_num'].toString()),
        requestHypoType = json['request_hypo_type'].toString(),
        reportId = (json['report_id'].toString() == '')
            ? null
            : int.parse(json['report_id'].toString());
  final EEWResult result;

  /// ## 情報更新時刻
  final DateTime? reportTime;
  final String? regionCode;

  final DateTime requestTime;

  /// ## 震源地
  final String? regionName;
  final bool? isCancel;

  /// ##  震源の深さ
  final String? depth;

  /// ## 予想最大震度
  final String? calcintensity;

  /// ## 最終報かどうか
  final bool? isFinal;

  /// ## 訓練報かどうか
  final bool? isTraining;

  /// ## 緯度(北緯)
  final double? latitude;

  /// ## 経度(東経)
  final double? longitude;

  /// ## 地震発生時刻
  final DateTime? originTime;

  /// ## マグニチュード
  final double? magnitude;

  /// ## 第n報
  final int? reportNum;
  final String requestHypoType;

  /// 地震ID
  final int? reportId;

  CommonHead? toDmdataEew({
    bool isTesting = false,
  }) {
    if (!result.hasData) {
      return null;
    }

    // 処理していく
    return CommonHead(
      eventId: reportId.toString(),
      headline: result.message,
      editoralOffice: '強震モニタ',
      infoKind: '強震モニタ',
      infoType: CommonHeadInfoType.announcement,
      infoKindVersion: '0',
      originalId: 'TELEGRAM_ID',
      pressDateTime: reportTime!,
      publishingOffice: [],
      reportDateTime: reportTime!,
      schema: CommonHeadSchema(type: 'VXSE4x', version: '0'),
      serialNo: reportNum?.toString(),
      status: isTesting ? CommonHeadStatus.test : CommonHeadStatus.normal,
      targetDateTime: reportTime!,
      targetDateTimeDubious: '強震モニタ - リプレイ',
      targetDuration: null,
      title: result.message.toString(),
      type: '強震モニタ',
      validDateTime: null,
      body: EEWInformation(
        isLastInfo: isFinal!,
        isCanceled: isTraining ?? false,
        isWarning: true,
        zones: [],
        prefectures: [],
        regions: [],
        earthQuake: EarthQuake(
          originTime: originTime,
          arrivalTime: originTime!,
          isAssuming: false,
          hypoCenter: HypoCenter(
            name: regionName.toString(),
            code: int.tryParse(regionCode.toString()) ?? 0,
            coordinateComponent: CoordinateComponent(
              latitude: Latitude(text: '', value: latitude!),
              longitude: Longitude(text: '', value: longitude!),
              height: null,
              geodeticSystem: null,
              condition: null,
            ),
            depth: Depth(
              unit: 'km',
              value: int.parse(depth!.replaceAll('km', '')),
              condition: null,
              type: '深さ',
            ),
            reduce: Reduce(
              code: 0,
              name: '',
            ),
            landOrSea: null,
            accuracy: Accuracy(
              depthCalculation: DepthCalculation.f2,
              epicCenterAccuracy: EpicCenters(
                epicCenterAccuracy: EpicCenterAccuracy.f2,
                hypoCenterAccuracy: HypoCenterAccuracy.f2,
              ),
              magnitudeCalculation: MagnitudeCalculation.f2,
              numberOfMagnitudeCalculation: NumberOfMagnitudeCalculation.f2,
            ),
          ),
          magnitude: Magnitude(
            condition: null,
            type: '',
            unit: 'M',
            value: magnitude,
          ),
        ),
        intensity: Intensity(
          maxint: ForecastMaxInt(
            from: JmaIntensity.values.firstWhere(
              (e) =>
                  e.name ==
                  calcintensity
                      .toString()
                      .replaceAll('強', '+')
                      .replaceAll('弱', '-'),
              orElse: () => JmaIntensity.Error,
            ),
            to: JmaIntensity.values.firstWhere(
              (e) =>
                  e.name ==
                  calcintensity
                      .toString()
                      .replaceAll('強', '+')
                      .replaceAll('弱', '-'),
              orElse: () => JmaIntensity.Error,
            ),
          ),
          appendix: null,
          forecastMaxLpgmInt: null,
          region: [],
        ),
        text: result.message,
        comments: null,
      ).toJson(),
    );
  }
}

DateTime yyyyMMddHHmmss(String s) {
  final l = s.split('').map(int.parse).toList();
  final toParse =
      '${l[0]}${l[1]}${l[2]}${l[3]}/${l[4]}${l[5]}/${l[6]}${l[7]} ${l[8]}${l[9]}:${l[10]}${l[11]}:${l[12]}${l[13]}';
  return DateFormat('yyyy/MM/dd HH:mm:ss').parseStrict(toParse);
}
