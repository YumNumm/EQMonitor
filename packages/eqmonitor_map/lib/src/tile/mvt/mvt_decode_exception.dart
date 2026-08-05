import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_limits.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mvt_decode_exception.freezed.dart';

/// tile bytesはPMTiles archiveから読み出したuntrusted dataであり、壊れた
/// 入力を空tileへ丸めず必ずこの型で失敗させる。fail-openのfallbackは置かない。
@freezed
sealed class MvtDecodeException with _$MvtDecodeException implements Exception {
  /// protobuf wire形式そのものが壊れている場合。varintが境界を越える、
  /// length-delimitedフィールドがtile境界を越える、未対応のwire typeなど。
  const factory MvtDecodeException.malformedProtobuf({
    required String reason,
  }) = MvtMalformedProtobufException;

  /// layerのversionがMVT仕様の1または2以外の場合。
  const factory MvtDecodeException.unsupportedLayerVersion({
    required int version,
  }) = MvtUnsupportedLayerVersionException;

  /// geometry commandの並び・引数・geometry typeごとの規則違反。
  /// command IDが未知、count/引数個数の不整合、Point以外でのMoveTo count誤り、
  /// LineTo無しのpart、ClosePathで閉じていないPolygon ringなど。
  const factory MvtDecodeException.invalidGeometryCommand({
    required String reason,
  }) = MvtInvalidGeometryCommandException;

  /// 呼び出し側が渡した[MvtDecodeLimits]を超過した場合。
  const factory MvtDecodeException.limitExceeded({
    required String reason,
  }) = MvtLimitExceededException;
}
