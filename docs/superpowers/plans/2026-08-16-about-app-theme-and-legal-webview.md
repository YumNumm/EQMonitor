# About App Theme and Legal WebView Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 「このアプリについて」の本文を両テーマで読めるデザインシステム準拠UIにし、利用規約とプライバシーポリシーを共通のアプリ内WebViewで表示する。

**Architecture:** Markdown本文の表示責務は設定機能に残し、スタイルだけを `context.designSystem` から明示的に構築する。WebView本体と読み込み状態UIは `core/component/web_view` に分離し、オンボーディングと法的文書ルートが同じ `AppWebViewPage` を利用する。

**Tech Stack:** Flutter, Dart, flutter_hooks, flutter_markdown, flutter_inappwebview, go_router_builder, flutter_test

## Global Constraints

- Flutter / Dart コマンドは必ず `mise exec --` 経由で実行する。
- 利用規約 URL は `https://eqmonitor.app/term_of_service` とする。
- プライバシーポリシー URL は `https://eqmonitor.app/privacy_policy` とする。
- ライト・ダーク両テーマでデザインシステムの color、typography、spacing、shape を使う。
- 例外文字列を利用者向け画面へ直接表示しない。
- `StatefulWidget`、`dynamic`、`Object`、`!` 演算子、`print()`、テキストを含む固定高さを導入しない。
- ユーザーが変更済みの `analysis_options.yaml`、`mise.lock`、各 package の `analysis_options.yaml` は編集・ステージしない。

---

## File Map

- Create `app/lib/core/component/web_view/app_web_view_body.dart`: WebViewの loading / loaded / error 表示だけを担当する。
- Create `app/lib/core/component/web_view/app_web_view_page.dart`: `InAppWebView` のイベントを表示状態へ変換する共通ページ。
- Delete `app/lib/feature/onboarding/ui/page/onboarding_web_view_page.dart`: 共通ページへ置き換える。
- Rename `app/lib/feature/settings/children/application_info/about_this_app.dart` to `about_this_app_page.dart`: デザインシステム準拠のアプリ情報ページ。
- Delete `app/lib/feature/settings/children/application_info/term_of_service_page.dart`: WebViewルートへ置き換える。
- Delete `app/lib/feature/settings/children/application_info/privacy_policy_page.dart`: WebViewルートへ置き換える。
- Modify `app/lib/core/router/router.dart`: 共通WebView import、法的文書URL、不要なルート引数を更新する。
- Modify `app/lib/core/router/router.g.dart`: `go_router_builder` による生成結果。
- Modify `app/lib/feature/onboarding/ui/components/onboarding_bottom_bar.dart`: 引数なし法的文書ルートを呼ぶ。
- Create `app/test/feature/settings/children/application_info/about_this_app_page_test.dart`: 両テーマのMarkdown表示を検証する。
- Create `app/test/core/component/web_view/app_web_view_body_test.dart`: loading / loaded / error / retry を検証する。
- Create `app/test/core/router/legal_document_route_test.dart`: 各法的文書ルートのタイトルとURLを検証する。

---

### Task 1: 「このアプリについて」をデザインシステムへ統一

**Files:**
- Create: `app/test/feature/settings/children/application_info/about_this_app_page_test.dart`
- Rename: `app/lib/feature/settings/children/application_info/about_this_app.dart` → `app/lib/feature/settings/children/application_info/about_this_app_page.dart`
- Modify: `app/lib/core/router/router.dart`

**Interfaces:**
- Consumes: `buildTheme({required ThemeColorSet colorSet, required Brightness brightness})`, `BuildContext.designSystem`
- Produces: `AboutThisAppPage`, デザインシステム由来の `MarkdownStyleSheet`

- [ ] **Step 1: ダークテーマで本文色が背景と同化する回帰テストを書く**

`DefaultAssetBundle` で短いMarkdownを返し、ライト・ダークをそれぞれpumpする。壊れ方は「`MarkdownBody` がテーマ固有の本文色を使わない」と定義する。

