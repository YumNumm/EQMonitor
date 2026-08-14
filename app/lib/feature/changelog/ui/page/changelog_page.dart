// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'package:eqmonitor/feature/changelog/data/notifier/changelog_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:material_ui/material_ui.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ChangelogPage extends ConsumerWidget {
  const ChangelogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(changelogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('変更履歴')),
      body: switch (state) {
        AsyncLoading() => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        AsyncError(:final error) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              const Text('読み込みに失敗しました'),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: () => ref.invalidate(changelogProvider),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
        AsyncData(:final value) => _ChangelogList(entries: value.entries),
      },
    );
  }
}

class _ChangelogList extends StatelessWidget {
  const _ChangelogList({required this.entries});

  final List<api.ChangelogEntry> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const Center(child: Text('変更履歴はありません'));
    }
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 32),
      itemCount: entries.length,
      itemBuilder: (context, index) =>
          ChangelogEntryCard(entry: entries[index]),
    );
  }
}

class ChangelogEntryCard extends StatelessWidget {
  const ChangelogEntryCard({required this.entry, super.key});

  final api.ChangelogEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('yyyy年MM月dd日').format(entry.date.toLocal());
    final content = entry.content;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'v${entry.version}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(dateStr, style: theme.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 8),
          if (content != null && content.isNotEmpty)
            _ThemedMarkdownBody(data: content)
          else
            for (final section in entry.sections)
              _SectionWidget(section: section),
          const Divider(),
        ],
      ),
    );
  }
}

class _SectionWidget extends StatelessWidget {
  const _SectionWidget({required this.section});

  final api.ChangelogSection section;

  @override
  Widget build(BuildContext context) {
    final markdownContent =
        '### ${section.title}\n\n${section.items.map((i) => '- $i').join('\n')}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _ThemedMarkdownBody(data: markdownContent),
    );
  }
}

/// `flutter_markdown` は Flutter 本体の `ThemeData` を要求するため、
/// material_ui へ移行したアプリのテーマを直接渡せない。
/// テキストスタイルのみを明示的に受け渡して配色崩れを防ぐ。
class _ThemedMarkdownBody extends StatelessWidget {
  const _ThemedMarkdownBody({required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MarkdownBody(
      data: data,
      styleSheet: MarkdownStyleSheet(
        p: textTheme.bodyMedium,
        h1: textTheme.headlineSmall,
        h2: textTheme.titleLarge,
        h3: textTheme.titleMedium,
        h4: textTheme.titleSmall,
        h5: textTheme.titleSmall,
        h6: textTheme.titleSmall,
        listBullet: textTheme.bodyMedium,
        strong: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        em: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
        a: textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline),
        code: textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
      ),
    );
  }
}
