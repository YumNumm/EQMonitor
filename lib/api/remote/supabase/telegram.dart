// ignore_for_file: avoid_classes_with_only_static_members

import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TelegramItem {
  TelegramItem({
    required this.telegram,
    required this.type,
  });
  final TelegramJsonMain telegram;
  final String type;
}

class TelegramApi {
  static Future<List<TelegramItem>> getTelegramsRangeV2({
    int limit = 20,
    int offset = 0,
  }) async {
    final res = await Supabase.instance.client
        .from('telegram_v2')
        .select<List<Map<String, dynamic>>>('type, data')
        .order('id')
        .range(offset, offset + limit - 1);

    final telegrams = <TelegramItem>[];

    for (final e in res) {
      telegrams.add(
        TelegramItem(
          telegram: TelegramJsonMain.fromJson(
            e['data'] as Map<String, dynamic>,
          ),
          type: e['type'].toString(),
        ),
      );
    }

    return telegrams;
  }
}
