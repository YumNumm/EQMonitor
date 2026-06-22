# 津波電文 state 差分追跡 ＋ UI層レイヤリング規約 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 津波 `/v2/tsunami/{id}/telegrams` の各電文が持つ `TsunamiState` スナップショット列を、予報区・観測点ごとの各項目の時系列変化として追跡するドメインモデルへ変換し、debug 画面に横スクロールのタイムラインとして表示する。あわせて UI 層での `eqmonitor_api` 型利用を禁止する custom lint を導入する。

**Architecture:** data 層で 2 段のモデルを持つ。(A) ジェネリックな中間表現 `Tracked<T> = List<TrackedValue<T>>`（追跡項目＝オブジェクト単位、変化点のみ保持）、(B) Notifier が公開する表示向きの `*Timeline`（追跡項目フィールド＋電文メタをフラット化）。API → ドメイン変換は既存の `extension XApiExtension on api.X { toDomain() }` パターンに倣う。UI は公開型のみ参照する。

**Tech Stack:** Flutter 3.44.0 / Dart ^3.11.0、Riverpod（riverpod_annotation）、Flutter Hooks、freezed、Retrofit/Dio、analysis_server_plugin（eqmonitor_lints）。

**設計 spec:** `docs/superpowers/specs/2026-06-23-tsunami-telegram-state-tracking-design.md`

## Global Constraints

- メインブランチ `develop`。PR は `--repo YumNumm/EQMonitor`、base `develop`。
- 作業ブランチ: `feat/tsunami-telegram-state-tracking`（origin/develop 起点で作成済み。enum 生成パッチ commit を含む）。
- `dart analyze` は **警告ゼロ**でパスすること（`melos run analyze`、対象 app＋packages）。
- `dart format` 準拠（CI 強制）。
- クロスパッケージ参照は package import（相対 import 禁止）。
- 生成物（`*.g.dart` / `*.freezed.dart`）はコミットする。アノテーション変更後 `melos run generate`。
- **トップレベル関数は禁止**（`avoid_top_level_functions`）。変換は extension メソッドか専用クラスのメソッドで実装する。
- **公開 Riverpod Provider は 1 ファイル 1 つまで**。
- **UI 層（`**/ui/**`）は `package:eqmonitor_api` を import しない**（本 plan で lint 化）。
- 電文一意 ID は API の `LatestTelegram.id`（再生成後の Dart 型 `api.LatestTelegram.id`）。合成しない。
- backend submodule は `95e2b695`（origin/main）へ更新済み。API 側の app 全体適応（`pressed_at` 等のリネーム反映）は **別 Agent 管轄**。本 plan は津波機能・lints・eqmonitor_api 再生成に限定する。

## 新スキーマ（再生成後の `api.*` 型）参照

`backend/api/api/openapi.json`（更新済み）より。swagger_parser は snake_case → lowerCamelCase 変換する。

- `api.LatestTelegram`: `id`(String), `type`(TelegramType), `serialNo`(num?), `title`(String), `editorialOffice`(String), `publishingOffice`(List<String>), `pressedAt`(DateTime), `reportedAt`(DateTime), `targetedAt`(DateTime?), `revokedAt`(DateTime?), `headline`(String?), `infoKind`(String), `comments`(...)
- `api.TsunamiTelegramWithState`: `telegram`(LatestTelegram), `state`(TsunamiState)  ※旧 `type` フィールドは廃止
- `api.TsunamiTelegramsResponse`: `telegrams`(List<TsunamiTelegramWithState>)
- `api.TsunamiState`: `id, eventIds, isActive, isCanceled, updatedAt, earthquakes, latestTelegrams, regions, offshoreStations`
- `api.TsunamiRegion`: `code`(String), `name`(String), `kind`(TsunamiWarningKind), `lastKind`(TsunamiWarningKind), `forecast`(TsunamiRegionForecast?), `estimation`(TsunamiRegionEstimation?), `stations`(List<TsunamiRegionStation>)
- `api.TsunamiRegionForecast`: `firstHeight`(TsunamiRegionForecastFirstHeight?), `maxHeight`(TsunamiRegionForecastMaxHeight?)
- `api.TsunamiRegionForecastFirstHeight`: `arrivalTime`(DateTime?), `condition`(FirstHeightCondition?), `revise`(Revise?)
- `api.TsunamiRegionForecastMaxHeight`: `value`(num?), `isOver`(bool?), `qualitative`(QualitativeHeight?), `isImportant`(bool?), `revise`(Revise?)
- `api.TsunamiRegionEstimation`: `firstHeight`(object: `arrivalTime`DateTime?, `isAlreadyArrived`bool?, `revise`Revise?), `maxHeight`(object: `dateTime`DateTime?, `value`num?, `isOver`bool?, `qualitative`QualitativeHeight?, `isObserving`bool?, `revise`Revise?)
- `api.TsunamiRegionStation`: `code`(String), `name`(String), `forecast`(TsunamiStationForecast?), `observation`(TsunamiStationObservation?)
- `api.TsunamiStationForecast`: `highTideAt`(DateTime), `firstHeight`(object: `arrivalTime`DateTime?, `condition`FirstHeightCondition?, `revise`Revise?)?
- `api.TsunamiStationObservation`: `sensor`(String?), `firstHeight`(TsunamiStationObservationFirstHeight), `maxHeight`(TsunamiStationObservationMaxHeight?)
- `api.TsunamiOffshoreStation`: `code`(String), `name`(String), `sensor`(String?), `firstHeight`(TsunamiStationObservationFirstHeight), `maxHeight`(TsunamiStationObservationMaxHeight?)
- `api.TsunamiStationObservationFirstHeight`: `arrivalTime`(DateTime?), `initial`(WaveInitial?), `isUnidentifiable`(bool?), `isMissing`(bool?), `revise`(Revise?)
- `api.TsunamiStationObservationMaxHeight`: `dateTime`(DateTime?), `value`(num?), `isOver`(bool?), `isRising`(bool?), `condition`(ObservationMaxHeightCondition?), `isMissing`(bool?), `revise`(Revise?)
- 値のみ enum: `api.TsunamiWarningKind`(majorWarning/warning/warningCancel/advisory/advisoryCancel/forecast/none), `api.FirstHeightCondition`(arriving/firstWaveConfirmed/imminent), `api.Revise`(addition/update), `api.QualitativeHeight`(enormous/high), `api.WaveInitial`(push/pull), `api.ObservationMaxHeightCondition`(minor/observing/important)

---

## ファイル構成

