import 'package:eqmonitor/api/supabase/telegram.dart';
import 'package:eqmonitor/schema/supabase/telegram.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EarthquakeHistoryPage extends HookConsumerWidget {
  EarthquakeHistoryPage({super.key});

  final TelegramApi telegramApi = TelegramApi();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: FutureBuilder(
        future: telegramApi.getTelegramsWithLimit(limit: 40),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final telegrams = snapshot.data as List<Telegram>;
            return ListView.builder(
              itemCount: telegrams.length,
              itemBuilder: (ctx, index) {
                final telegram = telegrams[index];
                return ListTile(
                  title: Text(
                    DateFormat('yyyy-MM-dd HH:mm頃').format(
                      telegram.time.toUtc().toLocal(),
                    ),
                  ),
                  subtitle: Text(
                    '電文タイプ: ${telegram.type}\n'
                    '電文id,hashの一部: ${telegram.id}, ${(telegram.hash).substring(0, 10)}\n'
                    'イベントID: ${telegram.eventId} 電文データの長さ: ${telegram.data?.toString().length}\n'
                    '最大震度: ${telegram.maxint} 震央: ${telegram.hypoName}\n',
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
