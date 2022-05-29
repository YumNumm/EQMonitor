import '../../eq-information/earthquake.dart';
import 'telegram.dart';

class Event {
  Event({
    required this.id,
    required this.eventId,
    required this.originTime,
    required this.arrivalTime,
    required this.hypoCenter,
    required this.magnitude,
    required this.maxInt,
    required this.telegrams,
  });
  Event.fromJson(Map<String, dynamic> j)
      : id = int.parse(j['id'].toString()),
        eventId = j['eventId'].toString(),
        originTime = DateTime.tryParse(j['originTime'].toString()),
        arrivalTime = DateTime.parse(j['arrivalTime'].toString()),
        hypoCenter = (j['hypocenter'].toString() == 'null')
            ? null
            : EarthQuakeInformationHypoCenter.fromJson(
                j['hypocenter'] as Map<String, dynamic>,
              ),
        magnitude = (j['magnitude'].toString() == "null")
            ? null
            : Magnitude.fromJson(j['magnitude'] as Map<String, dynamic>),
        maxInt = (j['magnitude'].toString() == 'null')
            ? null
            : j['magnitude'].toString(),
        telegrams = List.generate(
          (j['telegrams'] as List<dynamic>).length,
          (index) => Telegram.fromJson(
            (j['telegrams'] as List<dynamic>)[index] as Map<String, dynamic>,
          ),
        );

  /// ID
  final int id;

  /// 地震情報のEvent ID
  final String eventId;

  /// 地震発生時刻
  /// 震度速報のみの場合は出現しない
  final DateTime? originTime;

  /// 地震検知時刻
  final DateTime arrivalTime;

  /// 震源要素 Earthquake component / Hypocenterを参照
  final EarthQuakeInformationHypoCenter? hypoCenter;

  /// マグニチュード要素 Earthquake component / Magnitudeを参照
  final Magnitude? magnitude;

  /// 最大震度、観測した震度がない場合はNullとする
  final String? maxInt;

  /// 地震情報の電文リスト
  final List<Telegram> telegrams;
}
