import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_eew_report_resolver.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_origin_time_resolver.g.dart';

@riverpod
ReplayOriginTimeResolver replayOriginTimeResolver(Ref ref) =>
    ReplayOriginTimeResolver(
      reports: ref.watch(replayEewReportResolverProvider),
    );

class const ReplayOriginTimeResolver({
  required final ReplayEewReportResolver reports,
}) {
  DateTime? resolve(List<ReplayData> frames) {
    for (final frame in frames) {
      final originTime = reports.decode(frame)?.eew.originTime;
      if (originTime != null) {
        return originTime.toUtc();
      }
    }
    return null;
  }
}
