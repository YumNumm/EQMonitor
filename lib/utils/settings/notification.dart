import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 10)
class NotificationSettings extends HiveObject {
  @HiveField(0)
  List<EQLevel> notifyLevel;
  NotificationSettings({
    required this.notifyLevel,
    required this.isDeveloper,
  });
  @HiveField(1)
  bool isDeveloper;
}

enum EQLevel {
  zero,
  one,
  two,
  three,
  four,
  five,
  fiveplus,
  six,
  sixplus,
  seven
}
