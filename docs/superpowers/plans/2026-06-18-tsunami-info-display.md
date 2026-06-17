# 津波情報表示画面 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 津波情報の詳細画面を実装する。デバッグ画面から遷移可能にし、マップ＋シートで警報ステータス・現在地情報・地域一覧・地震情報を表示する。

**Architecture:** 地震履歴詳細画面と同一の Stack[MapView + BasicModalSheet] パターン。データは `GET /v2/tsunami/:tsunamiId` で取得した `TsunamiState` を AsyncNotifier で管理。30秒間隔ポーリングで更新。

**Tech Stack:** Flutter/Dart, Riverpod (code-gen), GoRouter (typed routes), MapLibre, Freezed models (API層は生成済み)

## Global Constraints

- 絵文字の使用禁止（通知以外）
- Material Icons のみ使用
- `context.designSystem` でデザインシステムにアクセス
- カード形状: `RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(16))`
- プロバイダー: `@riverpod` アノテーション + code-gen
- ルーティング: `@TypedGoRoute` + `GoRouteData`
- build_runner 実行: `dart run build_runner build --delete-conflicting-outputs` を app/ で実行

---

### Task 1: Data Layer + Route + Debug Page + Page Skeleton

データ取得のNotifier、GoRouterルート定義、デバッグ画面エントリ、ページの骨格を作成する。

**Files:**
- Create: `app/lib/feature/tsunami/data/notifier/tsunami_details_notifier.dart`
- Create: `app/lib/feature/tsunami/ui/tsunami_details_page.dart`
- Create: `app/lib/feature/settings/children/config/debug/tsunami/debug_tsunami_details_page.dart`
- Modify: `app/lib/core/router/router.dart` (ルート追加)
- Modify: `app/lib/feature/settings/children/config/debug/debug_page.dart` (デバッグメニュー追加)

**Interfaces:**
- Consumes: `TsunamiApiClient.getV2TsunamiTsunamiId(tsunamiId:)` (packages/eqmonitor_api)
- Produces: `tsunamiDetailsNotifierProvider(tsunamiId)` — `AsyncNotifier<TsunamiState>`。全後続タスクがこのプロバイダーを `ref.watch` する。

- [ ] **Step 1: Notifier を作成**

```dart
// app/lib/feature/tsunami/data/notifier/tsunami_details_notifier.dart
import 'dart:async';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_details_notifier.g.dart';

@riverpod
class TsunamiDetailsNotifier extends _$TsunamiDetailsNotifier {
  Timer? _refreshTimer;

  @override
  Future<TsunamiState> build(String tsunamiId) async {
    _startPolling();
    ref.onDispose(() => _refreshTimer?.cancel());
    return _fetch();
  }

  Future<TsunamiState> _fetch() async {
    final client = ref.read(apiClientProvider).tsunami;
    final response = await client.getV2TsunamiTsunamiId(
      tsunamiId: tsunamiId,
    );
    return response.data;
  }

  void _startPolling() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => ref.invalidateSelf(),
    );
  }
}
```

- [ ] **Step 2: ページの骨格を作成**

```dart
// app/lib/feature/tsunami/ui/tsunami_details_page.dart
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_details_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TsunamiDetailsPage extends HookConsumerWidget {
  const TsunamiDetailsPage({required this.tsunamiId, super.key});

  final String tsunamiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tsunamiDetailsNotifierProvider(tsunamiId));
    final colorScheme = Theme.of(context).colorScheme;

    return switch (state) {
      AsyncLoading() => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(),
        body: ErrorCard(
          error: error,
          onReload: () async => ref.refresh(
            tsunamiDetailsNotifierProvider(tsunamiId),
          ),
        ),
      ),
      AsyncData(value: final tsunami) => Scaffold(
        body: Stack(
          children: [
            // TODO: TsunamiDetailsMapView
            const ColoredBox(
              color: Colors.grey,
              child: SizedBox.expand(),
            ),
            SafeArea(
              bottom: false,
              child: BasicModalSheet(
                hasAppBar: false,
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        // TODO: TsunamiWarningStatusCard
                        // TODO: CurrentLocationTsunamiCard
                        // TODO: TsunamiRegionList
                        // TODO: AdBanner
                        // TODO: TsunamiEarthquakeCard
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Tsunami: ${tsunami.id}\n'
                            'Active: ${tsunami.isActive}\n'
                            'Regions: ${tsunami.forecastRegions.length}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (Navigator.canPop(context))
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton.filledTonal(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedSuperellipseBorder(
                          side: BorderSide(
                            color: colorScheme.primary.withValues(alpha: 0.2),
                          ),
                          borderRadius: BorderRadius.circular(128),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                    color: colorScheme.primary,
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
          ],
        ),
      ),
    };
  }
}
```

- [ ] **Step 3: GoRouter にルートを追加**

`app/lib/core/router/router.dart` の `@TypedGoRoute<DebugRoute>` の `routes` 配列に追加:

```dart
TypedGoRoute<DebugTsunamiDetailsRoute>(path: 'tsunami-details'),
```

DebugRoute の routes 配列内（既存の DebugEewCardRoute 等と同列）に追加。

同ファイルの DebugRoute クラス群の近くに追加:

```dart
class DebugTsunamiDetailsRoute extends GoRouteData
    with $DebugTsunamiDetailsRoute {
  const DebugTsunamiDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugTsunamiDetailsPage();
  }
}
```

さらに、津波詳細ページ自体のルート（ホームからの遷移用）を追加:

```dart
@TypedGoRoute<TsunamiDetailsRoute>(path: '/tsunami/:tsunamiId')
class TsunamiDetailsRoute extends GoRouteData with $TsunamiDetailsRoute {
  const TsunamiDetailsRoute({required this.tsunamiId});

  final String tsunamiId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TsunamiDetailsPage(tsunamiId: tsunamiId);
  }
}
```

- [ ] **Step 4: デバッグ画面を作成**

