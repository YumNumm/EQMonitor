# EQMonitor Agent Instructions

このファイルは `.cursor/rules/` の内容を統合したものです。
Cursor を使う場合は `.cursor/rules/*.mdc` が直接読み込まれます。

---

## GitHub / Pull Request・Issue（厳守）

- **PR と Issue を作成してよいのは YumNumm org のリポジトリのみ。upstream へは絶対に作成しない。**
- `gh pr create` / `gh issue create` では `--repo YumNumm/<repo>` を**必ず明示する**。省略禁止。
- 特に `third_party/flutter_scene` は `bdero/flutter_scene` の fork の submodule であり、この配下では `gh` が既定の送信先を **upstream** にする。`--repo` を省略すると upstream へ PR が飛ぶ。
- EQMonitor 本体のメインブランチは `develop`。PR のベースブランチは `develop` を指定する。
- Claude Code では `.claude/settings.json` の PreToolUse フックが `--repo YumNumm/` を含まない `gh pr create` / `gh issue create` を deny する。**このフックは Claude Code でしか動かない**ため、他のエージェント（Codex 等）では本ルールを自分で守ること。

---

## 生命に関わる情報・開発上の共通前提

このプロジェクトでは、緊急地震速報など生命に関わる情報を扱います。以下を守ってください。

- とりあえずで固定値にフォールバックしたり、ランダムに生成したりしないこと。
- やり残したことやその場しのぎのコードを入れることは推奨されません。入れた場合は、プロジェクトルートの `docs/todo/{level}_{title}.md` に記載してください。`level` は3桁の整数で、数値が大きいほど優先度が高いです。
  - 今後検討すべき課題や改善点を見つけた場合も、同様にtodoに記載してください。

## Flutter アプリ（クライアント）

- 数万人規模の利用を想定する。コードの品質・可読性はもちろん、単体テスト・Widget テストなどを充実させ、バグの低減につなげること。
- データの読み込み中・エラー時の表示は雑になりがちです。例外をそのまま表示して overflow したりしないよう、その場に合わせた正しい表示を開発者と検討し実装すること。

## テスト方針

- TDD は有効な選択肢だが、一律の必須手順にはしない。ユーザーの指示と変更リスクに応じて、テスト先行・テスト追加・既存テストによる回帰確認を選択する。
- 文言や情報配置など表示専用の軽微な変更では、Widget Test の追加を必須としない。
- 緊急情報の判定、データ変換、状態遷移、通知条件、永続化、障害修正など、誤動作の影響や回帰リスクが高いロジックには自動テストを用意する。
- 新しいテストを追加しない場合も、関連する既存テストと静的解析を実行し、追加しない理由を作業結果に記載する。

---

## EQMonitor Flutter / Dart コーディング規約

> 対象ファイル: `*.dart`

### ツール・コマンド

- Flutter / Dart に関するコマンドは常に `mise exec --` 経由で実行する
- 依存追加は `flutter pub add` を使う（pubspec.yaml を直接編集しない）
- コード生成: `dart run build_runner build --delete-conflicting-outputs`

### 設計原則

- SOLID 原則を厳格に適用する
- Presentation（Widget）・Domain（ロジック）・Data（リポジトリ / API）のレイヤー構成
- レイヤー内の命令的な処理は、パッケージ側の宣言的な実装で代替できないか検討する（不可能または機能欠損が生じる場合は命令的な実装も可）

### ディレクトリ構成

#### 全体構造

```
lib/
├── core/          # アプリ全体の根幹（共通コンポーネント・テーマ・ルーター・ユーティリティ等）
├── features/      # 機能単位のモジュール
├── page/          # トップレベルのページ（必要に応じて）
├── app.dart
└── main.dart
```

#### features/${NAME}/ の構造

```
features/${NAME}/
├── data/
│   ├── model/
│   ├── repository/
│   ├── data_source/   # (任意) 複数APIや複雑性がある場合のみ
│   ├── notifier/
│   ├── provider/
│   └── flow/
└── ui/
    ├── page/          # *_page.dart を配置
    └── components/    # 再利用可能な Widget を配置
```

