# iOS: プログラム的カメラ移動のキャンセルが apiGesture として通知される懸念

## 背景

EEW 地図フォーカスでは、`MapEventStartMoveCamera` の `reason` が
`CameraChangeReason.apiGesture` のときにユーザー操作とみなして
`EewMapFocus.clearFocus()` を呼び、自動追従を解除している
（`app/lib/feature/home/ui/component/map/home_map_view.dart`）。

## リスク

iOS (MapLibre Native) では、進行中のカメラアニメーションが別のカメラ操作で
中断された場合に、中断の通知が `apiGesture` 相当の reason で流れてくる可能性がある。
その場合、ユーザーが地図に触れていないにもかかわらず EEW フォーカスが解除され、
以降の震源更新・揺れ検知拡大でカメラが追従しなくなる。

- 発生条件（推定）: fit アニメーション中に次の fit が要求され、前のアニメーションが
  キャンセルされる。EEW 更新が高頻度で届く場面（第2報以降の連続受信）で起きうる。
- 影響: 自動追従の停止。ホームボタンは有効なままなので手動復帰は可能。

## 対応方針（未実施）

MapLibre 側にパッチを当てるのではなく、アプリ側で抑止する。

1. `HomeMapCameraCoordinator` にプログラム的カメラ操作中フラグを持たせる
   （`MapAutomaticFocusOperationQueue` の実行中区間 + 完了直後の短いグレース期間）。
2. `home_map_view.dart` の `MapEventStartMoveCamera` ハンドラで、
   そのフラグが立っている間は `clearFocus()` を呼ばない。
3. 実機（iOS / Android 双方）で、連続 fit 中に意図せず解除されないこと、
   および実ジェスチャでは解除されることを確認する。

## 検証手順（メモ）

```bash
mise exec -- flutter run --flavor dev
# デバッグの再生モードで EEW 連続報を流し、fit アニメーション中に
# 次の fit が走る状況を作って isFocused の変化をログで確認する
```