すべて新規（既存ファイルは Task 1 の生成物と Task 2 の `main.dart` 追記、既存 UI への ignore 付与を除く）。

```
packages/eqmonitor_lints/lib/src/rules/avoid_eqmonitor_api_in_ui.dart   # 新規 lint
packages/eqmonitor_lints/lib/main.dart                                  # 登録追記

app/lib/feature/tsunami/data/model/value/                               # 値のみ enum のドメイン版
  tsunami_warning_kind.dart  first_height_condition.dart  revise.dart
  qualitative_height.dart    wave_initial.dart            observation_max_height_condition.dart
app/lib/feature/tsunami/data/model/
  tsunami_forecast_first_height.dart      tsunami_forecast_max_height.dart
  tsunami_estimation_first_height.dart    tsunami_estimation_max_height.dart
  tsunami_station_forecast.dart           tsunami_station_observation.dart
  tsunami_observation_first_height.dart   tsunami_observation_max_height.dart
  tsunami_telegram_meta.dart
app/lib/feature/tsunami/data/model/tracking/
  tracked_value.dart            # TrackedValue<T> + typedef Tracked<T>
  tracked_region.dart  tracked_region_station.dart  tracked_offshore_station.dart
  tracked_tsunami_timeline.dart # ルート集約 + 構築 extension
app/lib/feature/tsunami/data/model/timeline/
  first_height_timeline_entry.dart   # 公開表示型（追跡項目ごと）
  max_height_timeline_entry.dart     kind_timeline_entry.dart
  observation_timeline_entry.dart    tsunami_timeline.dart   # 公開ルート集約
app/lib/feature/tsunami/data/notifier/
  tsunami_telegram_timeline_notifier.dart (+ .g.dart)

app/lib/feature/settings/children/config/debug/tsunami/
  tsunami_telegram_timeline_debug_page.dart
  components/tsunami_timeline_row.dart

app/test/feature/tsunami/
  tracked_tsunami_timeline_test.dart
  tsunami_telegram_timeline_notifier_test.dart
```

---

## Task 1: 前提整備 — submodule pin コミット ＆ eqmonitor_api 再生成

**Files:**
- Modify: `backend`（submodule pointer）, `packages/eqmonitor_api/openapi/openapi.json`, `packages/eqmonitor_api/lib/src/**`（生成物）

**Interfaces:**
- Produces: 再生成後の `api.*` 型（`api.LatestTelegram.id` 等。上記「新スキーマ」参照）。

> backend submodule は既に `95e2b695` へ更新済み。Dart クライアントは stale（`pressAt`、`id` 無し）。
> 別 Agent が既に再生成済みなら Step 2/3 は差分なしで no-op になる（その場合 Step 4 へ）。

- [ ] **Step 1: stale 確認**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
diff -q packages/eqmonitor_api/openapi/openapi.json backend/api/api/openapi.json \
  && echo "UP-TO-DATE" || echo "NEEDS REGEN"
```
Expected: `NEEDS REGEN`（UP-TO-DATE なら Step 2-3 をスキップ）

- [ ] **Step 2: eqmonitor_api 再生成**

```bash
cd packages/eqmonitor_api
dart run bin/generate.dart
```
Expected: `✅ コード生成が完了しました`。`lib/src/models/latest_telegram.dart` に `id` と `pressedAt` が出る。値のみ union（`tsunami_warning_kind.dart` 等）は enum として生成される（generate.dart のパッチ済み）。

- [ ] **Step 3: 生成確認**

```bash
grep -nE "required String id|pressedAt" packages/eqmonitor_api/lib/src/models/latest_telegram.dart
grep -c "enum TsunamiWarningKind" packages/eqmonitor_api/lib/src/models/tsunami_warning_kind.dart
```
Expected: `id` と `pressedAt` がヒット、enum 行が `1`。

- [ ] **Step 4: analyze（eqmonitor_api）**

```bash
cd packages/eqmonitor_api && dart analyze 2>&1 | grep -iE ' error ' | head; echo "exit ok"
```
Expected: error 行なし。

- [ ] **Step 5: コミット**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
git add backend packages/eqmonitor_api
git commit -m "chore(eqmonitor_api): backend submodule更新に追従しclient再生成(telegram.id 追加)"
```

---

## Task 2: lint ルール `avoid_eqmonitor_api_in_ui`

**Files:**
- Create: `packages/eqmonitor_lints/lib/src/rules/avoid_eqmonitor_api_in_ui.dart`
- Modify: `packages/eqmonitor_lints/lib/main.dart`
- Modify: 既存 UI 違反ファイル（`// ignore_for_file` 付与）

**Interfaces:**
- Produces: lint `avoid_eqmonitor_api_in_ui`（`**/ui/**` での `package:eqmonitor_api` import を WARNING）。

> 既存ルールは unit テストを持たず CI の `dart analyze` で検証する方式。本ルールも同方式（fixture を使った analyze で確認）。

- [ ] **Step 1: ルール実装**

`packages/eqmonitor_lints/lib/src/rules/avoid_eqmonitor_api_in_ui.dart`:
```dart
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

class AvoidEqmonitorApiInUi extends AnalysisRule {
  AvoidEqmonitorApiInUi()
    : super(name: _code.name, description: _code.problemMessage);

  static const _code = LintCode(
    'avoid_eqmonitor_api_in_ui',
    'UI 層 (ui/ 配下) で package:eqmonitor_api を import してはいけません。',
    correctionMessage:
        'data 層でアプリ用ドメインモデルへ変換し、UI からはドメイン型のみ参照してください。',
    severity: DiagnosticSeverity.WARNING,
  );

  @override
  DiagnosticCode get diagnosticCode => _code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final path = context.definingUnit.unit.declaredFragment?.source.fullName;
    if (path == null || !_isInUiLayer(path)) {
      return;
    }
    registry.addImportDirective(this, _Visitor(this));
  }

  static bool _isInUiLayer(String path) {
    final normalized = path.replaceAll(r'\', '/');
    return normalized.contains('/ui/');
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final AnalysisRule rule;

  @override
  void visitImportDirective(ImportDirective node) {
    final uri = node.uri.stringValue;
    if (uri != null && uri.startsWith('package:eqmonitor_api')) {
      rule.reportAtNode(node);
    }
  }
}
```

- [ ] **Step 2: 登録追記**

`packages/eqmonitor_lints/lib/main.dart` に import と登録を追加:
```dart
import 'package:eqmonitor_lints/src/rules/avoid_eqmonitor_api_in_ui.dart';
```
`register` 内のリストへ `AvoidEqmonitorApiInUi(),` を追加。

