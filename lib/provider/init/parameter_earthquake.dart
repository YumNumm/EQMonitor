import 'dart:convert';

import 'package:eqmonitor/utils/talker_log/log_types.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../schema/remote/dmdata/parameter-earthquake/parameter-earthquake.dart';

final parameterEarthquakeProvider = Provider<ParameterEarthquake>((ref) {
  throw UnimplementedError('Parameter-Earthquakeが読み込まれていません');
});

Future<ParameterEarthquake> loadParameterEarthquake(Talker talker) async {
  final stopwatch = Stopwatch()..start();
  final body = await rootBundle.loadString('assets/parameter-earthquake.json');
  final json = jsonDecode(body) as Map<String, dynamic>;
  final parameter = ParameterEarthquake.fromJson(json);
  final duration = (stopwatch..stop()).elapsedMicroseconds;
  talker.logTyped(
    InitializationEventLog(
      'Parameter-Earthquakeを読み込みました: ${duration / 1000}ms',
    ),
  );
  return parameter;
}
