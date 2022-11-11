import 'package:eqmonitor/model/database/information/information.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Information テーブルから情報を取得
class SupabaseInformationApi {
  SupabaseInformationApi();

  /// ## Information情報を取得します
  /// [limit] 結果の最大数
  /// [offset] 結果のオフセット
  static Future<List<Information>> getInformation({
    int limit = 20,
    int offset = 0,
  }) async {
    final res = await Supabase.instance.client
        .from('information')
        .select<List<Map<String, dynamic>>>()
        .order('id')
        .range(offset, offset + limit - 1);

    return <Information>[for (final e in res) Information.fromJson(e)];
  }

  /// ## Information情報を追加します
  /// [information] 追加する情報
  static Future<void> addInformation(Information information) async {
    await Supabase.instance.client
        .from('information')
        .insert(information.toJson());
  }
}
