import 'package:isar/isar.dart';

part 'eq_history.schema.g.dart';

@Collection()
class EQHistory {
  @Id()
  int? id;

  String? hash;
  @Index()
  String? type;
  @Index()
  DateTime? time;
  String? url;
  String? imageUrl;
  String? headline;
  @Index()
  String? maxint;
  @Index()
  double? magnitude;
  String? magnitudeCondition;
  @Index()
  double? depth;
  double? lat;
  double? lon;
  int? serialNo;
  String? hypoName;
}
