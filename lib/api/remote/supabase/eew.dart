import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../env/env.dart';
import '../../../schema/remote/dmdata/commonHeader.dart';

class EewApi {
  final supabase = SupabaseClient(Env.supabaseS1Url, Env.supabaseS1AnonKey);

  Future<List<CommonHead>> getEewTelegrams({int limit = 10}) async {
    final res = await supabase
        .from('eew')
        .select<List<Map<String, dynamic>>>()
        .order('id')
        .limit(limit);
    final toReturn = <CommonHead>[];
    for (final r in res) {
      toReturn.add(
        CommonHead.fromJson(
          jsonDecode(r['data']) as Map<String, dynamic>,
        ),
      );
    }
    return toReturn;
  }
}
