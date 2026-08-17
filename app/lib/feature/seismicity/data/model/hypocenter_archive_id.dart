import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_partition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hypocenter_archive_id.freezed.dart';

@freezed
abstract class HypocenterArchiveId with _$HypocenterArchiveId {
  const factory({
    required HypocenterArchivePartition partition,
    required String jstLabel,
  }) = _HypocenterArchiveId;
}
