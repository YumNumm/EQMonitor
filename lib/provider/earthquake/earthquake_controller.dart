import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/remote/supabase/telegram.dart';
import '../../schema/remote/supabase/telegram.dart';
import '../setting/developer_mode.dart';

final earthquakeHistoryFutureProvider =
    FutureProvider<Map<int, List<Telegram>>>(
  (ref) async {
    final telegrams = await TelegramApi.getTelegramsWithLimit();
    final testTelegram = <Telegram>[];
    if (kDebugMode || ref.read(developerModeProvider).isDeveloper) {
      final telegram = await TelegramApi.getTestData();
      testTelegram.addAll(telegram);
    }

    final grouped = [
      ...telegrams,
      if (kDebugMode || ref.read(developerModeProvider).isDeveloper)
        ...testTelegram,
    ]
        .where(
          (element) => <String>['VXSE51', 'VXSE52', 'VXSE53', 'VXSE61']
              .contains(element.type),
        )
        .toList()
        .sorted(
          (a, b) => int.parse(b.eventId.toString()).compareTo(
            int.parse(a.eventId.toString()),
          ),
        )
        .groupListsBy((element) => int.parse(element.eventId.toString()));

    return grouped;
  },
);
