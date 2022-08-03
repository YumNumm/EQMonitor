import 'dart:convert';

import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EewApi {
  final supabase = Supabase.instance.client;

  // ## SupabaseからEewをStreamで取得します
  // eewテーブル
  Stream<CommonHead> eewStream() async* {
    // 5秒待機
    await Future<void>.delayed(const Duration(seconds: 5));
    // もし、デバッグモードならテスト電文を追加
    if (kDebugMode) {
      final res = await http.get(
        Uri.parse(
          'https://sample.dmdata.jp/eew/20171213b/json/vxse44_rjtd_20171213112257.json',
        ),
      );
      yield CommonHead.fromJson(
        jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>,
      );
    }
    final subscription =
        supabase.from('eew').on(SupabaseEventTypes.all, (payload) {
      Logger().i('commitDt: ${payload.commitTimestamp}\n${payload.newRecord}');
      if (payload.eventType == 'INSERT') {}
    });
  }
}
