// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_incident_data.freezed.dart';
part 'feed_incident_data.g.dart';

@Freezed()
abstract class FeedIncidentData with _$FeedIncidentData {
  const factory FeedIncidentData({
    /// const: "INCIDENT"
    required String type,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = _FeedIncidentData;
  
  factory FeedIncidentData.fromJson(Map<String, Object?> json) => _$FeedIncidentDataFromJson(json);
}
