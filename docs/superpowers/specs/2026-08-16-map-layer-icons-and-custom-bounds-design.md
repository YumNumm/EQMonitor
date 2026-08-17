# マップレイヤー設定アイコン削除・カスタム範囲保存 設計

## 目的

- マップレイヤー設定画面の5セクションから装飾アイコンを削除する。
- カスタム表示範囲の取得値がホーム設定へ保存され、永続化後も復元できることを自動テストで保証する。

## 対象範囲

対象のセクションは「緊急地震速報」「揺れ検知」「現在地」「強震モニタ」「マップ」とする。
戻る、セクション開閉、情報、保存など操作を示すアイコンは維持する。

## UI設計

`HomeMapLayerPage` の `_SettingsSection` から `IconData` 引数と40pxのアイコンコンテナを削除する。
タイトル・説明・開閉矢印は既存の横並びを維持し、アイコン分の余白も削除してテキスト領域を広げる。
セクションの展開状態、設定項目、各操作の挙動は変更しない。

## カスタム範囲保存設計

範囲取得と保存を `save_home_map_bounds_flow.dart` の公開flow関数へ切り出す。
flowは次の順序で処理する。

1. `MapController.getVisibleRegion()` から東西南北の境界を取得する。
2. 南西・北東の緯度経度から `LatLngBoundary` を構築する。
3. 現在の `HomeConfigurationModel` を読み込む。
4. `defaultBounds` を `HomeMapDefaultBounds.custom`、`customBounds` を取得した境界に更新する。
5. `HomeConfigurationNotifier.saveMutation` 経由でSharedPreferencesへ保存する。
6. 保存完了後、呼び出し元の画面がmountedなら範囲選択画面を閉じる。

`HomeMapBoundsSelectorPage` はcontroller未生成時には保存を開始せず、生成済みの場合だけflowを呼び出す。
保存中の例外処理や画面表示は既存のMutation契約を維持し、この変更では新しいフォールバック値を導入しない。

## テスト設計

### セクションアイコン

`HomeMapLayerPage` をWidgetテストで描画し、5つの装飾アイコンが存在しないことを確認する。
同時に戻るアイコンと5つの開閉矢印が残ることを確認し、操作用アイコンまで削除する回帰を防ぐ。

### 範囲取得と永続化

テスト用 `MapController` が返す固定の `LngLatBounds` をflowへ渡す。
保存後に以下を確認する。

- provider上の `defaultBounds` が `custom` である。
- provider上の `customBounds` がcontrollerの東西南北と一致する。
- SharedPreferencesのJSONに同じ境界が保存されている。
- 新しいProviderContainerで読み直しても同じ境界が復元される。
- 保存完了後に範囲選択ルートが閉じる。

これにより、MapLibreからの範囲取得、緯度経度変換、notifier更新、JSON変換、永続化、復元までを一つの契約として検証する。

## 変更しない事項

- カスタム選択時の画面遷移方法
- プリセット範囲の値
- 地図の初期ズーム計算
- MapLibre自体の描画や端末固有実装
