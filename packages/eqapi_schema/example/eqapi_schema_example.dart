import 'dart:convert';
import 'dart:io';

import 'package:eqapi_schema/model/telegram_v3.dart';

Future<List<TelegramV3>> main() async {
  // load file
  final file = File('test_resources/eqapi_schema_test.json');
  final jsonString = await file.readAsString();
  // parse json
  final json = jsonDecode(jsonString) as Map<String, dynamic>;
  final results = <TelegramV3>[];
  (json['results'] as Map<String, dynamic>).forEach((eventId, value) {
    final telegrams = value as List<dynamic>;
    for (final e in telegrams) {
      final telegram = TelegramV3.fromJsonAndEventID(
          e as Map<String, dynamic>, int.parse(eventId),);
      results.add(telegram);
    }
  });
  for (final e in results) {
    print('${e.runtimeType}: ${e.body is TelegramVxse53Body}');
  }
  return results;
}
