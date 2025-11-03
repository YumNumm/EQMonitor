import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:intl/intl.dart';
import 'package:nied_api_client/src/hinet/aqua/model/angle_pair.dart';
import 'package:nied_api_client/src/hinet/aqua/model/aqua_event.dart';
import 'package:nied_api_client/src/hinet/aqua/model/aqua_event_type.dart';
import 'package:nied_api_client/src/hinet/aqua/model/focal_mechanism.dart';
import 'package:timezone/timezone.dart';

/// AQUAカタログHTMLパーサー
class AquaHtmlParser {
  /// 日時フォーマット（例: 2025-09-29 23:33:08）
  static final _dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  /// カタログHTMLをパースしてイベントリストを返す
  Future<List<AquaEvent>> parseCatalog({
    required Uint8List bytes,
  }) async {
    final decoded = await CharsetConverter.decode('euc-jp', bytes);
    final document = html_parser.parse(decoded);
    final events = <AquaEvent>[];

    // class="aqua_catalogue"のテーブルを検索
    final table = document.querySelector('table.aqua_catalogue');
    if (table == null) {
      return events;
    }

    final rows = table.querySelectorAll('tr');

    // データ行を処理（id属性を持つ行のみ）
    for (final row in rows) {
      final id = row.attributes['id'];
      if (id == null || !id.startsWith('lst')) {
        continue;
      }

      try {
        final event = _parseTableRow(row);
        if (event != null) {
          events.add(event);
        }
      } catch (e) {
        rethrow;
      }
    }

    return events;
  }

  /// テーブル行をパースしてAquaEventを作成
  AquaEvent? _parseTableRow(Element row) {
    final cells = row.querySelectorAll('td');

    // 最低限必要なセル数をチェック
    if (cells.length < 12) {
      return null;
    }

    // Origin Time (例: 2025-09-29 23:33:08)
    final originTimeText = cells[0].text.trim();
    final originTime = _dateTimeFormat.parse(originTimeText);

    // ID (yyyyMMddHHmmss形式)
    final id = DateFormat('yyyyMMddHHmmss').format(originTime);

    // Region
    final region = cells[1].text.trim();

    // Latitude (例: 37.8N)
    final latText = cells[2].text.trim();
    final latitude = _parseLatitude(latText);

    // Longitude (例: 141.7E)
    final lonText = cells[3].text.trim();
    final longitude = _parseLongitude(lonText);

    // Depth (例: 58km)
    final depthText = cells[4].text.trim();
    final depth = double.parse(depthText.replaceAll('km', ''));

    // Magnitude
    final magnitude = double.parse(cells[5].text.trim());

    // Type (C or M)
    final typeText = cells[11].text.trim();
    final type = AquaEventType.fromCode(typeText);

    // Focal Mechanism (Strike/Dip/Rake)
    FocalMechanism? focalMechanism;
    // Strike (例: 179.4°/17.6°)
    final strikeText = cells[6].text.trim();
    final strikes = _parseSlashSeparatedValues(strikeText);

    // Dip (例: 21.0°/70.0°)
    final dipText = cells[7].text.trim();
    final dips = _parseSlashSeparatedValues(dipText);

    // Rake (例: 72.9°/96.4°)
    final rakeText = cells[8].text.trim();
    final rakes = _parseSlashSeparatedValues(rakeText);

    if (strikes.length == 2 && dips.length == 2 && rakes.length == 2) {
      focalMechanism = FocalMechanism(
        tiltAngle: AnglePair(first: dips[0], second: strikes[0]),
        slipAngle: AnglePair(first: rakes[0], second: strikes[1]),
        strikeAngle: AnglePair(first: dips[1], second: rakes[1]),
      );
    }

    // Variance Reduction
    final varianceReductionText = cells[9].text.trim();
    final varianceReduction = varianceReductionText.isNotEmpty
        ? double.tryParse(varianceReductionText)
        : null;

    // Station Count
    final stationCount = int.parse(cells[10].text.trim());

    return AquaEvent(
      id: id,
      originTime: TZDateTime.from(originTime, getLocation('Asia/Tokyo')),
      region: region,
      latitude: latitude,
      longitude: longitude,
      depth: depth,
      magnitude: magnitude,
      focalMechanism: focalMechanism,
      varianceReduction: varianceReduction,
      stationCount: stationCount,
      type: type,
    );
  }

  /// 緯度をパース (例: 37.8N → 37.8, 37.8S → -37.8)
  double _parseLatitude(String text) {
    final value = double.parse(text.replaceAll(RegExp('[NS]'), ''));
    return text.contains('S') ? -value : value;
  }

  /// 経度をパース (例: 141.7E → 141.7, 141.7W → -141.7)
  double _parseLongitude(String text) {
    final value = double.parse(text.replaceAll(RegExp('[EW]'), ''));
    return text.contains('W') ? -value : value;
  }

  /// スラッシュ区切りの値をパース (例: 179.4°/17.6° → [179.4, 17.6])
  List<double> _parseSlashSeparatedValues(String text) {
    return text
        .split('/')
        .map((s) {
          // 数字、ピリオド、マイナス記号以外を除去
          final cleaned = s.trim().replaceAll(RegExp(r'[^\d.\-]'), '');
          return cleaned;
        })
        .map(double.parse)
        .toList();
  }
}
