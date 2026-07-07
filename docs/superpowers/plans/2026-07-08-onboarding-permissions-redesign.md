# Onboarding Permissions Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** オンボーディング権限ページを、通知・重大な通知・位置情報を個別に説明して許可/スキップできる画面へ作り替え、オンボーディングの下部ナビゲーション状態を読みやすく整理する。

**Architecture:** 権限の完了判定と連動状態は純粋な Dart model に切り出し、Widget はその状態を表示・更新するだけにする。オンボーディング親はページ遷移と下部バー状態を持ち、ステップ側は明示的なコールバックで現在のナビゲーション設定を登録する。Q&Aリンクは新しいアプリ内WebViewページへ遷移し、正式URLができるまでは `https://example.com` を表示する。

**Tech Stack:** Flutter 3.44.4, Dart ^3.11.0, Riverpod 3, flutter_hooks, go_router_builder, Firebase Messaging, Geolocator, flutter_inappwebview

## Global Constraints

- Flutter / Dart コマンドは常に `mise exec --` 経由で実行する。
- 依存追加は `flutter pub add` を使い、`pubspec.yaml` の依存部分を直接編集しない。
- `.g.dart` や `.*.dart` に該当する生成ファイルは直接編集しない。
- Widget Test は新規追加しない。必要な検証は純粋ロジックの単体テストに限定する。
- ストレージキー追加は不要。新しい永続化は行わない。
- 生命に関わる情報を扱うため、権限や位置情報の状態に固定値フォールバックやランダム値を入れない。
- この計画書の実行中も、ユーザーから明示依頼があるまで git commit は作成しない。

---

## File Structure

- Create: `app/lib/feature/onboarding/ui/model/onboarding_permission_flow_state.dart`
  - 権限項目の状態、スキップ連動、次へ有効化条件を表現する純粋 Dart model。
- Create: `app/test/feature/onboarding/onboarding_permission_flow_state_test.dart`
  - Widget Test ではなく、権限状態 model の単体テスト。
- Modify: `app/lib/feature/onboarding/ui/page/onboarding_page.dart`
  - 下部ナビゲーション状態の命名と受け渡しを整理する。新しい model import と WebView で必要な import を追加する。
- Modify: `app/lib/feature/onboarding/ui/components/onboarding_step_page.dart`
  - ステップにナビゲーション設定コールバックを明示的に渡す。
- Modify: `app/lib/feature/onboarding/ui/components/welcome_step_page.dart`
  - 既存の `scope.setStepNavigation` 依存を、新しい明示コールバックへ移す。
- Modify: `app/lib/feature/onboarding/ui/components/notification_settings_step_page.dart`
  - 既存の `scope.setStepNavigation` 依存を、新しい明示コールバックへ移す。
- Modify: `app/lib/feature/onboarding/ui/components/complete_step_page.dart`
  - 既存の `scope.setStepNavigation` 依存を、新しい明示コールバックへ移す。
- Modify: `app/lib/feature/onboarding/ui/components/permissions_step_page.dart`
  - 権限ページを2セクション構成に作り替える。
- Modify: `app/lib/feature/onboarding/ui/model/onboarding_permission_status.dart`
  - 旧 `_PermissionState` を使わなくなったら削除し、既存 `_NotificationPreset` のみ残す。不要ならファイル名変更はせず差分を小さくする。
- Create: `app/lib/feature/onboarding/ui/page/onboarding_web_view_page.dart`
  - Q&Aリンク用のアプリ内WebViewページ。
- Modify: `app/lib/feature/onboarding/ui/onboarding_page.dart`
  - WebViewページの export を追加する。
- Modify: `app/lib/core/router/router.dart`
  - WebViewルート追加、オンボーディング未完了時のリダイレクト例外追加。
- Generated: `app/lib/core/router/router.g.dart`
  - `go_router_builder` で再生成する。直接編集しない。
- Modify: `app/pubspec.yaml`, `app/pubspec.lock`
  - `mise exec -- flutter pub add flutter_inappwebview` により更新する。

---

### Task 1: Add Permission Flow Model

**Files:**
- Create: `app/lib/feature/onboarding/ui/model/onboarding_permission_flow_state.dart`
- Test: `app/test/feature/onboarding/onboarding_permission_flow_state_test.dart`

