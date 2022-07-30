import 'dart:convert';

import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class EewApi {
  final supabase = Supabase.instance.client;

  /// ## SupabaseからEewをStreamで取得します
  /// eewテーブル
  Stream<CommonHead> eewStream() async* {
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
    final res = supabase
        .from('eew')
        .stream(['id'])
        .limit(5)
        .order('id', ascending: true)
        .execute();
    await for (final telegrams in res) {
      for (final telegram in telegrams) {
        yield CommonHead.fromJson(
          jsonDecode(telegram['data']) as Map<String, dynamic>,
        );
      }
    }
  }
}
