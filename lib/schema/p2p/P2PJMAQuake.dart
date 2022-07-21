import 'package:intl/intl.dart';

/// ## 地震情報
class P2PJMAQuake {

  P2PJMAQuake({
    required this.id,
    required this.code,
    required this.time,
    required this.issue,
    required this.earthquake,
    required this.points,
  });

  P2PJMAQuake.fromJson(Map<String, dynamic> j)
      : id = j['id'].toString(),
        code = int.parse(j['code'].toString()),
        time = DateFormat('yyyy/MM/dd HH:mm.SSS').parse(j['time'].toString()),
        issue = P2PJMAQuakeIssue.fromJson(j['issue'] as Map<String, dynamic>),
        earthquake = P2PJMAQuakeEarthQuake.fromJson(
          j['earthquake'] as Map<String, dynamic>,
        ),
        points = (j['points'].toString() == '')
            ? null
            : List<P2PJMAQuakePoint>.generate(
                (j['points'] as List<dynamic>).length,
                (index) => P2PJMAQuakePoint.fromJson(
                  (j['points'] as List<dynamic>)[index] as Map<String, dynamic>,
                ),
              );
  /// ## 情報を一意に識別するID
  final String id;

  /// ## 情報コード。常に`551`
  final int code;

  /// ## 受信日付
  final DateTime time;

  /// ## 発表元の情報
  final P2PJMAQuakeIssue issue;

  /// ## 地震情報
  final P2PJMAQuakeEarthQuake earthquake;

  /// ## 震度観測点の情報
  final List<P2PJMAQuakePoint>? points;
}

/// ## 発表元の情報
class P2PJMAQuakeIssue {

  P2PJMAQuakeIssue.fromJson(Map<String, dynamic> j)
      : source = (j['source'].toString() == '') ? null : j['source'].toString(),
        time = DateFormat('yyyy/MM/dd HH:mm.SSS').parse(j['time'].toString()),
        type = P2PJMAQuakeIssueType.values
            .firstWhere((e) => e.name == j['type'].toString()),
        correct = P2PJMAQuakeIssueCorrect.values
            .firstWhere((e) => e.name == j['correct'].toString());
  P2PJMAQuakeIssue({
    required this.source,
    required this.time,
    required this.type,
    required this.correct,
  });
  /// ## 発表元
  final String? source;

  /// ## 発表日時
  final DateTime time;

  /// ## 発表種類
  final P2PJMAQuakeIssueType type;

  /// ## 訂正の有無
  final P2PJMAQuakeIssueCorrect correct;
}

/// ## 地震情報
class P2PJMAQuakeEarthQuake {
  P2PJMAQuakeEarthQuake.fromJson(Map<String, dynamic> j)
      : time = DateFormat('yyyy/MM/dd HH:mm.SSS').parse(j['time'].toString()),
        hypocenter = (j['hypocenter'].toString() == '')
            ? null
            : P2PJMAQuakeEarthQuakeHypoCenter.fromJson(
                j['hypocenter'] as Map<String, dynamic>,
              ),
        maxScale = enumToScale(j['maxScale'].toString()),
        domesticTsunami = (j['domesticTsunami'].toString() == '')
            ? null
            : P2PJMAQuakeDomesticTsunami.values
                .firstWhere((e) => e.name == j['domesticTsunami'].toString()),
        foreignTsunami = (j['foreignTsunami'].toString() == '')
            ? null
            : P2PJMAQuakeForeignTsunami.values
                .firstWhere((e) => e.name == j['foreignTsunami'].toString());
  P2PJMAQuakeEarthQuake({
    required this.time,
    required this.hypocenter,
    required this.maxScale,
    required this.domesticTsunami,
    required this.foreignTsunami,
  });
  /// ## 発生日時
  final DateTime time;

  /// ## 震源情報
  final P2PJMAQuakeEarthQuakeHypoCenter? hypocenter;

  /// ## 最大震度
  final String? maxScale;

  /// ## 国内への津波の有無
  final P2PJMAQuakeDomesticTsunami? domesticTsunami;

  /// ## 海外での津波の有無
  final P2PJMAQuakeForeignTsunami? foreignTsunami;
}

/// ## 震度観測点の情報
class P2PJMAQuakePoint {