**Interfaces:**
- Produces: `OnboardingPermissionDecision`, `OnboardingPermissionFlowState`
- Consumes: no app services, no Flutter SDK

- [ ] **Step 1: Add the pure model file**

Create `app/lib/feature/onboarding/ui/model/onboarding_permission_flow_state.dart`:

```dart
enum OnboardingPermissionDecision {
  notRequested,
  granted,
  skipped,
}

extension OnboardingPermissionDecisionX on OnboardingPermissionDecision {
  bool get isComplete => switch (this) {
    OnboardingPermissionDecision.granted ||
    OnboardingPermissionDecision.skipped => true,
    OnboardingPermissionDecision.notRequested => false,
  };

  bool get isGranted => this == OnboardingPermissionDecision.granted;
}

class OnboardingPermissionFlowState {
  const OnboardingPermissionFlowState({
    required this.isCriticalAlertSupported,
    this.notification = OnboardingPermissionDecision.notRequested,
    this.criticalAlert = OnboardingPermissionDecision.notRequested,
    this.foregroundLocation = OnboardingPermissionDecision.notRequested,
    this.backgroundLocation = OnboardingPermissionDecision.notRequested,
  });

  final bool isCriticalAlertSupported;
  final OnboardingPermissionDecision notification;
  final OnboardingPermissionDecision criticalAlert;
  final OnboardingPermissionDecision foregroundLocation;
  final OnboardingPermissionDecision backgroundLocation;

  bool get isCriticalAlertVisible => isCriticalAlertSupported;

  bool get canRequestCriticalAlert =>
      isCriticalAlertVisible && notification.isGranted;

  bool get canRequestBackgroundLocation => foregroundLocation.isGranted;

  bool get canContinue =>
      notification.isComplete &&
      (!isCriticalAlertVisible || criticalAlert.isComplete) &&
      foregroundLocation.isComplete &&
      backgroundLocation.isComplete;

  OnboardingPermissionFlowState grantNotification() => copyWith(
    notification: OnboardingPermissionDecision.granted,
  );

  OnboardingPermissionFlowState skipNotification() => copyWith(
    notification: OnboardingPermissionDecision.skipped,
    criticalAlert: OnboardingPermissionDecision.skipped,
  );

  OnboardingPermissionFlowState grantCriticalAlert() => copyWith(
    criticalAlert: OnboardingPermissionDecision.granted,
  );

  OnboardingPermissionFlowState skipCriticalAlert() => copyWith(
    criticalAlert: OnboardingPermissionDecision.skipped,
  );

  OnboardingPermissionFlowState grantForegroundLocation() => copyWith(
    foregroundLocation: OnboardingPermissionDecision.granted,
  );

  OnboardingPermissionFlowState skipForegroundLocation() => copyWith(
    foregroundLocation: OnboardingPermissionDecision.skipped,
    backgroundLocation: OnboardingPermissionDecision.skipped,
  );

  OnboardingPermissionFlowState grantBackgroundLocation() => copyWith(
    backgroundLocation: OnboardingPermissionDecision.granted,
  );

  OnboardingPermissionFlowState skipBackgroundLocation() => copyWith(
    backgroundLocation: OnboardingPermissionDecision.skipped,
  );

  OnboardingPermissionFlowState copyWith({
    bool? isCriticalAlertSupported,
    OnboardingPermissionDecision? notification,
    OnboardingPermissionDecision? criticalAlert,
    OnboardingPermissionDecision? foregroundLocation,
    OnboardingPermissionDecision? backgroundLocation,
  }) => OnboardingPermissionFlowState(
    isCriticalAlertSupported:
        isCriticalAlertSupported ?? this.isCriticalAlertSupported,
    notification: notification ?? this.notification,
    criticalAlert: criticalAlert ?? this.criticalAlert,
    foregroundLocation: foregroundLocation ?? this.foregroundLocation,
    backgroundLocation: backgroundLocation ?? this.backgroundLocation,
  );
}
```

- [ ] **Step 2: Add unit tests**

Create `app/test/feature/onboarding/onboarding_permission_flow_state_test.dart`:

```dart
import 'package:eqmonitor/feature/onboarding/ui/model/onboarding_permission_flow_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingPermissionFlowState', () {
    test('initial state cannot continue', () {
      const state = OnboardingPermissionFlowState(
        isCriticalAlertSupported: true,
      );

      expect(state.canContinue, isFalse);
      expect(state.canRequestCriticalAlert, isFalse);
      expect(state.canRequestBackgroundLocation, isFalse);
    });

    test('skipping notification also skips critical alert', () {
      final state = const OnboardingPermissionFlowState(
        isCriticalAlertSupported: true,
      ).skipNotification();

      expect(state.notification, OnboardingPermissionDecision.skipped);
      expect(state.criticalAlert, OnboardingPermissionDecision.skipped);
    });

    test('unsupported critical alert is not required to continue', () {
      final state = const OnboardingPermissionFlowState(
        isCriticalAlertSupported: false,
      )
          .grantNotification()
          .grantForegroundLocation()
          .grantBackgroundLocation();

      expect(state.isCriticalAlertVisible, isFalse);
      expect(state.canContinue, isTrue);
    });

    test('foreground location grants access to background request', () {
      final initial = const OnboardingPermissionFlowState(
        isCriticalAlertSupported: false,
      );
      final granted = initial.grantForegroundLocation();

      expect(initial.canRequestBackgroundLocation, isFalse);
      expect(granted.canRequestBackgroundLocation, isTrue);
    });

    test('skipping foreground location also skips background location', () {
      final state = const OnboardingPermissionFlowState(
        isCriticalAlertSupported: false,
      ).skipForegroundLocation();

      expect(state.foregroundLocation, OnboardingPermissionDecision.skipped);
      expect(state.backgroundLocation, OnboardingPermissionDecision.skipped);
    });

    test('all visible items must be complete to continue', () {
      final incomplete = const OnboardingPermissionFlowState(
        isCriticalAlertSupported: true,
      )
          .grantNotification()
          .grantCriticalAlert()
          .grantForegroundLocation();
      final complete = incomplete.skipBackgroundLocation();

      expect(incomplete.canContinue, isFalse);
      expect(complete.canContinue, isTrue);
    });
  });
}
```

- [ ] **Step 3: Run the unit test**

Run:

```bash
mise exec -- flutter test test/feature/onboarding/onboarding_permission_flow_state_test.dart
```

Working directory: `app/`

Expected: all tests pass.

---

### Task 2: Simplify Onboarding Navigation State Wiring

**Files:**
- Modify: `app/lib/feature/onboarding/ui/page/onboarding_page.dart`
- Modify: `app/lib/feature/onboarding/ui/components/onboarding_step_page.dart`
- Modify: `app/lib/feature/onboarding/ui/components/welcome_step_page.dart`
- Modify: `app/lib/feature/onboarding/ui/components/notification_settings_step_page.dart`
- Modify: `app/lib/feature/onboarding/ui/components/complete_step_page.dart`

**Interfaces:**
- Consumes: existing `_StepNavigationState`
- Produces: explicit `_OnboardingStepNavigation` and `_OnboardingNavigationRegistrar`

- [ ] **Step 1: Replace implicit scope setter with explicit registrar types**

In `app/lib/feature/onboarding/ui/page/onboarding_page.dart`, replace the old typedef:

```dart
typedef _SetStepNavigation =
    void Function({
      required _OnboardingStep step,
      required _StepNavigationState state,
    });
```

with:

```dart
typedef _OnboardingNavigationRegistrar =
    void Function(_StepNavigationState state);

class _OnboardingStepNavigation {
  const _OnboardingStepNavigation({
    required this.nextPage,
    required this.previousPage,
    required this.register,
  });

  final Future<void> Function() nextPage;
  final Future<void> Function() previousPage;
  final _OnboardingNavigationRegistrar register;
}
```

- [ ] **Step 2: Update `OnboardingPage` to create a current-step registrar**

In `OnboardingPage.build`, replace `setStepNavigation` with:

```dart
final registerNavigation = useCallback<_OnboardingNavigationRegistrar>((state) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!context.mounted) {
      return;
    }
    stepNavigation.value = state;
  });
}, [stepNavigation]);

final stepControls = _OnboardingStepNavigation(
  nextPage: animateToNext,
  previousPage: goToPrevious,
  register: registerNavigation,
);
```

Remove `setStepNavigation` from `_OnboardingScope`.

