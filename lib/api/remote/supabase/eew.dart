import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../env/env.dart';
import '../../../schema/remote/dmdata/commonHeader.dart';

class EewApi {
  final supabase = SupabaseClient(Env.supabaseS1Url, Env.supabaseS1AnonKey);
  final streamSupabase =
      SupabaseClient(Env.supabaseS2Url, Env.supabaseS2AnonKey);

  Future<List<CommonHead>> getEewTelegrams({int limit = 10}) async {
    final res = await supabase.from('eew').select().order('id').limit(limit);

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
