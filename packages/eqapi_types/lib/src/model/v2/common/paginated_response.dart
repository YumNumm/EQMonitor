import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_response.freezed.dart';
part 'paginated_response.g.dart';

/// ページネーション用のレスポンス共通フィールド
@freezed
abstract class PaginatedResponseMeta with _$PaginatedResponseMeta {
  const factory PaginatedResponseMeta({
    /// 次のページを取得するためのトークン
    String? nextToken,

    /// ポーリング用のトークン
    String? nextPooling,
  }) = _PaginatedResponseMeta;

  factory PaginatedResponseMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginatedResponseMetaFromJson(json);
}