- [ ] **Step 3: Pass navigation controls through `_OnboardingStepPage`**

In `app/lib/feature/onboarding/ui/components/onboarding_step_page.dart`, change the widget to:

```dart
class _OnboardingStepPage extends StatelessWidget {
  const _OnboardingStepPage({
    required this.step,
    required this.navigation,
  });

  final _OnboardingStep step;
  final _OnboardingStepNavigation navigation;

  @override
  Widget build(BuildContext context) {
    return switch (step) {
      _OnboardingStep.welcome => _WelcomeStepPage(navigation: navigation),
      _OnboardingStep.permissions => _PermissionsStepPage(
        navigation: navigation,
      ),
      _OnboardingStep.notificationSettings => _NotificationSettingsStepPage(
        navigation: navigation,
      ),
      _OnboardingStep.complete => _CompleteStepPage(navigation: navigation),
    };
  }
}
```

Then update the `PageView.builder` call in `onboarding_page.dart`:

```dart
itemBuilder: (context, index) => _OnboardingStepPage(
  step: _steps[index],
  navigation: stepControls,
),
```

- [ ] **Step 4: Update step constructors and navigation registration**

For `welcome_step_page.dart`, `notification_settings_step_page.dart`, and `complete_step_page.dart`:

1. Add a required `navigation` constructor parameter.
2. Replace `scope.nextPage` with `navigation.nextPage`.
3. Replace `scope.setStepNavigation(...)` with `navigation.register(...)`.
4. Remove `final scope = _OnboardingScope.of(context);` where no longer needed.

Example for `complete_step_page.dart`:

```dart
class _CompleteStepPage extends HookConsumerWidget {
  const _CompleteStepPage({
    required this.navigation,
  });

  final _OnboardingStepNavigation navigation;
```

and:

```dart
useEffect(() {
  navigation.register(
    _StepNavigationState(
      buttonLabel: 'はじめる',
      isNextEnabled: !isProcessing,
      isProcessing: isProcessing,
      onNext: completeOnboarding,
    ),
  );
  return null;
}, [navigation, isProcessing]);
```

- [ ] **Step 5: Run existing onboarding widget test**

Run:

```bash
mise exec -- flutter test test/feature/onboarding/onboarding_page_test.dart
```

Working directory: `app/`

Expected: existing tests pass. Do not add new Widget Tests.

---

### Task 3: Add WebView Dependency and Page

**Files:**
- Modify via command: `app/pubspec.yaml`
- Modify via command: `app/pubspec.lock`
- Create: `app/lib/feature/onboarding/ui/page/onboarding_web_view_page.dart`
- Modify: `app/lib/feature/onboarding/ui/onboarding_page.dart`
- Modify: `app/lib/core/router/router.dart`
- Generated: `app/lib/core/router/router.g.dart`

**Interfaces:**
- Produces: `OnboardingWebViewPage`
- Produces route: `OnboardingWebViewRoute({required String title, required String url})`

- [ ] **Step 1: Add direct WebView dependency**

Run:

```bash
mise exec -- flutter pub add flutter_inappwebview
```

Working directory: `app/`

Expected: `app/pubspec.yaml` and `app/pubspec.lock` update through the package manager.

- [ ] **Step 2: Create the WebView page**

Create `app/lib/feature/onboarding/ui/page/onboarding_web_view_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class OnboardingWebViewPage extends StatelessWidget {
  const OnboardingWebViewPage({
    required this.title,
    required this.url,
    super.key,
  });

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    final uri = WebUri(url);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: uri),
      ),
    );
  }
}
```

- [ ] **Step 3: Export the page**

Modify `app/lib/feature/onboarding/ui/onboarding_page.dart`:

```dart
export 'page/onboarding_page.dart';
export 'page/onboarding_web_view_page.dart';
```

- [ ] **Step 4: Add route import and route**

In `app/lib/core/router/router.dart`, add the import:

```dart
import 'package:eqmonitor/feature/onboarding/ui/page/onboarding_web_view_page.dart';
```

Add a top-level typed route near `OnboardingRoute`:

```dart
@TypedGoRoute<OnboardingWebViewRoute>(path: '/onboarding/web-view')
class OnboardingWebViewRoute extends GoRouteData with $OnboardingWebViewRoute {
  const OnboardingWebViewRoute({
    required this.title,
    required this.url,
  });

  final String title;
  final String url;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      OnboardingWebViewPage(title: title, url: url);
}
```

