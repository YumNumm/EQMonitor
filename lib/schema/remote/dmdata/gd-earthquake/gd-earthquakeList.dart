import '../eq-information/earthquake-information/hypocenter.dart';
import '../eq-information/earthquake-information/magnitude.dart';

/// ## GD Earthquake List
/// `GET https://api.dmdata.jp/v2/gd/earthquake
/// 地震情報のリスト
class GDEarthquakeList {
  GDEarthquakeList({
    required this.responseId,
    required this.responseTime,
    required this.status,
    required this.items,
    required this.nextToken,
    required this.nextPooling,
    required this.nextPoolingInterval,
  });
  GDEarthquakeList.fromJson(Map<String, dynamic> j)
      : responseId = j['responseId'].toString(),
        responseTime = DateTime.parse(j['responseTime'].toString()),
        status = j['status'].toString(),
        items = List<GDEarthquakeListItem>.generate(
          (j['items'] as List<dynamic>).length,
          (i) => GDEarthquakeListItem.fromJson(
           ( j['items'] as Map<String,dynamic>)[i] as Map<String, dynamic>,
          ),
        ),
        nextToken = (j['nextToken'] == null) ? null : j['nextToken'].toString(),
        nextPooling = j['nextPooling'].toString(),
        nextPoolingInterval = int.parse(j['nextPoolingInterval'].toString());

  /// API処理ID
  final String responseId;

  /// API処理時刻
  final DateTime responseTime;

  /// 成功時は`ok`、失敗時は`error`
  final String status;

  /// アイテムリスト
  final List<GDEarthquakeListItem> items;

  /// 次のリソースがある場合に出現。
  final String? nextToken;

  /// PULL時に使用する
  final String nextPooling;

  /// 次のPullまでの待機時間(ms)
  final int nextPoolingInterval;
}

/// ## アイテムリスト
class GDEarthquakeListItem {
  GDEarthquakeListItem({
    required this.id,
    required this.eventId,
    required this.originTime,
    required this.arrivalTime,
    required this.hypoCenter,
    required this.magnitude,
    required this.maxInt,
  });
  GDEarthquakeListItem.fromJson(Map<String, dynamic> j)
      : id = int.parse(j['id'].toString()),
        eventId = j['eventId'].toString(),
        originTime = (j['originTime'] == null)
            ? null
            : DateTime.parse(j['originTime'].toString()),
        arrivalTime = DateTime.parse(j['arrivalTime'].toString()),
        hypoCenter = (j['hypocenter'] == null)
            ? null
            : HypoCenter.fromJson(
                j['hypocenter'] as Map<String, dynamic>,
              ),
        magnitude = (j['magnitude'] == null)
            ? null
            : Magnitude.fromJson(j['magnitude'] as Map<String, dynamic>),
        maxInt = (j['maxInt'] == null) ? null : j['maxInt'].toString();

  /// ID
  final int id;

  /// 地震情報のイベントID
  final String eventId;

  /// 地震発生時刻
  final DateTime? originTime;

  /// 地震検知時刻
  final DateTime arrivalTime;

  /// 震源要素
  final HypoCenter? hypoCenter;

  /// マグニチュード要素
  final Magnitude? magnitude;

  /// 最大震度
  final String? maxInt;
}
