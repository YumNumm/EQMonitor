import 'package:isar/isar.dart';

part 'city.model.g.dart';

@Collection()
class City {
  @Id()
  late int cityCode;

  late int prefCode;

  late String cityName;
}