- [ ] **Step 3: ルールの正/負を fixture で確認**

UI 配下に一時 fixture を作り、報告されることを確認:
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
mkdir -p app/lib/feature/__lint_probe__/ui
printf "import 'package:eqmonitor_api/eqmonitor_api.dart';\nvoid x() {}\n" \
  > app/lib/feature/__lint_probe__/ui/probe.dart
cd app && dart analyze lib/feature/__lint_probe__ 2>&1 | grep avoid_eqmonitor_api_in_ui
```
Expected: `avoid_eqmonitor_api_in_ui` が 1 件報告される。
data 層では出ないことも確認:
```bash
mkdir -p lib/feature/__lint_probe__/data
printf "import 'package:eqmonitor_api/eqmonitor_api.dart' as api;\napi.TsunamiState? s;\n" \
  > lib/feature/__lint_probe__/data/probe.dart
dart analyze lib/feature/__lint_probe__/data 2>&1 | grep -c avoid_eqmonitor_api_in_ui
```
Expected: `0`。確認後 probe を削除:
```bash
rm -rf lib/feature/__lint_probe__
```

- [ ] **Step 4: 既存 UI 違反を grandfather（ignore 付与）**

新ルールで既存 UI が警告にならないよう、違反ファイルへ ignore を付与:
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
for f in $(grep -rln "package:eqmonitor_api" app/lib | grep '/ui/'); do
  grep -q "ignore_for_file: avoid_eqmonitor_api_in_ui" "$f" || \
    sed -i '' '1s;^;// ignore_for_file: avoid_eqmonitor_api_in_ui\n;' "$f"
done
```
（`sed -i ''` は macOS BSD sed。`dart format` で先頭行整形は後段 Task 11 で実施。）

- [ ] **Step 5: analyze（lints＋app）で警告ゼロ確認**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/app
dart analyze 2>&1 | grep -c avoid_eqmonitor_api_in_ui
```
Expected: `0`（既存は ignore 済み、新規違反なし）。

- [ ] **Step 6: コミット**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
git add packages/eqmonitor_lints app/lib
git commit -m "feat(lints): UI層でのeqmonitor_api import禁止ルール追加(既存違反はignoreで猶予)"
```

---

## Task 3: 値のみ enum のドメイン型 ＋ toDomain()

**Files:**
- Create: `app/lib/feature/tsunami/data/model/value/{tsunami_warning_kind,first_height_condition,revise,qualitative_height,wave_initial,observation_max_height_condition}.dart`

**Interfaces:**
- Produces: ドメイン enum `TsunamiWarningKind`/`FirstHeightCondition`/`Revise`/`QualitativeHeight`/`WaveInitial`/`ObservationMaxHeightCondition`、各 `api.X` に `toDomain()` extension。

- [ ] **Step 1: enum 実装（全6ファイル）**

`tsunami_warning_kind.dart`:
```dart
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

enum TsunamiWarningKind {
  majorWarning,
  warning,
  warningCancel,
  advisory,
  advisoryCancel,
  forecast,
  none,
}

extension TsunamiWarningKindApiExt on api.TsunamiWarningKind {
  TsunamiWarningKind toDomain() => switch (this) {
    api.TsunamiWarningKind.majorWarning => TsunamiWarningKind.majorWarning,
    api.TsunamiWarningKind.warning => TsunamiWarningKind.warning,
    api.TsunamiWarningKind.warningCancel => TsunamiWarningKind.warningCancel,
    api.TsunamiWarningKind.advisory => TsunamiWarningKind.advisory,
    api.TsunamiWarningKind.advisoryCancel => TsunamiWarningKind.advisoryCancel,
    api.TsunamiWarningKind.forecast => TsunamiWarningKind.forecast,
    api.TsunamiWarningKind.none => TsunamiWarningKind.none,
  };
}
```
`first_height_condition.dart`（`arriving/firstWaveConfirmed/imminent`）、`revise.dart`（`addition/update`）、`qualitative_height.dart`（`enormous/high`）、`wave_initial.dart`（`push/pull`）、`observation_max_height_condition.dart`（`minor/observing/important`）も同形（ドメイン enum ＋ `switch` 網羅の `toDomain()` extension）。enum 名・メンバー名は「新スキーマ」の api enum と一致させる。

- [ ] **Step 2: analyze**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/app
dart analyze lib/feature/tsunami/data/model/value 2>&1 | grep -iE ' error ' ; echo ok
```
Expected: error なし（`switch` は網羅、default 不要）。

- [ ] **Step 3: コミット**

```bash
git add app/lib/feature/tsunami/data/model/value
git commit -m "feat(tsunami): 値のみenumのドメイン型とtoDomain変換を追加"
```

---

## Task 4: 追跡項目（concern）ドメイン型 ＋ toDomain()

**Files:**
- Create: `app/lib/feature/tsunami/data/model/{tsunami_forecast_first_height,tsunami_forecast_max_height,tsunami_estimation_first_height,tsunami_estimation_max_height,tsunami_station_forecast,tsunami_station_observation,tsunami_observation_first_height,tsunami_observation_max_height}.dart`

**Interfaces:**
- Consumes: Task 3 のドメイン enum。
- Produces: 上記 freezed ドメイン型と、対応する `api.X` の `toDomain()` extension。後続 Task 6/7 が利用。

> freezed の値等価が変化点判定に使われる（Task 7）。すべて `@freezed` で生成。

- [ ] **Step 1: 型実装（代表例の完全コード）**

`tsunami_forecast_first_height.dart`:
```dart
import 'package:eqmonitor/feature/tsunami/data/model/value/first_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_forecast_first_height.freezed.dart';

@freezed
abstract class TsunamiForecastFirstHeight with _$TsunamiForecastFirstHeight {
  const factory TsunamiForecastFirstHeight({
    required DateTime? arrivalTime,
    required FirstHeightCondition? condition,
    required Revise? revise,
  }) = _TsunamiForecastFirstHeight;
}

