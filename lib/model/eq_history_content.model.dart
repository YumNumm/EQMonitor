import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'eq_history_content.model.freezed.dart';
part 'eq_history_content.model.g.dart';

@freezed

/// 過去の電文データを管理 (JSON Parse用)
class EQHistoryContent with _$EQHistoryContent {
  factory EQHistoryContent({
    required String hash,
    required String type,
    required DateTime time,
    required String url,
    @JsonKey(name: 'imageurl') String? imageUrl,
    required String headline,
    Map<String, dynamic>? data,
    String? maxint,
    double? magnitude,
    @JsonKey(name: 'magnitude_condition') String? magnitudeCondition,
    double? depth,
    double? lat,
    double? lon,
    @JsonKey(name: 'serialno') int? serialNo,
    @JsonKey(name: 'hyponame') String? hypoName,
  }) = _EQHistoryContent;

  factory EQHistoryContent.fromJson(Map<String, dynamic> json) =>
      _$EQHistoryContentFromJson(json);
}
