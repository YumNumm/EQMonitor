import 'package:jma_eew_xml/src/model/jma_coordinate.dart';

final class const JmaEewEarthquake({
  required final DateTime? originTime,
  required final DateTime arrivalTime,
  required final String? condition,
  required final JmaEewHypocenter hypocenter,
  required final JmaEewMagnitude magnitude,
}) {
  static const assumedHypocenterCondition = '仮定震源要素';

  bool get isAssumedHypocenter => condition == assumedHypocenterCondition;
}

final class const JmaEewHypocenter({
  required final String code,
  required final String name,
  required final JmaCoordinate? coordinate,
  required final String? coordinateDescription,
  required final String? reduceCode,
  required final String? reduceName,
  required final String? landOrSea,
  required final JmaEewAccuracy? accuracy,
});

final class const JmaEewAccuracy({
  required final int epicenterRank,
  required final int epicenterRank2,
  required final int depthRank,
  required final int magnitudeCalculationRank,
  required final int numberOfMagnitudeCalculation,
});

final class const JmaEewMagnitude({
  required final double? value,
  required final String? type,
  required final String? condition,
  required final String? description,
});
