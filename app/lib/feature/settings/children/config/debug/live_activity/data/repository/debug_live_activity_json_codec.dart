import 'dart:convert';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_content_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final debugLiveActivityJsonCodecProvider = Provider<DebugLiveActivityJsonCodec>(
  (ref) => const DebugLiveActivityJsonCodec(),
);

class DebugLiveActivityJsonCodec {
  const new();

  String encode(UnifiedLiveActivityContentState state) =>
      const JsonEncoder.withIndent('  ').convert(state.toJson());

  Result<UnifiedLiveActivityContentState, FormatException> parse(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return const Failure(FormatException('JSON が空です'));
    }
    try {
      final decoded = jsonDecode(trimmed);
      if (decoded is! Map<String, dynamic>) {
        return const Failure(FormatException('JSON オブジェクトを入力してください'));
      }
      return Success(UnifiedLiveActivityContentState.fromJson(decoded));
    } on FormatException catch (error, stackTrace) {
      return Failure(error, stackTrace);
    }
  }
}