#### Data 層の各ディレクトリの役割

**`data/model/`**

- アプリ固有の型定義を行う
- API パッケージの型は `as api` でエイリアス import し、アプリの型に変換する extension を定義する
- Freezed を積極的に利用する
- 新しい型を作成する前に、既存の型に類似・重複するものがないか必ず確認する
  - 同じフィールド構成（code + name + intensity 等）を持つ型がないか検索する
  - 別 feature に同様の役割を持つ型がないか確認する
  - 汎用的なレスポンス型（ページネーション等）が既に存在しないか確認する
  - 重複がある場合は、既存の型を拡張・再利用する方針を優先する

```dart
import 'package:eqapi_types/eqapi_types.dart' as api;

extension EarthquakeModelConverter on api.EarthquakeResponse {
  EarthquakeModel toModel() => EarthquakeModel(...);
}
```

**`data/repository/`**

- API の Fetch と型変換を担う
- API 通信を行うものは `Future<Result<T, ApiException>>` を返す（例外あり）
- Riverpod で DI する
- 基本的にすべての外部データアクセスは repository を経由する

**`data/notifier/`**

- アプリケーションの状態を保持する
- `@riverpod` アノテーションを使用する
- 副作用を持つ関数は Riverpod 3 の Mutation を利用する

**`data/provider/`**

- notifier を持たない、派生・加工された状態（computed provider）のみを配置する

**`data/flow/`**

- 非同期処理の後にダイアログ表示や画面遷移など UI 操作を伴うユースケースを記述する
- Riverpod 関連で唯一、関数の引数に `WidgetRef ref` と `BuildContext context` を持つことが許される

#### UI 層

- `ui/page/`: 画面全体を表す Widget を `*_page.dart` として配置（`_screen.dart` は使わない）
- `ui/components/`: その feature 内で再利用する Widget を配置

### 状態管理

- Riverpod + flutter_hooks を使用する
- StatefulWidget は基本的に利用しない。HookWidget または HookConsumerWidget で状態を管理する

### ルーティング

- go_router + go_router_builder を使用する

### 型安全

- `dynamic`、`any`、`Object` 型は `Map<String, dynamic>` 以外での利用を禁止
- Null Safety: `!` 演算子の使用を禁止する。`?` とフロー解析で安全に扱う

### Widget 設計

- Widget のコードを不用意に長くしない。再利用しない Widget は private class で作成する
- Widget に関数やゲッターを定義することを禁止する
- build メソッドは純粋かつ高速に保つ。副作用やネットワーク呼び出しを含めない
- `const` コンストラクタを積極的に使用する
- リスト表示には `ListView.builder` または `SliverList` を使用する（`SingleChildScrollView` は基本不使用）
- テキストを含む要素に固定の高さを数値指定しない（textScale 拡大時の overflow 防止）

### ビジュアルデザイン（Material 3）

- `ThemeData` + `ColorScheme.fromSeed` でテーマを構築する
- Light / Dark モード両対応（`ThemeMode.system`）
- カスタムトークン（色・サイズ）には `ThemeExtension` を使用する

### 命名規則

- 型名: `PascalCase`
- メンバー: `camelCase`
- ファイル名: `snake_case`
- 画面ファイル: `*_page.dart`（`*_screen.dart` は使わない）

### ログ

- 基本的に talker を使用する
- `print()` の使用を禁止する

### コードスタイル

- 2つ以上の引数を持つ関数・クラスは原則として名前付き引数を使用する
- 関数は簡潔に保つ（目安: 20 行以内）
- 内部で非同期処理を `unawaited` するくらいなら、関数自体を `async` にして `await` すること
- コメントはコード上明らかな部分には不要。複雑な処理や実装意図が読み取りにくい箇所にのみ書く
- 重い処理（JSON パース等）には `compute()` で Isolate を活用する
- enum 等で dart の dot shorthand を利用できる場合は利用する

### プライベート関数の禁止と代替設計

クラス内でのプライベートメソッドは、テスト可能性を損なうため原則禁止する。