```dart
// app/lib/feature/settings/children/config/debug/tsunami/debug_tsunami_details_page.dart
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugTsunamiDetailsPage extends HookConsumerWidget {
  const DebugTsunamiDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tsunami Details Debug')),
      body: _TsunamiListView(),
    );
  }
}

class _TsunamiListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _fetchTsunamiList(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return const Center(child: Text('No tsunami events found'));
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.id),
              subtitle: Text(
                'Active: ${item.isActive} | '
                'Canceled: ${item.isCanceled} | '
                'Regions: ${item.forecastRegions.length}',
              ),
              onTap: () => TsunamiDetailsRoute(
                tsunamiId: item.id,
              ).push<void>(context),
            );
          },
        );
      },
    );
  }

  Future<List<TsunamiState>> _fetchTsunamiList(WidgetRef ref) async {
    final client = ref.read(apiClientProvider).tsunami;
    final response = await client.getV2Tsunami(limit: '20');
    // TsunamiListResponse の items は TsunamiListItem だが、
    // デバッグ用なので ID だけ取得して詳細画面に渡す
    return [];
  }
}
```

注意: `getV2Tsunami()` は `TsunamiListResponse` を返すので、一覧の `id` を取得して詳細ルートに渡す形にする。`_fetchTsunamiList` の実装は `TsunamiListResponse` の items から id を取得して ListTile に表示し、タップで `TsunamiDetailsRoute` に遷移させる。デバッグ画面なので簡素でよい。

実装者は `TsunamiListResponse` と `TsunamiListItem` のフィールドを確認して適切に実装すること。

- [ ] **Step 5: デバッグメニューにエントリ追加**

`app/lib/feature/settings/children/config/debug/debug_page.dart` のカード系デバッグセクション（DebugEewCardRoute の ListTile の近く）に追加:

```dart
ListTile(
  title: const Text('Tsunami Details'),
  subtitle: const Text('津波情報詳細画面のデバッグ'),
  leading: const Icon(Icons.tsunami),
  onTap: () async =>
      const DebugTsunamiDetailsRoute().push<void>(context),
),
```

- [ ] **Step 6: build_runner を実行**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs
```

GoRouter の `$DebugTsunamiDetailsRoute` mixin と `$TsunamiDetailsRoute` mixin、Riverpod の `tsunamiDetailsNotifierProvider` が生成されることを確認。

- [ ] **Step 7: ビルド確認**

```bash
cd app && flutter analyze
```

エラーがないことを確認。

- [ ] **Step 8: コミット**

```bash
git add app/lib/feature/tsunami/ app/lib/feature/settings/children/config/debug/tsunami/ app/lib/core/router/router.dart app/lib/feature/settings/children/config/debug/debug_page.dart
git add app/lib/core/router/router.g.dart app/lib/feature/tsunami/data/notifier/tsunami_details_notifier.g.dart
git commit -m "feat(tsunami): add tsunami details page skeleton with debug entry"
```

---

### Task 2: WarningStripeDecoration 汎用コンポーネント + 津波警報色定義

EEWカードのストライプパターンを汎用コンポーネントとして切り出し、津波警報レベルの色定義を追加する。

**Files:**
- Create: `app/lib/core/component/decoration/warning_stripe_decoration.dart`
- Create: `app/lib/feature/tsunami/ui/utils/tsunami_warning_color.dart`
- Modify: `app/lib/feature/home/ui/component/eew/eew_card.dart` (ストライプを汎用コンポーネントに置換)

**Interfaces:**
- Consumes: なし
- Produces:
  - `WarningStripeDecoration({required List<Color> colors, double height = 8.0, double stripeWidth = 8.0})` — 全カードで使用
  - `TsunamiWarningColor` — 警報レベル→色の変換ユーティリティ。`stripeColors(TsunamiWarningKind)`, `headerColor(TsunamiWarningKind)`, `mapFillColor(TsunamiWarningKind)` を提供

- [ ] **Step 1: WarningStripeDecoration を作成**

```dart
// app/lib/core/component/decoration/warning_stripe_decoration.dart
import 'package:flutter/material.dart';

class WarningStripeDecoration extends StatelessWidget {
  const WarningStripeDecoration({
    required this.colors,
    super.key,
    this.height = 8.0,
    this.stripeWidth = 8.0,
  });

  final List<Color> colors;
  final double height;
  final double stripeWidth;

  @override
  Widget build(BuildContext context) {
    if (colors.isEmpty) {
      return SizedBox(height: height);
    }
    return CustomPaint(
      painter: _StripePainter(colors: colors, stripeWidth: stripeWidth),
      size: Size(double.infinity, height),
    );
  }
}

class _StripePainter extends CustomPainter {
  _StripePainter({required this.colors, required this.stripeWidth});

  final List<Color> colors;
  final double stripeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final totalWidth = size.width + h * 2;
    var x = -h;
    while (x < totalWidth) {
      final path = Path()
        ..moveTo(x, h)
        ..lineTo(x + stripeWidth, h)
        ..lineTo(x + h + stripeWidth, 0)
        ..lineTo(x + h, 0)
        ..close();
      final colorIndex =
          ((x + h) / stripeWidth).floor().abs() % colors.length;
      final paint = Paint()..color = colors[colorIndex];
      canvas.drawPath(path, paint);
      x += stripeWidth;
    }
  }

  @override
  bool shouldRepaint(covariant _StripePainter oldDelegate) =>
      oldDelegate.colors != colors || oldDelegate.stripeWidth != stripeWidth;
}
```

- [ ] **Step 2: 津波警報色定義を作成**

```dart
// app/lib/feature/tsunami/ui/utils/tsunami_warning_color.dart
import 'dart:ui';

import 'package:eqmonitor_api/eqmonitor_api.dart';

abstract final class TsunamiWarningColor {
  static List<Color> stripeColors(TsunamiWarningKind kind) => switch (kind) {
        TsunamiWarningKind.majorWarning => const [
          Color(0xFF800080),
          Color(0xFF000000),
        ],
        TsunamiWarningKind.warning => const [
          Color(0xFFFF0000),
          Color(0xFF000000),
        ],
        TsunamiWarningKind.advisory => const [
          Color(0xFFFFCC00),
          Color(0xFF996600),
        ],
        TsunamiWarningKind.forecast ||
        TsunamiWarningKind.none => const [],
      };

