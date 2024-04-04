import 'package:eqapi_types/model/v1/v1_database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram.freezed.dart';
part 'telegram.g.dart';

@freezed
class TelegramV1 with _$TelegramV1  implements V1Database {
  const factory TelegramV1({
    required int id,
    required int eventId,
    required String type,
    required String schemaType,
    required String status,
    required String infoType,
    required DateTime pressTime,
    required DateTime reportTime,
    DateTime? validTime,
    int? serialNo,
    String? headline,
    required Map<String, dynamic> body,
  }) = _TelegramV1;

  factory TelegramV1.fromJson(Map<String, dynamic> json) =>
      _$TelegramV1FromJson(json);
}
