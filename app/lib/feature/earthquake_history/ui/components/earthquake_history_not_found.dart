import 'package:flutter/material.dart';

class EarthquakeHistoryNotFound extends StatelessWidget {
  const EarthquakeHistoryNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const before2021 = Text(
      '2021年11月18日以前の地震情報は、本アプリでは扱っていません。',
      textAlign: TextAlign.center,
    );
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
            before2021,
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
    const before2021 = Text(
      '2021年11月18日以前の地震情報は、本アプリでは扱っていません。',
      textAlign: TextAlign.center,
    );
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
              before2021,
            ],
          ),
        ),
      ),
    );
  }
}
