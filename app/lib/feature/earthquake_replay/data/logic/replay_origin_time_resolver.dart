import 'dart:convert';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show EewItemWithRelations;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_origin_time_resolver.g.dart';

@riverpod
ReplayOriginTimeResolver replayOriginTimeResolver(Ref ref) =>
    const ReplayOriginTimeResolver();

class const ReplayOriginTimeResolver() {
  DateTime? resolve(List<ReplayData> frames) {
    for (final frame in frames.whereType<EqMonitorEewReplayData>()) {
      try {
        final originTime = EewItemWithRelations.fromJson(
          jsonDecode(frame.json) as Map<String, dynamic>,
        ).originTime;
        if (originTime != null) {
          return originTime.toUtc();
        }
      } on Object {
        continue;
      }
    }
    return null;
  }
}