```dart
testWidgets('Markdown本文はテーマのonSurface色を使う', (tester) async {
  final appTheme = AppTheme.eqmonitorDefault();
  for (final brightness in Brightness.values) {
    final colorSet = brightness == Brightness.light
        ? appTheme.light
        : appTheme.dark;
    if (colorSet == null) {
      throw StateError('$brightness theme is missing');
    }

    await tester.pumpWidget(
      DefaultAssetBundle(
        bundle: _MarkdownAssetBundle(),
        child: MaterialApp(
          theme: buildTheme(colorSet: colorSet, brightness: brightness),
          home: const AboutThisAppPage(),
        ),
      ),
    );
    await tester.pump();

    final markdown = tester.widget<MarkdownBody>(find.byType(MarkdownBody));
    expect(markdown.styleSheet?.p?.color, colorSet.onSurface);
    expect(markdown.styleSheet?.a?.color, colorSet.primary);
    expect(find.byType(ListView), findsOneWidget);
  }
});

final class _MarkdownAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async =>
      ByteData.sublistView(Uint8List.fromList(utf8.encode('# 見出し\n本文')));
}
```

- [ ] **Step 2: 対象テストを実行してREDを確認する**

Run:

```bash
mise exec -- flutter test app/test/feature/settings/children/application_info/about_this_app_page_test.dart
```

Expected: `AboutThisAppPage` が未定義、または既存 `MarkdownBody.styleSheet` の本文色が期待値と一致せずFAIL。

- [ ] **Step 3: ページをリネームし、デザインシステムのスタイルを適用する**

`AboutThisAppPage.build` の先頭で `final designSystem = context.designSystem;` を取得する。`SingleChildScrollView` + `Column` を `ListView` へ変更し、次を明示する。

```dart
final markdownStyleSheet = MarkdownStyleSheet(
  a: designSystem.typography.bodyMedium.copyWith(
    color: designSystem.colorTheme.primary,
    decoration: TextDecoration.underline,
  ),
  p: designSystem.typography.bodyMedium.copyWith(
    color: designSystem.colorTheme.onSurface,
  ),
  code: designSystem.typography.monoSmall.copyWith(
    color: designSystem.colorTheme.onSurface,
    backgroundColor: designSystem.colorTheme.surfaceContainerHigh,
  ),
  h1: designSystem.typography.headlineSmall,
  h2: designSystem.typography.titleLarge,
  h3: designSystem.typography.titleMedium,
  h4: designSystem.typography.titleSmall,
  h5: designSystem.typography.bodyLarge,
  h6: designSystem.typography.bodyMedium,
  blockquote: designSystem.typography.bodyMedium.copyWith(
    color: designSystem.colorTheme.onSurfaceVariant,
  ),
  listBullet: designSystem.typography.bodyMedium.copyWith(
    color: designSystem.colorTheme.onSurface,
  ),
  blockSpacing: designSystem.spacing.sm,
  listIndent: designSystem.spacing.xxl,
  codeblockPadding: EdgeInsets.all(designSystem.spacing.sm),
  codeblockDecoration: BoxDecoration(
    color: designSystem.colorTheme.surfaceContainerHigh,
    borderRadius: BorderRadius.circular(designSystem.shape.sm),
  ),
  horizontalRuleDecoration: BoxDecoration(
    border: Border(
      top: BorderSide(color: designSystem.colorTheme.outlineVariant),
    ),
  ),
);
```

`BorderedContainer` には `padding: EdgeInsets.all(designSystem.spacing.lg)`、デザインシステムの margin と card 角丸を渡す。ListTile の title、subtitle、leading icon と Divider も typography / color token を明示する。ルーターの import と `AboutThisAppRoute.build` は `AboutThisAppPage` に更新する。

- [ ] **Step 4: formatと対象テストを実行してGREENを確認する**

Run:

```bash
mise exec -- dart format app/lib/feature/settings/children/application_info/about_this_app_page.dart app/lib/core/router/router.dart app/test/feature/settings/children/application_info/about_this_app_page_test.dart
mise exec -- flutter test app/test/feature/settings/children/application_info/about_this_app_page_test.dart
```

Expected: PASS。ライト・ダークの各ループで `onSurface` と `primary` が一致する。

- [ ] **Step 5: Task 1だけをコミットする**

```bash
git add app/lib/feature/settings/children/application_info/about_this_app.dart app/lib/feature/settings/children/application_info/about_this_app_page.dart app/lib/core/router/router.dart app/test/feature/settings/children/application_info/about_this_app_page_test.dart
git commit -m "Fix: アプリ情報画面をダークテーマに対応"
```

