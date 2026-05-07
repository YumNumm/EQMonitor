---
name: feature-roadmap
overview: 既存 TODO、コード内 TODO、主要機能の実装状況から、今後実装すべき機能を優先度付きロードマップとして整理します。生命に関わる情報の正確性と通知到達性を最優先にし、地図表示・履歴 UI・設定導線を段階的に進めます。
todos:
  - id: fix-eew-intensity-codegen
    content: EEW 予報区の intensity / maxIntensity が unknown 固定になる codegen 問題を修正する
    status: pending
  - id: restore-eew-map-layer
    content: ホーム地図の EEW 予想震度レイヤー更新処理を有効化する
    status: pending
  - id: restore-estimated-intensity
    content: arv_400 を API/モデルに追加し推計震度計算点生成を復旧する
    status: pending
  - id: implement-permission-onboarding
    content: オンボーディングで通知権限リクエストと拒否時説明を実装する
    status: pending
  - id: improve-location-error-ux
    content: 現在地・位置情報依存 UI のエラー表示と復旧導線を整える
    status: pending
  - id: complete-history-scope-flow
    content: ホーム地震履歴の指定地域設定と一覧遷移条件の整合を実装する
    status: pending
isProject: false
---

# 今後実装機能ロードマップ

## 最優先: EEW と推計震度の正確性

- T01: `packages/eqmonitor_api` の codegen 問題を修正し、EEW 予報区の `intensity` / `maxIntensity` が `unknown` 固定になる状態を解消する。
  - 関連: [docs/todo/083_eew_codegen_and_missing_features.md](docs/todo/083_eew_codegen_and_missing_features.md)
  - 影響: [app/lib/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart](app/lib/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart), [app/lib/feature/eew/ui/screen/eew_details_screen.dart](app/lib/feature/eew/ui/screen/eew_details_screen.dart)
- T02: EEW 予想震度レイヤーの `styleController.updateFilter` 更新処理を有効化し、EEW 更新に地図表示が追随するようにする。
  - 関連: [app/lib/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart](app/lib/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart)
- T03: `earthquake_stations.json` に `arv_400` を追加するバックエンド/API 側対応と、クライアントの `_generateCalculationPoints` 復旧を進める。
  - 関連: [docs/todo/800_estimated_intensity_arv400.md](docs/todo/800_estimated_intensity_arv400.md), [app/lib/core/provider/estimated_intensity/provider/estimated_intensity_provider.dart](app/lib/core/provider/estimated_intensity/provider/estimated_intensity_provider.dart)

## 高優先: 通知・復帰・権限フロー

- T04: オンボーディングで通知権限を実際に要求し、拒否時も完了できる説明と後から変更できる導線を用意する。
  - 関連: [docs/todo/076_onboarding_permission_flow.md](docs/todo/076_onboarding_permission_flow.md), [app/lib/feature/onboarding/ui/onboarding_page.dart](app/lib/feature/onboarding/ui/onboarding_page.dart)
- T05: アプリ復帰時に EEW の REST 再取得を明示的に行い、WebSocket 停止中の鮮度落ちを抑える。
  - 関連: [app/lib/feature/eew/data/eew_telegram.dart](app/lib/feature/eew/data/eew_telegram.dart)
- T06: FCM バックグラウンドメッセージと Live Activity 更新の役割を整理し、ログのみの状態から必要な同期処理へ拡張する。
  - 関連: [app/lib/main.dart](app/lib/main.dart), [app/lib/feature/live_activity/data/provider/live_activity_token_stream.dart](app/lib/feature/live_activity/data/provider/live_activity_token_stream.dart)

## 中優先: 地震履歴・現在地・地図 UI の完成度

- T07: 「各地の震度」で震度ツリーが空の速報ケースを表示できるようにする。
  - 関連: [app/lib/feature/earthquake_history/ui/components/region_intensity.dart](app/lib/feature/earthquake_history/ui/components/region_intensity.dart)
- T08: 現在地震度カードや位置情報依存 UI のエラー時表示を、非表示ではなく短い説明と復旧導線にする。
  - 関連: [app/lib/feature/earthquake_history/ui/components/current_location_intensity_card.dart](app/lib/feature/earthquake_history/ui/components/current_location_intensity_card.dart), [app/lib/feature/location/data/location.dart](app/lib/feature/location/data/location.dart)
- T09: 地震履歴マップの震度アイコン生成失敗・読み込み中を扱い、アイコンが出ないだけの状態を減らす。
  - 関連: [app/lib/feature/map/features/icon/data/repository/intensity_icon_repository.dart](app/lib/feature/map/features/icon/data/repository/intensity_icon_repository.dart), [app/lib/feature/earthquake_history/ui/layer/earthquake_history_intensity_icon_layer.dart](app/lib/feature/earthquake_history/ui/layer/earthquake_history_intensity_icon_layer.dart)

## 中長期: 設定・検索・データ連携

- T10: ホーム地震履歴の「指定地域」設定 UI を実装し、一覧画面の検索条件と整合させる。
  - 関連: [docs/todo/075_home_earthquake_history_scope_followups.md](docs/todo/075_home_earthquake_history_scope_followups.md), [app/lib/feature/home/data/model/home_configuration_model.dart](app/lib/feature/home/data/model/home_configuration_model.dart)
- T11: 設定画面に位置情報・権限状態の導線を追加し、通知/位置/オンボーディングの説明を一貫させる。
  - 関連: [app/lib/feature/settings/settings_screen.dart](app/lib/feature/settings/settings_screen.dart)
- T12: 揺れ検知の WebSocket 切断時フォールバックと ARV データ活用を設計・実装する。
  - 関連: [docs/todo/084_backend_arv_implementation.md](docs/todo/084_backend_arv_implementation.md), [app/lib/feature/shake_detection/data/provider/shake_detection_provider.dart](app/lib/feature/shake_detection/data/provider/shake_detection_provider.dart)

## 補足

- [docs/todo/083_eew_codegen_and_missing_features.md](docs/todo/083_eew_codegen_and_missing_features.md) の「WebSocket 未接続時 API フォールバック」は、現在の `eew_telegram.dart` では対応済みに見えるため、TODO ドキュメントの更新候補です。
- 実装順は、ユーザーの安全に直結する「正しい EEW/震度表示」と「通知到達性」を先に置くのが妥当です。
