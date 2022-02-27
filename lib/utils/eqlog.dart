import 'package:intl/intl.dart';

class EQLog {
  final DateTime time;
  final String place;
  final double magunitude;
  final String maxIntensity;
  EQLog({
    required this.time,
    required this.place,
    required this.magunitude,
    required this.maxIntensity,
  });

  EQLog.fromList(List<String> l)
      : time = DateFormat('yyyy年MM月dd日 HH時mm分ごろ').parseStrict(l[0]),
        place = l[1],
        magunitude = double.parse(l[2]),
        maxIntensity = l[3];
}
