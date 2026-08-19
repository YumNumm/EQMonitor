/// デバッグ編集画面でリスト項目を追加する際に、重複しない識別子を採番する。
class EarthquakeVxseDebugDraftIdentityGenerator {
  const new();

  String nextCode({required String prefix, required Set<String> usedCodes}) {
    var suffix = 1;
    while (usedCodes.contains('$prefix-$suffix')) {
      suffix++;
    }
    return '$prefix-$suffix';
  }

  DateTime nextCommentTime({
    required DateTime base,
    required Set<DateTime> usedTimes,
  }) {
    var candidate = base;
    do {
      candidate = candidate.add(const Duration(seconds: 1));
    } while (usedTimes.contains(candidate));
    return candidate;
  }

  double nextPrePeriodBand({required Set<double> usedBands}) {
    var tenths = 16;
    while (usedBands.contains(tenths / 10)) {
      tenths++;
    }
    return tenths / 10;
  }
}