---

### Task 2: 共通WebViewの状態表示を作る

**Files:**
- Create: `app/lib/core/component/web_view/app_web_view_body.dart`
- Create: `app/test/core/component/web_view/app_web_view_body_test.dart`

**Interfaces:**
- Consumes: `BuildContext.designSystem`
- Produces: `enum AppWebViewLoadStatus { loading, loaded, error }`, `AppWebViewBody({required Widget webView, required AppWebViewLoadStatus status, required Future<void> Function() onRetry})`

- [ ] **Step 1: loading / loaded / error / retry のWidgetテストを書く**

壊れ方は「読み込み中が無表示」「例外文字列を表示」「再読み込み操作が呼ばれない」と定義する。外部WebViewはモックせず、状態UIへ実Widgetの `SizedBox` を渡す。

```dart
testWidgets('loadingは進捗表示を重ねる', (tester) async {
  await tester.pumpWidget(_app(status: AppWebViewLoadStatus.loading));
  expect(find.byKey(const Key('web-view-content')), findsOneWidget);
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});

testWidgets('loadedはWebViewだけを表示する', (tester) async {
  await tester.pumpWidget(_app(status: AppWebViewLoadStatus.loaded));
  expect(find.byKey(const Key('web-view-content')), findsOneWidget);
  expect(find.byType(CircularProgressIndicator), findsNothing);
  expect(find.text('ページを読み込めませんでした'), findsNothing);
});

testWidgets('errorは安全な文言と再読み込み操作を表示する', (tester) async {
  var retried = false;
  await tester.pumpWidget(
    _app(
      status: AppWebViewLoadStatus.error,
      onRetry: () async => retried = true,
    ),
  );
  expect(find.text('ページを読み込めませんでした'), findsOneWidget);
  expect(find.textContaining('Exception'), findsNothing);
  await tester.tap(find.text('再読み込み'));
  expect(retried, true);
});
```

テスト用 `_app` は `AppTheme.eqmonitorDefault().light` をnullチェックしてから `buildTheme` に渡し、`AppWebViewBody.webView` へ `SizedBox(key: Key('web-view-content'))` を渡す。

- [ ] **Step 2: 対象テストを実行してREDを確認する**

Run:

```bash
mise exec -- flutter test app/test/core/component/web_view/app_web_view_body_test.dart
```

Expected: `AppWebViewLoadStatus` と `AppWebViewBody` が未定義でFAIL。

- [ ] **Step 3: 最小の状態表示を実装する**

`AppWebViewBody` は `Stack(fit: StackFit.expand)` の最下層に `webView` を置き、その上をswitch式で切り替える。

```dart
final overlay = switch (status) {
  AppWebViewLoadStatus.loaded => const SizedBox.shrink(),
  AppWebViewLoadStatus.loading => ColoredBox(
      color: designSystem.colorTheme.surface,
      child: Center(
        child: CircularProgressIndicator(
          color: designSystem.colorTheme.primary,
        ),
      ),
    ),
  AppWebViewLoadStatus.error => ColoredBox(
      color: designSystem.colorTheme.surface,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(designSystem.spacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: designSystem.spacing.md,
            children: [
              Text(
                'ページを読み込めませんでした',
                style: designSystem.typography.titleMedium,
              ),
              Text(
                '通信状況を確認して、もう一度お試しください。',
                style: designSystem.typography.bodyMedium,
                textAlign: TextAlign.center,
              ),
              FilledButton.tonal(
                onPressed: onRetry,
                child: const Text('再読み込み'),
              ),
            ],
          ),
        ),
      ),
    ),
};
```

- [ ] **Step 4: formatと対象テストを実行してGREENを確認する**

Run:

```bash
mise exec -- dart format app/lib/core/component/web_view/app_web_view_body.dart app/test/core/component/web_view/app_web_view_body_test.dart
mise exec -- flutter test app/test/core/component/web_view/app_web_view_body_test.dart
```

Expected: 3 tests PASS。

- [ ] **Step 5: Task 2だけをコミットする**

