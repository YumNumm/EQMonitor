# MapLibreレイヤー初期化時のレース回避ルール

## 背景
`useEffect` 内で `StyleController.addSource/addLayer` を非同期実行しつつ、完了前に `updateGeoJsonSource` を呼ぶと、source未作成エラーが発生する。

## ルール
- レイヤー初期化完了前は更新処理を走らせない。
- `isInitialized` のような状態フラグは、初期化完了 **後** に true にする。
- クリーンアップ時は先に初期化フラグを false に戻してから `removeLayer/removeSource` を行う。

## 実装パターン
```dart
unawaited(() async {
  await _initializeLayers(styleController);
  isInitialized.value = true;
  await _updateLayers(styleController, eew, travelTimeMap);
}());
```

## 確認コマンド
- 差分確認: `git --no-pager diff -- app/lib/feature/eew/ui/components/eew_static_ps_wave_layer.dart`
- 変更確認: `git --no-pager status --short`
