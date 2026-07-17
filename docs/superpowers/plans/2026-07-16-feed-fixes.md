# お知らせ機能修正 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** お知らせ機能の3つの問題を修正する — (1) ホーム→詳細遷移の404、(2) 一覧ページのUI崩れ（EarthquakeHistoryListTile風に刷新）、(3) 未読の緊急度の高いお知らせをHomeSheet上部にバナー表示（既読位置を端末に永続化、初回起動時は非表示）。

**Architecture:** バックエンドには id 指定の Feed 取得エンドポイントが存在しない（`/v2/feeds` 一覧と `/v2/feeds/source/{telegramHash}` のみ）ため、404はアプリ側のみで修正する。一覧で取得済みの `FeedItem` を GoRouter の `$extra` で詳細ページへ渡し、本文は `FeedItemData` 内のテキストから補完する（詳細ページに既にこのフォールバックが存在する）。既読管理は SharedPreferences に「最後に既読にした publishedAt」を保存する。

**Tech Stack:** Flutter / Riverpod (riverpod_annotation + build_runner) / go_router_builder / Freezed / flutter_hooks / shared_preferences

## Global Constraints

- バックエンド（`backend/`）は変更しない。アプリ側のみで完結させる。
- 既存の `FeedDetailsRoute`（path: `/feed/source/:telegramHash`）は**通知ディープリンク用に残す**。削除・変更禁止（`app/lib/core/fcm/notification_deep_link.dart` が依存）。
- 生成ファイル（`*.g.dart`, `*.freezed.dart`）は手で編集しない。`cd app && dart run build_runner build --delete-conflicting-outputs` で再生成し、**生成ファイルもコミットする**。
- import は package import（`package:eqmonitor/...`）を使う。相対 import 禁止。
- 変更ファイルは `dart format <files>` を通す。
- `dart analyze` は app/ でプラグイン起因のハング実績あり。`timeout 300 dart analyze <対象ディレクトリ>` で実行し、タイムアウトした場合は `flutter test` のコンパイル成功を代替ゲートとする。
- テスト実行: `cd app && flutter test <テストファイル>`。
- 緊急度の定義（全タスク共通）: `isHighUrgency = isImportant || priority == critical || priority == high`。強調色は critical: `Color(0xFFD32F2F)`（赤）、high または isImportant: `Color(0xFFF57C00)`（オレンジ）。
- 日時表示フォーマット: `yyyy/MM/dd HH:mm`（`intl` の `DateFormat`）。
- テスト内の `publishedAt` は **ローカル時刻の `DateTime(...)` コンストラクタ**で作る（`DateTime.parse('...+09:00')` はテスト実行環境のTZに依存して表示文字列が変わるため、表示検証には使わない）。
- コミットメッセージは既存スタイルに合わせ日本語で `fix:` / `feat:` / `test:` プレフィックス。

---

### Task 1: 404修正 — FeedItem を `$extra` で渡す詳細ルートの新設

ホームの `_HomeFeedListTile` が `FeedDetailsRoute(telegramHash: item.id)` と、**Feed の id を電文ハッシュ用ルートに渡している**のが404の原因（`app/lib/feature/home/ui/component/sheet/home_feed_sheet.dart:104`）。API `/v2/feeds/source/{telegramHash}` は電文ハッシュ専用で、id では常に404になる。id で1件取得できるAPIは存在しないため、一覧で取得済みの `FeedItem` をルートの `$extra` で渡し、詳細ページはそれを直接表示する。

**Files:**
- Modify: `app/lib/feature/feed/data/model/feed_items.dart`（末尾に `FeedItemX` extension 追加）
- Modify: `app/lib/feature/feed/ui/page/feed_details_page.dart`（`_FeedDetailsBody` → 公開クラス `FeedDetailsBody` にリネーム）
- Create: `app/lib/feature/feed/ui/page/feed_item_details_page.dart`
- Modify: `app/lib/core/router/router.dart`（`FeedItemDetailsRoute` 追加）+ `dart run build_runner build` で `router.g.dart` 再生成
- Modify: `app/lib/feature/home/ui/component/sheet/home_feed_sheet.dart`（onTap の遷移先変更）
- Test: `app/test/feature/feed/feed_item_details_page_test.dart`

**Interfaces:**
- Consumes: 既存の `FeedItem` / `FeedDetail`（`feed_items.dart`）、`feedProvider`（`feed_notifier.dart`、`FeedNotifierState = ({List<FeedItem> items, String? nextCursor})`）
- Produces:
  - `extension FeedItemX on FeedItem { FeedDetail toDetail(); }`（feed_items.dart。Task 2 がこの extension に getter を追加する）
  - `class FeedItemDetailsPage extends ConsumerWidget { const FeedItemDetailsPage({required String id, FeedItem? item, Key? key}); }`
  - `class FeedItemDetailsRoute extends GoRouteData`（path: `/feed/detail/:id`、フィールド `String id` と `FeedItem? $extra`）。Task 2・Task 4 が `FeedItemDetailsRoute(id: item.id, $extra: item).push<void>(context)` を使う
  - `class FeedDetailsBody extends StatelessWidget`（旧 `_FeedDetailsBody` の公開版、`FeedDetail item` を受ける）

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/feed/feed_item_details_page_test.dart` を作成:

```dart
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/ui/page/feed_item_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final _item = FeedItem(
  id: 'feed-1',
  feedType: FeedType.developerMessage,
  priority: FeedPriority.normal,
  isImportant: false,
  publishedAt: DateTime(2026, 7, 1, 12, 34),
  expiresAt: null,
  title: 'テストお知らせ',
  summary: '概要テキスト',
  data: const FeedItemData.developerMessage(),
);