  P2PJMAQuakePoint.fromJson(Map<String, dynamic> j)
      : pref = j['pref'].toString(),
        addr = j['addr'].toString(),
        isArea =
            bool.fromEnvironment(j['isArea'].toString(), defaultValue: true),
        scale = enumToScale(j['scale'].toString())!;

  P2PJMAQuakePoint({
    required this.pref,
    required this.addr,
    required this.isArea,
    required this.scale,
  });
  /// ## 都道府県
  final String pref;

  /// ## 震度観測点名称
  /// （震度速報の場合は[気象庁|緊急地震速報や震度情報で用いる区域の名称](http://www.data.jma.go.jp/svd/eqev/data/joho/shindo-name.html)に記載のある区域名）
  final String addr;

  /// ## 区域名かどうか
  final bool isArea;

  /// ## 震度
  final String scale;
}

/// ## 震源情報
class P2PJMAQuakeEarthQuakeHypoCenter {
  P2PJMAQuakeEarthQuakeHypoCenter({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.depth,
    required this.magnitude,
  });

  P2PJMAQuakeEarthQuakeHypoCenter.fromJson(Map<String, dynamic> j)
      : name = (j['name'].toString() == '') ? null : j['name'].toString(),
        latitude = (j['latitude'].toString() == '-200')
            ? null
            : double.parse(j['latitude'].toString()),
        longitude = (j['longitude'].toString() == '-200')
            ? null
            : double.parse(j['longitude'].toString()),
        depth = (j['depth'].toString() == '-1')
            ? null
            : int.parse(j['depth'].toString()),
        magnitude = (j['magnitude'].toString() == '-1')
            ? null
            : double.parse(j['magnitude'].toString());
  /// ## 名称
  final String? name;

  /// ## 緯度
  final double? latitude;

  /// ## 経度
  final double? longitude;

  /// ## 深さ(km)
  /// - ごく浅い = `0`
  /// - 存在しない = `-1`
  final int? depth;

  /// ## マグニチュード
  final double? magnitude;
}

enum P2PJMAQuakeIssueType {
  /// ## 震度速報
  ScalePrompt,

  /// ## 震源に関する情報
  Destination,

  /// ## 震度・震源に関する情報
  ScaleAndDestination,

  /// ## 各地の震度に関する情報
  DetailScale,

  /// ## 遠地地震に関する情報
  Foreign,

  /// ## その他の情報
  Other,
}

/// ## 訂正の有無
enum P2PJMAQuakeIssueCorrect {
  /// ## なし
  None,

  /// ## 不明
  Unknown,

  /// ## 震度
  ScaleOnly,

  /// ## 震源
  DestinationOnly,

  /// ## 震度・震源
  ScaleAndDestination,
}

/// ## 国内への津波の有無
enum P2PJMAQuakeDomesticTsunami {
  /// ## なし
  None,

  /// ## 不明
  Unknown,

  /// ## 調査中
  Checking,

  /// ## 若干の海面変動が予想されるが、被害の心配なし
  NonEffective,

  /// ## 津波注意報
  Watch,

  /// ## 津波予報(種類不明)
  Warning,
}

/// ## 海外での津波の有無
enum P2PJMAQuakeForeignTsunami {
  /// なし
  None,

  /// ## 不明
  Unknown,

  /// ## 調査中
  Checking,

  /// ## 震源の近傍で小さな津波の可能性があるが、被害の心配なし
  NonEffectiveNearby,

  /// ## 震源の近傍で津波の可能性がある
  WarningNearby,

  /// ## 太平洋で津波の可能性がある
  WarningPacific,

  /// ## 太平洋の広域で津波の可能性がある
  WarningPacificWide,

  /// ## インド洋で津波の可能性がある
  WarningIndian,

  /// ## インド洋の広域で津波の可能性がある
  WarningIndianWide,

  /// ## 一般にこの規模では津波の可能性がある
  Potential,
}

String? enumToScale(String? scale) {
  switch (scale.toString()) {
    case '-1':
      return null;
    case '10':
      return '1';
    case '20':
      return '2';
    case '30':
      return '3';
    case '40':
      return '4';
    case '45':
      return '5-';
    case '50':
      return '5+';
    case '55':
      return '6-';
    case '60':
      return '6+';
    case '70':
      return '7';

    default:
      return null;
  }
}
