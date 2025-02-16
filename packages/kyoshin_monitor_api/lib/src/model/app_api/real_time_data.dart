import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_monitor_api/src/model/result.dart';
import 'package:kyoshin_monitor_api/src/model/security.dart';

part 'real_time_data.freezed.dart';
part 'real_time_data.g.dart';

@freezed
class RealTimeData with _$RealTimeData {
  const factory RealTimeData({
    required DateTime? dateTime,
    required String? packetType,
    required String? kyoshinType,
    required String? baseData,
    required String? baseSerialNo,
    required List<double?>? items,
    required Result? result,
    required Security? security,
  }) = _RealTimeData;

  factory RealTimeData.fromJson(
    Map<String, dynamic> json,
  ) => _$RealTimeDataFromJson(json);
}