class _FakeFeedNotifier extends FeedNotifier {
  _FakeFeedNotifier(this.items);

  final List<FeedItem> items;

  @override
  Future<FeedNotifierState> build() async =>
      (items: items, nextCursor: null);
}

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  List<Override> overrides = const [],
}) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        home: child,
      ),
    ),
  );
}

void main() {
  testWidgets('渡された FeedItem から詳細を表示する', (tester) async {
    await _pump(tester, FeedItemDetailsPage(id: 'feed-1', item: _item));
    await tester.pump();
    expect(find.text('テストお知らせ'), findsOneWidget);
  });

  testWidgets('item が無い場合は feedProvider のキャッシュから id で解決する', (
    tester,
  ) async {
    await _pump(
      tester,
      const FeedItemDetailsPage(id: 'feed-1'),
      overrides: [
        feedProvider.overrideWith(() => _FakeFeedNotifier([_item])),
      ],
    );
    await tester.pump();
    await tester.pump();
    expect(find.text('テストお知らせ'), findsOneWidget);
  });

  testWidgets('解決できない場合は見つからない旨を表示する', (tester) async {
    await _pump(
      tester,
      const FeedItemDetailsPage(id: 'missing'),
      overrides: [
        feedProvider.overrideWith(() => _FakeFeedNotifier([])),
      ],
    );
    await tester.pump();
    await tester.pump();
    expect(find.text('お知らせが見つかりませんでした'), findsOneWidget);
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/feed/feed_item_details_page_test.dart`
Expected: コンパイルエラー（`feed_item_details_page.dart` が存在しない）

- [ ] **Step 3: `FeedItemX.toDetail()` を追加**

`app/lib/feature/feed/data/model/feed_items.dart` の末尾（`FeedNankaiEarthquakeInfo` クラスの後）に追加:

```dart
/// [FeedItem] の派生プロパティ・変換。
extension FeedItemX on FeedItem {
  /// 一覧アイテムから詳細表示用の [FeedDetail] を作る。
  /// 一覧APIは body を返さないため body は null になるが、
  /// 詳細画面側で [FeedItemData] 内のテキストから本文が補完される。
  FeedDetail toDetail() => FeedDetail(
    id: id,
    feedType: feedType,
    priority: priority,
    isImportant: isImportant,
    publishedAt: publishedAt,
    expiresAt: expiresAt,
    title: title,
    summary: summary,
    body: null,
    data: data,
  );
}
```

- [ ] **Step 4: `_FeedDetailsBody` を公開クラスにリネーム**

`app/lib/feature/feed/ui/page/feed_details_page.dart` 内の `_FeedDetailsBody` を `FeedDetailsBody` にリネームする（クラス宣言・コンストラクタ・`_FeedDetailsBody({required this.item})` → `FeedDetailsBody({required this.item, super.key})`・ファイル内の使用箇所 `data: (item) => _FeedDetailsBody(item: item)` → `data: (item) => FeedDetailsBody(item: item)`、および static メソッド内の型参照）。ロジックは一切変えない。

- [ ] **Step 5: `FeedItemDetailsPage` を作成**

`app/lib/feature/feed/ui/page/feed_item_details_page.dart`:

```dart
import 'package:collection/collection.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/ui/page/feed_details_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 一覧で取得済みの [FeedItem] を表示するお知らせ詳細ページ。
///
/// 通常はルートの `$extra` で [item] が渡される。状態復元などで
/// [item] が無い場合は [feedProvider] のキャッシュから [id] で解決する。
/// （id 指定で1件取得するAPIは存在しないため、解決できない場合は
/// 見つからない旨を表示して一覧へ誘導する）
class FeedItemDetailsPage extends ConsumerWidget {
  const FeedItemDetailsPage({required this.id, this.item, super.key});

  final String id;
  final FeedItem? item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passed = item;
    final Widget body;
    if (passed != null) {
      body = FeedDetailsBody(item: passed.toDetail());
    } else {
      final state = ref.watch(feedProvider);
      final resolved = state.valueOrNull?.items.firstWhereOrNull(
        (e) => e.id == id,
      );
      if (resolved != null) {
        body = FeedDetailsBody(item: resolved.toDetail());
      } else if (state.isLoading) {
        body = const Center(child: CircularProgressIndicator.adaptive());
      } else {
        body = const _FeedItemNotFound();
      }
    }
    return Scaffold(
      appBar: AppBar(title: const Text('お知らせ')),
      body: body,
    );
  }
}

class _FeedItemNotFound extends StatelessWidget {
  const _FeedItemNotFound();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('お知らせが見つかりませんでした'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async => const FeedRoute().push<void>(context),
              child: const Text('お知らせ一覧へ'),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 6: ルートを追加**

`app/lib/core/router/router.dart` の `FeedDetailsRoute` クラス定義の直後に追加（import に `package:eqmonitor/feature/feed/data/model/feed_items.dart` と `package:eqmonitor/feature/feed/ui/page/feed_item_details_page.dart` を追加）:

```dart
@TypedGoRoute<FeedItemDetailsRoute>(path: '/feed/detail/:id')
class FeedItemDetailsRoute extends GoRouteData with $FeedItemDetailsRoute {
  const FeedItemDetailsRoute({required this.id, this.$extra});

  final String id;
  final FeedItem? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      FeedItemDetailsPage(id: id, item: $extra);
}
```

既存の `FeedDetailsRoute`（`/feed/source/:telegramHash`）は変更しない。

- [ ] **Step 7: コード生成**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `lib/core/router/router.g.dart` に `$FeedItemDetailsRoute` mixin が生成され、エラーなく完了

- [ ] **Step 8: ホームの遷移先を修正**

`app/lib/feature/home/ui/component/sheet/home_feed_sheet.dart` の `_HomeFeedListTile` 内:

```dart
// 変更前
onTap: () => FeedDetailsRoute(telegramHash: item.id).push<void>(context),
// 変更後
onTap: () async =>
    FeedItemDetailsRoute(id: item.id, $extra: item).push<void>(context),
```

- [ ] **Step 9: テストが通ることを確認**

Run: `cd app && flutter test test/feature/feed/feed_item_details_page_test.dart`
Expected: PASS（3件）

既存テストの回帰確認: `cd app && flutter test test/feature/feed/`
Expected: 全件 PASS

- [ ] **Step 10: format・コミット**

```bash
cd app && dart format lib/feature/feed/data/model/feed_items.dart lib/feature/feed/ui/page/feed_details_page.dart lib/feature/feed/ui/page/feed_item_details_page.dart lib/core/router/router.dart lib/feature/home/ui/component/sheet/home_feed_sheet.dart test/feature/feed/feed_item_details_page_test.dart
cd .. && git add app/lib/feature/feed app/lib/core/router app/lib/feature/home/ui/component/sheet/home_feed_sheet.dart app/test/feature/feed/feed_item_details_page_test.dart
git commit -m "fix: ホームのお知らせから詳細への遷移が404になる問題を修正"
```

---

### Task 2: お知らせ一覧UIの刷新 — `FeedItemListTile`

一覧ページの行を `EarthquakeHistoryListTile` と同じ Material `ListTile` 構成（角丸矩形のleadingアイコン + 太字タイトル + サブタイトル + tileColor による強調背景）に刷新する。緊急度の高いアイテム（isImportant / critical / high）は背景色とアイコン色で目立たせる。現在一覧の行はタップ不能なので、タップで詳細へ遷移できるようにする。

**Files:**
- Modify: `app/lib/feature/feed/data/model/feed_items.dart`（`FeedItemX` に `isHighUrgency` 追加）
- Create: `app/lib/feature/feed/ui/component/feed_item_list_tile.dart`
- Modify: `app/lib/feature/feed/ui/page/feed_page.dart`
- Test: `app/test/feature/feed/feed_item_list_tile_test.dart`

**Interfaces:**
- Consumes: Task 1 の `FeedItemDetailsRoute`（`FeedItemDetailsRoute(id: item.id, $extra: item).push<void>(context)`）、Task 1 の `FeedItemX` extension、既存の `FeedTypeBadge`（`feed_item_card.dart`）
- Produces:
  - `extension FeedItemX on FeedItem { bool get isHighUrgency; }`（Task 3 が使う）
  - `Color? feedUrgencyColor(FeedItem item)`（`feed_item_list_tile.dart` のトップレベル関数。Task 4 のバナーが使う。critical → `Color(0xFFD32F2F)`、high/isImportant → `Color(0xFFF57C00)`、それ以外 → null）
  - `class FeedItemListTile extends StatelessWidget { const FeedItemListTile({required FeedItem item, void Function()? onTap, Key? key}); }`

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/feed/feed_item_list_tile_test.dart`:

```dart
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

FeedItem _item({
  FeedPriority priority = FeedPriority.normal,
  bool isImportant = false,
  String? title = 'タイトル',
  String? summary = '概要',
}) => FeedItem(
  id: 'feed-1',
  feedType: FeedType.developerMessage,
  priority: priority,
  isImportant: isImportant,
  publishedAt: DateTime(2026, 7, 1, 12, 34),
  expiresAt: null,
  title: title,
  summary: summary,
  data: const FeedItemData.developerMessage(),
);

Future<void> _pump(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          DesignSystemThemeExtension.light(),
        ],
      ),
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  testWidgets('タイトル・概要・日時を表示する', (tester) async {
    await _pump(tester, FeedItemListTile(item: _item()));
    expect(find.text('タイトル'), findsOneWidget);
    expect(find.text('概要'), findsOneWidget);
    expect(find.text('2026/07/01 12:34'), findsOneWidget);
  });

  testWidgets('title が無い場合は summary をタイトルとして表示する', (tester) async {
    await _pump(
      tester,
      FeedItemListTile(item: _item(title: null, summary: '概要のみ')),
    );
    expect(find.text('概要のみ'), findsOneWidget);
  });

  testWidgets('critical は赤系の背景で強調される', (tester) async {
    await _pump(
      tester,
      FeedItemListTile(item: _item(priority: FeedPriority.critical)),
    );
    final tile = tester.widget<ListTile>(find.byType(ListTile));
    expect(
      tile.tileColor,
      const Color(0xFFD32F2F).withValues(alpha: 0.4),
    );
  });

  testWidgets('isImportant はオレンジ系の背景で強調される', (tester) async {
    await _pump(tester, FeedItemListTile(item: _item(isImportant: true)));
    final tile = tester.widget<ListTile>(find.byType(ListTile));
    expect(
      tile.tileColor,
      const Color(0xFFF57C00).withValues(alpha: 0.4),
    );
  });

  testWidgets('通常のお知らせは背景色なし', (tester) async {
    await _pump(tester, FeedItemListTile(item: _item()));
    final tile = tester.widget<ListTile>(find.byType(ListTile));
    expect(tile.tileColor, isNull);
  });

  testWidgets('タップで onTap が呼ばれる', (tester) async {
    var tapped = false;
    await _pump(
      tester,
      FeedItemListTile(item: _item(), onTap: () => tapped = true),
    );
    await tester.tap(find.byType(ListTile));
    expect(tapped, isTrue);
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/feed/feed_item_list_tile_test.dart`
Expected: コンパイルエラー（`feed_item_list_tile.dart` が存在しない）

- [ ] **Step 3: `isHighUrgency` を追加**

`app/lib/feature/feed/data/model/feed_items.dart` の `FeedItemX` extension（Task 1 で追加済み）の先頭にgetterを追加:

```dart
  /// ユーザーに目立たせるべき緊急度の高いお知らせかどうか。
  bool get isHighUrgency =>
      isImportant ||
      priority == FeedPriority.critical ||
      priority == FeedPriority.high;
```

- [ ] **Step 4: `FeedItemListTile` を作成**

`app/lib/feature/feed/ui/component/feed_item_list_tile.dart`:

```dart
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// critical のベースカラー(赤)。
const _criticalColor = Color(0xFFD32F2F);

/// high / isImportant のベースカラー(オレンジ)。
const _highColor = Color(0xFFF57C00);

/// 緊急度の高いお知らせの強調色。緊急度が高くない場合は null。
Color? feedUrgencyColor(FeedItem item) {
  if (item.priority == FeedPriority.critical) {
    return _criticalColor;
  }
  if (item.isHighUrgency) {
    return _highColor;
  }
  return null;
}

IconData _feedTypeIcon(FeedItemData data) => switch (data) {
  FeedItemDataEarthquakeNotice() => Icons.crisis_alert,
  FeedItemDataEarthquakeExplanation() => Icons.menu_book,
  FeedItemDataEarthquakeCounts() => Icons.format_list_numbered,
  FeedItemDataEarthquakeNankai() => Icons.waves,
  FeedItemDataAppUpdate() => Icons.system_update,
  FeedItemDataIncident() => Icons.warning_amber_rounded,
  FeedItemDataDeveloperMessage() => Icons.campaign,
};

/// お知らせ一覧の1行。EarthquakeHistoryListTile と同じ ListTile 構成に揃える。
class FeedItemListTile extends StatelessWidget {
  const FeedItemListTile({required this.item, this.onTap, super.key});

  final FeedItem item;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorTheme = context.designSystem.colorTheme;
    final urgencyColor = feedUrgencyColor(item);
    final dateStr = DateFormat(
      'yyyy/MM/dd HH:mm',
    ).format(item.publishedAt.toLocal());
    final title = (item.title ?? item.summary ?? '').replaceAll('◆', '');
    final summary = item.title != null
        ? item.summary?.replaceAll('◆', '')
        : null;

    return ListTile(
      onTap: onTap,
      tileColor: urgencyColor?.withValues(alpha: 0.4),
      leading: _FeedTypeIconBox(
        icon: _feedTypeIcon(item.data),
        color: urgencyColor ?? colorTheme.surfaceContainerHighest,
        iconColor: urgencyColor != null
            ? Colors.white
            : colorTheme.onSurfaceVariant,
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.bold,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (summary != null && summary.isNotEmpty)
            Text(
              summary,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorTheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          Row(
            children: [
              FeedTypeBadge(data: item.data),
              const SizedBox(width: 8),
              Text(
                dateStr,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontFamily: FontFamily.googleSansCode,
                  fontFamilyFallback: const [FontFamily.notoSansJP],
                  letterSpacing: -0.2,
                  color: colorTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: colorTheme.onSurfaceVariant,
      ),
    );
  }
}

/// 震度アイコンと同じ角丸矩形の中に種別アイコンを表示する。
class _FeedTypeIconBox extends StatelessWidget {
  const _FeedTypeIconBox({
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  final IconData icon;
  final Color color;
  final Color iconColor;

  static const _size = 40.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size,
      width: _size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(_size / 5),
        ),
        child: Center(child: Icon(icon, color: iconColor, size: _size * 0.6)),
      ),
    );
  }
}
```

- [ ] **Step 5: 一覧ページを新タイルに差し替え**

`app/lib/feature/feed/ui/page/feed_page.dart` — import に `package:eqmonitor/core/router/router.dart` と `package:eqmonitor/feature/feed/ui/component/feed_item_list_tile.dart` を追加し、`_PagingBody` の `SliverPagingList` を差し替える:

```dart
          SliverPagingList<String?, FeedItem>(
            dataSource: dataSource,
            builder: (context, item, index) => FeedItemListTile(
              item: item,
              onTap: () async => FeedItemDetailsRoute(
                id: item.id,
                $extra: item,
              ).push<void>(context),
            ),
            initialLoadingWidget: FeedItemListTile(item: _loadingDummyItem('1')),
            appendLoadingWidget: FeedItemListTile(item: _loadingDummyItem('2')),
            errorBuilder: (context, error, stackTrace) => ErrorCard(
              error: error,
              onReload: () async => dataSource.refresh(),
            ),
            emptyWidget: const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text('お知らせはありません'),
              ),
            ),
          ),
```

`FeedItemListTileContent` の import（`feed_item_card.dart`）が不要になったら削除する。ファイル末尾にヘルパーを追加（既存の initialLoadingWidget / appendLoadingWidget が使っていたダミーアイテムの共通化）:

```dart
FeedItem _loadingDummyItem(String id) => FeedItem(
  id: id,
  feedType: FeedType.appUpdate,
  priority: FeedPriority.normal,
  isImportant: false,
  title: 'アップデート',
  summary: 'アップデートがあります',
  data: const FeedItemData.appUpdate(),
  publishedAt: DateTime.now(),
  expiresAt: DateTime.now().add(const Duration(days: 30)),
);
```

- [ ] **Step 6: テストが通ることを確認**

Run: `cd app && flutter test test/feature/feed/`
Expected: 全件 PASS（新規6件含む）

- [ ] **Step 7: format・コミット**

```bash
cd app && dart format lib/feature/feed/data/model/feed_items.dart lib/feature/feed/ui/component/feed_item_list_tile.dart lib/feature/feed/ui/page/feed_page.dart test/feature/feed/feed_item_list_tile_test.dart
cd .. && git add app/lib/feature/feed app/test/feature/feed
git commit -m "feat: お知らせ一覧のUIをEarthquakeHistoryListTile風に刷新"
```

---

### Task 3: 既読管理 — `FeedLastRead` と `unreadHighUrgencyFeed`

「最後に既読にしたお知らせの publishedAt」を SharedPreferences に永続化する Notifier と、「未読の緊急度の高いお知らせのうち最新の1件」を返す派生 provider を作る。お知らせ一覧ページを開いたら読み込み済みの最新まで既読にする。**初回起動（保存値なし）の間は未読判定しない（null を返す）** — 初期化（基準値の保存）は Task 4 で HomeSheet が行う。

**Files:**
- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`（key 追加）
- Create: `app/lib/feature/feed/data/provider/feed_last_read_provider.dart`
- Create: `app/lib/feature/feed/data/provider/unread_high_urgency_feed_provider.dart`
- Modify: `app/lib/feature/feed/ui/page/feed_page.dart`（一覧を開いたら既読化）
- Test: `app/test/feature/feed/feed_last_read_provider_test.dart`
- Test: `app/test/feature/feed/unread_high_urgency_feed_provider_test.dart`

**Interfaces:**
- Consumes: `sharedPreferencesDataSourceProvider`（`core/data/preferences/shared/shared_preferences_data_source.dart`）、`feedProvider`、Task 2 の `FeedItemX.isHighUrgency`
- Produces:
  - `feedLastReadProvider` — `AsyncNotifierProvider` 相当。`Future<DateTime?> build()`、`Future<void> markRead(DateTime publishedAt)`（前進のみ）、`Future<void> initializeIfUnset(DateTime publishedAt)`（未設定時のみ保存）。Task 4 が両メソッドを使う
  - `unreadHighUrgencyFeedProvider` — `FeedItem?` を返す。Task 4 のバナーが watch する

- [ ] **Step 1: 失敗するテストを書く（FeedLastRead）**

`app/test/feature/feed/feed_last_read_provider_test.dart`:

```dart
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_last_read_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

ProviderContainer _container(Map<String, Object> initialPrefs) {
  SharedPreferences.setMockInitialValues(initialPrefs);
  return ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWith(
        (ref) => SharedPreferences.getInstance(),
      ),
    ],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('未設定の場合は null を返す', () async {
    final container = _container({});
    addTearDown(container.dispose);

    final value = await container.read(feedLastReadProvider.future);
    expect(value, isNull);
  });

  test('保存済みの既読位置を読み込む', () async {
    final saved = DateTime(2026, 7, 1, 12);
    final container = _container({
      SharedPreferencesKey.feedLastReadPublishedAt.key:
          saved.millisecondsSinceEpoch,
    });
    addTearDown(container.dispose);

    final value = await container.read(feedLastReadProvider.future);
    expect(value, saved);
  });

  test('markRead は既読位置を進めて永続化する', () async {
    final container = _container({});
    addTearDown(container.dispose);

    final target = DateTime(2026, 7, 2, 9);
    await container.read(feedLastReadProvider.notifier).markRead(target);

    expect(await container.read(feedLastReadProvider.future), target);
    final prefs = await SharedPreferences.getInstance();
    expect(
      prefs.getInt(SharedPreferencesKey.feedLastReadPublishedAt.key),
      target.millisecondsSinceEpoch,
    );
  });

  test('markRead は過去方向には戻さない', () async {
    final newer = DateTime(2026, 7, 3);
    final container = _container({
      SharedPreferencesKey.feedLastReadPublishedAt.key:
          newer.millisecondsSinceEpoch,
    });
    addTearDown(container.dispose);

    await container
        .read(feedLastReadProvider.notifier)
        .markRead(DateTime(2026, 7, 1));

    expect(await container.read(feedLastReadProvider.future), newer);
  });

  test('initializeIfUnset は未設定時のみ保存する', () async {
    final container = _container({});
    addTearDown(container.dispose);

    final first = DateTime(2026, 7, 1);
    await container
        .read(feedLastReadProvider.notifier)
        .initializeIfUnset(first);
    expect(await container.read(feedLastReadProvider.future), first);

    await container
        .read(feedLastReadProvider.notifier)
        .initializeIfUnset(DateTime(2026, 7, 5));
    expect(await container.read(feedLastReadProvider.future), first);
  });
}
```

- [ ] **Step 2: 失敗するテストを書く（unreadHighUrgencyFeed）**

`app/test/feature/feed/unread_high_urgency_feed_provider_test.dart`:

```dart
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_last_read_provider.dart';
import 'package:eqmonitor/feature/feed/data/provider/unread_high_urgency_feed_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

FeedItem _item({
  required String id,
  required DateTime publishedAt,
  FeedPriority priority = FeedPriority.normal,
  bool isImportant = false,
}) => FeedItem(
  id: id,
  feedType: FeedType.developerMessage,
  priority: priority,
  isImportant: isImportant,
  publishedAt: publishedAt,
  expiresAt: null,
  title: 'title-$id',
  summary: null,
  data: const FeedItemData.developerMessage(),
);

class _FakeFeedNotifier extends FeedNotifier {
  _FakeFeedNotifier(this.items);

  final List<FeedItem> items;

  @override
  Future<FeedNotifierState> build() async =>
      (items: items, nextCursor: null);
}

class _FakeFeedLastRead extends FeedLastRead {
  _FakeFeedLastRead(this.value);

  final DateTime? value;

  @override
  Future<DateTime?> build() async => value;
}

Future<ProviderContainer> _container({
  required List<FeedItem> items,
  required DateTime? lastRead,
}) async {
  final container = ProviderContainer(
    overrides: [
      feedProvider.overrideWith(() => _FakeFeedNotifier(items)),
      feedLastReadProvider.overrideWith(() => _FakeFeedLastRead(lastRead)),
    ],
  );
  await container.read(feedProvider.future);
  await container.read(feedLastReadProvider.future);
  return container;
}

void main() {
  final base = DateTime(2026, 7, 1, 12);

  test('既読位置が未設定(初回起動)の場合は null', () async {
    final container = await _container(
      items: [
        _item(
          id: 'a',
          publishedAt: base.add(const Duration(hours: 1)),
          priority: FeedPriority.critical,
        ),
      ],
      lastRead: null,
    );
    addTearDown(container.dispose);

    expect(container.read(unreadHighUrgencyFeedProvider), isNull);
  });

  test('未読の critical を返す', () async {
    final urgent = _item(
      id: 'a',
      publishedAt: base.add(const Duration(hours: 1)),
      priority: FeedPriority.critical,
    );
    final container = await _container(items: [urgent], lastRead: base);
    addTearDown(container.dispose);

    expect(container.read(unreadHighUrgencyFeedProvider), urgent);
  });

  test('既読済みの緊急お知らせは返さない', () async {
    final container = await _container(
      items: [
        _item(
          id: 'a',
          publishedAt: base.subtract(const Duration(hours: 1)),
          priority: FeedPriority.critical,
        ),
      ],
      lastRead: base,
    );
    addTearDown(container.dispose);

    expect(container.read(unreadHighUrgencyFeedProvider), isNull);
  });

  test('未読でも緊急度が高くなければ返さない', () async {
    final container = await _container(
      items: [
        _item(id: 'a', publishedAt: base.add(const Duration(hours: 1))),
      ],
      lastRead: base,
    );
    addTearDown(container.dispose);

    expect(container.read(unreadHighUrgencyFeedProvider), isNull);
  });

  test('未読の緊急お知らせが複数ある場合は最新の1件を返す', () async {
    final older = _item(
      id: 'old',
      publishedAt: base.add(const Duration(hours: 1)),
      isImportant: true,
    );
    final newer = _item(
      id: 'new',
      publishedAt: base.add(const Duration(hours: 2)),
      priority: FeedPriority.high,
    );
    final container = await _container(
      items: [older, newer],
      lastRead: base,
    );
    addTearDown(container.dispose);

    expect(container.read(unreadHighUrgencyFeedProvider), newer);
  });
}
```

- [ ] **Step 3: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/feed/feed_last_read_provider_test.dart test/feature/feed/unread_high_urgency_feed_provider_test.dart`
Expected: コンパイルエラー（provider ファイルが存在しない）

- [ ] **Step 4: SharedPreferencesKey を追加**

`app/lib/core/data/preferences/shared/shared_preferences_key.dart` の enum に追加（`bglDebugNotifyApiUpdate` の後、`;` の前）:

```dart
  feedLastReadPublishedAt('feed_last_read_published_at'),
```

- [ ] **Step 5: `FeedLastRead` Notifier を作成**

`app/lib/feature/feed/data/provider/feed_last_read_provider.dart`:

```dart
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_last_read_provider.g.dart';

/// お知らせの既読位置(最後に既読にしたアイテムの publishedAt)を
/// 端末に永続化する。未設定(初回起動)の場合は null。
@Riverpod(keepAlive: true)
class FeedLastRead extends _$FeedLastRead {
  static const _key = SharedPreferencesKey.feedLastReadPublishedAt;

  @override
  Future<DateTime?> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    final millis = await dataSource.getInt(key: _key);
    return millis != null
        ? DateTime.fromMillisecondsSinceEpoch(millis)
        : null;
  }

  /// 既読位置を [publishedAt] まで進める。過去方向には戻さない。
  Future<void> markRead(DateTime publishedAt) async {
    final current = await future;
    if (current != null && !publishedAt.isAfter(current)) {
      return;
    }
    await _save(publishedAt);
  }

  /// 未設定(初回起動)の場合のみ既読位置を初期化する。
  /// 初回起動時に過去のお知らせがすべて未読扱いになり
  /// バナーが表示されるのを防ぐ。
  Future<void> initializeIfUnset(DateTime publishedAt) async {
    final current = await future;
    if (current != null) {
      return;
    }
    await _save(publishedAt);
  }

  Future<void> _save(DateTime publishedAt) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setInt(
      key: _key,
      value: publishedAt.millisecondsSinceEpoch,
    );
    state = AsyncData(publishedAt);
  }
}
```

- [ ] **Step 6: `unreadHighUrgencyFeed` provider を作成**

`app/lib/feature/feed/data/provider/unread_high_urgency_feed_provider.dart`:

```dart
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_last_read_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unread_high_urgency_feed_provider.g.dart';

/// 未読の緊急度の高いお知らせのうち最新の1件。該当なしなら null。
/// 既読位置が未設定(初回起動直後)の間も null を返し、表示しない。
@riverpod
FeedItem? unreadHighUrgencyFeed(Ref ref) {
  final items = ref.watch(feedProvider).valueOrNull?.items;
  final lastRead = ref.watch(feedLastReadProvider).valueOrNull;
  if (items == null || lastRead == null) {
    return null;
  }
  FeedItem? newest;
  for (final item in items) {
    if (!item.isHighUrgency || !item.publishedAt.isAfter(lastRead)) {
      continue;
    }
    if (newest == null || item.publishedAt.isAfter(newest.publishedAt)) {
      newest = item;
    }
  }
  return newest;
}
```

- [ ] **Step 7: コード生成**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `feed_last_read_provider.g.dart` と `unread_high_urgency_feed_provider.g.dart` が生成される

- [ ] **Step 8: 一覧ページを開いたら既読化する**

`app/lib/feature/feed/ui/page/feed_page.dart` — `FeedPage` を `HookConsumerWidget` に変更し、build 冒頭に追加。import に `dart:async`、`package:flutter_hooks/flutter_hooks.dart`、`package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart`、`package:eqmonitor/feature/feed/data/provider/feed_last_read_provider.dart` を追加:

```dart
class FeedPage extends HookConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 一覧を開いたら、読み込み済みの最新お知らせまで既読にする
    useEffect(
      () {
        unawaited(
          Future(() async {
            final state = await ref.read(feedProvider.future);
            if (!context.mounted || state.items.isEmpty) {
              return;
            }
            final newest = state.items
                .map((e) => e.publishedAt)
                .reduce((a, b) => a.isAfter(b) ? a : b);
            await ref.read(feedLastReadProvider.notifier).markRead(newest);
          }),
        );
        return null;
      },
      const [],
    );

    final dataSourceAsync = ref.watch(feedDataSourceProvider);
    // ... 以降は既存のまま
```

- [ ] **Step 9: テストが通ることを確認**

Run: `cd app && flutter test test/feature/feed/`
Expected: 全件 PASS（新規10件含む）

- [ ] **Step 10: format・コミット**

```bash
cd app && dart format lib/core/data/preferences/shared/shared_preferences_key.dart lib/feature/feed/data/provider/feed_last_read_provider.dart lib/feature/feed/data/provider/unread_high_urgency_feed_provider.dart lib/feature/feed/ui/page/feed_page.dart test/feature/feed/feed_last_read_provider_test.dart test/feature/feed/unread_high_urgency_feed_provider_test.dart
cd .. && git add app/lib app/test
git commit -m "feat: お知らせの既読位置を端末に保存し未読の緊急お知らせを判定できるようにする"
```

---

### Task 4: HomeFeedSheet に未読緊急お知らせバナーを表示

`unreadHighUrgencyFeedProvider` が返すアイテムを HomeFeedSheet カード最上部に強調色バナーで表示する。タップで詳細へ遷移し既読化、×ボタンで既読化のみ。フィード読み込み完了時に `initializeIfUnset` を呼び、初回起動時はその時点の最新を基準として保存する（＝バナーを出さない）。

**Files:**
- Modify: `app/lib/feature/home/ui/component/sheet/home_feed_sheet.dart`
- Test: `app/test/feature/home/home_feed_sheet_banner_test.dart`

**Interfaces:**
- Consumes: Task 1 の `FeedItemDetailsRoute`、Task 2 の `feedUrgencyColor`（`feed_item_list_tile.dart`）、Task 3 の `feedLastReadProvider`（`markRead` / `initializeIfUnset`）と `unreadHighUrgencyFeedProvider`
- Produces: なし（UI 最終消費者）

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/home/home_feed_sheet_banner_test.dart`:

```dart
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_last_read_provider.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/home_feed_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final _base = DateTime(2026, 7, 1, 12);

FeedItem _item({
  required String id,
  required DateTime publishedAt,
  FeedPriority priority = FeedPriority.normal,
}) => FeedItem(
  id: id,
  feedType: FeedType.incident,
  priority: priority,
  isImportant: false,
  publishedAt: publishedAt,
  expiresAt: null,
  title: 'タイトル-$id',
  summary: '概要-$id',
  data: const FeedItemData.incident(),
);

class _FakeFeedNotifier extends FeedNotifier {
  _FakeFeedNotifier(this.items);

  final List<FeedItem> items;

  @override
  Future<FeedNotifierState> build() async =>
      (items: items, nextCursor: null);
}

class _FakeFeedLastRead extends FeedLastRead {
  _FakeFeedLastRead(this.initial);

  final DateTime? initial;
  final markReadCalls = <DateTime>[];
  final initializeCalls = <DateTime>[];

  @override
  Future<DateTime?> build() async => initial;

  @override
  Future<void> markRead(DateTime publishedAt) async {
    markReadCalls.add(publishedAt);
    final current = await future;
    if (current != null && !publishedAt.isAfter(current)) {
      return;
    }
    state = AsyncData(publishedAt);
  }

  @override
  Future<void> initializeIfUnset(DateTime publishedAt) async {
    initializeCalls.add(publishedAt);
    final current = await future;
    if (current != null) {
      return;
    }
    state = AsyncData(publishedAt);
  }
}

Future<void> _pump(
  WidgetTester tester, {
  required List<FeedItem> items,
  required _FakeFeedLastRead lastRead,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        feedProvider.overrideWith(() => _FakeFeedNotifier(items)),
        feedLastReadProvider.overrideWith(() => lastRead),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        home: const Scaffold(
          body: SingleChildScrollView(child: HomeFeedSheet()),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
}

void main() {
  testWidgets('未読の緊急お知らせがあればバナーを表示する', (tester) async {
    final urgent = _item(
      id: 'urgent',
      publishedAt: _base.add(const Duration(hours: 1)),
      priority: FeedPriority.critical,
    );
    await _pump(
      tester,
      items: [urgent],
      lastRead: _FakeFeedLastRead(_base),
    );

    expect(find.text('タイトル-urgent'), findsOneWidget);
  });

  testWidgets('未読の緊急お知らせがなければバナーを表示しない', (tester) async {
    final read = _item(
      id: 'read',
      publishedAt: _base.subtract(const Duration(hours: 1)),
      priority: FeedPriority.critical,
    );
    await _pump(
      tester,
      items: [read],
      lastRead: _FakeFeedLastRead(_base),
    );

    expect(find.text('タイトル-read'), findsNothing);
  });

  testWidgets('既読位置が未設定(初回起動)ならバナーを出さず初期化する', (tester) async {
    final urgent = _item(
      id: 'urgent',
      publishedAt: _base.add(const Duration(hours: 1)),
      priority: FeedPriority.critical,
    );
    final lastRead = _FakeFeedLastRead(null);
    await _pump(tester, items: [urgent], lastRead: lastRead);

    expect(find.text('タイトル-urgent'), findsNothing);
    expect(lastRead.initializeCalls, [urgent.publishedAt]);
  });

  testWidgets('×ボタンで既読化されバナーが消える', (tester) async {
    final urgent = _item(
      id: 'urgent',
      publishedAt: _base.add(const Duration(hours: 1)),
      priority: FeedPriority.critical,
    );
    final lastRead = _FakeFeedLastRead(_base);
    await _pump(tester, items: [urgent], lastRead: lastRead);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    await tester.pump();

    expect(lastRead.markReadCalls, [urgent.publishedAt]);
    expect(find.text('タイトル-urgent'), findsNothing);
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/home/home_feed_sheet_banner_test.dart`
Expected: FAIL（バナー未実装のため `find.text('タイトル-urgent')` が見つからない、`initializeCalls` が空）

- [ ] **Step 3: HomeFeedSheet にバナーと初期化処理を実装**

`app/lib/feature/home/ui/component/sheet/home_feed_sheet.dart` を修正。

import に追加:

```dart
import 'dart:async';

import 'package:eqmonitor/feature/feed/data/provider/feed_last_read_provider.dart';
import 'package:eqmonitor/feature/feed/data/provider/unread_high_urgency_feed_provider.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_list_tile.dart';
```

`HomeFeedSheet.build` の `final state = ref.watch(feedProvider);` の直後に追加:

```dart
    // 初回起動時: フィード読み込み完了時点の最新を既読基準として保存し、
    // 過去のお知らせがバナー表示されないようにする
    ref.listen(feedProvider, (_, next) {
      final items = next.valueOrNull?.items;
      if (items == null || items.isEmpty) {
        return;
      }
      final newest = items
          .map((e) => e.publishedAt)
          .reduce((a, b) => a.isAfter(b) ? a : b);
      unawaited(
        ref.read(feedLastReadProvider.notifier).initializeIfUnset(newest),
      );
    });
    final unreadItem = ref.watch(unreadHighUrgencyFeedProvider);
```

`Card.outlined` の `child: Column(...)` の `children` 先頭（「お知らせ」ヘッダー `Padding` の前）に追加:

```dart
          if (unreadItem != null) _UnreadFeedBanner(item: unreadItem),
```

ファイル末尾にバナーwidgetを追加:

```dart
/// 未読の緊急度の高いお知らせを知らせるバナー。
/// タップで詳細へ遷移して既読化、×ボタンで既読化のみ行う。
class _UnreadFeedBanner extends ConsumerWidget {
  const _UnreadFeedBanner({required this.item});

  final FeedItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final color = feedUrgencyColor(item) ?? const Color(0xFFF57C00);

    return Material(
      color: color,
      child: InkWell(
        onTap: () async {
          unawaited(
            ref.read(feedLastReadProvider.notifier).markRead(item.publishedAt),
          );
          await FeedItemDetailsRoute(id: item.id, $extra: item)
              .push<void>(context);
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            spacing.lg,
            spacing.xs,
            spacing.xs,
            spacing.xs,
          ),
          child: Row(
            children: [
              const Icon(Icons.campaign, color: Colors.white),
              SizedBox(width: spacing.sm),
              Expanded(
                child: Text(
                  (item.title ?? item.summary ?? '').replaceAll('◆', ''),
                  style: typography.titleSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () async => ref
                    .read(feedLastReadProvider.notifier)
                    .markRead(item.publishedAt),
                icon: const Icon(Icons.close, color: Colors.white),
                tooltip: '既読にする',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: テストが通ることを確認**

Run: `cd app && flutter test test/feature/home/home_feed_sheet_banner_test.dart`
Expected: PASS（4件）

回帰確認: `cd app && flutter test test/feature/feed/ test/feature/home/`
Expected: 全件 PASS

- [ ] **Step 5: format・コミット**

```bash
cd app && dart format lib/feature/home/ui/component/sheet/home_feed_sheet.dart test/feature/home/home_feed_sheet_banner_test.dart
cd .. && git add app/lib/feature/home app/test/feature/home
git commit -m "feat: 未読の緊急お知らせバナーをホームに表示"
```

---

## 検証（全タスク完了後）

- `cd app && flutter test test/feature/feed/ test/feature/home/` — 全件 PASS
- `cd app && timeout 300 dart analyze lib/feature/feed lib/feature/home lib/core/router lib/core/data` — issues なし（タイムアウト時は flutter test のコンパイル成功を代替ゲートとする）
- 生成ファイル（`router.g.dart`、`*_provider.g.dart`）がコミットに含まれていること
