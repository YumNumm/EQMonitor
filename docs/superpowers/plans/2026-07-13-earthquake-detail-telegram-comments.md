# 地震履歴詳細画面: 電文コメント表示 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴詳細画面の地図右下「データソース: …」ラベル内に、電文の固定付加文・自由付加文を表示する。

**Architecture:** 詳細APIレスポンスに既に含まれる電文コメントを、`toEarthquake` 変換時に新ドメインモデル `EarthquakeTelegramComment` として保持する。表示対象の選択（VXSE53優先、なければ51+52、6xは追加）は純粋関数で実装し単体テストする。UIは既存ラベルカードの `Text` を `Column` 化してコメント行を追加するだけ。追加API呼び出しなし。

**Tech Stack:** Flutter / Dart 3.11, Riverpod, freezed + json_serializable（`build_runner` でコード生成、生成ファイルはコミット対象）

**Spec:** `docs/superpowers/specs/2026-07-13-earthquake-detail-telegram-comments-design.md`

## Global Constraints

- `dart analyze` 警告ゼロ（CI必須）。`dart format` 済みであること。
- 生成ファイル（`*.freezed.dart`, `*.g.dart`)はコミットする。
- クロスパッケージ依存は package import（相対import禁止）。
- 作業ディレクトリ: リポジトリルート（`app/` はFlutterアプリ）。
- **注意（既知の問題）**: `dart analyze` は app/ でプラグイン起因でハングすることがある。必ず `timeout 300` を付けて実行する。
- コミットメッセージは日本語・Conventional Commits（例: `feat: ...`）。

---

### Task 1: `EarthquakeTelegramComment` モデルと抽出関数

**Files:**
- Create: `app/lib/feature/earthquake_history/data/model/earthquake_telegram_comment.dart`
- Create: `app/test/feature/earthquake_history/earthquake_telegram_comment_test.dart`
- 生成される: 同ディレクトリの `earthquake_telegram_comment.freezed.dart` / `.g.dart`

**Interfaces:**
- Consumes: `api.EarthquakeTelegram`（`package:eqmonitor_api` — `telegram: Telegram`, `comments: TelegramComments?`）、`EarthquakeTelegramType` と拡張 `toEarthquakeTelegramTypeOrNull`（`app/lib/feature/earthquake_history/data/model/earthquake_telegram_type.dart`）
- Produces:
  - `class EarthquakeTelegramComment { EarthquakeTelegramType type; DateTime reportedAt; String? additional; String? free; }`（freezed / JSON対応）
  - `List<EarthquakeTelegramComment> extractTelegramComments(List<api.EarthquakeTelegram> telegrams)`

- [ ] **Step 1: モデルファイルを作成（抽出関数はまだ書かない）**

`app/lib/feature/earthquake_history/data/model/earthquake_telegram_comment.dart`:

```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_telegram_comment.freezed.dart';
part 'earthquake_telegram_comment.g.dart';

/// 電文に付随するコメント（固定付加文・自由付加文）
@freezed
abstract class EarthquakeTelegramComment with _$EarthquakeTelegramComment {
  const factory EarthquakeTelegramComment({
    required EarthquakeTelegramType type,
    required DateTime reportedAt,

    /// 固定付加文
    required String? additional,

    /// 自由付加文
    required String? free,
  }) = _EarthquakeTelegramComment;

  factory EarthquakeTelegramComment.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeTelegramCommentFromJson(json);
}
```

（`api` importはこの時点では未使用warningになるため、Step 3の抽出関数追加まで import 行を入れず、Step 5で追加してもよい。シンプルにするなら Step 5 実装時にまとめて import を整える。）

- [ ] **Step 2: コード生成を実行**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `Succeeded after ...` で `earthquake_telegram_comment.freezed.dart` / `.g.dart` が生成される

- [ ] **Step 3: 抽出関数の失敗するテストを書く**

`app/test/feature/earthquake_history/earthquake_telegram_comment_test.dart`:

