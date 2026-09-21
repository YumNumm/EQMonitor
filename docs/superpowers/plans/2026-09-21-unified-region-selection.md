# Unified Region Selection Implementation Plan

> **For agentic workers:** Use superpowers:executing-plans to implement this plan task-by-task. User authorized implementation and explicitly waived TDD; implement inline and add regression tests afterward.

**Goal:** 地域選択の検索・地図・選択状態を共通化し、全地域種別の単一／複数選択と震央地名フィルターを提供する。

**Architecture:** `feature/region_selection` が用途非依存の選択結果を返す。カタログと型付き選択状態を共通化し、呼び出し元が通知・保存・検索条件へ変換する。震央はPMTilesのidをコード表へ結合する。

**Tech Stack:** Flutter, Hooks, generated Riverpod, Freezed, go_router_builder, MapLibre, pmtiles_v3.

**Spec:** `docs/superpowers/specs/2026-09-21-unified-region-selection-design.md`

## Global Constraints

- TDDは採用せず、実装後に必要な回帰テストを追加する。
- 通知のEEW区域と観測地域の細分区域を区別する。
- 欠測を固定値や最寄りの震央地名で補わない。
- 元worktreeの未コミット変更を変更しない。
- Flutter/Dartコマンドはmise exec経由。codemagic-cli-toolsの不足sidecarは今回不要なため環境変数で無効化する。

## Review Focus

- 同じ市区町村に複数のEEW親がある場合、通知先の親が失われないこと。
- 複数選択で種別・一覧／地図を変えても以前の選択が消えないこと。
- 古いタップの非同期完了・dispose後の完了で選択が変わらないこと。
- 旧pack・未知の震央ID・地物がないコードでも一覧とキャンセルが使えること。
- 地域と震央を別々に解除しても他の履歴条件が維持されること。

## Task 1: 共通モデル・カタログ・検索・選択ロジック

Files: `app/lib/feature/region_selection/data/{model,logic,provider,repository}/`、`app/test/feature/region_selection/`。

Interfaces: `RegionOption` は種別・コード・名称・親情報、`RegionSelectionRequest` は候補種別・通知モード・初期値・単一／複数設定を持つ。結果は `List<RegionOption>`、キャンセルはnull。

```dart
enum RegionSelectionMode { single, multiple }
// single: [option] / multiple: identityで追加・解除。
// 全地域種別が同じReducerを使う。
```

- [x] モデル、カタログ生成、正規化検索、単一／複数選択の純粋ロジックを実装。
- [x] 名前・かな・英名、親子の結合、種別を跨ぐコード衝突、複数EEW親をテスト。
- [x] 全種別の単一置換／複数追加解除と初期値復元をテスト。

## Task 2: 一覧・地図を持つ共通画面

Files: `region_selection/ui/{page,component,action}/`、`region_selection/data/repository/region_map_repository.dart`、`core/router/router.dart`。

Interfaces: 型付きrouteのextraは `RegionSelectionRequest`、戻り値は `List<RegionOption>?`。画面と地図は同じ選択リストを共有する。

```dart
// 地図の震央地名: featuresAtPoint(..., layerIds: [epicenterHitLayer])
// properties['id'] を数値として検証し、catalogの震央候補に照合。
// 行政区域: 既存の常駐JMA workerを再利用。
```

- [x] 検索・種別・親への絞り込み・選択確認・空値決定・キャンセルを実装。
- [x] 地図レイヤー、最新操作ガード、worker照合、震央照合、旧pack時の案内を実装。
- [x] 単一／複数UI、一覧／地図の状態保持、ロード失敗時の再試行をテスト。
- [x] PMTiles由来fixtureと未知ID、複数候補、世代変更をテスト。

## Task 3: 各呼び出し元と震央フィルター

Files: `home/ui/component/sheet/home_earthquake_history_sheet.dart`、`settings/children/config/earthquake_history/earthquake_history_config_page.dart`、`core/component/chip/region_intensity_filter_chip.dart`、`earthquake_history/ui/components/earthquake_history_parameter_persistent_delegate.dart`、`earthquake_history/ui/page/earthquake_history_search_page.dart`、通知設定・ウィジェット設定のpage。