In the onboarding redirect exception list, add:

```dart
const OnboardingWebViewRoute(title: '', url: '').location,
```

Because `location` includes query parameters for this route, if equality does not work as intended after generation, replace the list check with a helper condition:

```dart
final allowedDuringOnboarding = [
  const OnboardingRoute().location,
  const TermOfServiceRoute($extra: null).location,
  const PrivacyPolicyRoute($extra: null).location,
  const LicenseRoute().location,
].contains(state.matchedLocation) ||
    state.matchedLocation == '/onboarding/web-view' ||
    state.matchedLocation.startsWith(const DebugRoute().location);
```

Then use `allowedDuringOnboarding` in the redirect branch.

- [ ] **Step 5: Regenerate routes**

Run:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Working directory: `app/`

Expected: `app/lib/core/router/router.g.dart` is regenerated. Do not edit generated files manually.

---

### Task 4: Rebuild Permissions Step UI

**Files:**
- Modify: `app/lib/feature/onboarding/ui/page/onboarding_page.dart`
- Modify: `app/lib/feature/onboarding/ui/components/permissions_step_page.dart`
- Modify: `app/lib/feature/onboarding/ui/model/onboarding_permission_status.dart`

**Interfaces:**
- Consumes: `OnboardingPermissionFlowState`
- Consumes route: `OnboardingWebViewRoute`
- Produces: new `_PermissionsStepPage({required _OnboardingStepNavigation navigation})`

- [ ] **Step 1: Add imports**

In `app/lib/feature/onboarding/ui/page/onboarding_page.dart`, add:

```dart
import 'package:eqmonitor/feature/onboarding/ui/model/onboarding_permission_flow_state.dart';
import 'package:flutter/foundation.dart';
```

If `_PermissionState` is no longer used, remove it from `app/lib/feature/onboarding/ui/model/onboarding_permission_status.dart` and keep:

```dart
part of '../page/onboarding_page.dart';

enum _NotificationPreset { recommended, custom }
```

- [ ] **Step 2: Change `_PermissionsStepPage` constructor and state**

At the top of `permissions_step_page.dart`, replace the current class header and initial state with:

```dart
class _PermissionsStepPage extends HookConsumerWidget {
  const _PermissionsStepPage({
    required this.navigation,
  });

  static const _temporaryQaUrl = 'https://example.com';

  final _OnboardingStepNavigation navigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final permissionFlow = useState(
      OnboardingPermissionFlowState(
        isCriticalAlertSupported: defaultTargetPlatform == TargetPlatform.iOS,
      ),
    );
    final isProcessing = useState(false);
```

- [ ] **Step 3: Add request handlers**

Inside `build`, add these local async handlers:

```dart
void showPermissionDeniedSnackBar() {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('権限が許可されませんでした。必要になったら設定から変更できます。'),
    ),
  );
}

Future<void> requestNotificationPermission() async {
  isProcessing.value = true;
  final messaging = ref.read(firebaseMessagingProvider);
  final settings = await messaging.requestPermission();
  final authStatus = settings.authorizationStatus;
  if (!context.mounted) {
    return;
  }
  isProcessing.value = false;
  if (authStatus == AuthorizationStatus.authorized ||
      authStatus == AuthorizationStatus.provisional) {
    permissionFlow.value = permissionFlow.value.grantNotification();
    return;
  }
  showPermissionDeniedSnackBar();
}

Future<void> requestCriticalAlertPermission() async {
  isProcessing.value = true;
  final messaging = ref.read(firebaseMessagingProvider);
  final settings = await messaging.requestPermission(criticalAlert: true);
  final isGranted = settings.criticalAlert == AppleNotificationSetting.enabled;
  if (!context.mounted) {
    return;
  }
  isProcessing.value = false;
  if (isGranted) {
    permissionFlow.value = permissionFlow.value.grantCriticalAlert();
    return;
  }
  showPermissionDeniedSnackBar();
}

Future<void> requestForegroundLocationPermission() async {
  isProcessing.value = true;
  final permission = await Geolocator.requestPermission();
  if (!context.mounted) {
    return;
  }
  isProcessing.value = false;
  if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
    permissionFlow.value = permissionFlow.value.grantForegroundLocation();
    return;
  }
  showPermissionDeniedSnackBar();
}

Future<void> requestBackgroundLocationPermission() async {
  isProcessing.value = true;
  final permission = await Geolocator.requestPermission();
  if (!context.mounted) {
    return;
  }
  isProcessing.value = false;
  if (permission == LocationPermission.always) {
    permissionFlow.value = permissionFlow.value.grantBackgroundLocation();
    return;
  }
  showPermissionDeniedSnackBar();
}

void openWebView({required String title}) {
  OnboardingWebViewRoute(
    title: title,
    url: _PermissionsStepPage._temporaryQaUrl,
  ).push<void>(context);
}
```

