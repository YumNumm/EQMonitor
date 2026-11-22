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
      // 読めない EEW フレームは再生時にも読み飛ばす。形式の誤りだけを対象にする。
      try {
        final decoded = jsonDecode(frame.json);
        final originTime = decoded is Map<String, dynamic>
            ? EewItemWithRelations.fromJson(decoded).originTime
            : null;
        if (originTime != null) {
          return originTime.toUtc();
        }
      } on FormatException {
        continue;
      } on TypeError {
        continue;
      } on ArgumentError {
        continue;
      }
    }
    return null;
  }
}
