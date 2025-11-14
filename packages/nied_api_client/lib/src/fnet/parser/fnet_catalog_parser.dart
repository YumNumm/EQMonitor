import 'package:nied_api_client/src/fnet/model/fnet_earthquake_event.dart';

/// F-netカタログデータのパーサー
class FnetCatalogParser {
  /// カタログファイルの内容をパースしてイベントのリストを返す
  static List<FnetEarthquakeEvent> parse(String content) {
    final lines = content.split('\n');
    final events = <FnetEarthquakeEvent>[];

    for (final line in lines) {
      // コメント行と空行をスキップ
      if (line.trim().isEmpty || line.startsWith('#')) {
        continue;
      }

      // ヘッダー行をスキップ
      if (line.startsWith('Origin_Time')) {
        continue;
      }

      try {
        final event = _parseEvent(line);
        if (event != null) {
          events.add(event);
        }
      } catch (e) {
        // パースに失敗した行はスキップ
        continue;
      }
    }

    return events;
  }

  static FnetEarthquakeEvent? _parseEvent(String line) {
    // タブまたは複数のスペースで区切られたデータを分割
    final parts = line.split(RegExp(r'\s+'));

    if (parts.length < 20) {
      return null;
    }

    try {
      // 発生時刻をパース (例: 2025/11/01,14:44:06.18)
      final dateTimeParts = parts[0].split(',');
      if (dateTimeParts.length != 2) {
        return null;
      }

      final dateParts = dateTimeParts[0].split('/');
      final timeParts = dateTimeParts[1].split(':');

      if (dateParts.length != 3 || timeParts.length != 3) {
        return null;
      }

      final year = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final day = int.parse(dateParts[2]);
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      final secondStr = timeParts[2];
      final second = double.parse(secondStr);
      final secondInt = second.floor();
      final millisecond = ((second - secondInt) * 1000).round();

      final originTime = DateTime.utc(
        year,
        month,
        day,
        hour,
        minute,
        secondInt,
        millisecond,
      );

      // 各フィールドをパース
      final latitude = double.parse(parts[1]);
      final longitude = double.parse(parts[2]);
      final jmaDepth = double.parse(parts[3]);
      final jmaMagnitude = double.parse(parts[4]);
      final regionName = parts[5];

      // 断層パラメータをパース (セミコロン区切り)
      final strike = FaultParameterPair.parse(parts[6]);
      final dip = FaultParameterPair.parse(parts[7]);
      final rake = FaultParameterPair.parse(parts[8]);

      // 科学的記法の値をパース (例: 1.89e+15)
      final seismicMoment = double.parse(parts[9]);
      final mtDepth = double.parse(parts[10]);
      final mtMagnitude = double.parse(parts[11]);
      final varianceReduction = double.parse(parts[12]);

      // モーメントテンソル成分
      final mxx = double.parse(parts[13]);
      final mxy = double.parse(parts[14]);
      final mxz = double.parse(parts[15]);
      final myy = double.parse(parts[16]);
      final myz = double.parse(parts[17]);
      final mzz = double.parse(parts[18]);

      final momentTensor = MomentTensor(
        mxx: mxx,
        mxy: mxy,
        mxz: mxz,
        myy: myy,
        myz: myz,
        mzz: mzz,
      );

      final unit = double.parse(parts[19]);
      final numberOfStations = int.parse(parts[20]);

      return FnetEarthquakeEvent(
        originTime: originTime,
        latitude: latitude,
        longitude: longitude,
        jmaDepth: jmaDepth,
        jmaMagnitude: jmaMagnitude,
        regionName: regionName,
        strike: strike,
        dip: dip,
        rake: rake,
        seismicMoment: seismicMoment,
        mtDepth: mtDepth,
        mtMagnitude: mtMagnitude,
        varianceReduction: varianceReduction,
        momentTensor: momentTensor,
        unit: unit,
        numberOfStations: numberOfStations,
      );
    } catch (e) {
      return null;
    }
  }
}