```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

api.EarthquakeTelegram _telegram({
  required api.TelegramType type,
  required DateTime reportedAt,
  api.TelegramComments? comments,
}) => api.EarthquakeTelegram(
  telegram: api.Telegram(
    id: '${type.name}-${reportedAt.toIso8601String()}',
    eventId: '20260713120000',
    type: type,
    title: 'タイトル',
    status: api.TelegramStatus.normal,
    infoType: api.InfoType.publication,
    editorialOffice: '気象庁本庁',
    publishingOffice: const ['気象庁'],
    pressedAt: reportedAt,
    reportedAt: reportedAt,
    infoKind: '地震情報',
    infoKindVersion: '1.0',
    hash: 'hash',
    createdAt: reportedAt,
  ),
  comments: comments,
);

void main() {
  group('extractTelegramComments', () {
    test('コメント付きの対象電文を変換する', () {
      final reportedAt = DateTime(2026, 7, 13, 12);
      final result = extractTelegramComments([
        _telegram(
          type: api.TelegramType.vxse53,
          reportedAt: reportedAt,
          comments: const api.TelegramComments(
            additional: 'この地震による津波の心配はありません。',
            free: '自由付加文です。',
          ),
        ),
      ]);

      expect(result, [
        EarthquakeTelegramComment(
          type: EarthquakeTelegramType.vxse53,
          reportedAt: reportedAt,
          additional: 'この地震による津波の心配はありません。',
          free: '自由付加文です。',
        ),
      ]);
    });

    test('commentsがnullの電文は除外する', () {
      final result = extractTelegramComments([
        _telegram(
          type: api.TelegramType.vxse53,
          reportedAt: DateTime(2026, 7, 13, 12),
        ),
      ]);
      expect(result, isEmpty);
    });

    test('additionalもfreeもnullの電文は除外する', () {
      final result = extractTelegramComments([
        _telegram(
          type: api.TelegramType.vxse53,
          reportedAt: DateTime(2026, 7, 13, 12),
          comments: const api.TelegramComments(text: '主文のみ'),
        ),
      ]);
      expect(result, isEmpty);
    });

    test('対象外タイプ（VXSE45等）は除外する', () {
      final result = extractTelegramComments([
        _telegram(
          type: api.TelegramType.vxse45,
          reportedAt: DateTime(2026, 7, 13, 12),
          comments: const api.TelegramComments(additional: '固定付加文'),
        ),
      ]);
      expect(result, isEmpty);
    });
  });
}
```

- [ ] **Step 4: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/earthquake_telegram_comment_test.dart`
Expected: コンパイルエラー `The function 'extractTelegramComments' isn't defined` で FAIL

- [ ] **Step 5: 抽出関数を実装**

`earthquake_telegram_comment.dart` の末尾に追加（`api` importが有効になる）:

```dart
/// APIの電文リストからコメント（固定付加文・自由付加文）を持つ電文を抽出する
List<EarthquakeTelegramComment> extractTelegramComments(
  List<api.EarthquakeTelegram> telegrams,
) => telegrams
    .map((e) {
      final type = e.telegram.type.toEarthquakeTelegramTypeOrNull;
      final comments = e.comments;
      if (type == null || comments == null) {
        return null;
      }
      if (comments.additional == null && comments.free == null) {
        return null;
      }
      return EarthquakeTelegramComment(
        type: type,
        reportedAt: e.telegram.reportedAt,
        additional: comments.additional,
        free: comments.free,
      );
    })
    .nonNulls
    .toList();
```

- [ ] **Step 6: テストが通ることを確認**

Run: `cd app && flutter test test/feature/earthquake_history/earthquake_telegram_comment_test.dart`
Expected: `All tests passed!`（4件）

- [ ] **Step 7: フォーマット・コミット**

```bash
cd app && dart format lib/feature/earthquake_history/data/model/earthquake_telegram_comment.dart test/feature/earthquake_history/earthquake_telegram_comment_test.dart
git add app/lib/feature/earthquake_history/data/model/earthquake_telegram_comment.dart app/lib/feature/earthquake_history/data/model/earthquake_telegram_comment.freezed.dart app/lib/feature/earthquake_history/data/model/earthquake_telegram_comment.g.dart app/test/feature/earthquake_history/earthquake_telegram_comment_test.dart
git commit -m "feat: 電文コメントのドメインモデルと抽出関数を追加"
```

---

