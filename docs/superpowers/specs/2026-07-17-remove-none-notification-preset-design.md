# Remove None Notification Preset Design

## Goal

通知設定画面の通知プリセットから「通知しない」を除外し、通知の有効・無効は既存の「通知を受け取る」toggle に一本化する。

## Scope

- 設定画面のプリセット一覧は「推奨設定」「すべて」「カスタム」の3択にする。
- オンボーディングのプリセット一覧は既存の4択を維持する。
- `NotificationPreset.none`、保存済みの `none` 値、プリセット適用処理は維持する。
- 通知種別、対象地域、最低震度など、各プリセットの適用内容は変更しない。

## Design

`NotificationPresetSelector` が現在共有しているプリセット順序を、用途別に分ける。

- onboarding: `recommended`, `all`, `custom`, `none`
- settings: `recommended`, `all`, `custom`

Widget の style に応じた一覧だけを子 Widget に渡す。タイトルや説明文、権限未許可時の `none` 自動選択、永続化された `none` の読み込みはそのまま残す。

この境界により、master toggle を持つ設定画面だけ重複した操作を除去し、master toggle を持たないオンボーディングの既存動作と保存データ互換性を保つ。

## Existing Preset Behavior

- 推奨設定は通知を有効化し、現在地について緊急地震速報を予想震度4以上、地震情報を観測震度1以上で通知する。
- すべては推奨設定に加え、全国について緊急地震速報と地震情報を震度3以上で通知する。
- 今回の変更では上記の適用値を変更しない。

## Testing

`notification_preset_selector_test.dart` に Widget test を追加する。

- settings style では「通知しない」が表示されず、残り3件が表示される。
- onboarding style では「通知しない」が引き続き表示される。
- 既存の OS 権限未許可時の `none` 自動選択テストを維持する。

実装前に settings style のテストが失敗することを確認し、一覧の分離後に selector と preset applier の関連テストを再実行する。

## Out of Scope

- `NotificationPreset.none` の削除や保存値の移行
- オンボーディング画面の選択肢変更
- プリセットが適用する通知条件の変更
- master toggle の動作変更
