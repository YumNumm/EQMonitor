# バックエンド: ARV (Arrival Time) データ取得の実装

> **着手して実装したら削除すること。**

## 背景

`notification-resolver` の揺れ検知相関サービスで、観測点ごとの地震波到達時刻 (ARV) が常に `null` で返されている。
ARV は揺れ検知カードの観測点プロットや到達予想表示に使われる可能性があり、未実装のまま放置されている。

## 現状

**ファイル:** `backend/service/notification-resolver/src/correlation/correlation-service.ts:213`

```ts
return {
  eventId: payload.eventId,
  // ...
  points: payload.points.map(p => ({
    code: p.code,
    latitude: p.location.latitude,
    longitude: p.location.longitude,
    intensity: p.intensity ?? null,
    arv: null, // TODO: 観測点データからARVを取得
  })),
};
```

`ShakeInfo` 構造体の `arv` フィールドがすべての観測点で `null` になっている。

## やること

1. **ARV の定義を確認する**
   - `arv` (Arrival Time) が何を意味するか仕様を確認する（地震波到達時刻 `Date` / 到達までの秒数 `number` など）。
   - `payload.points` が持つデータ (`RealtimeShakeData`) に ARV 相当の情報が含まれるか調べる。

2. **観測点データから ARV を取得する**
   - DMDATA の観測点データ (`packages/observation-points/`) や走時表 (`packages/travel-time-table/`) を参照し、ARV を算出・取得する方法を検討する。
   - データがリアルタイムで取得できる場合は `payload.points` から直接マッピングする。
   - 計算が必要な場合は `travel-time-table` を使い、震源座標と観測点座標から P 波到達時刻を推定する。

3. **型定義を更新する**
   - `arv` が `null` から具体的な型に変わる場合、下流の SSE / クライアント API の型定義も合わせて更新する。

## 参照

- `backend/service/notification-resolver/src/correlation/correlation-service.ts`
- `backend/packages/observation-points/`
- `backend/packages/travel-time-table/`
- `backend/docs/shake-detection.md`
