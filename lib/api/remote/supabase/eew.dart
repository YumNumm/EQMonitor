import 'dart:convert';

import 'package:eqmonitor/private/keys.dart';
import 'package:eqmonitor/schema/remote/dmdata/commonHeader.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EewApi {
  final supabase = SupabaseClient(supabaseS1Url, supabaseS1AnonKey);
  final streamSupabase = SupabaseClient(supabaseS2Url, supabaseS2AnonKey);

  Future<List<CommonHead>> getEewTelegrams({int limit = 10}) async {
    final res =
        await supabase.from('eew').select().order('id').limit(limit).execute();
    if (res.hasError) {
      throw Exception(res.error!.toJson());
    }
    final toReturn = <CommonHead>[];
    for (final r in res.data as List) {
      toReturn.add(
        CommonHead.fromJson(
          jsonDecode((r as Map<String, dynamic>)['data'])
              as Map<String, dynamic>,
        ),
      );
    }
    return toReturn;
  }
}