extension TsunamiRegionForecastFirstHeightApiExt
    on api.TsunamiRegionForecastFirstHeight {
  TsunamiForecastFirstHeight toDomain() => TsunamiForecastFirstHeight(
    arrivalTime: arrivalTime,
    condition: condition?.toDomain(),
    revise: revise?.toDomain(),
  );
}
```

残りの型（フィールドは「新スキーマ」参照、すべて `required ...?` で freezed、`toDomain()` で api → domain 変換）:
- `tsunami_forecast_max_height.dart` — `TsunamiForecastMaxHeight { double? value, bool? isOver, QualitativeHeight? qualitative, bool? isImportant, Revise? revise }`、`on api.TsunamiRegionForecastMaxHeight`。`value: value?.toDouble()`。
- `tsunami_estimation_first_height.dart` — `{ DateTime? arrivalTime, bool? isAlreadyArrived, Revise? revise }`、`on api.TsunamiRegionEstimationFirstHeight`（api の入れ子型名は生成結果に合わせる。後述 Step 1.5 で確認）。
- `tsunami_estimation_max_height.dart` — `{ DateTime? dateTime, double? value, bool? isOver, QualitativeHeight? qualitative, bool? isObserving, Revise? revise }`。
- `tsunami_observation_first_height.dart` — `{ DateTime? arrivalTime, WaveInitial? initial, bool? isUnidentifiable, bool? isMissing, Revise? revise }`、`on api.TsunamiStationObservationFirstHeight`。
- `tsunami_observation_max_height.dart` — `{ DateTime? dateTime, double? value, bool? isOver, bool? isRising, ObservationMaxHeightCondition? condition, bool? isMissing, Revise? revise }`、`on api.TsunamiStationObservationMaxHeight`。
- `tsunami_station_forecast.dart` — `{ DateTime highTideAt, TsunamiForecastFirstHeight? firstHeight }`、`on api.TsunamiStationForecast`（`firstHeight` の api 入れ子型を `toDomain()`）。
- `tsunami_station_observation.dart` — `{ String? sensor, TsunamiObservationFirstHeight firstHeight, TsunamiObservationMaxHeight? maxHeight }`、`on api.TsunamiStationObservation`。

- [ ] **Step 1.5: api 入れ子型の正式名を確認**

estimation / station forecast の入れ子オブジェクトは swagger_parser が独自命名する。実際の型名を grep で確認し、extension の `on api.<実型名>` を合わせる:
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api
ls lib/src/models | grep -iE "estimation|station_forecast|station_observation|forecast_first|forecast_max"
```
Expected: 対応ファイル名が出る。型名（PascalCase 化）を extension 対象に使う。

- [ ] **Step 2: 生成 ＆ analyze**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/app
dart run build_runner build --delete-conflicting-outputs 2>&1 | tail -3
dart analyze lib/feature/tsunami/data/model 2>&1 | grep -iE ' error ' ; echo ok
```
Expected: 生成成功、error なし。

- [ ] **Step 3: コミット**

```bash
git add app/lib/feature/tsunami/data/model
git commit -m "feat(tsunami): 追跡項目のドメイン型とtoDomain変換を追加"
```

---

## Task 5: 電文メタ ドメイン型 ＋ toDomain()

**Files:**
- Create: `app/lib/feature/tsunami/data/model/tsunami_telegram_meta.dart`

**Interfaces:**
- Produces: `TsunamiTelegramMeta`（`telegramId` を含む）、`extension on api.LatestTelegram { toTelegramMeta() }`。

- [ ] **Step 1: 実装**

```dart
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_telegram_meta.freezed.dart';

@freezed
abstract class TsunamiTelegramMeta with _$TsunamiTelegramMeta {
  const factory TsunamiTelegramMeta({
    required String telegramId,
    required int? serialNo,
    required String title,
    required String? headline,
    required DateTime publishedAt,
    required DateTime reportedAt,
    required DateTime? targetedAt,
    required DateTime? revokedAt,
    required String infoKind,
  }) = _TsunamiTelegramMeta;
}

extension LatestTelegramApiExt on api.LatestTelegram {
  TsunamiTelegramMeta toTelegramMeta() => TsunamiTelegramMeta(
    telegramId: id,
    serialNo: serialNo?.toInt(),
    title: title,
    headline: headline,
    publishedAt: pressedAt,
    reportedAt: reportedAt,
    targetedAt: targetedAt,
    revokedAt: revokedAt,
    infoKind: infoKind,
  );
}
```

- [ ] **Step 2: 生成 ＆ analyze ＆ コミット**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/app
dart run build_runner build --delete-conflicting-outputs 2>&1 | tail -2
dart analyze lib/feature/tsunami/data/model/tsunami_telegram_meta.dart 2>&1 | grep -iE ' error ' ; echo ok
git add app/lib/feature/tsunami/data/model/tsunami_telegram_meta.dart app/lib/feature/tsunami/data/model/tsunami_telegram_meta.freezed.dart
git commit -m "feat(tsunami): 電文メタ ドメイン型を追加"
```
Expected: error なし。

---

## Task 6: 中間表現 — TrackedValue<T> ＆ Tracked* entity

**Files:**
- Create: `app/lib/feature/tsunami/data/model/tracking/tracked_value.dart`
- Create: `app/lib/feature/tsunami/data/model/tracking/{tracked_region,tracked_region_station,tracked_offshore_station,tracked_tsunami_timeline}.dart`

**Interfaces:**
- Consumes: Task 3/4/5 のドメイン型。
- Produces: `typedef Tracked<T> = List<TrackedValue<T>>;`、`TrackedValue<T>`、`TrackedRegion`/`TrackedRegionStation`/`TrackedOffshoreStation`/`TrackedTsunamiTimeline`（フィールドは下記）。

> `TrackedValue<T>` は `fromJson` 不要（in-memory）。freezed のジェネリック型として生成する。

- [ ] **Step 1: TrackedValue 実装**

`tracked_value.dart`:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracked_value.freezed.dart';

/// {value, telegramId}[] を表す追跡履歴（変化点のみ）。
typedef Tracked<T> = List<TrackedValue<T>>;

