import 'package:collection/collection.dart';
import 'package:eqmonitor/api/remote/supabase/telegram.dart';
import 'package:eqmonitor/schema/remote/supabase/telegram.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final earthquakeHistoryFutureProvider =
    FutureProvider<Map<int, List<Telegram>>>(
  (ref) async {
    final telegrams = await TelegramApi.getTelegramsWithLimit();

    final grouped = telegrams
        .where(
          (element) => <String>['VXSE51', 'VXSE52', 'VXSE53', 'VXSE61']
              .contains(element.type),
        )
        .toList()
        .groupListsBy((element) => int.parse(element.eventId.toString()));
    return grouped;
  },
);
