import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../schema/setting/change_log.dart';
import '../init/dio.dart';

final changeLogProvider = FutureProvider<ChangeLog>((ref) async {
  final res = await ref.read(dioProvider).get(
        'https://raw.githubusercontent.com/EQMonitor/EQMonitor/main/changelog.json',
      );
  return ChangeLog.fromJson(json.decode(res.data));
});

final changeLogMockProvider = FutureProvider<ChangeLog>((ref) async {
  return ChangeLog(
    items: [
      ChangeLogItem(
        version: '1.0.0',
        buildId: 1000,
        isBreakingChange: true,
        comment: '#新機能\n - これはテストバージョン',
        date: DateTime.now(),
        url:
            'https://raw.githubusercontent.com/EQMonitor/EQMonitor/main/changelog.json',
      )
    ],
  );
});
