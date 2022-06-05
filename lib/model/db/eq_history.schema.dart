import 'package:isar/isar.dart';

part 'eq_history.schema.g.dart';

@Collection()
class EQHistory {
  @Id()
  int? id;

  String? hash;
  String? type;
  DateTime? time;
  String? url;
  String? imageUrl;
  String? headline;
  String? maxint;
  double? magnitude;
  String? magnitudeCondition;
  double? depth;
  double? lat;
  double? lon;
  int? serialNo;
  String? hypoName;
}
