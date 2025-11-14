# NIED API Client

防災科学技術研究所（NIED）のAPI向けDart/Flutterクライアントライブラリ

## 機能

### Hi-net AQUA System

AQUAシステム（Accurate and QUick Analysis System for Source Parameters）のメカニズム解カタログからデータを取得・解析します。

## 使用方法

### 基本的な使用方法

```dart
import 'package:dio/dio.dart';
import 'package:nied_api_client/nied_api_client.dart';

void main() async {
  final client = NiedApiClient(dio: Dio());

  // パラメータのバリデーション
  AquaCatalogValidator.validateYearMonth(2025, 9);

  // カタログHTML取得
  final response = await client.hinet.aqua.catalogue.getCatalogHtml(
    year: 2025,
    month: 9,
    lang: Language.japanese.code,
  );

  // HTMLパース
  final parser = AquaHtmlParser();
  final events = parser.parseCatalog(response.data);

  for (final event in events) {
    print('${event.originTime}: ${event.region} M${event.magnitude}');

    // 発震機構解がある場合
    if (event.focalMechanism != null) {
      print('  Strike: ${event.focalMechanism!.nodalPlane1.strike}°');
      print('  Dip: ${event.focalMechanism!.nodalPlane1.dip}°');
      print('  Rake: ${event.focalMechanism!.nodalPlane1.rake}°');
    }
  }
}
```

### 発震機構解画像URL生成

```dart
final client = NiedApiClient(dio: Dio());

// 通常画像
final normalUrl = client.hinet.aqua.focalMechanism.normal(
  id: '20251103000018',
  type: AquaEventType.cmt,
);
// https://www.hinet.bosai.go.jp/hypo/AQUA/AQUA-CMT/2025/11/20251103000018.png

// 詳細画像
final detailUrl = client.hinet.aqua.focalMechanism.detail(
  id: '20251103000018',
  type: AquaEventType.cmt,
);
// https://www.hinet.bosai.go.jp/hypo/AQUA/AQUA-CMT/2025/11/20251103000018.d.png
```

### 最新データの取得

```dart
// year, monthを両方nullにすると最新のデータを取得
final response = await client.hinet.aqua.catalogue.getCatalogHtml(
  year: null,
  month: null,
  lang: Language.japanese.code,
);
```

### パラメータの制約

- `year`, `month` は両方null または両方not null
- `year >= 2004`
- `year == 2004` の場合 `month >= 8`
- `1 <= month <= 12`

これらの制約は `AquaCatalogValidator.validateYearMonth()` で検証できます。

## ビルド

コード生成を実行：

```bash
dart run build_runner build --delete-conflicting-outputs
```

## テスト

```bash
dart test
```

## データソース

- [Hi-net AQUA システム](https://www.hinet.bosai.go.jp/AQUA/)
- 利用可能期間: 2004年8月〜

## ライセンス

このパッケージは防災科研のデータを利用しています。データの利用規約については[Hi-netのウェブサイト](https://www.hinet.bosai.go.jp/)をご確認ください。
