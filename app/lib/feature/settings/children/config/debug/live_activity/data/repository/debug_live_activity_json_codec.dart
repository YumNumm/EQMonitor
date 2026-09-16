import 'dart:convert';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_live_activity_json_codec.g.dart';

@Riverpod(keepAlive: true)
DebugLiveActivityJsonCodec debugLiveActivityJsonCodec(Ref ref) =>
    const DebugLiveActivityJsonCodec();

/// ContentState の `Map` と、UI で編集する JSON 文字列を相互変換する。
class DebugLiveActivityJsonCodec {
  const new();

  /// 人間が編集しやすいようインデント付きで整形する。
  String encode(Map<String, dynamic> contentState) =>
      const JsonEncoder.withIndent('  ').convert(contentState);

  /// JSON 文字列をオブジェクトとして解釈する。
  ///
  /// - オブジェクト以外（配列・数値・null 等）は [FormatException] を返す。
  /// - パース失敗も [FormatException] を返す。
  Result<Map<String, dynamic>, FormatException> parse(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return const Failure(FormatException('JSON が空です'));
    }
    final Object? decoded;
    try {
      decoded = jsonDecode(trimmed);
    } on FormatException catch (e, stackTrace) {
      return Failure(e, stackTrace);
    }
    if (decoded is! Map<String, dynamic>) {
      return const Failure(
        FormatException('ContentState は JSON オブジェクトである必要があります'),
      );
    }
    return Success(decoded);
  }
}
