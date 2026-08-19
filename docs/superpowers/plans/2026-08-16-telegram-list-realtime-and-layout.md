# Telegram List Realtime and Layout Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震別電文一覧をWebSocket更新へ追従させ、震度・都道府県・差分表示を指定どおり整える。

**Architecture:** 電文一覧と詳細の各Notifierが正規化済み `realtimeEventsProvider` を直接購読し、同一eventIdの地震upsertだけで自身を再取得する。表示は共通震度アイコンと都道府県単位のWidget境界を使い、差分モデルは既知値同士だけを変更として扱う。

**Tech Stack:** Flutter, Dart, Riverpod 3, flutter_test, Dio test adapter, Freezed

## Global Constraints

- Flutter/Dartコマンドは必ず `mise exec --` 経由で実行する。
- ページ層にWebSocket購読や再取得の副作用を追加しない。
- 同一eventIdの `RealtimeEarthquakeUpsertEvent` だけを再取得トリガーにする。
- 固定値・推測値へのフォールバックを追加しない。
- production codeより先に失敗するテストを書き、REDを確認する。
- ユーザー所有の既存変更には触れず、各コミットには対象ファイルだけをstageする。

## File Map

- `app/lib/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart`: 一覧のリアルタイム再取得。
- `app/lib/feature/telegram_list/data/notifier/telegram_details_notifier.dart`: 詳細のリアルタイム再取得。
- 対応する `*.g.dart`: Riverpod生成hashの更新。
- `app/test/feature/telegram_list/telegram_list_by_event_id_notifier_test.dart`: eventId一致・不一致のNotifier回帰テスト。
- `app/lib/feature/telegram_list/ui/components/intensity_region_list.dart`: 共通震度アイコンと県単位改行。
- `app/test/feature/telegram_list/intensity_region_list_test.dart`: 震度アイコンとレイアウトのWidgetテスト。
- `app/lib/feature/telegram_list/data/model/earthquake_body_diff.dart`: 既知値同士だけを差分とする契約。
- `app/test/feature/telegram_list/domain/earthquake_body_diff_test.dart`: 不明値と実訂正の単体テスト。
- `docs/knowledge/20260816_telegram_list_realtime_refresh.md`: 今後の同種画面で守る購読ルール。

---

### Task 1: 一覧・詳細Notifierのリアルタイム再取得

**Files:**
- Modify: `app/test/feature/telegram_list/telegram_list_by_event_id_notifier_test.dart`
- Modify: `app/lib/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart`
- Modify: `app/lib/feature/telegram_list/data/notifier/telegram_details_notifier.dart`
- Regenerate: `app/lib/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.g.dart`
- Regenerate: `app/lib/feature/telegram_list/data/notifier/telegram_details_notifier.g.dart`

**Interfaces:**
- Consumes: `realtimeEventsProvider` and `RealtimeEarthquakeUpsertEvent.record.eventId`.
- Produces: 同一eventIdで `ref.invalidateSelf()` を実行する2つのfamily Notifier。

- [ ] **Step 1: 一覧Providerの失敗テストを書く**

  `StreamController<RealtimeEvent>.broadcast(sync: true)` と `_StubRealtimeEvents` を追加する。初回取得後に次を送出し、APIリクエスト数を検証する。

  ```dart
  controller.add(
    RealtimeEvent.earthquakeUpsert(
      record: _earthquake(eventId: 'event-1'),
      source: RealtimeSource.eqmonitor,
    ),
  );
  await container.pump();
  expect(adapter.requests, hasLength(2));
  ```

  続けて `event-2` を送出しても2回のままであることを別テストで検証する。`_earthquake` はstatus `.normal`、type `.normal`、precision `.second`、空のdatasources/telegramsを持つ実APIモデルを返す。

- [ ] **Step 2: 一覧テストのREDを確認する**

  Run: `cd app && mise exec -- flutter test test/feature/telegram_list/telegram_list_by_event_id_notifier_test.dart`
  Expected: 一致event送出後もリクエスト数が1のためFAIL。

