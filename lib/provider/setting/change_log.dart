import 'package:eqmonitor/provider/init/dio.dart';
import 'package:eqmonitor/schema/setting/change_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeLogProvider = FutureProvider<ChangeLog>((ref) async {
  final res = await ref.read(DioProvider).get(
        'https://raw.githubusercontent.com/EQMonitor/EQMonitor/main/changelog.json',
      );
  return ChangeLog.fromJson(res.data as Map<String, dynamic>);
});

