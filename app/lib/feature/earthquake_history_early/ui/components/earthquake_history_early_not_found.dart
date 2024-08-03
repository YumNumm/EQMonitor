import 'package:flutter/material.dart';

class EarthquakeHistoryEarlyNotFound extends StatelessWidget {
  const EarthquakeHistoryEarlyNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
            ),
            Text(
              '条件を満たす地震情報は見つかりませんでした。',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class EarthquakeHistoryEarlyAllFetched extends StatelessWidget {
  const EarthquakeHistoryEarlyAllFetched({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 48,
              ),
              Text(
                '全件取得済みです。',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
