import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/util/byte_size_formatter.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/action/earthquake_archive_action.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive_exception.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/notifier/earthquake_archive_download_notifier.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/provider/earthquake_archive_detail_provider.dart';
import 'package:eqmonitor/feature/earthquake_archive/ui/components/earthquake_archive_error_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class const EarthquakeArchiveDetailPage({
  required final String eventId,
  super.key,
}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = earthquakeArchiveDetailProvider(eventId: eventId);
    final archiveAsync = ref.watch(provider);
    return Scaffold(
      appBar: AppBar(title: Text(eventId)),
      body: switch (archiveAsync) {
        AsyncData(:final value) => _ArchiveDetail(archive: value),
        AsyncError(:final error) => EarthquakeArchiveErrorView(
          message: switch (error) {
            EarthquakeArchiveException(:final failure) => failure.message,
            _ => EarthquakeArchiveFailure.unknown.message,
          },
          onRetry: () => ref.invalidate(provider),
        ),
        _ => const Center(child: AccessibleCircularProgressIndicator()),
      },
    );
  }
}

class const _ArchiveDetail({required final EarthquakeArchive archive})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const bytes = ByteSizeFormatter();
    const timeFormat = DateTimeFormat.yearMonthDayHourMinuteSecond;
    return ListView(
      children: [
        _DownloadButtons(archive: archive),
        const Divider(),
        ListTile(
          title: const Text('震源・M'),
          subtitle: Text(
            '${archive.hypocenterName ?? '震源不明'}'
            '　M${archive.magnitude?.toStringAsFixed(1) ?? '-'}',
          ),
        ),
        ListTile(
          title: const Text('発生時刻'),
          subtitle: Text(archive.originTime.formatWithTz(timeFormat)),
        ),
        ListTile(
          title: const Text('区間'),
          subtitle: Text(
            '${archive.startTime.formatWithTz(timeFormat)}'
            ' 〜 ${archive.endTime.formatWithTz(timeFormat)}',
          ),
        ),
        ListTile(
          title: const Text('種別・波形'),
          subtitle: Text(
            '${archive.type.label}・${archive.waveformStatus.label}',
          ),
        ),
        ListTile(
          title: const Text('ファイル'),
          subtitle: Text(
            '${archive.fileName}\n${bytes.format(archive.fileSizeBytes)}',
          ),
          isThreeLine: true,
        ),
        const Divider(),
        for (final frame in archive.frames)
          ListTile(
            title: Text('${frame.kind.label}（${frame.frameType}）'),
            subtitle: Text(
              '${frame.frameCount} フレーム・${bytes.format(frame.totalBytes)}\n'
              '${frame.firstTime.formatWithTz(timeFormat)}'
              ' 〜 ${frame.lastTime.formatWithTz(timeFormat)}',
            ),
            isThreeLine: true,
          ),
      ],
    );
  }
}

class const _DownloadButtons({required final EarthquakeArchive archive})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDownloading = ref.watch(
      EarthquakeArchiveDownloadNotifier.downloadMutation,
    ) is MutationPending;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: isDownloading
          ? const Center(child: AccessibleCircularProgressIndicator())
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () async => ref
                      .read(earthquakeArchiveActionProvider)
                      .download(ref, context, archive: archive, play: true),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('保存して再生'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () async => ref
                      .read(earthquakeArchiveActionProvider)
                      .download(ref, context, archive: archive, play: false),
                  icon: const Icon(Icons.download_rounded),
                  label: const Text('保存のみ'),
                ),
              ],
            ),
    );
  }
}
