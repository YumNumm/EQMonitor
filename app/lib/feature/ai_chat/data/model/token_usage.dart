import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_usage.freezed.dart';

@freezed
abstract class TokenUsage with _$TokenUsage {
  const factory TokenUsage({
    @Default(0) int inputTokens,
    @Default(0) int outputTokens,
    @Default(0) int totalTokens,
    @Default(0) int turns,
  }) = _TokenUsage;

  const TokenUsage._();

  /// 累積トークン使用量を更新。
  TokenUsage add({int? input, int? output, int? total}) {
    final i = inputTokens + (input ?? 0);
    final o = outputTokens + (output ?? 0);
    return TokenUsage(
      inputTokens: i,
      outputTokens: o,
      totalTokens: total != null ? totalTokens + total : i + o,
      turns: turns + 1,
    );
  }
}
