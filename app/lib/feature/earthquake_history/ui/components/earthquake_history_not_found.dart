import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/earthquake_history_early_screen.dart';
import 'package:flutter/material.dart';

class EarthquakeHistoryNotFound extends StatelessWidget {
  const EarthquakeHistoryNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 48,
            ),
            const Text(
              '条件を満たす地震情報は見つかりませんでした',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              '2020年11月18日以降の地震情報は、震度データベースで検索できます',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            FilledButton(
              onPressed: () =>
                  const EarthquakeHistoryEarlyRoute().push<void>(context),
              child: const Text('震度データベース'),
            ),
          ],
        ),
      ),
    );
  }
}

class EarthquakeHistoryAllFetched extends StatelessWidget {
  const EarthquakeHistoryAllFetched({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search,
                size: 48,
              ),
              const Text(
                '全件取得済みです',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                '2020年11月18日以降の地震情報は、震度データベースで検索できます',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              FilledButton(
                onPressed: () =>
                    const EarthquakeHistoryEarlyRoute().push<void>(context),
                child: const Text('震度データベース'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