- [ ] **Step 3: 詳細Providerの失敗テストを書く**

  `TelegramDetails` を継承したspyで `fetch` を実装する。cache clientでは `CacheMissException`、fresh clientでは `freshFetchCount` を加算して空Mapを返す。family providerをspyでoverrideし、一致eventで1→2、不一致eventで増えないことを検証する。

- [ ] **Step 4: 詳細テストのREDを確認する**

  Run: `cd app && mise exec -- flutter test test/feature/telegram_list/telegram_list_by_event_id_notifier_test.dart`
  Expected: 詳細の `freshFetchCount` が1のままでFAIL。

- [ ] **Step 5: 両Notifierへ最小の購読処理を追加する**

  各 `build(String eventId)` の先頭に同じeventIdだけを受けるlistenerを置く。

  ```dart
  ref.listen(realtimeEventsProvider, (_, next) {
    if (next case AsyncData(
      value: RealtimeEarthquakeUpsertEvent(:final record),
    ) when record.eventId == eventId) {
      ref.invalidateSelf();
    }
  });
  ```

  `TelegramDetails.build` は式形式からblock形式へ変更して `cachedBuild()` を返す。

- [ ] **Step 6: Riverpodコードを再生成してGREENを確認する**

  Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

  Run: `cd app && mise exec -- flutter test test/feature/telegram_list/telegram_list_by_event_id_notifier_test.dart`
  Expected: 全テストPASS。

- [ ] **Step 7: リアルタイム修正をコミットする**

  ```bash
  git add app/lib/feature/telegram_list/data/notifier app/test/feature/telegram_list/telegram_list_by_event_id_notifier_test.dart
  git commit -m "Fix: 電文一覧を地震更新へ追従"
  ```

### Task 2: 共通震度アイコンと都道府県単位改行

**Files:**
- Create: `app/test/feature/telegram_list/intensity_region_list_test.dart`
- Modify: `app/lib/feature/telegram_list/ui/components/intensity_region_list.dart`

**Interfaces:**
- Consumes: `JmaIntensityIcon(intensity:, type: .filled, size:)` と市区町村コード先頭2桁。
- Produces: 各震度行に共通アイコンを持ち、各都道府県が独立した縦行になる `IntensityRegionList`。

- [ ] **Step 1: アイコン利用の失敗Widgetテストを書く**

  `DesignSystemThemeExtension.light()` を登録した `MaterialApp` で震度4のentryをpumpし、次を検証する。

  ```dart
  expect(find.byType(JmaIntensityIcon), findsOneWidget);
  expect(
    tester.widget<JmaIntensityIcon>(find.byType(JmaIntensityIcon)).intensity,
    JmaIntensity.four,
  );
  ```

- [ ] **Step 2: 県単位改行の失敗Widgetテストを書く**

  十分広い画面に茨城県2市と栃木県1市をpumpし、`tester.getTopLeft(find.text('茨城県')).dy` と栃木県のdyが異なることを検証する。現状の単一Wrapでは同じdyとなるfixtureを使う。

- [ ] **Step 3: WidgetテストのREDを確認する**

  Run: `cd app && mise exec -- flutter test test/feature/telegram_list/intensity_region_list_test.dart`
  Expected: `JmaIntensityIcon` が0件、県名のdyが同一でFAIL。

- [ ] **Step 4: 独自バッジを共通アイコンへ置換する**

  `IntensityColors` 依存と独自 `Container` を削除し、`JmaIntensityIcon(intensity: intensity, type: .filled, size: 28)` を配置する。

- [ ] **Step 5: 都道府県グループを独立Widgetへ分ける**

  県コード順のグループを `Column` のchildrenにし、各childを県名と市区町村の `Wrap` にする。Widget内private methodは残さず、private StatelessWidgetへ責務を分離する。

- [ ] **Step 6: WidgetテストのGREENを確認する**

  Run: `cd app && mise exec -- flutter test test/feature/telegram_list/intensity_region_list_test.dart`
  Expected: 全テストPASS、overflow例外なし。