If `AppleNotificationSetting` is not exposed by the installed Firebase Messaging version, use `settings.criticalAlert.name == 'enabled'` only as a last resort and add a short comment explaining the SDK compatibility reason.

- [ ] **Step 4: Register bottom navigation**

Replace the old `useEffect` navigation registration with:

```dart
useEffect(() {
  navigation.register(
    _StepNavigationState(
      buttonLabel: '次へ',
      isNextEnabled: permissionFlow.value.canContinue,
      isProcessing: isProcessing.value,
      onNext: navigation.nextPage,
    ),
  );
  return null;
}, [navigation, permissionFlow.value, isProcessing.value]);
```

- [ ] **Step 5: Replace the page body**

Replace the old `return Padding(...)` body with a scrollable two-section layout:

```dart
return Padding(
  padding: EdgeInsets.symmetric(horizontal: designSystem.spacing.lg),
  child: ListView(
    children: [
      SizedBox(height: designSystem.spacing.xxxxl),
      Text(
        '通知と\n位置情報',
        style: designSystem.typography.displayMedium,
      ),
      SizedBox(height: designSystem.spacing.sm),
      Text(
        '必要な権限をひとつずつ確認できます。あとから設定で変更できます。',
        style: designSystem.typography.bodyLarge.copyWith(
          color: designSystem.colorTheme.onSurfaceVariant,
        ),
      ),
      SizedBox(height: designSystem.spacing.xl),
      _PermissionSection(
        title: '1. 通知権限',
        children: [
          _PermissionActionCard(
            title: '通知を許可',
            description: '地震情報や緊急地震速報を通知でお知らせします。'
                '通知を送る条件や地域はこの後設定できます',
            decision: permissionFlow.value.notification,
            isEnabled: !isProcessing.value,
            onSkip: () => permissionFlow.value =
                permissionFlow.value.skipNotification(),
            onAllow: requestNotificationPermission,
          ),
          if (permissionFlow.value.isCriticalAlertVisible) ...[
            SizedBox(height: designSystem.spacing.md),
            _PermissionActionCard(
              title: '重大な通知を許可',
              description: '現在地を警報地域とする緊急地震速報(警報)が発表されたときに、'
                  'おやすみモードやマナーモードを無視して強制的に通知を配信します。',
              decision: permissionFlow.value.criticalAlert,
              isEnabled: !isProcessing.value &&
                  permissionFlow.value.canRequestCriticalAlert,
              disabledReason: permissionFlow.value.canRequestCriticalAlert
                  ? null
                  : '先に通知を許可してください',
              onSkip: () => permissionFlow.value =
                  permissionFlow.value.skipCriticalAlert(),
              onAllow: requestCriticalAlertPermission,
            ),
          ],
        ],
      ),
      SizedBox(height: designSystem.spacing.xl),
      _PermissionSection(
        title: '2. 位置情報権限',
        description: Text.rich(
          TextSpan(
            text: '端末の位置情報を利用して、適した通知をお知らせします。\n',
            children: [
              TextSpan(
                text: 'EQMonitorにおける位置情報の扱い方',
                style: designSystem.typography.bodySmall.copyWith(
                  color: designSystem.colorTheme.primary,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => openWebView(title: '位置情報の扱い方'),
              ),
            ],
          ),
        ),
        children: [
          _PermissionActionCard(
            title: 'アプリを開いている時の位置情報',
            description: '緊急地震速報発表時に現在地の予想震度と到達までの時間を表示します。'
                '気象庁が現在地の予想震度と到達予想時刻を発表した場合に限ります。'
                '詳しい情報\n'
                '地震情報を開いた時に、現在地付近で観測した震度を表示します',
            decision: permissionFlow.value.foregroundLocation,
            isEnabled: !isProcessing.value,
            onSkip: () => permissionFlow.value =
                permissionFlow.value.skipForegroundLocation(),
            onAllow: requestForegroundLocationPermission,
            linkLabel: '詳しい情報',
            onLinkTap: () => openWebView(title: '緊急地震速報の詳しい情報'),
          ),
          SizedBox(height: designSystem.spacing.md),
          _PermissionActionCard(
            title: 'アプリを開いていない時の位置情報',
            description: '現在地で緊急地震速報(警報)が発表された時に重大な通知でお知らせします。\n'
                '注意!: 高速で移動している場合やネットワーク環境が悪い場合、'
                '低電力モードにしている場合、前の位置情報で通知が配信される場合があります。\n'
                '現在地で揺れを観測した地震情報が発表された場合のみ通知することができます。'
                'この後の通知設定で細かく設定できます',
            decision: permissionFlow.value.backgroundLocation,
            isEnabled: !isProcessing.value &&
                permissionFlow.value.canRequestBackgroundLocation,
            disabledReason: permissionFlow.value.canRequestBackgroundLocation
                ? null
                : '先にアプリ使用中の位置情報を許可してください',
            onSkip: () => permissionFlow.value =
                permissionFlow.value.skipBackgroundLocation(),
            onAllow: requestBackgroundLocationPermission,
          ),
        ],
      ),
      SizedBox(height: designSystem.spacing.xl),
    ],
  ),
);
```

