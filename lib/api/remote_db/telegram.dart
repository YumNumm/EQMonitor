import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../schema/supabase/telegram.dart' show Telegram;

class TelegramApi {
  final supabase = Supabase.instance.client;

  /// ## SupabaseからTelegramを取得します
  /// dataは除きます。
  /// [limit] 結果の最大数
  /// [offset] 結果のオフセット
  Future<List<Telegram>> getTelegramsWithLimit({
    int? limit = 200,
    int offset = 0,
  }) async {
    // TODO(YumNumm): Telegram取得時offsetの実装
    if (offset != 0) {
      throw UnimplementedError('Telegram offset is not implemented yet');
    }
    final PostgrestResponse<dynamic> res;
    if (limit == null) {
      res = await supabase
          .from('telegram')
          .select(
            'id,'
            'type,'
            'time,'
            'url,'
            'image_url,'
            'headline,'
            'maxint,'
            'magnitude,'
            'magnitude_condition,'
            'depth,'
            'lat,'
            'lon,'
            'serial_no,'
            'event_id,'
            'hypo_name,'
            'hash,'
            'depth_condition',
          )
          .order('id')
          .execute();
    } else {
      res = await supabase
          .from('telegram')
          .select(
            'id,'
            'type,'
            'time,'
            'url,'
            'image_url,'
            'headline,'
            'maxint,'
            'magnitude,'
            'magnitude_condition,'
            'depth,'
            'lat,'
            'lon,'
            'serial_no,'
            'event_id,'
            'hypo_name,'
            'hash,'
            'depth_condition',
          )
          .order('id')
          .limit(limit)
          .execute();
    }

    if (res.hasError) {
      throw Exception(res.error?.message);
    }
    final telegrams = <Telegram>[];
    for (final telegram in res.data) {
      telegrams.add(Telegram.fromJson(telegram));
    }
    return telegrams;
  }

  Future<int> getAllTelegramCount() async {
    final res = await supabase
        .from('telegram')
        .select('id')
        .order('id')
        .single()
        .execute(count: CountOption.exact);
    if (res.hasError || res.count == null) {
      throw Exception(res.error?.message);
    }
    return res.count!;
  }
}