```bash
git add app/lib/core/component/web_view/app_web_view_body.dart app/test/core/component/web_view/app_web_view_body_test.dart
git commit -m "Add: WebViewの読み込み状態表示を共通化"
```

---

### Task 3: 法的文書とオンボーディングを共通WebViewへ統合

**Files:**
- Create: `app/test/core/router/legal_document_route_test.dart`
- Create: `app/lib/core/component/web_view/app_web_view_page.dart`
- Delete: `app/lib/feature/onboarding/ui/page/onboarding_web_view_page.dart`
- Delete: `app/lib/feature/settings/children/application_info/term_of_service_page.dart`
- Delete: `app/lib/feature/settings/children/application_info/privacy_policy_page.dart`
- Modify: `app/lib/core/router/router.dart`
- Modify: `app/lib/core/router/router.g.dart`
- Modify: `app/lib/feature/onboarding/ui/components/onboarding_bottom_bar.dart`
- Modify: `app/lib/feature/settings/children/application_info/about_this_app_page.dart`

**Interfaces:**
- Consumes: `AppWebViewBody`, `AppWebViewLoadStatus`, `InAppWebView`
- Produces: `const AppWebViewPage({required String title, required String url})`, `const TermOfServiceRoute()`, `const PrivacyPolicyRoute()`

- [ ] **Step 1: ルートが正しいWebView destinationを返すテストを書く**

壊れ方は「規約とポリシーのURL取り違え」「外部Markdownページへの退行」と定義する。`BuildContext` と `GoRouterState` は副作用を持たない `Fake` を使い、ルートが返した実Widgetを検証する。

```dart
test('利用規約ルートは指定URLのAppWebViewPageを構築する', () {
  final page = const TermOfServiceRoute().build(
    _FakeBuildContext(),
    _FakeGoRouterState(),
  );
  expect(page, isA<AppWebViewPage>());
  expect((page as AppWebViewPage).title, '利用規約');
  expect(page.url, 'https://eqmonitor.app/term_of_service');
});

test('プライバシーポリシールートは指定URLのAppWebViewPageを構築する', () {
  final page = const PrivacyPolicyRoute().build(
    _FakeBuildContext(),
    _FakeGoRouterState(),
  );
  expect(page, isA<AppWebViewPage>());
  expect((page as AppWebViewPage).title, 'プライバシーポリシー');
  expect(page.url, 'https://eqmonitor.app/privacy_policy');
});

final class _FakeBuildContext extends Fake implements BuildContext {}
final class _FakeGoRouterState extends Fake implements GoRouterState {}
```

- [ ] **Step 2: 対象テストを実行してREDを確認する**

Run:

```bash
mise exec -- flutter test app/test/core/router/legal_document_route_test.dart
```

Expected: 引数なしルートまたは `AppWebViewPage` が未定義でFAIL。

- [ ] **Step 3: 共通 `AppWebViewPage` を実装する**

`HookWidget` でcontrollerと状態を保持し、main-frameのネットワークエラーとHTTPエラーだけをerrorへ変換する。subresource failureは無視し、例外内容は `AppWebViewBody` に渡さない。

```dart
class AppWebViewPage extends HookWidget {
  const AppWebViewPage({required this.title, required this.url, super.key});

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    final controller = useRef<InAppWebViewController?>(null);
    final status = useState(AppWebViewLoadStatus.loading);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: AppWebViewBody(
        status: status.value,
        onRetry: () async {
          status.value = AppWebViewLoadStatus.loading;
          await controller.value?.reload();
        },
        webView: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(url)),
          onWebViewCreated: (value) => controller.value = value,
          onLoadStart: (_, _) => status.value = AppWebViewLoadStatus.loading,
          onLoadStop: (_, _) {
            if (status.value != AppWebViewLoadStatus.error) {
              status.value = AppWebViewLoadStatus.loaded;
            }
          },
          onReceivedError: (_, request, _) {
            if (request.isForMainFrame ?? true) {
              status.value = AppWebViewLoadStatus.error;
            }
          },
          onReceivedHttpError: (_, request, response) {
            final isFailure = (response.statusCode ?? 0) >= 400;
            if ((request.isForMainFrame ?? true) && isFailure) {
              status.value = AppWebViewLoadStatus.error;
            }
          },
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: 法的文書ルートと全呼び出しを更新する**

`router.dart` は古い3ページのimportを削除し、`AppWebViewPage` をimportする。法的文書ルートは次の形にし、redirect、アプリ情報画面、オンボーディング下部バーの `$extra: null` を削除する。`OnboardingWebViewRoute` も共通ページを返す。

```dart
class TermOfServiceRoute extends GoRouteData with $TermOfServiceRoute {
  const TermOfServiceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AppWebViewPage(
        title: '利用規約',
        url: 'https://eqmonitor.app/term_of_service',
      );
}

