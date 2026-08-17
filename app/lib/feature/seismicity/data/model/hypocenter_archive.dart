import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hypocenter_archive.freezed.dart';

@freezed
abstract class HypocenterArchive with _$HypocenterArchive {
  const factory({
    required HypocenterArchiveId id,
    required DateTime periodFrom,
    required DateTime periodTo,
    required String url,
    required int featureCount,
    required int sizeBytes,
    required String queryRevision,
  }) = _HypocenterArchive;
}
