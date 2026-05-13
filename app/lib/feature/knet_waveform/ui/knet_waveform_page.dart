import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_credentials_provider.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_directory_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class KnetWaveformPage extends ConsumerWidget {
  const KnetWaveformPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credentials = ref.watch(knetCredentialsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('K-NET 強震波形'),
      ),
      body: credentials.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
        data: (data) {
          if (data == null) {
            return _UnconfiguredView(
              onSetup: () =>
                  const KnetCredentialsSettingsRoute().push<void>(context),
            );
          }
          return _ConfiguredView(userId: data.userId);
        },
      ),
    );
  }
}

class _UnconfiguredView extends StatelessWidget {
  const _UnconfiguredView({required this.onSetup});

  final VoidCallback onSetup;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'BOSAI 認証情報が未設定です',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '防災科研の強震波形データをダウンロードするには、'
              ' 事前に NIED のサイトでユーザー登録を行い、'
              ' 認証情報を設定してください。',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onSetup,
              icon: const Icon(Icons.settings),
              label: const Text('認証情報を設定する'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfiguredView extends StatelessWidget {
  const _ConfiguredView({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sensors,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'K-NET/KiK-net 強震観測網',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'ユーザー: $userId',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => _openYearPicker(context),
              icon: const Icon(Icons.image_search),
              label: const Text('PNG図・MP4動画を表示'),
            ),
            const SizedBox(height: 12),
            FilledButton.tonalIcon(
              onPressed: () => _openYearPickerForRecords(context),
              icon: const Icon(Icons.sensors),
              label: const Text('観測点一覧・波形を表示'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () =>
                  const KnetCredentialsSettingsRoute().push<void>(context),
              icon: const Icon(Icons.settings),
              label: const Text('認証設定'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openYearPickerForRecords(BuildContext context) async {
    final year = await showDialog<int>(
      context: context,
      builder: (_) => const _YearPickerDialog(),
    );
    if (year == null || !context.mounted) {
      return;
    }

    final month = await showDialog<int>(
      context: context,
      builder: (_) => _MonthPickerDialog(year: year),
    );
    if (month == null || !context.mounted) {
      return;
    }

    final eventTime = await showDialog<DateTime>(
      context: context,
      builder: (_) => _RecordPickerDialog(year: year, month: month),
    );
    if (eventTime == null || !context.mounted) {
      return;
    }

    await KnetRecordListRoute($extra: eventTime).push<void>(context);
  }

  Future<void> _openYearPicker(BuildContext context) async {
    final year = await showDialog<int>(
      context: context,
      builder: (_) => const _YearPickerDialog(),
    );
    if (year == null || !context.mounted) {
      return;
    }

    final month = await showDialog<int>(
      context: context,
      builder: (_) => _MonthPickerDialog(year: year),
    );
    if (month == null || !context.mounted) {
      return;
    }

    final eventTime = await showDialog<DateTime>(
      context: context,
      builder: (_) => _RecordPickerDialog(year: year, month: month),
    );
    if (eventTime == null || !context.mounted) {
      return;
    }

    await KnetMediaRoute($extra: eventTime).push<void>(context);
  }
}

// ---------------------------------------------------------------------------
// Year picker dialog
// ---------------------------------------------------------------------------

class _YearPickerDialog extends ConsumerWidget {
  const _YearPickerDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yearsAsync = ref.watch(knetYearsProvider);
    return AlertDialog(
      title: const Text('年を選択'),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      content: SizedBox(
        width: double.maxFinite,
        child: yearsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('エラー: $e')),
          data: (years) {
            final reversed = years.reversed.toList();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: reversed.length,
              itemBuilder: (context, i) {
                final y = reversed[i];
                return ListTile(
                  title: Text('$y年'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).pop(y),
                );
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Month picker dialog
// ---------------------------------------------------------------------------

class _MonthPickerDialog extends ConsumerWidget {
  const _MonthPickerDialog({required this.year});

  final int year;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthsAsync = ref.watch(knetMonthsProvider(year));
    return AlertDialog(
      title: Text('$year年 — 月を選択'),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      content: SizedBox(
        width: double.maxFinite,
        child: monthsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('エラー: $e')),
          data: (months) {
            final reversed = months.reversed.toList();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: reversed.length,
              itemBuilder: (context, i) {
                final m = reversed[i];
                return ListTile(
                  title: Text('$m月'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).pop(m),
                );
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Record picker dialog (searchable)
// ---------------------------------------------------------------------------

class _RecordPickerDialog extends ConsumerStatefulWidget {
  const _RecordPickerDialog({required this.year, required this.month});

  final int year;
  final int month;

  @override
  ConsumerState<_RecordPickerDialog> createState() =>
      _RecordPickerDialogState();
}

class _RecordPickerDialogState extends ConsumerState<_RecordPickerDialog> {
  final _formatter = DateFormat('MM/dd HH:mm:ss');
  var _query = '';

  @override
  Widget build(BuildContext context) {
    final recordsAsync =
        ref.watch(knetRecordsProvider(widget.year, widget.month));
    return AlertDialog(
      title: Text('${widget.year}年${widget.month}月 — 記録を選択'),
      contentPadding: const EdgeInsets.only(top: 8),
      content: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.6,
        child: recordsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('エラー: $e')),
          data: (records) {
            final filtered = _query.isEmpty
                ? records
                : records.where((dt) {
                    return _formatter.format(dt).contains(_query);
                  }).toList();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: '時刻で絞り込む',
                      prefixIcon: Icon(Icons.search),
                      isDense: true,
                    ),
                    onChanged: (v) => setState(() => _query = v),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final dt = filtered[i];
                      return ListTile(
                        dense: true,
                        title: Text(_formatter.format(dt)),
                        onTap: () => Navigator.of(context).pop(dt),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
      ],
    );
  }
}