class PrivacyPolicyRoute extends GoRouteData with $PrivacyPolicyRoute {
  const PrivacyPolicyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AppWebViewPage(
        title: 'プライバシーポリシー',
        url: 'https://eqmonitor.app/privacy_policy',
      );
}
```

古いオンボーディングWebViewページ、利用規約Markdownページ、プライバシーポリシーMarkdownページを削除する。

- [ ] **Step 5: ルーターコードを再生成する**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: `lib/core/router/router.g.dart` から法的文書ルートの `$extra` と `showAcceptButton` query parameter がなくなる。他の生成ファイルに意図しない差分があればステージせず、原因を確認する。

- [ ] **Step 6: formatと対象テストを実行してGREENを確認する**

Run:

```bash
mise exec -- dart format app/lib/core/component/web_view/app_web_view_page.dart app/lib/core/router/router.dart app/lib/feature/onboarding/ui/components/onboarding_bottom_bar.dart app/lib/feature/settings/children/application_info/about_this_app_page.dart app/test/core/router/legal_document_route_test.dart
mise exec -- flutter test app/test/core/router/legal_document_route_test.dart app/test/core/component/web_view/app_web_view_body_test.dart app/test/feature/settings/children/application_info/about_this_app_page_test.dart
```

Expected: 全対象テストPASS。

- [ ] **Step 7: Task 3だけをコミットする**

```bash
git add app/lib/core/component/web_view/app_web_view_page.dart app/lib/core/router/router.dart app/lib/core/router/router.g.dart app/lib/feature/onboarding/ui/page/onboarding_web_view_page.dart app/lib/feature/onboarding/ui/components/onboarding_bottom_bar.dart app/lib/feature/settings/children/application_info/about_this_app_page.dart app/lib/feature/settings/children/application_info/term_of_service_page.dart app/lib/feature/settings/children/application_info/privacy_policy_page.dart app/test/core/router/legal_document_route_test.dart
git commit -m "Change: 法的文書をアプリ内WebView表示に統一"
```

---

### Task 4: 回帰検証とpush

**Files:**
- Verify only; production差分は追加しない。

**Interfaces:**
- Consumes: Tasks 1–3 の全変更
- Produces: 静的解析・対象テスト・関連テストの成功結果

- [ ] **Step 1: 差分の形式と意図しない変更を確認する**

Run:

```bash
git --no-pager diff HEAD~3 --check
git --no-pager diff HEAD~3 --stat
git --no-pager status --short
```

Expected: whitespace errorなし。ユーザー変更済み6ファイルはunstagedのまま。対象外ファイルに新規差分なし。

- [ ] **Step 2: appの静的解析を実行する**

Run:

```bash
cd app
mise exec -- flutter analyze lib/core/component/web_view lib/core/router/router.dart lib/feature/settings/children/application_info lib/feature/onboarding/ui/components/onboarding_bottom_bar.dart
```

Expected: `No issues found!`。既存の解析debtが対象パス外から報告される場合は、対象差分由来かを切り分ける。

- [ ] **Step 3: 対象テストとオンボーディング回帰テストを実行する**

Run:

```bash
mise exec -- flutter test app/test/core/component/web_view/app_web_view_body_test.dart app/test/core/router/legal_document_route_test.dart app/test/feature/settings/children/application_info/about_this_app_page_test.dart app/test/feature/onboarding/onboarding_page_test.dart
```

Expected: 全テストPASS、例外・警告なし。

- [ ] **Step 4: リモートへpushする**

Run:

```bash
git push origin HEAD:refs/heads/codex/about-app-legal-webview
```

Expected: `codex/about-app-legal-webview` がTasks 1–3のコミットを含む。