### Task 2: 表示コメント選択ロジック `selectTelegramCommentLines`

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake_telegram_comment.dart`（Task 1で作成したファイルの末尾に関数追加）
- Modify: `app/test/feature/earthquake_history/earthquake_telegram_comment_test.dart`（groupを追加）

**Interfaces:**
- Consumes: `EarthquakeTelegramComment`（Task 1）、`String.toHalfWidth`（`package:extensions/extensions.dart`、全角ASCII→半角変換）
- Produces: `List<String> selectTelegramCommentLines(List<EarthquakeTelegramComment> comments)` — 1要素=表示1行。空リスト=表示なし。

- [ ] **Step 1: 失敗するテストを書く**

`earthquake_telegram_comment_test.dart` の `main()` 内に group を追加:

```dart
group('selectTelegramCommentLines', () {
  EarthquakeTelegramComment comment({
    required EarthquakeTelegramType type,
    required DateTime reportedAt,
    String? additional,
    String? free,
  }) => EarthquakeTelegramComment(
    type: type,
    reportedAt: reportedAt,
    additional: additional,
    free: free,
  );

  test('VXSE53があれば53のコメントを採用し51/52は無視する', () {
    final lines = selectTelegramCommentLines([
      comment(
        type: EarthquakeTelegramType.vxse51,
        reportedAt: DateTime(2026, 7, 13, 12),
        additional: '速報の付加文',
      ),
      comment(
        type: EarthquakeTelegramType.vxse53,
        reportedAt: DateTime(2026, 7, 13, 12, 10),
        additional: 'この地震による津波の心配はありません。',
      ),
    ]);
    expect(lines, ['この地震による津波の心配はありません。']);
  });

  test('VXSE53が複数あればreportedAtが最新のものを採用する', () {
    final lines = selectTelegramCommentLines([
      comment(
        type: EarthquakeTelegramType.vxse53,
        reportedAt: DateTime(2026, 7, 13, 12, 20),
        additional: '最新の付加文',
      ),
      comment(
        type: EarthquakeTelegramType.vxse53,
        reportedAt: DateTime(2026, 7, 13, 12, 10),
        additional: '古い付加文',
      ),
    ]);
    expect(lines, ['最新の付加文']);
  });

  test('VXSE53がなければ51と52のコメントを結合する', () {
    final lines = selectTelegramCommentLines([
      comment(
        type: EarthquakeTelegramType.vxse51,
        reportedAt: DateTime(2026, 7, 13, 12),
        additional: '今後の情報に注意してください。',
      ),
      comment(
        type: EarthquakeTelegramType.vxse52,
        reportedAt: DateTime(2026, 7, 13, 12, 5),
        additional: 'この地震による津波の心配はありません。',
      ),
    ]);
    expect(lines, [
      '今後の情報に注意してください。',
      'この地震による津波の心配はありません。',
    ]);
  });

  test('VXSE6xのコメントは53に追加して表示する', () {
    final lines = selectTelegramCommentLines([
      comment(
        type: EarthquakeTelegramType.vxse53,
        reportedAt: DateTime(2026, 7, 13, 12, 10),
        additional: 'この地震による津波の心配はありません。',
      ),
      comment(
        type: EarthquakeTelegramType.vxse61,
        reportedAt: DateTime(2026, 7, 13, 13),
        free: '地震活動に関するお知らせ。',
      ),
    ]);
    expect(lines, [
      'この地震による津波の心配はありません。',
      '地震活動に関するお知らせ。',
    ]);
  });

  test('additionalとfreeの両方があればその順で表示し、同一文言は重複除去する', () {
    final lines = selectTelegramCommentLines([
      comment(
        type: EarthquakeTelegramType.vxse51,
        reportedAt: DateTime(2026, 7, 13, 12),
        additional: 'この地震による津波の心配はありません。',
        free: '自由付加文です。',
      ),
      comment(
        type: EarthquakeTelegramType.vxse52,
        reportedAt: DateTime(2026, 7, 13, 12, 5),
        additional: 'この地震による津波の心配はありません。',
      ),
    ]);
    expect(lines, [
      'この地震による津波の心配はありません。',
      '自由付加文です。',
    ]);
  });

  test('全角英数は半角に変換される', () {
    final lines = selectTelegramCommentLines([
      comment(
        type: EarthquakeTelegramType.vxse53,
        reportedAt: DateTime(2026, 7, 13, 12, 10),
        free: '地震の規模はＭ７．０です。',
      ),
    ]);
    expect(lines, ['地震の規模はM7.0です。']);
  });

  test('空入力なら空リストを返す', () {
    expect(selectTelegramCommentLines([]), isEmpty);
  });
});
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/earthquake_telegram_comment_test.dart`
Expected: コンパイルエラー `The function 'selectTelegramCommentLines' isn't defined` で FAIL

