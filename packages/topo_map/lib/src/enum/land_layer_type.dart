import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'type')
enum LandLayerType {
  worldWithoutJapan("日本以外の全地域"),
  municipalityEarthquakeTsunamiArea("市町村等（地震津波関係）"),
  earthquakeInformationSubdivisionArea("地震情報／細分区域"),
  tsunamiForecastArea("津波予報区");

  const LandLayerType(this.type);
  final String type;

  int get multiareaGroupNo => switch (this) {
        LandLayerType.worldWithoutJapan => 0,
        LandLayerType.municipalityEarthquakeTsunamiArea => 100000,
        LandLayerType.earthquakeInformationSubdivisionArea => 10,
        LandLayerType.tsunamiForecastArea => 1,
      };

  String toJson() => name;
}
