import 'package:eqapi_types/src/model/v2/eew/eew_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'responses.freezed.dart';
part 'responses.g.dart';

/// EEW一覧レスポンス
@freezed
abstract class EewListResponse with _$EewListResponse {
  const factory EewListResponse({
    required List<EewItemWithRelations> items,
    String? nextToken,
    String? nextPooling,
  }) = _EewListResponse;

  factory EewListResponse.fromJson(Map<String, dynamic> json) =>
      _$EewListResponseFromJson(json);
}

/// EEW配列レスポンス
@freezed
abstract class EewArrayResponse with _$EewArrayResponse {
  const factory EewArrayResponse({
    required List<EewItemWithRelations> items,
  }) = _EewArrayResponse;

  factory EewArrayResponse.fromJson(Map<String, dynamic> json) =>
      _$EewArrayResponseFromJson(json);
}

/// 最新EEWレスポンス
@freezed
abstract class EewLatestResponse with _$EewLatestResponse {
  const factory EewLatestResponse({
    required List<EewItemWithRelations> items,
  }) = _EewLatestResponse;

  factory EewLatestResponse.fromJson(Map<String, dynamic> json) =>
      _$EewLatestResponseFromJson(json);
}
