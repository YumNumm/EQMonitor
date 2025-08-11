import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_height.freezed.dart';

/// 津波の高さ情報
@freezed
abstract class TsunamiHeight with _$TsunamiHeight {
  const factory TsunamiHeight({
    /// 定量表現（メートル）
    double? value,

    /// 以上フラグ
    bool? isOver,

    /// 定性表現（「高い」「巨大」など）
    String? condition,

    /// 到達時刻
    DateTime? arrivalTime,

    /// 状況（「津波到達中と推測」など）
    String? situation,
  }) = _TsunamiHeight;

  const TsunamiHeight._();

  /// 表示用の高さ文字列を取得
  String get displayText {
    if (condition != null) {
      return condition!;
    }
    if (value != null) {
      final over = (isOver ?? false) ? '以上' : '';
      return '${value!.toStringAsFixed(1)}m$over';
    }
    return '不明';
  }
}
