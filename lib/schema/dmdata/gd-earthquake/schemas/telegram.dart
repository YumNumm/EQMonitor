import 'head.dart';
import 'head/schema.dart';

class Telegram {
  Telegram.fromJson(Map<String, dynamic> j)
      : serial = int.parse(j['serial'].toString()),
        id = j['id'].toString(),
        classification = j['classification'].toString(),
        head = Head.fromJson(j['head'] as Map<String, dynamic>),
        receivedTime = DateTime.parse(j['receivedTime'].toString()),
        xmlReport = j['xmlReport'].toString(),
        schema = Schema.fromJson(j['schema'] as Map<String, dynamic>),
        format =
            (j['format'].toString() == 'null') ? null : j['format'].toString(),
        url = j['url'].toString();

  Telegram({
    required this.serial,
    required this.id,
    required this.classification,
    required this.head,
    required this.receivedTime,
    required this.xmlReport,
    required this.schema,
    required this.format,
    required this.url,
  });

  /// 電文受信通番
  final int serial;

  /// 配信データを区別するユニーク384bitハッシュ
  final String id;

  /// 配信区分により変化。取りうる値は`telegram.earthquake`
  final String classification;

  /// ヘッダ情報
  final Head head;

  /// 受信時刻
  final DateTime receivedTime;

  /// XML電文のControl,Head情報
  final String xmlReport;

  /// 加工データのスキーマ情報
  final Schema schema;

  /// bodyフィールドの表現方法
  final String? format;

  /// 電文本体URL
  final String url;
}
