import 'package:json_annotation/json_annotation.dart';
import 'package:timezone/timezone.dart';

class const TZDateTimeJsonConverter()
    extends JsonConverter<TZDateTime, String> {
  @override
  TZDateTime fromJson(String json) {
    final base = DateTime.parse(json);
    return TZDateTime.from(base, getLocation('UTC'));
  }

  @override
  String toJson(TZDateTime dateTime) => dateTime.toIso8601String();
}

class const TZDateTimeJstJsonConverter()
    extends JsonConverter<TZDateTime, String> {
  @override
  TZDateTime fromJson(String json) {
    final base = DateTime.parse(json);
    return TZDateTime.from(base, getLocation('Asia/Tokyo'));
  }

  @override
  String toJson(TZDateTime dateTime) => dateTime.toIso8601String();
}
