import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_content_state.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_content_builder.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_json_codec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const codec = DebugLiveActivityJsonCodec();
  const builder = DebugLiveActivityContentBuilder();
  final state = builder.unifiedFromPreset(
    preset: DebugUnifiedPreset.allBlocks,
    id: 'logical-codec',
    now: DateTime.utc(2026, 9, 12),
  );

  test('typed snapshot encodes as pretty JSON and parses back to the DTO', () {
    final encoded = codec.encode(state);
    final result = codec.parse(encoded);

    expect(encoded, contains('\n  "schemaVersion"'));
    expect(
      result,
      isA<Success<UnifiedLiveActivityContentState, FormatException>>(),
    );
    expect(result.unwrap(), state);
  });

  test('empty, invalid JSON, arrays and invalid schema return Failure', () {
    for (final raw in <String>[
      '   ',
      '{ not json ',
      '[1, 2, 3]',
      '{"schemaVersion": 1}',
    ]) {
      expect(
        codec.parse(raw),
        isA<Failure<UnifiedLiveActivityContentState, FormatException>>(),
        reason: raw,
      );
    }
  });
}
