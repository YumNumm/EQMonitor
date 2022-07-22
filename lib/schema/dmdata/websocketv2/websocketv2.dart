import 'type.dart';

/// ## WebSocket v2 type:data
/// WebSocket `wss://{可変}.api.dmdata.jp/v2/websocket`
/// WebSocketを通じて気象庁の発表する電文をリアルタイムに配信します。

class WebSocketv2Data {
  WebSocketv2Data({
    required this.type,
    required this.version,
    required this.classification,
    required this.id,
    required this.passing,
    required this.head,
    required this.xmlReport,
    required this.format,
    required this.compression,
    required this.encoding,
    required this.body,
  });
  WebSocketv2Data.fromJson(Map<String, dynamic> j)
      : type = DmDataWebSocketType.data,
        version = j['version'].toString(),
        id = j['id'].toString(),
        classification = j['classification'].toString(),
        passing = List<WebSocketv2DataPassing>.generate(
          (j['passing'] as List<dynamic>).length,
          (index) => WebSocketv2DataPassing.fromJson(
            j['passing'][index] as Map<String, dynamic>,
          ),
        ),
        head = WebSocketv2DataHead.fromJson(j['head'] as Map<String, dynamic>),
        xmlReport = j['xmlReport'].toString(),
        format = j['format'].toString(),
        compression = j['compression'].toString(),
        encoding = j['encoding'].toString(),
        body = j['body'].toString();

  /// 常に`data`
  final DmDataWebSocketType type;

  /// バージョンを示す、作成処理の変更で予告なく変更となる場合がある
  final String version;

  /// 配信区分により変化。
  /// `telegram.earthquake`,
  /// `telegram.volcano`,
  /// `telegram.weather`,
  /// `telegram.scheduled`
  final String classification;

  /// 配信データを区別するユニーク384bitハッシュ
  final String id;

  /// 通過情報
  final List<WebSocketv2DataPassing> passing;

  /// ヘッダ情報
  final WebSocketv2DataHead head;

  /// XML電文Control,Head情報
  final String xmlReport; //! Object
  /// bodyフィールドの表現形式を示す。
  /// `xml`,`a/n`,`binary`は気象庁が定めたフォーマット、`json` は本サービスが独自に定めたフォーマット
  final String format;

  /// `body`フィールドの圧縮形式を示す。`gzip`または`zip`、非圧縮時は`null`を格納する
  final String compression;

  /// bodyフィールドのエンコーディング形式を示す。`base64`または、`utf-8`を格納する
  final String encoding;

  /// 本文
  final String body;
}

class WebSocketv2DataPassing {
  WebSocketv2DataPassing({
    required this.name,
    required this.time,
  });
  WebSocketv2DataPassing.fromJson(Map<String, dynamic> j)
      : name = j['name'].toString(),
        time = DateTime.parse(j['time'].toString());
  final String name;
  final DateTime time;
}

class WebSocketv2DataHead {
  WebSocketv2DataHead({
    required this.type,
    required this.author,
    required this.target,
    required this.time,
    required this.designation,
    required this.test,
    required this.xml,
  });
  WebSocketv2DataHead.fromJson(Map<String, dynamic> j)
      : type = DmDssTelegramDataType.values
            .firstWhere((e) => e.name == j['type'].toString()),
        author = j['author'].toString(),
        time = DateTime.parse(j['time'].toString()),
        target = (j['target'] == null) ? null : j['target'].toString(),
        designation = j['designation'].toString(),
        test = bool.fromEnvironment(j['test'].toString(), defaultValue: false),
        xml = (j['xml'].toString() == 'true')
            ? true
            : (j['xml'] == 'false')
                ? false
                : null;

  /// ## データ種類コード
  final DmDssTelegramDataType type;

  /// ## 発表英字官署名
  final String author;

  /// ## 対象観測地点コード (nullable)
  final String? target;

  /// ## 基点時刻（ISO8601拡張形式）
  final DateTime time;

  /// ## 指示コード (nullable)
  final String designation;
  final bool test;
  final bool? xml;
}
