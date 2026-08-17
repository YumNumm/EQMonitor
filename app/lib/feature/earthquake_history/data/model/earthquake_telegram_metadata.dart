import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_telegram_metadata.freezed.dart';
part 'earthquake_telegram_metadata.g.dart';

@freezed
abstract class EarthquakeTelegramMetadata with _$EarthquakeTelegramMetadata {
  const factory({
    required EarthquakeTelegramType type,
    required DateTime reportedAt,
  }) = _EarthquakeTelegramMetadata;

  factory fromJson(Map<String, dynamic> json) =>
      _$EarthquakeTelegramMetadataFromJson(json);
}