This step intentionally uses `ListView` because the content is longer than one viewport and text scaling must not overflow.

- [ ] **Step 6: Add private UI helper widgets in the same part file**

Append these private widgets to `permissions_step_page.dart`:

```dart
class _PermissionSection extends StatelessWidget {
  const _PermissionSection({
    required this.title,
    required this.children,
    this.description,
  });

  final String title;
  final Widget? description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: designSystem.typography.titleLarge),
        if (description != null) ...[
          SizedBox(height: designSystem.spacing.sm),
          DefaultTextStyle(
            style: designSystem.typography.bodySmall.copyWith(
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
            child: description!,
          ),
        ],
        SizedBox(height: designSystem.spacing.md),
        ...children,
      ],
    );
  }
}

class _PermissionActionCard extends StatelessWidget {
  const _PermissionActionCard({
    required this.title,
    required this.description,
    required this.decision,
    required this.isEnabled,
    required this.onSkip,
    required this.onAllow,
    this.disabledReason,
    this.linkLabel,
    this.onLinkTap,
  });

  final String title;
  final String description;
  final OnboardingPermissionDecision decision;
  final bool isEnabled;
  final VoidCallback onSkip;
  final Future<void> Function() onAllow;
  final String? disabledReason;
  final String? linkLabel;
  final VoidCallback? onLinkTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final isGranted = decision == OnboardingPermissionDecision.granted;
    final isSkipped = decision == OnboardingPermissionDecision.skipped;
    final actionButtons = isGranted
        ? const [_GrantedPermissionChip()]
        : [
            TextButton(
              onPressed: isSkipped || !isEnabled ? null : onSkip,
              child: Text(isSkipped ? 'スキップしました' : 'スキップ'),
            ),
            FilledButton(
              onPressed: isSkipped || !isEnabled ? null : onAllow,
              child: const Text('許可する'),
            ),
          ];

    return Container(
      padding: EdgeInsets.all(designSystem.spacing.md),
      decoration: BoxDecoration(
        color: designSystem.colorTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(designSystem.shape.card),
        border: Border.all(color: designSystem.colorTheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: designSystem.typography.titleMedium),
          SizedBox(height: designSystem.spacing.sm),
          _PermissionDescriptionText(
            description: description,
            linkLabel: linkLabel,
            onLinkTap: onLinkTap,
          ),
          if (disabledReason != null && !isEnabled) ...[
            SizedBox(height: designSystem.spacing.sm),
            Text(
              disabledReason!,
              style: designSystem.typography.bodySmall.copyWith(
                color: designSystem.colorTheme.outline,
              ),
            ),
          ],
          SizedBox(height: designSystem.spacing.md),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: designSystem.spacing.sm,
            runSpacing: designSystem.spacing.sm,
            children: actionButtons,
          ),
        ],
      ),
    );
  }
}

class _PermissionDescriptionText extends StatelessWidget {
  const _PermissionDescriptionText({
    required this.description,
    required this.linkLabel,
    required this.onLinkTap,
  });

  final String description;
  final String? linkLabel;
  final VoidCallback? onLinkTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final label = linkLabel;
    final recognizer = onLinkTap;
    if (label == null || recognizer == null || !description.contains(label)) {
      return Text(
        description,
        style: designSystem.typography.bodySmall.copyWith(
          color: designSystem.colorTheme.onSurfaceVariant,
        ),
      );
    }

    final parts = description.split(label);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: parts.first),
          TextSpan(
            text: label,
            style: designSystem.typography.bodySmall.copyWith(
              color: designSystem.colorTheme.primary,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = recognizer,
          ),
          TextSpan(text: parts.length > 1 ? parts[1] : ''),
        ],
      ),
      style: designSystem.typography.bodySmall.copyWith(
        color: designSystem.colorTheme.onSurfaceVariant,
      ),
    );
  }
}

class _GrantedPermissionChip extends StatelessWidget {
  const _GrantedPermissionChip();

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return Chip(
      avatar: Icon(
        Icons.check_circle_outline,
        color: designSystem.colorTheme.status.success,
      ),
      label: const Text('許可しました'),
    );
  }
}
```