@freezed
abstract class TrackedValue<T> with _$TrackedValue<T> {
  const factory TrackedValue({
    required T value,
    required String telegramId,
  }) = _TrackedValue<T>;
}
```

- [ ] **Step 2: Tracked entity 実装**

`tracked_region.dart`（import 略記、value/concern 型を package import）:
```dart
@freezed
abstract class TrackedRegion with _$TrackedRegion {
  const factory TrackedRegion({
    required String code,
    required String name,
    required Tracked<TsunamiWarningKind> kind,
    required Tracked<TsunamiWarningKind> lastKind,
    required Tracked<TsunamiForecastFirstHeight?> forecastFirstHeight,
    required Tracked<TsunamiForecastMaxHeight?> forecastMaxHeight,
    required Tracked<TsunamiEstimationFirstHeight?> estimationFirstHeight,
    required Tracked<TsunamiEstimationMaxHeight?> estimationMaxHeight,
    required List<TrackedRegionStation> stations,
  }) = _TrackedRegion;
}
```
`tracked_region_station.dart`:
```dart
@freezed
abstract class TrackedRegionStation with _$TrackedRegionStation {
  const factory TrackedRegionStation({
    required String code,
    required String name,
    required Tracked<TsunamiStationForecast?> forecast,
    required Tracked<TsunamiStationObservation?> observation,
  }) = _TrackedRegionStation;
}
```
`tracked_offshore_station.dart`:
```dart
@freezed
abstract class TrackedOffshoreStation with _$TrackedOffshoreStation {
  const factory TrackedOffshoreStation({
    required String code,
    required String name,
    required Tracked<TsunamiObservationFirstHeight> firstHeight,
    required Tracked<TsunamiObservationMaxHeight?> maxHeight,
  }) = _TrackedOffshoreStation;
}
```
`tracked_tsunami_timeline.dart`（ルート、構築 extension は Task 7 で追記）:
```dart
@freezed
abstract class TrackedTsunamiTimeline with _$TrackedTsunamiTimeline {
  const factory TrackedTsunamiTimeline({
    required List<TsunamiTelegramMeta> telegrams,
    required List<TrackedRegion> regions,
    required List<TrackedOffshoreStation> offshoreStations,
  }) = _TrackedTsunamiTimeline;
}
```

- [ ] **Step 3: 生成 ＆ analyze ＆ コミット**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/app
dart run build_runner build --delete-conflicting-outputs 2>&1 | tail -2
dart analyze lib/feature/tsunami/data/model/tracking 2>&1 | grep -iE ' error ' ; echo ok
git add app/lib/feature/tsunami/data/model/tracking
git commit -m "feat(tsunami): 中間表現(TrackedValue/Tracked* entity)を追加"
```
Expected: error なし。

---

## Task 7: 中間表現ビルダー（api レスポンス → TrackedTsunamiTimeline）

**Files:**
- Modify: `app/lib/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart`（extension 追記）
- Test: `app/test/feature/tsunami/tracked_tsunami_timeline_test.dart`

**Interfaces:**
- Consumes: `api.TsunamiTelegramsResponse`、Task 4/5 の `toDomain()`/`toTelegramMeta()`。
- Produces: `extension on api.TsunamiTelegramsResponse { TrackedTsunamiTimeline toTrackedTimeline() }`。

> トップレベル関数禁止のため変換は extension メソッドで実装。変化点判定は **直前に追加した値と freezed 等価で比較し、異なる時のみ追加**。電文は `pressedAt` 昇順（同時刻は `serialNo` 昇順）でソート。entity は全電文の和集合を `code` キーでまとめ、未登場電文では各追跡項目を `null` 値として扱う（=その telegramId で `null` の変化点になりうる）。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/tsunami/tracked_tsunami_timeline_test.dart`:
```dart
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  // 電文を組み立てるヘルパ（テスト内ローカル関数: トップレベル関数禁止のため）
  test('kind の変化点のみが記録される', () {
    api.LatestTelegram tg(String id, DateTime at) => api.LatestTelegram(
      id: id,
      type: api.TelegramType.vtse51,
      title: 't',
      editorialOffice: 'eo',
      publishingOffice: const ['po'],
      pressedAt: at,
      reportedAt: at,
      infoKind: 'k',
    );
    api.TsunamiState stateWithKind(api.TsunamiWarningKind kind) => api.TsunamiState(
      id: 'x',
      eventIds: const ['e'],
      isActive: true,
      isCanceled: false,
      updatedAt: DateTime(2026),
      earthquakes: const [],
      latestTelegrams: const [],
      regions: [
        api.TsunamiRegion(
          code: '100',
          name: '宮城',
          kind: kind,
          lastKind: kind,
          stations: const [],
        ),
      ],
      offshoreStations: const [],
    );
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 1, 0, 0)),
          state: stateWithKind(api.TsunamiWarningKind.warning),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 1, 0, 5)),
          state: stateWithKind(api.TsunamiWarningKind.warning), // 変化なし
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t3', DateTime(2026, 1, 1, 0, 10)),
          state: stateWithKind(api.TsunamiWarningKind.majorWarning), // 変化
        ),
      ],
    );

    final timeline = response.toTrackedTimeline();

    expect(timeline.telegrams.map((e) => e.telegramId), ['t1', 't2', 't3']);
    final region = timeline.regions.single;
    expect(region.kind.map((e) => e.telegramId), ['t1', 't3']);
    expect(region.kind.map((e) => e.value), [
      TsunamiWarningKind.warning,
      TsunamiWarningKind.majorWarning,
    ]);
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/app
flutter test test/feature/tsunami/tracked_tsunami_timeline_test.dart 2>&1 | tail -15
```
Expected: FAIL（`toTrackedTimeline` 未定義）。

- [ ] **Step 3: ビルダー実装（extension 追記）**

`tracked_tsunami_timeline.dart` に追記。`_appendChange` も extension 内の private 拡張ではなくクラス化が必要なため、変換は `_TrackedTimelineBuilder`（private クラス、トップレベル関数禁止対策）で実装し、extension から呼ぶ:
```dart
extension TsunamiTelegramsResponseApiExt on api.TsunamiTelegramsResponse {
  TrackedTsunamiTimeline toTrackedTimeline() =>
      _TrackedTimelineBuilder(this).build();
}

class _TrackedTimelineBuilder {
  _TrackedTimelineBuilder(this._response);

  final api.TsunamiTelegramsResponse _response;

