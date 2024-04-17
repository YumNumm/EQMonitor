import 'package:eqapi_types/eqapi_types.dart';

extension EarthquakeV1Ex on EarthquakeV1 {
  bool get isVolcano =>
      (text?.contains('大規模な噴火が発生しました') ?? false) &&
      (text?.contains('実際には、規模の大きな地震は発生していない点に留意') ?? false);

  String? get volcanoName {
    if (!isVolcano) {
      return null;
    }

    final splitted = text?.split('分頃（日本時間）に') ?? [];
    if (splitted.length != 2) {
      return null;
    }
    return splitted[1].split('で大規模な噴火が発生しました')[0];
  }
}
