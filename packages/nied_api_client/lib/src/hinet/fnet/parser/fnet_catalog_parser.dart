import 'package:nied_api_client/src/hinet/fnet/model/fnet_event.dart';

/// F-netカタログデータのパーサー
class FnetCatalogParser {
  const new();

  /// カタログテキストをパースしてイベントリストを返す
  List<FnetEvent> parse(String content) {
    final lines = content.split('\n');
    final events = <FnetEvent>[];

    for (final line in lines) {
      // コメント行や空行をスキップ
      if (line.trim().isEmpty || line.startsWith('#')) {
        continue;
      }

      try {
        final event = _parseLine(line);
        events.add(event);
      } on Exception catch (_) {
        // パースエラーは無視して次の行へ
        continue;
      }
    }

    return events;
  }

  FnetEvent _parseLine(String line) {
    final parts = line.split(RegExp(r'\s+'));

    if (parts.length < 20) {
      throw const FormatException('Invalid line format: not enough fields');
    }

    // 日時のパース (例: 2025/11/01,14:44:06.18)
    final dateTimeParts = parts[0].split(',');
    if (dateTimeParts.length != 2) {
      throw FormatException('Invalid datetime format: ${parts[0]}');
    }
    final dateParts = dateTimeParts[0].split('/');
    final timeParts = dateTimeParts[1].split(':');
    final secondParts = timeParts[2].split('.');

    final originTime = DateTime.utc(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
      int.parse(secondParts[0]),
      secondParts.length > 1
          ? (double.parse('0.${secondParts[1]}') * 1000).round()
          : 0,
    );

    return FnetEvent(
      originTime: originTime,
      latitude: double.parse(parts[1]),
      longitude: double.parse(parts[2]),
      jmaDepth: double.parse(parts[3]),
      jmaMagnitude: double.parse(parts[4]),
      regionName: parts[5],
      strike: FnetAnglePair.fromString(parts[6]),
      dip: FnetAnglePair.fromString(parts[7]),
      rake: FnetAnglePair.fromString(parts[8]),
      seismicMoment: double.parse(parts[9]),
      mtDepth: double.parse(parts[10]),
      momentMagnitude: double.parse(parts[11]),
      varianceReduction: double.parse(parts[12]),
      momentTensor: FnetMomentTensor(
        mxx: double.parse(parts[13]),
        mxy: double.parse(parts[14]),
        mxz: double.parse(parts[15]),
        myy: double.parse(parts[16]),
        myz: double.parse(parts[17]),
        mzz: double.parse(parts[18]),
      ),
      unit: double.parse(parts[19]),
      numberOfStations: int.parse(parts[20]),
    );
  }
}
