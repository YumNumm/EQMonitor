import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_id.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_partition.dart';

class HypocenterArchiveSelector {
  const new();

  List<HypocenterArchive> initialSelection({
    required List<HypocenterArchive> archives,
  }) {
    final days =
        archives
            .where(
              (archive) =>
                  archive.id.partition == HypocenterArchivePartition.day,
            )
            .toList()
          ..sort((a, b) => b.id.jstLabel.compareTo(a.id.jstLabel));
    return days.isEmpty ? const [] : [days.first];
  }

  List<HypocenterArchive> remap({
    required Set<HypocenterArchiveId> selected,
    required List<HypocenterArchive> archives,
  }) => archives.where((archive) => selected.contains(archive.id)).toList();

  List<HypocenterArchive>? remapComplete({
    required Set<HypocenterArchiveId> selected,
    required List<HypocenterArchive> archives,
  }) {
    final remapped = remap(selected: selected, archives: archives);
    return remapped.length == selected.length ? remapped : null;
  }
}