If lints object to the `description!` in `_PermissionSection`, replace that widget with a pattern variable:

```dart
if (description case final description?) ...[
  SizedBox(height: designSystem.spacing.sm),
  DefaultTextStyle(... child: description),
],
```

- [ ] **Step 7: Format and run focused tests**

Run:

```bash
mise exec -- dart format lib/feature/onboarding test/feature/onboarding
mise exec -- flutter test test/feature/onboarding/onboarding_permission_flow_state_test.dart
mise exec -- flutter test test/feature/onboarding/onboarding_page_test.dart
```

Working directory: `app/`

Expected: format succeeds and tests pass.

---

### Task 5: Analysis and Generation Verification

**Files:**
- Verify all changed app files.
- Generated file may change: `app/lib/core/router/router.g.dart`

**Interfaces:**
- Consumes all previous tasks.
- Produces a clean analyzer result for the touched area.

- [ ] **Step 1: Regenerate after all route edits**

Run:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Working directory: `app/`

Expected: build completes and generated router code is updated.

- [ ] **Step 2: Run focused tests**

Run:

```bash
mise exec -- flutter test test/feature/onboarding/onboarding_permission_flow_state_test.dart
mise exec -- flutter test test/feature/onboarding/onboarding_page_test.dart
```

Working directory: `app/`

Expected: both test commands pass.

- [ ] **Step 3: Run analyzer for the app**

Run:

```bash
mise exec -- flutter analyze
```

Working directory: `app/`

Expected: no new analyzer errors or warnings from the changed files.

- [ ] **Step 4: Manual smoke check**

Run the app and manually verify:

```bash
mise exec -- flutter run
```

Working directory: `app/`

Checklist:

- Initial permissions step shows disabled bottom `次へ`.
- Notification section has `スキップ` and `許可する`.
- Skipping notification marks critical alert skipped or removes it from the remaining requirements.
- Critical alert section appears only on iOS.
- Foreground location must be completed before background location can be requested.
- Both `Text.rich` links open an in-app WebView that loads `https://example.com`.
- Completing or skipping all visible permission items enables bottom `次へ`.

---

## Self-Review

- Spec coverage: The plan covers separate permission sections, next-button completion rules, critical-alert platform visibility, foreground/background location sequencing, WebView placeholder URL, onboarding navigation state cleanup, and the no-new-Widget-Test constraint.
- Placeholder scan: No `TBD`, `TODO`, or unspecified implementation steps remain.
- Type consistency: `OnboardingPermissionFlowState` is produced in Task 1 and consumed in Task 4; `OnboardingWebViewRoute` is produced in Task 3 and consumed in Task 4; `_OnboardingStepNavigation` is produced in Task 2 and consumed by all onboarding steps.
