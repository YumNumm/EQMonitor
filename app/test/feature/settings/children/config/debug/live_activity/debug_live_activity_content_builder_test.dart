import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_content_state.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_content_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const builder = DebugLiveActivityContentBuilder();
  final now = DateTime.utc(2026, 9, 12, 1, 30);

  test('all presets produce valid round-trippable complete snapshots', () {
    for (final preset in DebugUnifiedPreset.values) {
      final state = builder.unifiedFromPreset(
        preset: preset,
        id: 'logical-sequence',
        now: now,
      );

      expect(state.id, 'logical-sequence', reason: preset.name);
      expect(
        UnifiedLiveActivityContentState.fromJson(state.toJson()),
        state,
        reason: preset.name,
      );
      expect(
        state.toJson().keys,
        containsAll(<String>['shakeDetection', 'eew', 'earthquake']),
      );
    }
  });

  test(
    'logical and sample event IDs stay stable across primary transitions',
    () {
      final states =
          <DebugUnifiedPreset>[
            .shake,
            .eew,
            .earthquake,
          ].map(
            (preset) => builder.unifiedFromPreset(
              preset: preset,
              id: 'logical-sequence',
              now: now,
            ),
          );

      expect(states.map((state) => state.id).toSet(), <String>{
        'logical-sequence',
      });
      expect(
        states
            .expand((state) => [state.eew?.eventId, state.earthquake?.eventId])
            .whereType<String>()
            .toSet(),
        <String>{'debug-event-logical-sequence'},
      );
    },
  );

  test(
    'noLocation uses explicit null for every required nullable location',
    () {
      final state = builder.unifiedFromPreset(
        preset: DebugUnifiedPreset.noLocation,
        id: 'logical-no-location',
        now: now,
      );
      final json = state.toJson();

      expect(
        (json['shakeDetection'] as Map<String, dynamic>)['location'],
        isNull,
      );
      expect((json['eew'] as Map<String, dynamic>)['location'], isNull);
      expect((json['earthquake'] as Map<String, dynamic>)['location'], isNull);
    },
  );

  test('magnitude presets preserve UNKNOWN and OVER_M8 union variants', () {
    final unknown = builder.unifiedFromPreset(
      preset: DebugUnifiedPreset.magnitudeUnknown,
      id: 'logical-magnitude',
      now: now,
    );
    final overM8 = builder.unifiedFromPreset(
      preset: DebugUnifiedPreset.magnitudeOverM8,
      id: 'logical-magnitude',
      now: now,
    );

    expect(unknown.earthquake?.magnitude, const EarthquakeMagnitude.unknown());
    expect(overM8.earthquake?.magnitude, const EarthquakeMagnitude.overM8());
  });

  test(
    'ended and canceled presets remain snapshots for update, not end commands',
    () {
      final ended = builder.unifiedFromPreset(
        preset: DebugUnifiedPreset.shakeEnded,
        id: 'logical-lifecycle',
        now: now,
      );
      final canceledEew = builder.unifiedFromPreset(
        preset: DebugUnifiedPreset.canceledEew,
        id: 'logical-lifecycle',
        now: now,
      );
      final canceledEarthquake = builder.unifiedFromPreset(
        preset: DebugUnifiedPreset.canceledEarthquake,
        id: 'logical-lifecycle',
        now: now,
      );

      expect(ended.shakeDetection?.status, UnifiedShakeDetectionStatus.ended);
      expect(canceledEew.eew?.isCanceled, true);
      expect(canceledEarthquake.earthquake?.isCanceled, true);
    },
  );
}