  TrackedTsunamiTimeline build() {
    final sorted = [..._response.telegrams]..sort((a, b) {
      final byTime = a.telegram.pressedAt.compareTo(b.telegram.pressedAt);
      if (byTime != 0) {
        return byTime;
      }
      return (a.telegram.serialNo ?? 0).compareTo(b.telegram.serialNo ?? 0);
    });
    final telegrams = [
      for (final t in sorted) t.telegram.toTelegramMeta(),
    ];

    // region.code -> 各追跡項目のアキュムレータ
    final regionCodes = <String>[];
    final kind = <String, Tracked<TsunamiWarningKind>>{};
    final lastKind = <String, Tracked<TsunamiWarningKind>>{};
    final fcFirst = <String, Tracked<TsunamiForecastFirstHeight?>>{};
    final fcMax = <String, Tracked<TsunamiForecastMaxHeight?>>{};
    final esFirst = <String, Tracked<TsunamiEstimationFirstHeight?>>{};
    final esMax = <String, Tracked<TsunamiEstimationMaxHeight?>>{};
    final regionName = <String, String>{};
    // region.code -> station.code -> アキュムレータ
    final stationOrder = <String, List<String>>{};
    final stationName = <String, Map<String, String>>{};
    final stFc = <String, Map<String, Tracked<TsunamiStationForecast?>>>{};
    final stOb = <String, Map<String, Tracked<TsunamiStationObservation?>>>{};
    // offshore.code -> アキュムレータ
    final offshoreCodes = <String>[];
    final offshoreName = <String, String>{};
    final offFirst = <String, Tracked<TsunamiObservationFirstHeight>>{};
    final offMax = <String, Tracked<TsunamiObservationMaxHeight?>>{};

    for (final t in sorted) {
      final id = t.telegram.id;
      for (final r in t.state.regions) {
        if (!regionCodes.contains(r.code)) {
          regionCodes.add(r.code);
          kind[r.code] = [];
          lastKind[r.code] = [];
          fcFirst[r.code] = [];
          fcMax[r.code] = [];
          esFirst[r.code] = [];
          esMax[r.code] = [];
          stationOrder[r.code] = [];
          stationName[r.code] = {};
          stFc[r.code] = {};
          stOb[r.code] = {};
        }
        regionName[r.code] = r.name;
        _push(kind[r.code]!, r.kind.toDomain(), id);
        _push(lastKind[r.code]!, r.lastKind.toDomain(), id);
        _push(fcFirst[r.code]!, r.forecast?.firstHeight?.toDomain(), id);
        _push(fcMax[r.code]!, r.forecast?.maxHeight?.toDomain(), id);
        _push(esFirst[r.code]!, r.estimation?.firstHeight?.toDomain(), id);
        _push(esMax[r.code]!, r.estimation?.maxHeight?.toDomain(), id);
        for (final s in r.stations) {
          if (!stationOrder[r.code]!.contains(s.code)) {
            stationOrder[r.code]!.add(s.code);
            stFc[r.code]![s.code] = [];
            stOb[r.code]![s.code] = [];
          }
          stationName[r.code]![s.code] = s.name;
          _push(stFc[r.code]![s.code]!, s.forecast?.toDomain(), id);
          _push(stOb[r.code]![s.code]!, s.observation?.toDomain(), id);
        }
      }
      for (final o in t.state.offshoreStations) {
        if (!offshoreCodes.contains(o.code)) {
          offshoreCodes.add(o.code);
          offFirst[o.code] = [];
          offMax[o.code] = [];
        }
        offshoreName[o.code] = o.name;
        _push(offFirst[o.code]!, o.firstHeight.toDomain(), id);
        _push(offMax[o.code]!, o.maxHeight?.toDomain(), id);
      }
    }

    return TrackedTsunamiTimeline(
      telegrams: telegrams,
      regions: [
        for (final code in regionCodes)
          TrackedRegion(
            code: code,
            name: regionName[code]!,
            kind: kind[code]!,
            lastKind: lastKind[code]!,
            forecastFirstHeight: fcFirst[code]!,
            forecastMaxHeight: fcMax[code]!,
            estimationFirstHeight: esFirst[code]!,
            estimationMaxHeight: esMax[code]!,
            stations: [
              for (final sc in stationOrder[code]!)
                TrackedRegionStation(
                  code: sc,
                  name: stationName[code]![sc]!,
                  forecast: stFc[code]![sc]!,
                  observation: stOb[code]![sc]!,
                ),
            ],
          ),
      ],
      offshoreStations: [
        for (final code in offshoreCodes)
          TrackedOffshoreStation(
            code: code,
            name: offshoreName[code]!,
            firstHeight: offFirst[code]!,
            maxHeight: offMax[code]!,
          ),
      ],
    );
  }

  /// 直前と値が異なる場合のみ変化点を追加する。
  void _push<T>(List<TrackedValue<T>> acc, T value, String telegramId) {
    if (acc.isNotEmpty && acc.last.value == value) {
      return;
    }
    acc.add(TrackedValue<T>(value: value, telegramId: telegramId));
  }
}
```

- [ ] **Step 4: テストがパスすることを確認**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/app
flutter test test/feature/tsunami/tracked_tsunami_timeline_test.dart 2>&1 | tail -8
```
Expected: All tests passed!

- [ ] **Step 5: analyze ＆ コミット**

```bash
dart analyze lib/feature/tsunami/data/model/tracking test/feature/tsunami 2>&1 | grep -iE ' error ' ; echo ok
git add app/lib/feature/tsunami/data/model/tracking app/test/feature/tsunami/tracked_tsunami_timeline_test.dart
git commit -m "feat(tsunami): api応答→中間表現の変換ビルダーを追加(変化点のみ記録)"
```
Expected: error なし。

---

## Task 8: 公開表示型（タイムライン行）

**Files:**
- Create: `app/lib/feature/tsunami/data/model/timeline/{first_height_timeline_entry,max_height_timeline_entry,kind_timeline_entry,observation_timeline_entry,tsunami_timeline}.dart`

**Interfaces:**
- Consumes: Task 3/4/5 のドメイン型、Task 6 の `TsunamiTelegramMeta`。
- Produces: 各 `*TimelineEntry`、`typedef *Timeline = List<*TimelineEntry>`、公開ルート `TsunamiTimeline`（Task 9 が生成）。

- [ ] **Step 1: 型実装**

`first_height_timeline_entry.dart`:
```dart
import 'package:eqmonitor/feature/tsunami/data/model/value/first_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'first_height_timeline_entry.freezed.dart';

typedef FirstHeightTimeline = List<FirstHeightTimelineEntry>;

@freezed
abstract class FirstHeightTimelineEntry with _$FirstHeightTimelineEntry {
  const factory FirstHeightTimelineEntry({
    // 追跡項目のフィールド
    required DateTime? arrivalTime,
    required FirstHeightCondition? condition,
    required Revise? revise,
    // 電文メタ
    required String telegramId,
    required String? headline,
    required String title,
    required DateTime publishedAt,
    required DateTime? revokedAt,
  }) = _FirstHeightTimelineEntry;
}
```
`max_height_timeline_entry.dart`（`{ double? value, bool? isOver, QualitativeHeight? qualitative, bool? isImportant, Revise? revise }` ＋ 電文メタ）、`kind_timeline_entry.dart`（`{ TsunamiWarningKind kind }` ＋ 電文メタ）、`observation_timeline_entry.dart`（観測 first/max を表示するための `{ ... , 電文メタ }`）も同形で定義。電文メタ部（telegramId/headline/title/publishedAt/revokedAt）は共通。

