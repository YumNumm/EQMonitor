// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eqmonitor/schema/remote/supabase/telegram.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TelegramApi {
  /// ## SupabaseからTelegramを取得します
  /// dataは除きます。
  /// [limit] 結果の最大数
  /// [offset] 結果のオフセット
  static Future<List<Telegram>> getTelegramsWithLimit({
    int? limit = 200,
    int offset = 0,
  }) async {
    if (offset != 0) {
      throw UnimplementedError('Telegram offset is not implemented yet');
    }
    final PostgrestResponse<dynamic> res;
    if (limit == null) {
      res = await Supabase.instance.client
          .from('telegram')
          .select(
            'id,'
            'data, '
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
      res = await Supabase.instance.client
          .from('telegram')
          .select(
            'id,'
            'type,'
            'data, '
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
      throw HttpException(res.error?.message ?? '原因不明のエラー');
    }
    final telegrams = <Telegram>[];
    for (final telegram in res.data) {
      telegrams.add(Telegram.fromJson(telegram));
    }
    return telegrams;
  }

  static Future<List<Telegram>> getTestData() async {
    final urls = <String>[
      'https://sample.dmdata.jp/conversion/json/schema/earthquake-information/vxse53_rjtd_20210213231302.json',
      'https://sample.dmdata.jp/conversion/json/schema/earthquake-information/vxse53_rjtd_20210213231800.json',
    ];
    final telegrams = <Telegram>[];
    final futures = <Future<void>>[];
    for (final url in urls) {
      futures.add(
        Dio()
            .get(
              url,
            )
            .then(
              (res) => telegrams.add(
                Telegram(
                  data: res.data as Map<String, dynamic>,
                  type: 'VXSE53',
                  time: DateTime.now(),
                  url:
                      'https://sample.dmdata.jp/conversion/json/schema/earthquake-information/vxse53_rjtd_20210213231800.json',
                  depth: null,
                  depthCondition: null,
                  eventId: '202102132318000',
                  hash: '',
                  headline: '',
                  hypoName: null,
                  id: null,
                  imageUrl: null,
                  lat: null,
                  lon: null,
                  magnitude: null,
                  magnitudeCondition: null,
                  maxint: null,
                  serialNo: null,
                ),
              ),
            ),
      );
    }
    await Future.wait(futures);
    return telegrams;
  }

  static Future<int> getAllTelegramCount() async {
    final res = await Supabase.instance.client
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