  static Color headerColor(TsunamiWarningKind kind) => switch (kind) {
        TsunamiWarningKind.majorWarning => const Color(0xFF6A006A),
        TsunamiWarningKind.warning => const Color(0xFFB31A1A),
        TsunamiWarningKind.advisory => const Color(0xFFCC9900),
        TsunamiWarningKind.forecast => const Color(0xFF1E5AA0),
        TsunamiWarningKind.none => const Color(0xFF757575),
      };

  static Color mapFillColor(TsunamiWarningKind kind) => switch (kind) {
        TsunamiWarningKind.majorWarning =>
          const Color(0xFF800080).withValues(alpha: 0.4),
        TsunamiWarningKind.warning =>
          const Color(0xFFFF0000).withValues(alpha: 0.4),
        TsunamiWarningKind.advisory =>
          const Color(0xFFFFCC00).withValues(alpha: 0.4),
        TsunamiWarningKind.forecast =>
          const Color(0xFF1E5AA0).withValues(alpha: 0.3),
        TsunamiWarningKind.none => const Color(0x00000000),
      };

  static Color mapBorderColor(TsunamiWarningKind kind) => switch (kind) {
        TsunamiWarningKind.majorWarning => const Color(0xFF800080),
        TsunamiWarningKind.warning => const Color(0xFFFF0000),
        TsunamiWarningKind.advisory => const Color(0xFFFFCC00),
        TsunamiWarningKind.forecast => const Color(0xFF1E5AA0),
        TsunamiWarningKind.none => const Color(0x00000000),
      };

  static String displayName(TsunamiWarningKind kind) => switch (kind) {
        TsunamiWarningKind.majorWarning => '大津波警報',
        TsunamiWarningKind.warning => '津波警報',
        TsunamiWarningKind.advisory => '津波注意報',
        TsunamiWarningKind.forecast => '津波予報',
        TsunamiWarningKind.none => '解除',
      };
}
```

- [ ] **Step 3: EEW カードのストライプを汎用コンポーネントに置換**

`app/lib/feature/home/ui/component/eew/eew_card.dart` で:

1. `_EewStripePattern` ウィジェットの使用箇所を `WarningStripeDecoration` に置換:

```dart
// Before (line ~335):
SizedBox(
  height: 8,
  width: double.infinity,
  child: _EewStripePattern(isWarning: isWarning),
),

// After:
WarningStripeDecoration(
  colors: isWarning
      ? const [Colors.red, Colors.black]
      : const [Color(0xFFFFA500), Color.fromRGBO(128, 64, 0, 1)],
),
```

2. `_EewStripePattern` クラスと `_StripePainter` クラス（Lines 661-706）を削除

3. import を追加:
```dart
import 'package:eqmonitor/core/component/decoration/warning_stripe_decoration.dart';
```

- [ ] **Step 4: ビルド確認**

```bash
cd app && flutter analyze
```

- [ ] **Step 5: コミット**

```bash
git add app/lib/core/component/decoration/warning_stripe_decoration.dart app/lib/feature/tsunami/ui/utils/tsunami_warning_color.dart app/lib/feature/home/ui/component/eew/eew_card.dart
git commit -m "refactor: extract WarningStripeDecoration as reusable component"
```

---

### Task 3: TsunamiWarningStatusCard + History Overlay

警報ステータスカードと履歴変遷のオーバーレイを実装する。

**Files:**
- Create: `app/lib/feature/tsunami/ui/components/tsunami_warning_status_card.dart`
- Create: `app/lib/feature/tsunami/ui/components/tsunami_warning_history_overlay.dart`
- Modify: `app/lib/feature/tsunami/ui/tsunami_details_page.dart` (カードを組み込み)

**Interfaces:**
- Consumes:
  - `TsunamiState` (from tsunamiDetailsNotifierProvider)
  - `WarningStripeDecoration` (from Task 2)
  - `TsunamiWarningColor` (from Task 2)
- Produces:
  - `TsunamiWarningStatusCard({required TsunamiState tsunami})` — ページの Column に配置

- [ ] **Step 1: TsunamiWarningStatusCard を作成**

```dart
// app/lib/feature/tsunami/ui/components/tsunami_warning_status_card.dart
import 'package:eqmonitor/core/component/decoration/warning_stripe_decoration.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_warning_history_overlay.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TsunamiWarningStatusCard extends StatelessWidget {
  const TsunamiWarningStatusCard({required this.tsunami, super.key});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final shape = designSystem.shape;

    final maxKind = _resolveMaxKind(tsunami.forecastRegions);
    final isCanceled = tsunami.isCanceled;
    final isExpired = !tsunami.isActive && !tsunami.isCanceled;
    final showStripe = !isCanceled && !isExpired && maxKind != TsunamiWarningKind.forecast;

    final headerBg = isCanceled || isExpired
        ? color.surfaceRaised
        : TsunamiWarningColor.headerColor(maxKind);
    final headerFg = isCanceled || isExpired ? color.textDefault : Colors.white;
    final headline = _resolveHeadline(tsunami.latestTelegrams);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.outlineSoft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showStripe)
              WarningStripeDecoration(
                colors: TsunamiWarningColor.stripeColors(maxKind),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: headerBg,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      isCanceled
                          ? '解除済み'
                          : isExpired
                              ? '有効期限切れ'
                              : TsunamiWarningColor.displayName(maxKind),
                      style: TextStyle(
                        color: headerFg,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TsunamiWarningHistoryButton(tsunami: tsunami),
                ],
              ),
            ),
            if (headline != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Text(
                  headline,
                  style: TextStyle(
                    fontSize: 14,
                    color: designSystem.textColor.primary,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Text(
                '最終更新: ${DateFormat('yyyy/MM/dd HH:mm').format(tsunami.updatedAt.toLocal())}',
                style: TextStyle(
                  fontSize: 12,
                  color: designSystem.textColor.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static TsunamiWarningKind _resolveMaxKind(
    List<MergedForecastRegion> regions,
  ) {
    var max = TsunamiWarningKind.none;
    for (final r in regions) {
      if (r.kind.index < max.index) {
        max = r.kind;
      }
    }
    return max;
  }

  static String? _resolveHeadline(List<LatestTelegram> telegrams) {
    for (final t in telegrams) {
      if (t.type == TelegramType.vtse41 && t.headline != null) {
        return t.headline;
      }
    }
    return null;
  }
}
```

- [ ] **Step 2: TsunamiWarningHistoryButton + Overlay を作成**

```dart
// app/lib/feature/tsunami/ui/components/tsunami_warning_history_overlay.dart
import 'package:eqmonitor/core/designsystem/extensions/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TsunamiWarningHistoryButton extends StatefulWidget {
  const TsunamiWarningHistoryButton({required this.tsunami, super.key});

  final TsunamiState tsunami;

  @override
  State<TsunamiWarningHistoryButton> createState() =>
      _TsunamiWarningHistoryButtonState();
}

class _TsunamiWarningHistoryButtonState
    extends State<TsunamiWarningHistoryButton> {
  final _overlayController = OverlayPortalController();
  final _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) {
          return _HistoryOverlay(
            link: _link,
            tsunami: widget.tsunami,
            onDismiss: () => _overlayController.hide(),
          );
        },
        child: IconButton(
          icon: const Icon(Icons.history),
          color: Colors.white,
          onPressed: () {
            if (_overlayController.isShowing) {
              _overlayController.hide();
            } else {
              _overlayController.show();
            }
          },
        ),
      ),
    );
  }
}

