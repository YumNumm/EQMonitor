import 'dart:convert';

import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';
import 'package:eqmonitor/provider/telegram_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../env/env.dart';

class EewApi {
  final supabase = SupabaseClient(Env.supabaseS1Url, Env.supabaseS1AnonKey);

  Future<List<EewTelegram>> getEewTelegrams({int limit = 3}) async {
    final res = await supabase
        .from('eew')
        .select<List<Map<String, dynamic>>>()
        .order('id')
        .limit(limit);
    final toReturn = <EewTelegram>[];
    for (final r in res) {
      final payload = TelegramJsonMain.fromJson(
        jsonDecode(r['data'].toString()) as Map<String, dynamic>,
      );
      toReturn.add(
        EewTelegram(payload, EewInformation.fromJson(payload.body)),
      );
    }
    return toReturn;
  }
}
