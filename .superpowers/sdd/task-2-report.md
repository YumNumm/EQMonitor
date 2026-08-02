# Task 2 Report: Transition（状態遷移・shouldFit）

## Status

完了。

## Implemented

- `EewMapFocusState` / `EewMapFocusDecision` を Freezed model として追加した。
- `EewMapFocusTransition` と `eewMapFocusTransitionProvider` を追加した。
- `evaluate` は brief の評価ルールに沿って以下を処理する。
  - `reportTime` 最大の生存 EEW を最新として選択する。
  - 生存 EEW に存在しない累積揺れ矩形を破棄する。
  - `correlatedEewEventId == eventId` の揺れのみを 0.5 度矩形へ累積し、既存矩形とは `union` して縮小しない。
  - 最新 EEW の切替時は `isFocused: true` にし、fit 対象がある場合のみ `shouldFit: true` にする。
  - 同一 EEW フォーカス中は震源または累積矩形の変化時のみ `shouldFit: true` にする。
  - 手動解除状態では state 更新のみ行い `shouldFit: false` を維持する。
  - 全滅時はフォーカス状態と累積矩形をクリアし `shouldFit: false` にする。
- `clearFocus` は `isFocused` のみ `false` にする。
- `refocus` は最新 EEW へ明示フォーカスし、fit 対象がある場合のみ `shouldFit: true` にする。

## TDD Evidence

- RED:
  - `mise exec -- flutter test test/feature/home/data/logic/eew_map_focus_transition_test.dart`
  - Stub 実装に対して 9 件が期待差分で失敗することを確認した。
- GREEN:
  - `mise exec -- flutter test test/feature/home/data/logic/eew_map_focus_transition_test.dart`
  - `00:00 +11: All tests passed!`

## Tests Added

- `reportTimeが新しいEEWを最新として選ぶ`
- `フォーカス中に震源が変わるとshouldFit=true`
- `フォーカス中に0.5度矩形が変わるとshouldFit=true`
- `同一グリッド内の揺れ拡大ではshouldFit=false`
- `isFocused=falseでは震源変化でもshouldFit=false`
- `新しい最新EEWは手動解除後でもisFocused=trueかつshouldFit=true`
- `フォーカスEEW消滅で残存最新へ切替`
- `全滅でフォーカスクリア・shouldFit=false`
- `相関揺れのみ累積し他EEW・未紐付けは含めない`
- `clearFocusはisFocusedのみfalse`
- `refocusは最新へshouldFit=true`

## Verification

- `mise exec -- dart run build_runner build --delete-conflicting-outputs`
  - 成功。
  - build_runner 側で `--delete-conflicting-outputs` は削除済みオプションとして無視された。
- `mise exec -- dart format lib/feature/home/data/model/eew_map_focus_state.dart lib/feature/home/data/logic/eew_map_focus_transition.dart test/feature/home/data/logic/eew_map_focus_transition_test.dart`
  - 成功。
  - `packages/eqmonitor_lints/lib/analysis_options.yaml` を読めない警告が出た。
- IDE lints:
  - 対象 3 ファイルでエラーなし。
- `mise exec -- flutter test test/feature/home/data/logic/eew_map_focus_transition_test.dart`
  - 11 件通過。

## Concerns

- 初回 test 実行時に `build/ios/SourcePackages` と `build/macos/SourcePackages` が無く、plugin copy が失敗したためディレクトリを作成して再実行した。
- `flutter test` 実行中に `packages/assets_util/lib/src/ios/eqm_assets_util.dart` と一部既存 `.g.dart` hash に未関連差分が発生した。生成ファイル編集禁止・不要差分の無断 revert 禁止ルールに従い、この Task 2 コミットには含めない。
- `flutter test` 出力に `File modified during build. Build must be rerun.` が出るが、最終的な対象テストは `All tests passed!` で終了した。
