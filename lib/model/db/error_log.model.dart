import 'package:isar/isar.dart';

part 'error_log.model.g.dart';

@Collection()
class ErrorLog {
  @Id()
  int? code;

  String? payload;

  @Index()
  DateTime? createdAt;
}
