import 'package:json_annotation/json_annotation.dart';
import 'package:timezone/timezone.dart';

class TZDateTimeJsonConverter extends JsonConverter<TZDateTime, String> {
  const TZDateTimeJsonConverter();

  @override
  TZDateTime fromJson(String json) {
    final base = DateTime.parse(json);
    return TZDateTime.from(base, getLocation('UTC'));
  }

  @override
  String toJson(TZDateTime dateTime) => dateTime.toIso8601String();
}

class TZDateTimeJstJsonConverter extends JsonConverter<TZDateTime, String> {
  const TZDateTimeJstJsonConverter();

  @override
  TZDateTime fromJson(String json) {
    final base = DateTime.parse(json);
    return TZDateTime.from(base, getLocation('Asia/Tokyo'));
  }

  @override
  String toJson(TZDateTime dateTime) => dateTime.toIso8601String();
}
