import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/provider/init/application_support_dir.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../schema/dmdata/parameter-earthquake/parameter-earthquake.dart';

final parameterEarthquakeProvider = Provider<ParameterEarthquake>((ref) {
  throw UnimplementedError('Parameter-Earthquakeが読み込まれていません');
});

final parameterEarthquakeFutureProvider =
    FutureProvider<ParameterEarthquake>((ref) {
  final dir = ref.read(applicationSupportDirectoryProvider);
  final paramFile = File('${dir.path}/parameter-earthquake.json');
  final paramArvFile = File('${dir.path}/parameter-earthquake-arv.json');
  // 読み込む
  final stopwatch = Stopwatch()..start();
  final param = json.decode(utf8.decode(paramFile.readAsBytesSync()))
      as Map<String, dynamic>;
  final paramArv = json.decode(utf8.decode(paramArvFile.readAsBytesSync()));
  Logger().d('Parameter-Earthquakeを読み込みました: ${stopwatch.elapsedMicroseconds / 1000}ms');
  return ParameterEarthquake.fromTwoJson(param, paramArv);
});

Future<ParameterEarthquake> loadParameterEarthquake() async {
  final stopwatch = Stopwatch()..start();
  final body = await rootBundle.loadString('assets/parameter-earthquake.json');
  final json = jsonDecode(body) as Map<String, dynamic>;
  final parameter = ParameterEarthquake.fromJson(json);
  final duration = (stopwatch..stop()).elapsedMicroseconds;
  Logger().d('Parameter-Earthquakeを読み込みました: ${duration / 1000}ms');
  return parameter;
}
