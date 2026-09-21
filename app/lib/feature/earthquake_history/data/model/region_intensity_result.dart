import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';

typedef RegionIntensityResult = ({
  RegionSearchType searchType,
  String code,
  String name,
  JmaIntensity? intensityGte,
  JmaIntensity? intensityLte,
});
