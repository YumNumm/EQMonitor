import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_id.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_partition.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_manifest.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

extension HypocenterManifestResponseConverter
    on api.HypocenterManifestResponse {
  HypocenterManifest toModel() => HypocenterManifest(
    archives: data.archives.map((archive) => archive.toModel()).toList(),
    datasetRevision: meta.datasetRevision,
    dataUpdatedAt: meta.dataUpdatedAt,
  );
}

extension HypocenterArchiveConverter on api.Archives {
  HypocenterArchive toModel() {
    final partition = switch (this.partition) {
      api.Partition.year => HypocenterArchivePartition.year,
      api.Partition.day => HypocenterArchivePartition.day,
    };
    final jst = period.from.toUtc().add(const Duration(hours: 9));
    final month = jst.month.toString().padLeft(2, '0');
    final day = jst.day.toString().padLeft(2, '0');
    final label = switch (partition) {
      HypocenterArchivePartition.year => '${jst.year}',
      HypocenterArchivePartition.day => '${jst.year}-$month-$day',
    };
    return HypocenterArchive(
      id: HypocenterArchiveId(partition: partition, jstLabel: label),
      periodFrom: period.from,
      periodTo: period.to,
      url: url,
      featureCount: featureCount,
      sizeBytes: sizeBytes,
      queryRevision: queryRevision,
    );
  }
}

extension HypocenterResponseItemConverter on api.HypocenterResponseItem {
  SeismicityEvent toModel() => SeismicityEvent(
    eventId: hypocenterId,
    originTime: originTime,
    magnitude: magnitude?.toDouble(),
    depth: depthKm?.toDouble(),
    latitude: latitude.toDouble(),
    longitude: longitude.toDouble(),
    maxIntensity: maxIntensity,
  );
}