**ロジック系**: 処理を行う専用クラスを別ファイルに切り出し、Riverpod で DI する

```dart
// ✅ 良い例
@riverpod
RegionGeoJsonBuilder regionGeoJsonBuilder(Ref ref) => RegionGeoJsonBuilder();

class RegionGeoJsonBuilder {
  String build({required List<Region> regions}) { ... }
}
```

**イベントハンドラ系**: `XxxAction` クラスとして別ファイルに切り出し、Riverpod で DI する

```dart
// ✅ 良い例
@riverpod
EarthquakeHistoryMapAction earthquakeHistoryMapAction(Ref ref) =>
    EarthquakeHistoryMapAction();

class EarthquakeHistoryMapAction {
  void handleTap(WidgetRef ref, BuildContext context, LatLng point) { ... }
}
```

- `ref` / `context` を Action クラスのコンストラクタに渡すことを禁止する
- **Action 以外のクラス・関数**に `ref` や `context` を渡すことを絶対に禁止する（`data/flow/` の flow 関数は除く）

**switch 式 / 単純な変換のための関数**: 一箇所のみで使う場合は関数に切り出さず変数・定数として直接定義する

```dart
// ✅ 良い例
final label = switch (mode) { ... };
```

---

## コミット規約

差分をチェックし、1コミットあたり30~100行程度の粒度でコミットしてください。コミットが完了したらpushすること。

コミットメッセージは英語1単語のprefixをつけ、説明は1行で簡潔な日本語で示すこと。
1行で内容を要約できない場合はコミットを分割するか、コミットメッセージを複数行で記述することを検討してください。

差分を取得する時は、`--no-pager` を使うこと。

---

## Preferences キー管理規約

> 対象ファイル: `app/lib/**/*.dart`, `packages/*/lib/**/*.dart`

ストレージのキー文字列をコード中にハードコードすることを禁止する。キーは必ず専用の enum で一元管理すること。

### SharedPreferences

キーは `app/lib/core/data/preferences/shared/shared_preferences_key.dart` の `SharedPreferencesKey` enum に追加する。

```dart
// ❌ 悪い例
const kMyKey = 'my_key';
prefs.getString('my_key');

// ✅ 良い例
enum SharedPreferencesKey {
  myKey('my_key'),
  ;
}
prefs.getString(SharedPreferencesKey.myKey.key);
```

### SecureStorage

キーは `app/lib/core/data/preferences/secure/secure_storage_key.dart` の `SecureStorageKey` enum に追加する。
アクセスは必ず `SecurePreferencesDataSource` 経由で行う（`FlutterSecureStorage` を直接呼ばない）。

```dart
// ❌ 悪い例
secureStorage.read(key: 'my_secret');

// ✅ 良い例
enum SecureStorageKey { mySecret('my_secret'); }
final ds = await ref.read(securePreferencesDataSourceProvider.future);
ds.getString(key: SecureStorageKey.mySecret);
```

### チェックリスト

- 同じ用途のキーが既に enum に存在しないか確認する
- キー文字列は `snake_case` で統一する
- レガシーキー（移行用）の場合はコメントでその旨を明記する

---

## 知見の記録ルール

作業中に判明した重要な知見・運用上の注意点・プラットフォーム固有の情報は、会話が終わる前に `docs/knowledge/{YYYYMMDD}_<topic>.md` にルールとして残す。

### ルール作成のトリガー

ルールは次の場合に必ず作成する。

- Flutter / Dart・リリース周りの運用フロー（例: `dart-define` の渡し方、ストア提出・審査手順、CI でのビルド・署名）
- プラットフォーム固有の制約・注意点（例: iOS のバックグラウンド・権限、Android の通知チャネル）
- ハマった問題と解決策（例: `build_runner` とパッケージバージョンの不一致、CocoaPods / Gradle の衝突）
- ユーザーが「今後も考慮すべき」と指摘した内容

### フォーマット

- 内容は簡潔に・具体的なコマンド例を含める（500行以内）
- ルール作成後は必ずコミット・プッシュする
