import 'package:eqmonitor/core/util/byte_size_formatter.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/action/earthquake_archive_action.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const EarthquakeArchiveListTile({
  required final EarthquakeArchive archive,
  super.key,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final magnitude = archive.magnitude?.toStringAsFixed(1) ?? '-';
    final frames = archive.frames
        .map((frame) => '${frame.kind.label} ${frame.frameCount}')
        .join(' / ');
    return ListTile(
      title: Text('M$magnitude ${archive.hypocenterName ?? '震源不明'}'),
      subtitle: Text(
        '${archive.originTime.formatWithTz(.yearMonthDayHourMinuteSecond)}'
        '・${archive.type.label}・${archive.waveformStatus.label}'
        '・${const ByteSizeFormatter().format(archive.fileSizeBytes)}\n'
        '$frames',
      ),
      isThreeLine: true,
      trailing: const Icon(Icons.chevron_right),
      onTap: () async => ref
          .read(earthquakeArchiveActionProvider)
          .openDetail(context, archive: archive),
    );
  }
}
