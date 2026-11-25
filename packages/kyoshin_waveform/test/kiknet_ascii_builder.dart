final class const KiknetAsciiBuilder({
  required final String stationCode,
  required final String direction,
  final String recordTime = '2026/11/06 19:40:12',
  final List<int> counts = const [10, -10, 20, -20, 0, 0, 0, 0],
}) {
  String build() {
    final header = [
      ('Origin Time', '2026/11/06 19:39:00'),
      ('Lat.', '35.000'),
      ('Long.', '142.200'),
      ('Depth. (km)', '10'),
      ('Mag.', '6.1'),
      ('Station Code', stationCode),
      ('Station Lat.', '37.3000'),
      ('Station Long.', '140.5000'),
      ('Station Height(m)', '300'),
      ('Record Time', recordTime),
      ('Sampling Freq(Hz)', '100Hz'),
      ('Duration Time(s)', '120'),
      ('Dir.', direction),
      ('Scale Factor', '7845(gal)/8223790'),
      ('Max. Acc. (gal)', '0.019'),
      ('Last Correction', '2026/11/06 19:39:57'),
      ('Memo.', ''),
    ];
    final lines = [
      for (final (label, value) in header) '${label.padRight(18)}$value',
      for (var i = 0; i < counts.length; i += 8)
        counts.skip(i).take(8).map((v) => '$v'.padLeft(8)).join(' '),
    ];
    return '${lines.join('\n')}\n';
  }
}
