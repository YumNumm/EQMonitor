# EEW地図フォーカスとユーザージェスチャ

ホーム地図のEEW自動フォーカスは、MapLibreの
`MapEventStartMoveCamera` が `CameraChangeReason.apiGesture` を通知した場合だけ
解除する。`developerAnimation` や `apiAnimation` は自動カメラ移動なので解除しない。

iOSの`MLNCameraChangeReason`はbitmaskであり、pinchとrotateなど複数理由が同時に
立つ。flutter-maplibre側ではgesture bitのいずれかを含むか判定し、
`TransitionCancelled`単独をgestureとして扱わないこと。

- 解除後は同じEEWの更新で自動フォーカスを再開しない。
- 新しいEEWのイベントIDが追加された場合は自動フォーカスを再開する。
- EEW発表中にホームボタンを押した場合は、`autoZoom` 設定に関係なくEEWだけへ再フォーカスする。
- カメラアニメーション中のジェスチャでも解除できるよう、フォーカス状態はアニメーション開始前に公開し、完了時はセッションの同一性を確認する。

関連テスト:

```sh
mise exec -- flutter test \
  app/test/feature/home/data/logic/home_map_eew_focus_transition_test.dart \
  app/test/feature/home/data/provider/map_camera_state_provider_test.dart \
  app/test/feature/home/data/service/home_map_camera_coordinator_test.dart \
  app/test/feature/home/ui/home_map_controller_card_test.dart
```