- [ ] **Step 7: 表示修正をコミットする**

  ```bash
  git add app/lib/feature/telegram_list/ui/components/intensity_region_list.dart app/test/feature/telegram_list/intensity_region_list_test.dart
  git commit -m "Fix: 震度と市区町村表示を統一"
  ```

### Task 3: 不明値からの擬似差分を除外

**Files:**
- Modify: `app/test/feature/telegram_list/domain/earthquake_body_diff_test.dart`
- Modify: `app/lib/feature/telegram_list/data/model/earthquake_body_diff.dart`

**Interfaces:**
- Consumes: nullableな旧値・新値を持つ `HypocenterDiff`。
- Produces: 両値が非nullかつ異なる場合だけtrueとなる `hasMagnitudeChange`、`hasDepthChange`、`hasEpicenterNameChange`。

- [ ] **Step 1: 不明旧値を除外する失敗テストを書く**

  既存の「初報で差分あり」テストを契約どおり「差分なし」に変更し、旧Mがnull・新Mが3.8のケースでも `hasMagnitudeChange()` がfalseであることを追加する。既存の5.0→5.5テストは残す。

- [ ] **Step 2: 単体テストのREDを確認する**

  Run: `cd app && mise exec -- flutter test test/feature/telegram_list/domain/earthquake_body_diff_test.dart`
  Expected: null→既知値が変更扱いのためFAIL。

- [ ] **Step 3: 既知値同士だけを差分とする**

  ```dart
  bool hasMagnitudeChange() =>
      oldMagnitude != null && newMagnitude != null && oldMagnitude != newMagnitude;
  bool hasDepthChange() =>
      oldDepth != null && newDepth != null && oldDepth != newDepth;
  bool hasEpicenterNameChange() =>
      oldEpicenterName != null &&
      newEpicenterName != null &&
      oldEpicenterName != newEpicenterName;
  ```

- [ ] **Step 4: 単体テストのGREENを確認する**

  Run: `cd app && mise exec -- flutter test test/feature/telegram_list/domain/earthquake_body_diff_test.dart`
  Expected: 全テストPASS。

- [ ] **Step 5: 差分修正をコミットする**

  ```bash
  git add app/lib/feature/telegram_list/data/model/earthquake_body_diff.dart app/test/feature/telegram_list/domain/earthquake_body_diff_test.dart
  git commit -m "Fix: 不明値からの震源差分を非表示"
  ```

### Task 4: 知見記録と全体検証

**Files:**
- Create: `docs/knowledge/20260816_telegram_list_realtime_refresh.md`

**Interfaces:**
- Consumes: Task 1〜3の確定した実装契約。
- Produces: eventId別の派生画面でリアルタイム更新を接続する再利用可能な運用ルール。

- [ ] **Step 1: 知見を記録する**

  ページの `ref.watch` だけではWebSocket更新は発生せず、状態Notifierが `realtimeEventsProvider` を購読してIDを絞り、一覧と詳細を個別に更新することを記載する。テストコマンドも含める。

- [ ] **Step 2: formatと対象テストを実行する**

  Run: `cd app && mise exec -- dart format lib/feature/telegram_list test/feature/telegram_list`

  Run: `cd app && mise exec -- flutter test test/feature/telegram_list`
  Expected: 全テストPASS、例外・警告なし。

- [ ] **Step 3: 静的解析と差分検査を実行する**

  Run: `cd app && mise exec -- flutter analyze lib/feature/telegram_list test/feature/telegram_list`

  Run: `git --no-pager diff --check HEAD`
  Expected: 今回の対象に新規エラーなし、whitespace errorなし。

- [ ] **Step 4: 知見をコミットする**

  ```bash
  git add docs/knowledge/20260816_telegram_list_realtime_refresh.md
  git commit -m "Docs: 電文画面のリアルタイム購読規約を記録"
  ```

- [ ] **Step 5: detached HEADを解消後にpushする**

  Codexアプリの「Create branch」で `codex/telegram-list-realtime-refresh` を作成し、全コミットをpushする。既存の未関連変更はコミットへ含めない。
