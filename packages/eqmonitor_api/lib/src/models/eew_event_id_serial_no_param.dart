// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_event_id_serial_no_param.freezed.dart';
part 'eew_event_id_serial_no_param.g.dart';

@Freezed()
abstract class EewEventIdSerialNoParam with _$EewEventIdSerialNoParam {
  const factory EewEventIdSerialNoParam({
    required String eventId,
    required num serialNo,
  }) = _EewEventIdSerialNoParam;
  
  factory EewEventIdSerialNoParam.fromJson(Map<String, Object?> json) => _$EewEventIdSerialNoParamFromJson(json);
}
