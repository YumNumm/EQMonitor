import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/remote_db/telegram.dart';
import '../../model/earthquake/earthquake_log_model.dart';
import '../../schema/supabase/telegram.dart';

final earthquakeHistoryFutureProvider =
    FutureProvider<Map<int, List<Telegram>>>((ref) async {
  final telegrams = await TelegramApi.getTelegramsWithLimit();
  return telegrams
      .where(
        (element) => <String>['VXSE51', 'VXSE52', 'VXSE53', 'VXSE61']
            .contains(element.type),
      )
      .toList()
      .groupListsBy((element) => int.parse(element.eventId.toString()));
});
