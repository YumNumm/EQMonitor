# Similar Earthquake UI Design

## Summary

地震履歴詳細シートの最下部に「類似している地震」セクションを追加する。
バックエンド API `GET /v2/earthquake/{eventId}/similar` のレスポンスを表示し、
余震グループは折りたたみ式で展開可能にする。

## API Endpoint

`GET /v2/earthquake/{eventId}/similar`

### Response

```json
{
  "items": [
    {
      "earthquake": { /* EarthquakePartial */ },
      "score": 42.3,
      "grouped_earthquakes": [ /* EarthquakePartial[] */ ]
    }
  ]
}
```

- `items`: スコア昇順、最大50グループ
- `score`: km相当の距離スコア（0-500、小さいほど類似）
- `grouped_earthquakes`: 余震グループ内の他の地震（代表を除く）。単独地震は空配列

## Architecture

### Data Layer

#### eqmonitor_api パッケージ

OpenAPI spec に追加されるまで、Retrofit クライアントに手動で追加:

```dart
// earthquake_api_client.dart に追加
@GET('/v2/earthquake/{eventId}/similar')
Future<HttpResponse<SimilarEarthquakeResponse>> getV2EarthquakeEventIdSimilar({
  @Path('eventId') required String eventId,
});
```

モデル（eqmonitor_api パッケージ）:

```dart
// SimilarEarthquakeItem
@freezed
class SimilarEarthquakeItem {
  const factory SimilarEarthquakeItem({
    required EarthquakePartial earthquake,
    required double score,
    @JsonKey(name: 'grouped_earthquakes')
    required List<EarthquakePartial> groupedEarthquakes,
  }) = _SimilarEarthquakeItem;
}

// SimilarEarthquakeResponse
@freezed
class SimilarEarthquakeResponse {
  const factory SimilarEarthquakeResponse({
    required List<SimilarEarthquakeItem> items,
  }) = _SimilarEarthquakeResponse;
}
```

#### App Layer Models

```dart
// similar_earthquake_item.dart
@freezed
class SimilarEarthquakeItem {
  const factory SimilarEarthquakeItem({
    required EarthquakePartial earthquake,
    required double score,
    required SimilarityLevel level,
    required List<EarthquakePartial> groupedEarthquakes,
  }) = _SimilarEarthquakeItem;
}

// similarity_level.dart
enum SimilarityLevel {
  a(maxScore: 100),  // 5/5 filled
  b(maxScore: 200),  // 4/5 filled
  c(maxScore: 300),  // 3/5 filled
  d(maxScore: 400),  // 2/5 filled
  e(maxScore: 500);  // 1/5 filled

  const SimilarityLevel({required this.maxScore});
  final double maxScore;

  int get filledCount => 5 - index;

  static SimilarityLevel fromScore(double score) {
    return values.firstWhere(
      (l) => score <= l.maxScore,
      orElse: () => SimilarityLevel.e,
    );
  }
}
```

#### Provider

```dart
@riverpod
Future<List<SimilarEarthquakeItem>> similarEarthquake(
  Ref ref,
  String eventId,
) async {
  final repository = await ref.watch(earthquakeHistoryRepositoryProvider.future);
  return repository.fetchSimilarEarthquakes(eventId: eventId);
}
```

### UI Layer

#### Placement

詳細シート内の配置順序:

```
EarthquakeHypocenterInformationCard
EarthquakeLpgmIntensityCard
CurrentLocationIntensityCard
EarthquakeIntensityCard
AdBanner (24h経過後)
SimilarEarthquakeCard ← NEW
_TelegramListButton
```

#### SimilarEarthquakeCard

```
┌─────────────────────────────────────┐
│ セクションヘッダー: "類似している地震" │
├─────────────────────────────────────┤
│ [ListTile] 代表地震A                 │
│   trailing: スコアインジケータ [■■■■□]│
│   ▼ 展開ボタン (grouped count > 0)   │
│   ├── [ListTile] 余震A-1             │
│   ├── [ListTile] 余震A-2             │
│   └── [ListTile] 余震A-3             │
├─────────────────────────────────────┤
│ [ListTile] 代表地震B                 │
│   trailing: スコアインジケータ [■■■□□]│
├─────────────────────────────────────┤
│ ...（初期5件まで）                    │
├─────────────────────────────────────┤
│ [すべて表示] (残りN件)               │
└─────────────────────────────────────┘
```

#### SimilarityScoreIndicator

5段階の小さなセル（各8x8dp）を横に並べ、スコアレベルに応じて塗りつぶす。
レベルラベル(A-E)をセルの右に表示。

```
Level A: [■][■][■][■][■] A
Level B: [■][■][■][■][□] B
Level C: [■][■][■][□][□] C
Level D: [■][■][□][□][□] D
Level E: [■][□][□][□][□] E
```

- 塗りつぶし色: `colorScheme.primary`
- 未塗り色: `colorScheme.surfaceContainerHighest`

#### States

- **Loading**: `CircularProgressIndicator.adaptive()` (小さめ)
- **Empty** (items が空): セクション全体を非表示
- **Error**: 小さなエラーメッセージ + リトライボタン
- **Data**: 上記レイアウト

#### Interactions

- EarthquakeListTile タップ → 該当地震の詳細ページへ遷移
- 展開ボタンタップ → 余震グループの地震を展開/折りたたみ（デフォルト折りたたみ）
- 「すべて表示」ボタン → 残りの類似地震を表示（初期5件→全件）

## File Structure

```
app/lib/feature/earthquake_history/
  data/
    model/
      similar_earthquake_item.dart
      similarity_level.dart
    provider/
      similar_earthquake_provider.dart
  ui/
    components/
      similar_earthquake_card.dart
      similarity_score_indicator.dart

packages/eqmonitor_api/lib/src/
  clients/
    earthquake_api_client.dart              # メソッド追加
  models/
    similar_earthquake_item.dart            # 新規
    similar_earthquake_response.dart        # 新規
```

## Testing

- `similarEarthquakeProvider` の単体テスト（空レスポンス、グループ付きレスポンス）
- `SimilarityLevel.fromScore` の単体テスト（境界値）
- `SimilarityScoreIndicator` のWidgetテスト（各レベルの描画確認）