`tsunami_timeline.dart`（公開ルート集約。UI が参照）:
```dart
@freezed
abstract class TsunamiTimeline with _$TsunamiTimeline {
  const factory TsunamiTimeline({
    required List<TsunamiTelegramMeta> telegrams,
    required List<RegionTimeline> regions,
    required List<OffshoreStationTimeline> offshoreStations,
  }) = _TsunamiTimeline;
}
```
`RegionTimeline` / `OffshoreStationTimeline` も同ファイル群に定義（code/name ＋ 各 `*Timeline`、stations）。

- [ ] **Step 2: 生成 ＆ analyze ＆ コミット**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/app
dart run build_runner build --delete-conflicting-outputs 2>&1 | tail -2
dart analyze lib/feature/tsunami/data/model/timeline 2>&1 | grep -iE ' error ' ; echo ok
git add app/lib/feature/tsunami/data/model/timeline
git commit -m "feat(tsunami): 公開タイムライン表示型を追加"
```
Expected: error なし。

---

## Task 9: Notifier（中間表現 → 公開型）

**Files:**
- Create: `app/lib/feature/tsunami/data/notifier/tsunami_telegram_timeline_notifier.dart` (+ .g.dart)
- Test: `app/test/feature/tsunami/tsunami_telegram_timeline_notifier_test.dart`

**Interfaces:**
- Consumes: `apiClientProvider`（既存）、Task 7 の `toTrackedTimeline()`、Task 8 の公開型。
- Produces: 公開 Provider `tsunamiTelegramTimelineProvider(tsunamiId)` → `Future<TsunamiTimeline>`。

> 公開 Provider は 1 ファイル 1 つ。中間表現 → 公開型変換は本ファイル内の private クラス/メソッド（トップレベル関数禁止）。電文メタは telegramId で引けるよう Map 化し、各変化点に結合する。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/tsunami/tsunami_telegram_timeline_notifier_test.dart`（変換部分を検証。既存 `tracked` を公開型へ写像する private 変換を、Notifier 越しでなく公開型ビルダーで検証するため、変換ロジックを `TrackedTsunamiTimeline` の `toPublic()` extension に分離して直接テストする）:
```dart
import 'package:eqmonitor/feature/tsunami/data/model/timeline/tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_value.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('kind の変化点が電文メタと結合されて公開型になる', () {
    final meta = [
      TsunamiTelegramMeta(
        telegramId: 't1', serialNo: 1, title: 'T1', headline: null,
        publishedAt: DateTime(2026, 1, 1), reportedAt: DateTime(2026, 1, 1),
        targetedAt: null, revokedAt: null, infoKind: 'k',
      ),
    ];
    final tracked = TrackedTsunamiTimeline(
      telegrams: meta,
      regions: [
        TrackedRegion(
          code: '100', name: '宮城',
          kind: [const TrackedValue(value: TsunamiWarningKind.warning, telegramId: 't1')],
          lastKind: const [],
          forecastFirstHeight: const [], forecastMaxHeight: const [],
          estimationFirstHeight: const [], estimationMaxHeight: const [],
          stations: const [],
        ),
      ],
      offshoreStations: const [],
    );

    final TsunamiTimeline public = tracked.toPublic();

    final region = public.regions.single;
    expect(region.code, '100');
    expect(region.kind.single.kind, TsunamiWarningKind.warning);
    expect(region.kind.single.telegramId, 't1');
    expect(region.kind.single.title, 'T1');
  });
}
```

- [ ] **Step 2: テスト失敗を確認**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/app
flutter test test/feature/tsunami/tsunami_telegram_timeline_notifier_test.dart 2>&1 | tail -10
```
Expected: FAIL（`toPublic` 未定義）。

- [ ] **Step 3: 変換 extension を実装**

`tsunami_timeline.dart` に `extension on TrackedTsunamiTimeline { TsunamiTimeline toPublic() }` を追記（内部は private `_TsunamiTimelineMapper` クラス）。telegramId → meta の Map を作り、各 `Tracked<T>` の各 `TrackedValue` を対応する `*TimelineEntry`（追跡項目フィールド＋メタ）へ写像する。
```dart
extension TrackedTsunamiTimelineMapping on TrackedTsunamiTimeline {
  TsunamiTimeline toPublic() => _TsunamiTimelineMapper(this).map();
}

class _TsunamiTimelineMapper {
  _TsunamiTimelineMapper(this._tracked)
    : _metaById = {for (final m in _tracked.telegrams) m.telegramId: m};

  final TrackedTsunamiTimeline _tracked;
  final Map<String, TsunamiTelegramMeta> _metaById;

  TsunamiTimeline map() => TsunamiTimeline(
    telegrams: _tracked.telegrams,
    regions: [
      for (final r in _tracked.regions)
        RegionTimeline(
          code: r.code,
          name: r.name,
          kind: [
            for (final v in r.kind)
              KindTimelineEntry(
                kind: v.value,
                telegramId: v.telegramId,
                headline: _metaById[v.telegramId]!.headline,
                title: _metaById[v.telegramId]!.title,
                publishedAt: _metaById[v.telegramId]!.publishedAt,
                revokedAt: _metaById[v.telegramId]!.revokedAt,
              ),
          ],
          // forecastFirstHeight → FirstHeightTimelineEntry, forecastMaxHeight →
          // MaxHeightTimelineEntry, stations の forecast/observation も同様に写像
          // （各 *Timeline を構築）。
          // ...（残りの追跡項目も同じ要領で map する）
        ),
    ],
    offshoreStations: [
      for (final o in _tracked.offshoreStations)
        OffshoreStationTimeline(
          code: o.code,
          name: o.name,
          // firstHeight / maxHeight を *TimelineEntry へ写像
        ),
    ],
  );
}
```
> 残りの追跡項目（forecastFirstHeight / forecastMaxHeight / estimation / station forecast/observation / offshore first/max）も同じ写像パターンで埋める。null 値の `TrackedValue` は対応する entry のフィールドを null にして表す。

- [ ] **Step 4: テストパスを確認**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/app
flutter test test/feature/tsunami/tsunami_telegram_timeline_notifier_test.dart 2>&1 | tail -8
```
Expected: All tests passed!

- [ ] **Step 5: Notifier 実装**

`tsunami_telegram_timeline_notifier.dart`:
```dart
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_telegram_timeline_notifier.g.dart';

@riverpod
Future<TsunamiTimeline> tsunamiTelegramTimeline(
  Ref ref,
  String tsunamiId,
) async {
  final client = await ref.read(apiClientProvider.future);
  final response = await client.tsunami.getV2TsunamiTsunamiIdTelegrams(
    tsunamiId: tsunamiId,
  );
  return response.data.toTrackedTimeline().toPublic();
}
```
> `Ref` の型は riverpod_annotation の生成に合わせる（既存 notifier の書式に倣う）。`getV2TsunamiTsunamiIdTelegrams` の戻り値 `.data` が `api.TsunamiTelegramsResponse`。

