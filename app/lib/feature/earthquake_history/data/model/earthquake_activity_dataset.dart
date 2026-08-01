import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_activity_dataset.freezed.dart';

@freezed
abstract class EarthquakeActivityDataset with _$EarthquakeActivityDataset {
  const factory EarthquakeActivityDataset({
    required List<EarthquakePartialNormal> items,
    required DateTime fetchedAt,
  }) = _EarthquakeActivityDataset;
}
