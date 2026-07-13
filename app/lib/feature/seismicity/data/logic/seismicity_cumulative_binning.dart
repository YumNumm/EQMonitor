import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_daily_bin.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';

/// 発生回数積算図・日別ヒストグラム用のビニング。
///
/// 最初のイベント発生日から最後のイベント発生日まで、イベントが
/// 存在しない日も 0 件として補完した連続系列を返す。
class SeismicityCumulativeBinning {
  const SeismicityCumulativeBinning();

  static const maxDailyBinCount = 3660;

  List<SeismicityDailyBin> bin(List<SeismicityEvent> events) {
    if (events.isEmpty) {
      return const [];
    }

    final countsByDay = <DateTime, int>{};
    for (final event in events) {
      final day = DateTime.utc(
        event.originTime.year,
        event.originTime.month,
        event.originTime.day,
      );
      countsByDay[day] = (countsByDay[day] ?? 0) + 1;
    }

    final sortedDays = countsByDay.keys.toList()..sort();
    final firstDay = sortedDays.first;
    final lastDay = sortedDays.last;

    final inclusiveDayCount = lastDay.difference(firstDay).inDays + 1;
    if (inclusiveDayCount > maxDailyBinCount) {
      final bins = <SeismicityDailyBin>[];
      var cumulative = 0;
      for (final day in sortedDays) {
        final count = countsByDay[day] ?? 0;
        cumulative += count;
        bins.add(
          SeismicityDailyBin(
            date: day,
            count: count,
            cumulativeCount: cumulative,
          ),
        );
      }
      return bins;
    }

    final bins = <SeismicityDailyBin>[];
    var cumulative = 0;
    for (
      var day = firstDay;
      !day.isAfter(lastDay);
      day = day.add(const Duration(days: 1))
    ) {
      final count = countsByDay[day] ?? 0;
      cumulative += count;
      bins.add(
        SeismicityDailyBin(
          date: day,
          count: count,
          cumulativeCount: cumulative,
        ),
      );
    }
    return bins;
  }
}
