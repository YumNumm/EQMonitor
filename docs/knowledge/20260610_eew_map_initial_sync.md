# EEWマップ連携の初期同期ルール

## 背景
- EEW が既に活性中の状態でホームマップを生成すると、`ref.listen` の後追い通知だけでは初回イベントを拾えず、カメラ自動ズームが実行されない場合がある。
- MapLibre レイヤーの非同期初期化中に EEW データ更新が入ると、`isInitialized` 切り替えまでに発生した更新を取りこぼし、初回描画が遅延する場合がある。

## ルール
1. **コントローラ接続時に現在の EEW 状態を即時同期する。**
   - `setController()` 直後に `ref.read(eewAliveTelegramProvider)` を読み、通常の listen 更新と同じ遷移ハンドラを呼ぶ。
2. **レイヤー初期化完了直後に「最新状態」で `updateFilter` を必ず 1 回実行する。**
   - 初期化開始時点のスナップショットではなく、`useRef` に保持した最新値を使う。
3. **EEW 領域フィルター式は共通化し、空配列時は必ず非表示フィルターを返す。**
   - `['==', '1', '2']` を空状態の安全デフォルトとして使う。

## 実装時の確認コマンド
```bash
mise exec -- flutter test \
  app/test/feature/home/data/provider/map_camera_state_provider_test.dart \
  app/test/feature/home/ui/component/map/layer/eew_area_filter_test.dart

mise exec -- flutter analyze \
  app/lib/feature/home/data/provider/map_camera_state_provider.dart \
  app/lib/feature/home/ui/component/map/layer/eew_area_filter.dart \
  app/lib/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart \
  app/lib/feature/home/ui/component/map/layer/eew_warning_regions_layer.dart
```