Interfaces: 共通結果を `EarthquakeHistoryParameter`、`NotificationRegionSelection`、`WidgetRegionSelection` へ変換。震央選択は `parameter.copyWith(epicenterCodes: codes)` で反映。

```dart
// 地域の変更・解除では epicenterCodes を保持。
// 震央の変更・解除では既存のparameter variantと他条件を保持。
```

- [x] ホーム・観測地域・通知・ウィジェットを共通画面へ接続。
- [x] 震央チップに複数選択を接続し、既存検索URLを共通検索UIへ接続。
- [x] 既存選択復元・通知コード・保存・震央条件の独立性をテスト。
- [x] 旧selector、個別picker、未使用の検索・地図部品とテストを整理。

## Task 4: 検証・レビュー・公開

- [x] `mise exec -- dart run build_runner build --delete-conflicting-outputs` をappで実行。
- [x] 変更Dartをformatし、対象テスト・既存の通知地域／ホーム指定／履歴条件／検索／ウィジェットテストを実行。
- [x] `mise exec -- dart analyze app --fatal-infos --format machine` の結果を確認。
- [x] 実機未検証を既存TODOへ記録。共通化契約を関連knowledgeへ統合。
- [x] 独立レビューを受け、重要指摘を修正・回帰確認。
- [x] 意図した変更をstageしてhk check、論理単位でcommit、push、YumNumm/EQMonitorのdevelop向けPRを作成。

## Execution ledger

- Ruling: ユーザーの実装承認を受け、追加の実行方法選択では停止せずinline実装する。TDDはユーザー指定で省略し、回帰テストを実装後に追加する。
- Pre-flight: Task 1の共通結果をTask 2が返しTask 3が用途別へ変換する。通知の親情報はidentityに含め、Task 3まで保持する。

- 実装: 共通catalog・単一／複数reducer・一覧／地図UIを実装し、ホーム、履歴、通知、ウィジェットを接続。旧picker・selector・検索providerと専用テストを共通テストへ置換した。
- Asset Pack: 公開v0.1.0 ZIPの署名・hashを既存検証ツールで確認。`areaEpicenter.id`は数値、地名はJMAコード表から取得する。fixtureにmetadataと地名の抜粋を記録した。
- 検証: 最新developのM3E操作を含めて関連156件を実行し153件成功（新規25件を含む）。通知の文言期待値3件は変更前commit `4e5708b38` でも同じ失敗を再現した。format、textlint、hk check、手書きコードのdiff checkは成功。Freezedのformat-off出力にある空白は生成結果として保持した。
- 解析: 最新SDKで型エラー・変更箇所の診断は0件。未変更箇所にnull assertion警告3件と非推奨API診断4件があるため、app全体は終了コード2。初期SDKでのHooks lint plugin例外は最新SDKで再現しなくなった。
- 環境: 初期のFlutter 3.47 prereleaseでは既存m3e依存の制約で通常のpub getが失敗したため、lockfile一致cacheで検証した。その後、最新develop `d370fc824` のSDK更新を取り込み、通常の `dart pub get --enforce-lockfile` と27 packageのmelos bootstrapが成功した。
- 生成: 最新SDKで通常の `dart run build_runner build --delete-conflicting-outputs` が成功。生成されたrouterと新規model/providerを反映し、flutter_genが出力しなくなった空のfonts定義も生成結果に合わせた。
- レビュー: 独立レビューの3指摘（遅延lookup、都道府県かな、worker再試行）を修正し、再レビューで重要指摘なし。実機地図確認はTODOに残した。
- 統合: 最新developのM3E移行と競合する旧pickerを共通画面へ置換し、M3ETextButtonとAccessibleProgressIndicatorを共通画面へ継承した。PMTilesメタデータ読込はappの直接path依存として宣言した。
- 公開: `feature/unified-region-selection` をpushし、develop向け [PR #1823](https://github.com/YumNumm/EQMonitor/pull/1823) を作成した。
