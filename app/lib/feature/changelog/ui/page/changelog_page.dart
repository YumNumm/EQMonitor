import 'dart:async';

import 'package:eqmonitor/feature/changelog/data/notifier/changelog_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ChangelogPage extends ConsumerStatefulWidget {
  const ChangelogPage({super.key});

  @override
  ConsumerState<ChangelogPage> createState() => _ChangelogPageState();
}

class _ChangelogPageState extends ConsumerState<ChangelogPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(ref.read(changelogProvider.notifier).fetch());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(changelogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('変更履歴')),
      body: switch (state) {
        AsyncLoading() => const Center(child: CircularProgressIndicator.adaptive()),
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
                onPressed: () =>
                    ref.read(changelogProvider.notifier).fetch(),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
        AsyncData(:final value) when value == null => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        AsyncData(:final value) => _ChangelogList(entries: value!.entries),
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
      itemBuilder: (context, index) => _ChangelogEntryCard(
        entry: entries[index],
      ),
    );
  }
}

class _ChangelogEntryCard extends StatelessWidget {
  const _ChangelogEntryCard({required this.entry});

  final api.ChangelogEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('yyyy年MM月dd日').format(entry.date.toLocal());

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
    final theme = Theme.of(context);
    final markdownContent =
        '### ${section.title}\n\n${section.items.map((i) => '- $i').join('\n')}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MarkdownBody(
        data: markdownContent,
        styleSheet: MarkdownStyleSheet.fromTheme(theme),
      ),
    );
  }
}
