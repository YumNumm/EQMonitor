# Final review fixes report

Base: `dfd39db9c0debed97276f9760dd285ddf54131da`

Branch: `codex/live-monitor-mode`

## Finding 1: SafeArea effective insets

- `liveMonitorMapObscuredInsets` を公開 pure function として追加した。
- `max(systemInset, 8) - 8 + max(cardHeight, 0)` を top / bottom で計算し、
  focus builder の既存 8px と合成して実効遮蔽量を一致させた。
- automatic realtime、automatic earthquake、split realtime、split
  earthquake の全経路で `MediaQuery.padding` を渡した。
- full-bleed map、overlay の `SafeArea(minimum: EdgeInsets.all(8))`、
  `liveMonitorMapSafeSpacing = 8` は維持した。
- Widget test は追加していない。

### RED / GREEN

- RED:
  `live_monitor_map_safe_area_padding_test.dart` を追加して実行し、
  `liveMonitorMapObscuredInsets` 未実装エラーで exit 1 を確認した。
- GREEN:
  0 inset、8 未満、8 超、負の Card 高さ、異なる top / bottom を実装し、
  新規 4 件と `live_monitor_map_focus_builder_test.dart` の既存 16 件が
  PASS した。

## Finding 2: invalid geographic bounds

- Mercator 変換前に全 4 座標の finite、緯度 `-90...90`、経度
  `-180...180`、`latitudeSouth <= latitudeNorth` を検証するようにした。
- `longitudeWest > longitudeEast` は拒否せず、日付変更線横断として従来どおり
  target / camera command を生成する。
- zoom 上限 8 と manual `MapOptions` は変更していない。

### RED / GREEN

- RED:
  逆転緯度、範囲外緯度、範囲外経度の pure target / no-command test を
  追加し、従来実装が不正 bounds を target と camera command に変換する
  8 failures を確認した。日付変更線横断の characterization test は従来から
  PASS することも確認した。
- GREEN:
  境界検証後、`map_automatic_focus_controller_test.dart` と
  `seismic_map_focus_builder_test.dart` の計 30 件が PASS した。

## Finding 3: HomeMap camera orchestration

- controller / viewport 所有、generation、Home request、FIFO queue、
  realtime / Home bounds 構築、camera call、stale completion guard を
  `HomeMapCameraCoordinator` へ抽出した。
- coordinator は `Ref` / `BuildContext` を保持せず、公開 method の引数は
  named parameter にした。
- `@Riverpod(keepAlive: true)` の provider で coordinator を DI した。
- `HomeMapCameraState` は EEW / visible shake の購読、Home 設定 Future の読取、
  coordinator への委譲、返された `isAtHome` の公開だけを担当する。
- EEW と未結合揺れ検知の複合 focus、realtime のみの autoZoom gate、
  target 消滅時 / 明示操作時の Home 復帰、controller / viewport 置換、
  latest generation、controller identity、stale completion guard を維持した。
- race test は coordinator test へ移し、notifier test は action resolution と
  Provider wiring に限定した。

### RED / GREEN

- RED 1:
  coordinator の競合・autoZoom・複合 focus test を先に追加し、対象ファイルと
  class が未実装のため exit 1 になることを確認した。
- GREEN 1:
  coordinator 実装後、新規 7 件が PASS した。
- RED 2:
  Riverpod override を使う notifier wiring test を先に追加し、generated
  provider 未実装で exit 1 になることを確認した。
- GREEN 2:
  provider 生成と notifier 薄型化後、action resolution 3 件と wiring 4 件が
  PASS した。race test 7 件との同時実行も PASS した。
- Provider 派生更新テストで一度だけ async test double の待機順による失敗が
  発生した。production defect ではなく、`SynchronousFuture` で委譲完了を
  決定的に観測する test double へ修正し、再実行で PASS した。

## Verification

- `mise exec -- dart run build_runner build --delete-conflicting-outputs`
  - exit 0。生成対象は新規 coordinator provider と既存 notifier hash。
  - build_runner が同 flag を廃止済みとして無視する warning、既存の
    json_annotation constraint / JsonKey default warning は出たが、意図しない
    tracked generated churn はなかった。
- `mise exec -- flutter test app/test/feature/live_monitor
  app/test/feature/home/data/service/home_map_camera_coordinator_test.dart
  app/test/feature/home/data/provider/map_camera_state_provider_test.dart
  app/test/feature/map/data --reporter compact`
  - 206 tests PASS、0 failures。
  - brief 記載の SafeArea、focus builder、publication formatter、earthquake
    presenter、map host、Home coordinator / notifier、全 LiveMonitor、全 map data
    test を包含する。
- worktree の `app/tools` を repository root の lint plugin へ一時接続し、
  implementation plan 記載の targeted analyze を実行した。
  - `No issues found!`、exit 0。
  - 検証用 symlink は実行後に除去した。
- 変更した HomeMap / map / test の追加まとめ analyze は analyzer server が
  診断なしの待機状態を 2 分超継続したため中断した。source 単体への再試行でも
  同じ待機を再現した。必須 targeted analyze は成功しており、変更ソースは上記
  206 test の compile / execution で検証済み。
- `git diff --check`: exit 0。

## Remaining

- manual device QA はこの追補修正では実施していない。
- push は依頼どおり実施しない。

## Commits

- `19358c849` `fix: LiveMonitor地図のSafeArea余白を補正`
- `a934b6c4c` `fix: 自動フォーカスの不正範囲を拒否`
- `02f79d5a3` `refactor: HomeMapカメラ制御を抽出`
- `3621042a7` `refactor: HomeMap状態をカメラ制御へ委譲`