class _HistoryOverlay extends StatelessWidget {
  const _HistoryOverlay({
    required this.link,
    required this.tsunami,
    required this.onDismiss,
  });

  final LayerLink link;
  final TsunamiState tsunami;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;

    final entries = _buildTimelineEntries(tsunami);
    final maxKind = TsunamiWarningStatusCard._resolveMaxKind(
      tsunami.forecastRegions,
    );
    final title = tsunami.isCanceled
        ? '${TsunamiWarningColor.displayName(maxKind)} 解除済み'
        : '${TsunamiWarningColor.displayName(maxKind)} が発表中';

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.opaque,
            child: const ColoredBox(color: Colors.transparent),
          ),
        ),
        CompositedTransformFollower(
          link: link,
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          offset: const Offset(0, 8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Card(
              elevation: 8,
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: color.outlineSoft),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (final entry in entries)
                      _TimelineEntry(entry: entry),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static List<_WarningTimelineEntry> _buildTimelineEntries(
    TsunamiState tsunami,
  ) {
    final vtse41Telegrams = tsunami.latestTelegrams
        .where((t) => t.type == TelegramType.vtse41)
        .toList()
      ..sort((a, b) => a.pressAt.compareTo(b.pressAt));

    if (vtse41Telegrams.isEmpty) return [];

    final entries = <_WarningTimelineEntry>[];
    TsunamiWarningKind? previousMaxKind;

    for (final telegram in vtse41Telegrams) {
      // 電文のheadlineからkindの変化を推定
      // 実際のkindは電文ごとには取得できないので、headlineとtitleから判定
      final currentTitle = telegram.title;
      final pressAt = telegram.pressAt;
      final description = telegram.headline ?? currentTitle;

      entries.add(
        _WarningTimelineEntry(
          time: pressAt,
          description: description,
          isLast: false,
        ),
      );
    }

    if (entries.isNotEmpty) {
      entries.last = _WarningTimelineEntry(
        time: entries.last.time,
        description: entries.last.description,
        isLast: true,
      );
    }

    return entries;
  }
}

class _WarningTimelineEntry {
  const _WarningTimelineEntry({
    required this.time,
    required this.description,
    required this.isLast,
  });

  final DateTime time;
  final String description;
  final bool isLast;
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({required this.entry});

  final _WarningTimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final timeStr = DateFormat('yyyy/MM/dd HH:mm').format(
      entry.time.toLocal(),
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: entry.isLast
                        ? designSystem.textColor.tertiary
                        : designSystem.color.primary,
                    border: Border.all(
                      color: entry.isLast
                          ? designSystem.textColor.tertiary
                          : designSystem.color.primary,
                      width: 2,
                    ),
                  ),
                ),
                if (!entry.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: designSystem.textColor.tertiary.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${timeStr}ごろ',
                    style: TextStyle(
                      fontSize: 12,
                      color: designSystem.textColor.secondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

注意: `_HistoryOverlay` から `TsunamiWarningStatusCard._resolveMaxKind` を参照しているが、これは private static なのでアクセスできない。代わりに `tsunami_warning_status_card.dart` 側の `_resolveMaxKind` をトップレベル関数 `resolveMaxTsunamiWarningKind` として公開するか、`TsunamiWarningColor` にメソッドとして追加する。

実装者は `_resolveMaxKind` を `tsunami_warning_color.dart` の `TsunamiWarningColor.resolveMaxKind(List<MergedForecastRegion>)` として追加し、両ファイルから参照する形で解決すること:

```dart
// tsunami_warning_color.dart に追加
static TsunamiWarningKind resolveMaxKind(
  List<MergedForecastRegion> regions,
) {
  var max = TsunamiWarningKind.none;
  for (final r in regions) {
    if (r.kind.index < max.index) {
      max = r.kind;
    }
  }
  return max;
}
```

- [ ] **Step 3: ページにカードを組み込み**

`app/lib/feature/tsunami/ui/tsunami_details_page.dart` の Column 内の仮テキストを置換:

```dart
// Before:
Padding(
  padding: const EdgeInsets.all(16),
  child: Text(
    'Tsunami: ${tsunami.id}\n'
    ...
  ),
),

// After:
TsunamiWarningStatusCard(tsunami: tsunami),
```

import を追加:
```dart
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_warning_status_card.dart';
```

- [ ] **Step 4: ビルド確認・コミット**

```bash
cd app && flutter analyze
git add app/lib/feature/tsunami/
git commit -m "feat(tsunami): add TsunamiWarningStatusCard with history overlay"
```

---

### Task 4: CurrentLocationTsunamiCard

現在地付近の津波情報カードを実装する。

**Files:**
- Create: `app/lib/feature/tsunami/ui/components/current_location_tsunami_card.dart`
- Create: `app/lib/feature/tsunami/ui/components/tsunami_observation_station_tile.dart`
- Modify: `app/lib/feature/tsunami/ui/tsunami_details_page.dart` (カードを組み込み)

**Interfaces:**
- Consumes:
  - `TsunamiState` (from tsunamiDetailsNotifierProvider)
  - `locationStreamProvider` (from `package:eqmonitor/feature/location/data/location.dart`)
  - `jmaMapAreaTsunamiNearestProvider(latLng)` (既存)
  - `WarningStripeDecoration`, `TsunamiWarningColor` (from Task 2)
- Produces:
  - `CurrentLocationTsunamiCard({required TsunamiState tsunami})` — ConsumerWidget。位置情報取得に失敗した場合は `SizedBox.shrink()` を返す
  - `TsunamiObservationStationTile({required TsunamiObservationStation station})` — Task 5, 6 でも再利用

- [ ] **Step 1: TsunamiObservationStationTile を作成**

```dart
// app/lib/feature/tsunami/ui/components/tsunami_observation_station_tile.dart
import 'package:eqmonitor/core/designsystem/extensions/design_system_build_context_x.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TsunamiObservationStationTile extends StatelessWidget {
  const TsunamiObservationStationTile({required this.station, super.key});

  final TsunamiObservationStation station;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final firstHeight = station.firstHeight;
    final maxHeight = station.maxHeight;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            station.name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: designSystem.textColor.primary,
            ),
          ),
          const SizedBox(height: 2),
          if (!_isFirstHeightMissing(firstHeight))
            Text(
              _formatFirstHeight(firstHeight),
              style: TextStyle(
                fontSize: 13,
                color: designSystem.textColor.secondary,
              ),
            ),
          if (maxHeight != null && !(maxHeight.isMissing ?? false))
            Text(
              _formatMaxHeight(maxHeight),
              style: TextStyle(
                fontSize: 13,
                fontWeight: _isImportant(maxHeight) ? FontWeight.bold : null,
                color: _isImportant(maxHeight)
                    ? const Color(0xFFB31A1A)
                    : designSystem.textColor.secondary,
              ),
            ),
        ],
      ),
    );
  }

  static bool _isFirstHeightMissing(TsunamiObservationStationFirstHeight fh) =>
      fh.isMissing ?? false;

  static String _formatFirstHeight(
    TsunamiObservationStationFirstHeight fh,
  ) {
    if (fh.isUnidentifiable ?? false) {
      return '第一波: 識別不能';
    }
    final timePart = fh.arrivalTime != null
        ? DateFormat('HH:mm').format(fh.arrivalTime!.toLocal())
        : '--:--';
    final initialPart = switch (fh.initial) {
      WaveInitial.push => ' (押し)',
      WaveInitial.pull => ' (引き)',
      null => '',
    };
    return '第一波: ${timePart}到達$initialPart';
  }

  static String _formatMaxHeight(TsunamiObservationStationMaxHeight mh) {
    final parts = <String>['最大波:'];
    if (mh.value != null) {
      final valueStr = '${mh.value}m';
      parts.add(mh.over == true ? '$valueStr超' : valueStr);
    } else if (mh.condition != null) {
      parts.add(
        switch (mh.condition!) {
          ObservationMaxHeightCondition.minor => '微弱',
          ObservationMaxHeightCondition.observing => '観測中',
          ObservationMaxHeightCondition.important => '重要',
        },
      );
    }
    if (mh.dateTime != null) {
      parts.add(
        '(${DateFormat('HH:mm').format(mh.dateTime!.toLocal())})',
      );
    }
    if (mh.isRising == true) {
      parts.add('上昇中');
    }
    return parts.join(' ');
  }

  static bool _isImportant(TsunamiObservationStationMaxHeight mh) =>
      mh.condition == ObservationMaxHeightCondition.important;
}
```

- [ ] **Step 2: CurrentLocationTsunamiCard を作成**

```dart
// app/lib/feature/tsunami/ui/components/current_location_tsunami_card.dart
import 'package:eqmonitor/core/component/decoration/warning_stripe_decoration.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/map/nearest_jma_feature.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_observation_station_tile.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

class CurrentLocationTsunamiCard extends ConsumerWidget {
  const CurrentLocationTsunamiCard({required this.tsunami, super.key});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionAsync = ref.watch(locationStreamProvider);
    final position = positionAsync.valueOrNull;
    if (position == null) return const SizedBox.shrink();

    final latLng = LatLng(position.latitude, position.longitude);
    final nearestAsync = ref.watch(
      jmaMapAreaTsunamiNearestProvider(latLng),
    );
    final nearest = nearestAsync.valueOrNull;
    if (nearest == null) return const SizedBox.shrink();

    final regionCode = nearest.property?.code;
    if (regionCode == null) return const SizedBox.shrink();

    final region = tsunami.forecastRegions.cast<MergedForecastRegion?>().firstWhere(
      (r) => r?.code == regionCode,
      orElse: () => null,
    );
    if (region == null || region.kind == TsunamiWarningKind.none) {
      return const SizedBox.shrink();
    }

    final designSystem = context.designSystem;
    final color = designSystem.color;
    final stripeColors = TsunamiWarningColor.stripeColors(region.kind);
    final headerBg = TsunamiWarningColor.headerColor(region.kind);
    final distanceKm = nearest.distanceToCoastlineKm;
    final isOffshore = nearest.isOffshore ?? false;

    final observedStations = region.observation?.stations
            .where((s) => !(s.firstHeight.isMissing ?? false))
            .toList() ??
        [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.outlineSoft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (stripeColors.isNotEmpty)
              WarningStripeDecoration(colors: stripeColors),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: headerBg,
              child: Text(
                '${region.name}  ${TsunamiWarningColor.displayName(region.kind)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                '現在地付近の津波情報',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: designSystem.textColor.primary,
                ),
              ),
            ),
            if (distanceKm != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  '海岸線まで約${distanceKm.round()}km${isOffshore ? ' (海上)' : ''}',
                  style: TextStyle(
                    fontSize: 13,
                    color: designSystem.textColor.secondary,
                  ),
                ),
              ),
            if (observedStations.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                child: Text(
                  '観測状況',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: designSystem.textColor.primary,
                  ),
                ),
              ),
              for (final station in observedStations)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TsunamiObservationStationTile(station: station),
                ),
              const SizedBox(height: 12),
            ] else
              const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
```

注意: `jmaMapAreaTsunamiNearestProvider` のプロバイダー名と戻り値型（`MapDataItem?`）を確認すること。`MapDataItem` には `distanceToCoastlineKm` フィールドと `property?.code` があるはず。`isOffshore` フィールドの有無を実装時に確認し、なければ座標からの簡易判定（海岸線ポリゴンの内外判定）で代替すること。

- [ ] **Step 3: ページにカードを組み込み**

`app/lib/feature/tsunami/ui/tsunami_details_page.dart` の Column 内に追加:

```dart
TsunamiWarningStatusCard(tsunami: tsunami),
CurrentLocationTsunamiCard(tsunami: tsunami),
```

import を追加:
```dart
import 'package:eqmonitor/feature/tsunami/ui/components/current_location_tsunami_card.dart';
```

- [ ] **Step 4: ビルド確認・コミット**

```bash
cd app && flutter analyze
git add app/lib/feature/tsunami/
git commit -m "feat(tsunami): add CurrentLocationTsunamiCard with observation display"
```

---

### Task 5: TsunamiRegionList

警報レベル > 予報区 > 観測点の3段階階層リストを実装する。

**Files:**
- Create: `app/lib/feature/tsunami/ui/components/tsunami_region_list.dart`
- Modify: `app/lib/feature/tsunami/ui/tsunami_details_page.dart` (組み込み)

**Interfaces:**
- Consumes:
  - `TsunamiState` (from tsunamiDetailsNotifierProvider)
  - `TsunamiWarningColor` (from Task 2)
  - `TsunamiObservationStationTile` (from Task 4)
- Produces:
  - `TsunamiRegionList({required TsunamiState tsunami})` — ページの Column に配置

- [ ] **Step 1: TsunamiRegionList を作成**

```dart
// app/lib/feature/tsunami/ui/components/tsunami_region_list.dart
import 'package:eqmonitor/core/designsystem/extensions/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_observation_station_tile.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TsunamiRegionList extends StatelessWidget {
  const TsunamiRegionList({required this.tsunami, super.key});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByWarningKind(tsunami.forecastRegions);
    if (grouped.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final entry in grouped.entries) ...[
            _WarningGroupHeader(kind: entry.key),
            for (final region in entry.value)
              _ForecastRegionCard(region: region),
          ],
        ],
      ),
    );
  }

  static Map<TsunamiWarningKind, List<MergedForecastRegion>>
      _groupByWarningKind(List<MergedForecastRegion> regions) {
    final grouped = <TsunamiWarningKind, List<MergedForecastRegion>>{};
    final order = [
      TsunamiWarningKind.majorWarning,
      TsunamiWarningKind.warning,
      TsunamiWarningKind.advisory,
      TsunamiWarningKind.forecast,
    ];
    for (final kind in order) {
      final matching = regions.where((r) => r.kind == kind).toList();
      if (matching.isNotEmpty) {
        grouped[kind] = matching;
      }
    }
    return grouped;
  }
}

class _WarningGroupHeader extends StatelessWidget {
  const _WarningGroupHeader({required this.kind});

  final TsunamiWarningKind kind;

  @override
  Widget build(BuildContext context) {
    final headerColor = TsunamiWarningColor.headerColor(kind);

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: headerColor, width: 4),
          ),
          color: headerColor.withValues(alpha: 0.1),
        ),
        child: Text(
          TsunamiWarningColor.displayName(kind),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: headerColor,
          ),
        ),
      ),
    );
  }
}

class _ForecastRegionCard extends StatelessWidget {
  const _ForecastRegionCard({required this.region});

  final MergedForecastRegion region;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final hasObservation = region.observation != null &&
        region.observation!.stations.isNotEmpty;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.outlineSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              region.name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: designSystem.textColor.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: _ForecastDetails(region: region),
          ),
          if (hasObservation)
            _ObservationExpansion(
              stations: region.observation!.stations,
            ),
          if (!hasObservation)
            const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _ForecastDetails extends StatelessWidget {
  const _ForecastDetails({required this.region});

  final MergedForecastRegion region;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final parts = <String>[];

    final mh = region.maxHeight;
    if (mh != null) {
      if (mh.qualitative != null) {
        parts.add(
          '予想最大波高: ${switch (mh.qualitative!) {
            QualitativeHeight.enormous => '巨大',
            QualitativeHeight.high => '高い',
          }}',
        );
      } else if (mh.value != null) {
        final valueStr = '${mh.value}m';
        parts.add(
          '予想最大波高: ${mh.over == true ? '$valueStr超' : valueStr}',
        );
      }
    }

    final fh = region.firstHeight;
    if (fh != null) {
      if (fh.condition != null) {
        parts.add(
          '到達予想: ${switch (fh.condition!) {
            FirstHeightCondition.arriving => '第一波到達中',
            FirstHeightCondition.firstWaveConfirmed => '第一波確認',
            FirstHeightCondition.imminent => 'まもなく到達',
          }}',
        );
      } else if (fh.arrivalTime != null) {
        parts.add(
          '到達予想: ${DateFormat('HH:mm').format(fh.arrivalTime!.toLocal())}頃',
        );
      }
    }

    if (parts.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        parts.join('\n'),
        style: TextStyle(
          fontSize: 13,
          color: designSystem.textColor.secondary,
        ),
      ),
    );
  }
}

class _ObservationExpansion extends StatefulWidget {
  const _ObservationExpansion({required this.stations});

  final List<TsunamiObservationStation> stations;

  @override
  State<_ObservationExpansion> createState() => _ObservationExpansionState();
}

class _ObservationExpansionState extends State<_ObservationExpansion> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final observedStations = widget.stations
        .where((s) => !(s.firstHeight.isMissing ?? false))
        .toList();

    if (observedStations.isEmpty) return const SizedBox(height: 8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  size: 18,
                  color: designSystem.textColor.secondary,
                ),
                const SizedBox(width: 4),
                Text(
                  '観測点を表示 (${observedStations.length})',
                  style: TextStyle(
                    fontSize: 13,
                    color: designSystem.textColor.secondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_expanded)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final station in observedStations)
                  TsunamiObservationStationTile(station: station),
              ],
            ),
          ),
      ],
    );
  }
}
```

- [ ] **Step 2: ページに組み込み**

`app/lib/feature/tsunami/ui/tsunami_details_page.dart` の Column 内:

```dart
TsunamiWarningStatusCard(tsunami: tsunami),
CurrentLocationTsunamiCard(tsunami: tsunami),
TsunamiRegionList(tsunami: tsunami),
```

import を追加:
```dart
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_region_list.dart';
```

- [ ] **Step 3: ビルド確認・コミット**

```bash
cd app && flutter analyze
git add app/lib/feature/tsunami/
git commit -m "feat(tsunami): add TsunamiRegionList with hierarchical display"
```

---

### Task 6: TsunamiEarthquakeCard + AdBanner integration

地震情報カードと広告バナーの組み込み。

**Files:**
- Create: `app/lib/feature/tsunami/ui/components/tsunami_earthquake_card.dart`
- Modify: `app/lib/feature/tsunami/ui/tsunami_details_page.dart` (全コンポーネント統合)

**Interfaces:**
- Consumes: `TsunamiState` (from tsunamiDetailsNotifierProvider)
- Produces: `TsunamiEarthquakeCard({required TsunamiStateEarthquake earthquake, required List<String> eventIds})` — ページの Column に配置

- [ ] **Step 1: TsunamiEarthquakeCard を作成**

```dart
// app/lib/feature/tsunami/ui/components/tsunami_earthquake_card.dart
import 'package:eqmonitor/core/designsystem/extensions/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TsunamiEarthquakeCard extends StatelessWidget {
  const TsunamiEarthquakeCard({
    required this.earthquake,
    required this.eventIds,
    super.key,
  });

  final TsunamiStateEarthquake earthquake;
  final List<String> eventIds;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final hypo = earthquake.hypocenter;

    final magnitudeStr = hypo.magnitude.type == MagnitudeType.normal
        ? 'M${hypo.magnitude.value}'
        : 'M不明';
    final depthStr = hypo.depth.type == DepthType.normal
        ? '深さ${hypo.depth.value}km'
        : '深さ不明';
    final timeStr = DateFormat('yyyy/MM/dd HH:mm').format(
      earthquake.originTime.toLocal(),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.outlineSoft),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: eventIds.isNotEmpty
              ? () => EarthquakeHistoryDetailsRoute(
                    eventId: eventIds.first,
                  ).push<void>(context)
              : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hypo.value.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: designSystem.textColor.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$timeStr  $magnitudeStr  $depthStr',
                  style: TextStyle(
                    fontSize: 13,
                    color: designSystem.textColor.secondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

注意: `EarthquakeHistoryDetailsRoute` のルート名を実装時に確認すること。既存のルーター定義に合わせる。

- [ ] **Step 2: ページの Column を完成させる**

`app/lib/feature/tsunami/ui/tsunami_details_page.dart` の Column:

```dart
Column(
  children: [
    TsunamiWarningStatusCard(tsunami: tsunami),
    CurrentLocationTsunamiCard(tsunami: tsunami),
    TsunamiRegionList(tsunami: tsunami),
    if (tsunami.updatedAt
            .toLocal()
            .difference(DateTime.now())
            .abs() >
        const Duration(hours: 24))
      const AdBanner(),
    if (tsunami.earthquake != null)
      TsunamiEarthquakeCard(
        earthquake: tsunami.earthquake!,
        eventIds: tsunami.eventIds,
      ),
  ],
)
```

import を追加:
```dart
import 'package:eqmonitor/feature/ads/ui/component/ad_banner.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_earthquake_card.dart';
```

- [ ] **Step 3: ビルド確認・コミット**

```bash
cd app && flutter analyze
git add app/lib/feature/tsunami/
git commit -m "feat(tsunami): add TsunamiEarthquakeCard and complete sheet layout"
```

---

### Task 7: TsunamiDetailsMapView

MapLibre マップに津波予報区ポリゴン、震源マーカー、観測点マーカーを表示する。

**Files:**
- Create: `app/lib/feature/tsunami/ui/components/tsunami_details_map_view.dart`
- Modify: `app/lib/feature/tsunami/ui/tsunami_details_page.dart` (マップを組み込み)

**Interfaces:**
- Consumes:
  - `TsunamiState` (from tsunamiDetailsNotifierProvider)
  - `TsunamiWarningColor.mapFillColor`, `.mapBorderColor` (from Task 2)
  - JMA Map データ (protobuf)、津波パラメータ（観測点位置情報）
- Produces:
  - `TsunamiDetailsMapView({required TsunamiState tsunami})` — Stack の [0] に配置

- [ ] **Step 1: マップビューを作成**

このタスクは既存の `EarthquakeHistoryDetailsMapView` (`app/lib/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart`) を参考に実装する。

```dart
// app/lib/feature/tsunami/ui/components/tsunami_details_map_view.dart
import 'package:eqmonitor/core/designsystem/extensions/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class TsunamiDetailsMapView extends HookConsumerWidget {
  const TsunamiDetailsMapView({required this.tsunami, super.key});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // MapLibreの実装は既存のearthquake_history_details_map_view.dartを参考に。
    // 以下は骨格のみ。実装者は既存マップの初期化・レイヤー追加パターンを踏襲すること。

    return const ColoredBox(
      color: Colors.grey,
      child: SizedBox.expand(
        child: Center(
          child: Text('Map View - TODO: implement with MapLibre'),
        ),
      ),
    );
  }
}
```

実装者への詳細指示:

1. 既存の `earthquake_history_details_map_view.dart` を読み、MapLibre の初期化パターン（MapLibreMap widget, onMapCreated, onStyleLoadedCallback）を理解する

2. `onStyleLoaded` コールバックで以下のレイヤーを追加:
   - **津波予報区ポリゴンレイヤー**: JMAマップデータの `areaTsunami` から GeoJSON ソースを作成。`tsunami.forecastRegions` の `code` をキーに、`TsunamiWarningColor.mapFillColor(kind)` で塗りつぶし、`TsunamiWarningColor.mapBorderColor(kind)` でボーダー
   - **震源マーカー**: `earthquake?.hypocenter.coordinates` がある場合に SymbolLayer または CircleLayer で表示
   - **観測点マーカー**: 津波パラメータ（`TsunamiParameter`）の観測点位置情報を使い、`forecastRegions` 内の `observation.stations` のデータと照合して CircleLayer を追加。色は `maxHeight` に基づく

3. カメラ初期位置: 全予報区の bounds + 震源を含む LatLngBounds にフィット

4. 観測点タップ時: `onFeatureTapped` で Callout 表示（SnackBar またはカスタムオーバーレイ）

マップの実装は他のタスクと独立しており、初期段階では placeholder（ColoredBox）のままでも画面全体は動作する。マップ実装の詳細は既存コードのパターンに強く依存するため、実装者が `earthquake_history_details_map_view.dart` を参考に進めること。

- [ ] **Step 2: ページのマップを置換**

`app/lib/feature/tsunami/ui/tsunami_details_page.dart` の Stack[0]:

```dart
// Before:
const ColoredBox(
  color: Colors.grey,
  child: SizedBox.expand(),
),

// After:
TsunamiDetailsMapView(tsunami: tsunami),
```

import を追加:
```dart
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_details_map_view.dart';
```

- [ ] **Step 3: ビルド確認・コミット**

```bash
cd app && flutter analyze
git add app/lib/feature/tsunami/
git commit -m "feat(tsunami): add TsunamiDetailsMapView"
```

---

### Task 8: Final Integration + Polish

デバッグ画面の完成、エッジケース対応、lint修正、全体確認。

**Files:**
- Modify: `app/lib/feature/settings/children/config/debug/tsunami/debug_tsunami_details_page.dart`
- Modify: 全津波関連ファイル（lint修正）

**Interfaces:**
- Consumes: 全タスクの成果物
- Produces: 完成した津波情報表示画面

- [ ] **Step 1: デバッグ画面の完成**

`debug_tsunami_details_page.dart` の `_fetchTsunamiList` を正しく実装。`TsunamiListResponse` を確認し、`items` の型（`TsunamiListItem`）のフィールド（`id`, `headline`, `maxForecastGrade` 等）を使って一覧表示する。

```dart
// _TsunamiListView のリビルド
class _TsunamiListView extends ConsumerStatefulWidget {
  @override
  ConsumerState<_TsunamiListView> createState() => _TsunamiListViewState();
}

class _TsunamiListViewState extends ConsumerState<_TsunamiListView> {
  late Future<TsunamiListResponse> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchList();
  }

  Future<TsunamiListResponse> _fetchList() async {
    final client = ref.read(apiClientProvider).tsunami;
    final response = await client.getV2Tsunami(limit: '20');
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TsunamiListResponse>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final data = snapshot.data!;
        final items = data.items;
        if (items.isEmpty) {
          return const Center(child: Text('No tsunami events found'));
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.headline ?? item.id),
              subtitle: Text(
                'ID: ${item.id}\n'
                'Active: ${item.isActive} | Canceled: ${item.isCanceled}',
              ),
              isThreeLine: true,
              onTap: () => TsunamiDetailsRoute(
                tsunamiId: item.id,
              ).push<void>(context),
            );
          },
        );
      },
    );
  }
}
```

注意: `TsunamiListResponse` のフィールド名は生成コードに依存する。`items` が `List<TsunamiListItem>` なのか `List<TsunamiState>` なのかを確認し、適切にアクセスすること。

- [ ] **Step 2: flutter analyze + dart fix + dart format**

```bash
cd app && dart fix --apply && dart format . && flutter analyze
```

すべての warning/error を解消する。

- [ ] **Step 3: 最終コミット**

```bash
git add -A
git commit -m "feat(tsunami): polish debug page and fix lint issues"
```

- [ ] **Step 4: PR 作成**

```bash
gh pr create --repo YumNumm/EQMonitor --base develop --title "feat: 津波情報表示画面の実装" --body "$(cat <<'EOF'
## Summary
- 津波情報詳細画面（TsunamiDetailsPage）を新規実装
- Stack[MapView + BasicModalSheet] パターンで地震詳細画面と統一
- 警報ステータスカード、現在地カード、地域一覧、地震カードを実装
- WarningStripeDecoration を汎用コンポーネントとして切り出し
- デバッグ画面からの動線を追加

## Test plan
- [ ] デバッグ画面から津波詳細画面への遷移確認
- [ ] 過去の津波事例データでの表示確認
- [ ] 警報レベルごとの色分け確認
- [ ] 現在地カードの表示/非表示切り替え確認
- [ ] 地域一覧の展開/折りたたみ確認
- [ ] 解除済み津波の表示確認
- [ ] flutter analyze クリア
EOF
)"
```
