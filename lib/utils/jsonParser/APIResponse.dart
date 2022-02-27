import 'package:intl/intl.dart';

class NormalApiResponse {
  final APIResult result;
  final DateTime requestTime;
  final String requestHypoType;
  NormalApiResponse({
    required this.result,
    required this.requestTime,
    required this.requestHypoType,
  });
  NormalApiResponse.fromJson(Map<String, dynamic> json)
      : result = APIResult.fromJson(json['result'] as Map<String, dynamic>),
        requestTime = yyyyMMddHHmmss(json['request_time'].toString()),
        requestHypoType = json['request_hypo_type'].toString();
}

class EEWApiResponse {
  final APIResult result;
  final DateTime reportTime;
  final String regionCode;
  final DateTime requestTime;
  final String regionName;
  final double longitude;
  final bool isCancel;
  final String depth;
  final int calcintensity;
  final bool isFinal;
  final bool isTraining;
  final double latitude;
  final DateTime originTime;
  final double magunitude;
  final int reportNum;
  final String requestHypoType;
  final int reportId;
  final String alertFlg;
  EEWApiResponse({
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
    required this.magunitude,
    required this.reportNum,
    required this.requestHypoType,
    required this.reportId,
    required this.alertFlg,
  });
  EEWApiResponse.fromJson(Map<String, dynamic> json)
      : result = APIResult.fromJson(json['result'] as Map<String, dynamic>),
        reportTime = DateFormat('yyyy/MM/dd HH:mm:ss')
            .parseStrict(json['report_time'].toString()),
        regionCode = json['region_code'].toString(),
        requestTime = yyyyMMddHHmmss(json['request_time'].toString()),
        regionName = json['region_name'].toString(),
        longitude = double.parse(json['longitude'].toString()),
        latitude = double.parse(json['latitude'].toString()),
        isCancel = bool.fromEnvironment(json['is_cancel'].toString()),
        depth = json['depth'].toString(),
        calcintensity = int.parse(json['calcintensity'].toString()),
        isFinal = bool.fromEnvironment(json['is_final'].toString()),
        isTraining = bool.fromEnvironment(json['is_training'].toString()),
        originTime = yyyyMMddHHmmss(json['origin_time'].toString()),
        magunitude = double.parse(json['magunitude'].toString()),
        reportNum = int.parse(json['report_num'].toString()),
        requestHypoType = json['request_hypo_type'].toString(),
        reportId = int.parse(json['report_id'].toString()),
        alertFlg = json['alertflg'].toString();
}

class APIResult {
  final String status;
  final String message;
  final bool is_auth;
  APIResult({
    required this.status,
    required this.message,
    required this.is_auth,
  });
  APIResult.fromJson(Map<String, dynamic> json)
      : status = json['status'].toString(),
        message = json['message'].toString(),
        is_auth = bool.fromEnvironment(json['is_auth'].toString(),
            defaultValue: true);
}

DateTime yyyyMMddHHmmss(String s) {
  final l = s.split('').map(int.parse).toList();
  final toParse =
      '${l[0]}${l[1]}${l[2]}${l[3]}/${l[4]}${l[5]}/${l[6]}${l[7]} ${l[8]}${l[9]}:${l[10]}${l[11]}:${l[12]}${l[13]}';
  return DateFormat('yyyy/MM/dd HH:mm:ss').parseStrict(toParse);
}