- [ ] **Step 6: 生成 ＆ analyze ＆ コミット**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/app
dart run build_runner build --delete-conflicting-outputs 2>&1 | tail -2
dart analyze lib/feature/tsunami/data 2>&1 | grep -iE ' error ' ; echo ok
git add app/lib/feature/tsunami/data app/test/feature/tsunami/tsunami_telegram_timeline_notifier_test.dart
git commit -m "feat(tsunami): 公開タイムライン変換とNotifierを追加"
```
Expected: error なし。

---

## Task 10: debug 横スクロールタイムライン UI

**Files:**
- Create: `app/lib/feature/settings/children/config/debug/tsunami/tsunami_telegram_timeline_debug_page.dart`
- Create: `app/lib/feature/settings/children/config/debug/tsunami/components/tsunami_timeline_row.dart`
- Modify: 既存 debug ルーティング（`debug_tsunami_details_page.dart` から遷移ボタン追加、または既存 debug ルータへ登録）

**Interfaces:**
- Consumes: `tsunamiTelegramTimelineProvider`、公開型のみ。`package:eqmonitor_api` は import しない（lint 対象）。

> UI は公開ドメイン型のみ参照。各 entity を縦に並べ、各追跡項目を `Row` ＋横 `SingleChildScrollView` で電文（列）順に表示。

- [ ] **Step 1: タイムライン行コンポーネント実装**

`components/tsunami_timeline_row.dart`（`HookConsumerWidget` か `StatelessWidget`。StatefulWidget 禁止に注意）:
```dart
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:flutter/material.dart';

class TsunamiTimelineRow extends StatelessWidget {
  const TsunamiTimelineRow({
    required this.label,
    required this.telegrams,
    required this.cellBuilder,
    super.key,
  });

  final String label;
  final List<TsunamiTelegramMeta> telegrams;
  /// telegramId -> セル表示文字列（変化が無い列は null）
  final String? Function(String telegramId) cellBuilder;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 120, child: Text(label)),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final t in telegrams)
                  Container(
                    width: 140,
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Text(cellBuilder(t.telegramId) ?? '—'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
```

- [ ] **Step 2: ページ実装**

`tsunami_telegram_timeline_debug_page.dart`（`HookConsumerWidget`、`tsunamiId` 引数）。`AsyncValue` を `switch` で分岐し、`TsunamiTimeline.regions` / `offshoreStations` を縦リスト化、各追跡項目に `TsunamiTimelineRow` を使う。kind 行の `cellBuilder` 例: 変化点 map を作り `entry.telegramId == id` の値を返す。
```dart
// 例: kind 行のセル値
String? kindCell(RegionTimeline region, String id) {
  for (final e in region.kind) {
    if (e.telegramId == id) {
      return e.kind.name;
    }
  }
  return null;
}
```
（上記はウィジェットの private メソッド or ローカル関数としてビルド内に置く。トップレベル関数にしない。）

- [ ] **Step 3: 既存 debug 画面から遷移を追加**

`debug_tsunami_details_page.dart` の各 tsunami item に「タイムライン」ボタンを追加し `tsunami_telegram_timeline_debug_page.dart` へ push。
> 既存 `debug_tsunami_details_page.dart` は現状 `package:eqmonitor_api` を import している（別 Agent 管轄の未コミット変更あり）。本 Task では遷移追加のみ行い、API 型利用の除去は別タスク（必要なら `// ignore_for_file` 済み）。

- [ ] **Step 4: analyze（UI で eqmonitor_api 不参照を確認）**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/app
dart analyze lib/feature/settings/children/config/debug/tsunami 2>&1 | tail -15
grep -rn "package:eqmonitor_api" lib/feature/settings/children/config/debug/tsunami/tsunami_telegram_timeline_debug_page.dart lib/feature/settings/children/config/debug/tsunami/components/tsunami_timeline_row.dart || echo "no eqmonitor_api import (good)"
```
Expected: 新規ファイルに `avoid_eqmonitor_api_in_ui` 警告なし、eqmonitor_api import なし。

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/settings/children/config/debug/tsunami
git commit -m "feat(tsunami): debug横スクロールタイムライン画面を追加"
```

---

## Task 11: 最終 analyze ＆ format ＆ テスト

**Files:** （フォーマット対象の各変更ファイル）

- [ ] **Step 1: format**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
dart format app/lib/feature/tsunami app/lib/feature/settings/children/config/debug/tsunami app/test/feature/tsunami packages/eqmonitor_lints/lib
```

- [ ] **Step 2: melos run analyze（app＋packages、警告ゼロ）**

```bash
melos run analyze 2>&1 | tail -30
```
Expected: `No issues found!`（または error/warning 行なし）。残った警告は本 plan 範囲（tsunami / lints / eqmonitor_api）のものを修正。API リネーム由来の他 feature の警告は別 Agent 管轄として残ってよい（その場合は範囲外であることをコミットメッセージに明記）。

- [ ] **Step 3: melos run test（tsunami）**

```bash
cd app && flutter test test/feature/tsunami 2>&1 | tail -10
```
Expected: All tests passed!

- [ ] **Step 4: コミット**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
git add -A
git commit -m "chore(tsunami): format ＆ analyze 対応"
```

---

## Self-Review メモ

- **spec カバレッジ:** lint 規約=Task2、lint エラー修正=Task11、値 enum/concern ドメイン型=Task3/4、電文メタ=Task5、中間表現（Tracked）=Task6/7、公開型=Task8、Notifier=Task9、debug UI=Task10、telegram.id 前提=Task1。全項目に対応タスクあり。
- **型整合:** `toDomain()`（enum/concern）、`toTelegramMeta()`、`toTrackedTimeline()`、`toPublic()` の名称をタスク間で統一。`Tracked<T> = List<TrackedValue<T>>` を全 entity で使用。
- **既知の調整点（実装時に解消）:**
  - api 入れ子型の正式名（estimation first/max、station forecast first_height）は Task4 Step1.5 で grep 確認して合わせる。
  - `Ref` 型・Retrofit 戻り値 `.data` の正確な型は再生成後のコードに合わせる（Task9）。
  - `observation_timeline_entry` の表示フィールド粒度は Task8 実装時に first/max を内包する形で確定。
