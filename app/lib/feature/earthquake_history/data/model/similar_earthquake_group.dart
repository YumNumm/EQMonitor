import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/similarity_grade.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'similar_earthquake_group.freezed.dart';

/// 類似地震グループ。
///
/// `representative`はグループ内で最大マグニチュードの代表地震、
/// `groupedEarthquakes`は代表を除く同一グループの地震。
/// `score`はグループ内の最小スコア(km相当の距離スコア、小さいほど類似)。
@freezed
abstract class SimilarEarthquakeGroup with _$SimilarEarthquakeGroup {
  const factory SimilarEarthquakeGroup({
    required EarthquakePartial representative,
    required num score,
    required List<EarthquakePartial> groupedEarthquakes,
  }) = _SimilarEarthquakeGroup;

  const SimilarEarthquakeGroup._();

  /// `score`から導出した類似度グレード。
  SimilarityGrade get grade => SimilarityGrade.fromScore(score);
}

extension SimilarEarthquakeItemApiExtension on api.SimilarEarthquakeItem {
  SimilarEarthquakeGroup toSimilarEarthquakeGroup({
    required EarthquakeParameter parameter,
  }) => SimilarEarthquakeGroup(
    representative: earthquake.toEarthquakePartial(parameter: parameter),
    score: score,
    groupedEarthquakes: groupedEarthquakes
        .map((e) => e.toEarthquakePartial(parameter: parameter))
        .toList(),
  );
}
