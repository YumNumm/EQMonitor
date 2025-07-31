import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/eew/data/eew_by_event_id.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EewDetailsByEventIdPage extends HookConsumerWidget {
  const EewDetailsByEventIdPage({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eewsAsyncValue = ref.watch(eewsByEventIdProvider(eventId));

    return Scaffold(
      appBar: AppBar(title: const Text('緊急地震速報の履歴')),
      body: eewsAsyncValue.when(
        data: (eews) {
          if (eews.isEmpty) {
            return const Center(child: Text('データがありません'));
          }
          // serial_no の昇順でソート
          final sortedEews = useMemoized(
            () => eews.sorted(
              (a, b) => (a.serialNo ?? 0).compareTo(b.serialNo ?? 0),
            ),
            [eews],
          );
          return EewTable(eews: sortedEews);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorCard(
          error: error,
          onReload: () async => ref.refresh(eewsByEventIdProvider(eventId)),
        ),
      ),
    );
  }
}
