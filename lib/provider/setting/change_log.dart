import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../schema/setting/change_log.dart';
import '../init/dio.dart';

final changeLogProvider = FutureProvider<ChangeLog>((ref) async {
  final res = await ref.read(DioProvider).get<Map<String,dynamic>>(
        'https://raw.githubusercontent.com/EQMonitor/EQMonitor/main/changelog.json',
      );
  return ChangeLog.fromJson(res.data as Map<String, dynamic>);
});

final changeLogMockProvider = FutureProvider<ChangeLog>((ref) async {
  return ChangeLog(
    items: [
      ChangeLogItem(
        version: '1.0.0',
        buildId: 1000,
        isBreakingChange: true,
        comment: '',
        date: DateTime.now(),
        url:
            'https://raw.githubusercontent.com/EQMonitor/EQMonitor/main/changelog.json',
      )
    ],
  );
});