- [ ] **Step 3: 選択ロジックを実装**

`earthquake_telegram_comment.dart` に import を追加:

```dart
import 'package:extensions/extensions.dart';
```

末尾に関数を追加:

```dart
/// 詳細画面に表示するコメント行を選択する
///
/// - VXSE53 があれば最新（reportedAt基準）の53をベースに採用、
///   なければ最新の51と52を結合
/// - VXSE61 / VXSE62 のコメントは追加で表示（タイプごとに最新）
/// - 各電文から固定付加文（additional）→自由付加文（free）の順に収集し、
///   半角化のうえ同一文言は重複除去する
List<String> selectTelegramCommentLines(
  List<EarthquakeTelegramComment> comments,
) {
  EarthquakeTelegramComment? latestOf(EarthquakeTelegramType type) {
    EarthquakeTelegramComment? latest;
    for (final comment in comments) {
      if (comment.type != type) {
        continue;
      }
      if (latest == null || comment.reportedAt.isAfter(latest.reportedAt)) {
        latest = comment;
      }
    }
    return latest;
  }

  final vxse53 = latestOf(EarthquakeTelegramType.vxse53);
  final base = vxse53 != null
      ? [vxse53]
      : [
          latestOf(EarthquakeTelegramType.vxse51),
          latestOf(EarthquakeTelegramType.vxse52),
        ].nonNulls.toList();

  final selected = [
    ...base,
    latestOf(EarthquakeTelegramType.vxse61),
    latestOf(EarthquakeTelegramType.vxse62),
  ].nonNulls;

  final lines = <String>[];
  for (final comment in selected) {
    for (final text in [comment.additional, comment.free]) {
      if (text == null || text.isEmpty) {
        continue;
      }
      final line = text.toHalfWidth;
      if (!lines.contains(line)) {
        lines.add(line);
      }
    }
  }
  return lines;
}
```

- [ ] **Step 4: テストが通ることを確認**

Run: `cd app && flutter test test/feature/earthquake_history/earthquake_telegram_comment_test.dart`
Expected: `All tests passed!`（Task 1の4件 + 7件 = 11件）

- [ ] **Step 5: フォーマット・コミット**

```bash
cd app && dart format lib/feature/earthquake_history/data/model/earthquake_telegram_comment.dart test/feature/earthquake_history/earthquake_telegram_comment_test.dart
git add app/lib/feature/earthquake_history/data/model/earthquake_telegram_comment.dart app/test/feature/earthquake_history/earthquake_telegram_comment_test.dart
git commit -m "feat: 電文コメントの表示選択ロジックを追加"
```

---

### Task 3: ドメイン `Earthquake` にコメントを保持

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake.dart`
- Create: `app/test/feature/earthquake_history/earthquake_model_test.dart`
- 再生成される: `earthquake.freezed.dart` / `earthquake.g.dart`

**Interfaces:**
- Consumes: `EarthquakeTelegramComment` / `extractTelegramComments`（Task 1）
- Produces: `Earthquake.telegramComments`（`List<EarthquakeTelegramComment>`、デフォルト空リスト）。`toEarthquake` がAPIレスポンスから自動で詰める。

- [ ] **Step 1: 後方互換の失敗するテストを書く**

`app/test/feature/earthquake_history/earthquake_model_test.dart`:

```dart
import 'dart:convert';

import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Earthquake.telegramComments', () {
    Earthquake buildEarthquake() => Earthquake(
      eventId: '20260713120000',
      status: TelegramStatus.normal,
      originTime: DateTime(2026, 7, 13, 12),
      originTimePrecision: OriginTimePrecision.second,
      arrivalTime: null,
      dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
      telegramTypes: const [EarthquakeTelegramType.vxse53],
      telegramComments: [
        EarthquakeTelegramComment(
          type: EarthquakeTelegramType.vxse53,
          reportedAt: DateTime(2026, 7, 13, 12),
          additional: 'この地震による津波の心配はありません。',
          free: null,
        ),
      ],
      hypocenter: null,
      intensity: null,
      estimatedIntensityTileUrl: null,
    );

    test('JSON往復でtelegramCommentsが保持される', () {
      final earthquake = buildEarthquake();
      final json =
          jsonDecode(jsonEncode(earthquake.toJson())) as Map<String, dynamic>;
      expect(Earthquake.fromJson(json), earthquake);
    });

    test('telegramCommentsキーがない旧キャッシュJSONは空リストになる', () {
      final earthquake = buildEarthquake();
      final json =
          jsonDecode(jsonEncode(earthquake.toJson())) as Map<String, dynamic>
            ..remove('telegramComments');
      expect(Earthquake.fromJson(json).telegramComments, isEmpty);
    });
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/earthquake_model_test.dart`
Expected: コンパイルエラー `No named parameter with the name 'telegramComments'` で FAIL

- [ ] **Step 3: `Earthquake` にフィールドを追加し `toEarthquake` を拡張**

`app/lib/feature/earthquake_history/data/model/earthquake.dart` に import を追加:

```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
```

factory の `telegramTypes` の直後にフィールドを追加:

```dart
    required List<EarthquakeTelegramType> telegramTypes,

    /// 電文コメント（固定付加文・自由付加文）
    @Default([]) List<EarthquakeTelegramComment> telegramComments,
