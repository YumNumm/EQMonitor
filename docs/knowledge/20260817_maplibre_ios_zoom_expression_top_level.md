# MapLibre iOS: zoom依存の式は式ツリーの最上位に置く

## 事象

TestFlight ビルド 3.0.0 (1824) で、起動約8秒後 (強震モニタレイヤー追加時) に
iOS のみ SIGABRT でクラッシュした。クラッシュログの lastExceptionBacktrace は
`-[NSObject(NSKeyValueCoding) setValue:forKey:]` → `MLNCircleStyleLayer.setCircleRadius:`
→ `objc_exception_throw` を示していた。

## 原因

`kyoshin_monitor_observation_layer.dart` で `circle-radius` / `circle-stroke-width` を

```
['*', radiusScaleFactor, ['interpolate', ['linear'], ['zoom'], ...]]
```

という形にしていた。MapLibre iOS (MLN) は style JSON 式を NSExpression へ変換する際、
**camera (zoom) 依存の `interpolate` 式が式ツリーの最上位にあることを要求**し、
他の演算子の内側にネストされていると NSException を投げる。
Android (MapLibre Android) はネストを許容するため、iOS だけがクラッシュする。

## 対処

係数の乗算は `interpolate` の各 stop 出力値へ畳み込み、zoom 式を最上位に保つ。

```
['interpolate', ['linear'], ['zoom'], 3, 1 * factor, 10, 10 * factor]
```

## 教訓

- MapLibre のペイントプロパティ式を組み立てるときは、`['zoom']` を参照する式が
  最上位演算子になっているかを必ず確認する (iOS 実機/シミュレータでの確認が必要)。
- 式の形だけを検証するユニットテストでは iOS のこの制約は検出できない。
  `kyoshin_monitor_observation_layer_test.dart` に「zoom式が最上位にあること」を
  検証するテストを追加した。
