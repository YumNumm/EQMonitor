# KyoshinMonitorObservationLayer listenManual サブスクリプションリーク

## 背景

`KyoshinMonitorObservationLayer` は `useEffect` 内で `ref.listenManual()` を呼び出して
GeoJSON データの更新を `styleController` に反映している。

---

## 問題

**ファイル:** `app/lib/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart:108-122`

```dart
useEffect(
  () {
    if (!useKmoni) { return null; }

    ref.listenManual(
      homeKyoshinMonitorObservationGeoJsonProvider,
      (_, next) async { ... },
    );
    return null;  // ← BUG: ProviderSubscription を破棄していない
  },
  [styleController, useKmoni],
);
```

`ref.listenManual()` は `ProviderSubscription` を返すが、戻り値が無視されている。
`styleController` や `useKmoni` が変わるたびに `useEffect` が再実行され、
前のサブスクリプションがクローズされないまま新しいサブスクリプションが積み重なる。

結果として：
- 古い `styleController` への `updateGeoJsonSource` 呼び出しが残り続ける
- `removeSource` と `updateGeoJsonSource` の競合状態が発生しうる
- メモリ・イベントリークとなる

## 修正方針

`ref.listenManual()` の戻り値を保持し、`subscription.close` を `useEffect` のクリーンアップとして返す。

```dart
useEffect(
  () {
    if (!useKmoni) { return null; }

    final subscription = ref.listenManual(
      homeKyoshinMonitorObservationGeoJsonProvider,
      (_, next) async { ... },
    );
    return subscription.close;
  },
  [styleController, useKmoni],
);
```

---

## 参照

- `app/lib/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart`
