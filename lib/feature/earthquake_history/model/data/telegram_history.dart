import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_history.freezed.dart';
part 'telegram_history.g.dart';

@freezed
class TelegramHistoryV3 with _$TelegramHistoryV3 {
  const factory TelegramHistoryV3({
    @JsonKey(
      fromJson: _telegramHistoryV3DataFromJson,
      toJson: _telegramHistoryV3DataToJson,
    )
    required Map<String, List<TelegramV3>>? results,
    required bool success,
    required D1DbExecutionResult meta,
  }) = _TelegramHistoryV3;

  factory TelegramHistoryV3.fromJson(Map<String, dynamic> json) =>
      _$TelegramHistoryV3FromJson(json);
}

Map<String, List<TelegramV3>>? _telegramHistoryV3DataFromJson(
  Map<String, dynamic>? json,
) {
  if (json == null) {
    return null;
  }
  final result = <String, List<TelegramV3>>{};
  for (final key in json.keys) {
    final eventId = int.parse(key);
    final value = (json[key] as List<dynamic>)
        .map(
          (e) => TelegramV3.fromJson(
            {...e as Map<String, dynamic>, 'eventId': eventId},
          ),
        )
        .toList();
    result.addAll({
      key: value,
    });
  }
  return result;
}

Map<String, dynamic>? _telegramHistoryV3DataToJson(
  Map<String, List<TelegramV3>>? instance,
) =>
    (instance == null)
        ? null
        : instance.map(
            (key, value) => MapEntry(
              key,
              value.map((e) => e.toJson().remove('eventId')).toList(),
            ),
          );

@freezed
class D1DbExecutionResult with _$D1DbExecutionResult {
  const factory D1DbExecutionResult({
    required double duration,
  }) = _D1DbExecutionResult;

  factory D1DbExecutionResult.fromJson(Map<String, dynamic> json) =>
      _$D1DbExecutionResultFromJson(json);
}
