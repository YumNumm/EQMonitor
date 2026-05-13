import 'dart:async';

import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

/// サンプル地震イベント（発生日時 JST）
final _sampleEvents = <_EqEvent>[
  _EqEvent(
    dateTime: DateTime(2011, 3, 11, 14, 46, 18),
    description: '東北地方太平洋沖地震 M9.0',
  ),
  _EqEvent(
    dateTime: DateTime(2016, 4, 16, 1, 25, 5),
    description: '熊本地震（本震）M7.3',
  ),
  _EqEvent(
    dateTime: DateTime(2024, 1, 1, 16, 10, 9),
    description: '令和6年能登半島地震 M7.6',
  ),
];

class _EqEvent {
  const _EqEvent({required this.dateTime, required this.description});
  final DateTime dateTime;
  final String description;
}

/// 地震イベント一覧画面
///
/// ユーザーが地震を選択すると観測点一覧画面へ遷移する。
class KnetEarthquakeListPage extends ConsumerWidget {
  const KnetEarthquakeListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fmt = DateFormat('yyyy/MM/dd HH:mm:ss');
    return Scaffold(
      appBar: AppBar(
        title: const Text('地震イベント選択'),
      ),
      body: ListView.separated(
        itemCount: _sampleEvents.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final event = _sampleEvents[index];
          return ListTile(
            leading: const Icon(Icons.vibration),
            title: Text(event.description),
            subtitle: Text(fmt.format(event.dateTime)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => unawaited(
              KnetStationListRoute(
                eventTimeMs: event.dateTime.millisecondsSinceEpoch,
              ).push<void>(context),
            ),
          );
        },
      ),
    );
  }
}
