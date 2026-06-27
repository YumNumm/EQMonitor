import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/similarity_level.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'similar_earthquake_item.freezed.dart';

@freezed
abstract class SimilarEarthquakeItem with _$SimilarEarthquakeItem {
  const factory SimilarEarthquakeItem({
    required EarthquakePartial earthquake,
    required double score,
    required SimilarityLevel level,
    required List<EarthquakePartial> groupedEarthquakes,
  }) = _SimilarEarthquakeItem;
}

extension SimilarEarthquakeItemApiExtension on api.SimilarEarthquakeItem {
  SimilarEarthquakeItem toSimilarEarthquakeItem({
    required EarthquakeParameter parameter,
  }) =>
      SimilarEarthquakeItem(
        earthquake: earthquake.toEarthquakePartial(parameter: parameter),
        score: score.toDouble(),
        level: SimilarityLevel.fromScore(score.toDouble()),
        groupedEarthquakes: groupedEarthquakes
            .map((e) => e.toEarthquakePartial(parameter: parameter))
            .toList(),
      );
}