```

`toEarthquake` の `telegramTypes: ...` の直後に追加:

```dart
    telegramComments: extractTelegramComments(telegrams),
```

- [ ] **Step 4: コード生成を実行**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `Succeeded after ...` で `earthquake.freezed.dart` / `earthquake.g.dart` が更新される

- [ ] **Step 5: テストが通ることを確認**

Run: `cd app && flutter test test/feature/earthquake_history/`
Expected: `All tests passed!`（Task 1〜2の11件 + 2件）

- [ ] **Step 6: フォーマット・コミット**

```bash
cd app && dart format lib/feature/earthquake_history/data/model/earthquake.dart test/feature/earthquake_history/earthquake_model_test.dart
git add app/lib/feature/earthquake_history/data/model/earthquake.dart app/lib/feature/earthquake_history/data/model/earthquake.freezed.dart app/lib/feature/earthquake_history/data/model/earthquake.g.dart app/test/feature/earthquake_history/earthquake_model_test.dart
git commit -m "feat: ドメインEarthquakeに電文コメントを保持"
```

---

### Task 4: 詳細画面のデータソースラベルにコメントを表示

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart`（`_LoadedContent.build` とデータソースラベル部、現227-260行付近）

**Interfaces:**
- Consumes: `Earthquake.telegramComments`（Task 3）、`selectTelegramCommentLines`（Task 2）
- Produces: UIのみ（他タスクからの依存なし）

- [ ] **Step 1: import と表示行の算出を追加**

import 追加（アルファベット順の位置に）:

```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
```

`_LoadedContent.build` 内の `final designSystem = context.designSystem;` の直後に追加:

```dart
    final telegramCommentLines = selectTelegramCommentLines(
      earthquake.telegramComments,
    );
```

- [ ] **Step 2: ラベルカード内を Column 化してコメント行を追加**

データソースラベルの `BackdropFilter` 内 `Padding` の child を、既存の単一 `Text` から以下に置き換える:

```dart
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (final line in telegramCommentLines)
                            Text(
                              line,
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.end,
                            ),
                          Text(
                            'データソース: ${earthquake.dataSources.map((e) => switch (e) {
                              .jmaDisasterInformationXml => "気象庁災害情報XML",
                              .jmaIntensityDatabase => "気象庁震度データベース",
                            }).join(', ')}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
```

（「データソース: …」の `Text` は既存のまま、`Column` の最後の子に移動するだけ。`telegramCommentLines` が空なら従来と同一表示。）

- [ ] **Step 3: 静的解析**

Run: `cd app && timeout 300 dart analyze .`
Expected: `No issues found!`（ハングしたらtimeoutで打ち切り、`dart analyze lib/feature/earthquake_history` で再試行）

- [ ] **Step 4: アプリ全体のテストを実行**

Run: `cd app && flutter test`
Expected: 既存テスト含め `All tests passed!`

- [ ] **Step 5: フォーマット・コミット**

```bash
cd app && dart format lib/feature/earthquake_history/ui/earthquake_history_details_page.dart
git add app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart
git commit -m "feat: 地震履歴詳細画面のデータソースラベルに電文コメントを表示"
```

---

## 完了後

- superpowers:verification-before-completion → superpowers:finishing-a-development-branch に従う。
- PRを作る場合: base `develop`、`gh pr create --repo YumNumm/EQMonitor --base develop`（CLAUDE.md 厳守）。
