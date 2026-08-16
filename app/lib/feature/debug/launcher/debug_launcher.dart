import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// go_router の現在表示中の画面ロケーションを解決する。
///
/// go_router は `push` (imperative navigation) でルートを積んでも
/// [RouteMatchList.uri] を更新しないため、`currentConfiguration.uri` だけでは
/// push で開いた画面（例: デバッグ画面）を検出できない。
/// スタック最上段が [ImperativeRouteMatch] の場合はそのロケーションを参照する。
class GoRouterCurrentLocationResolver {
  static String resolve(GoRouter router) {
    final configuration = router.routerDelegate.currentConfiguration;
    final lastMatch = configuration.matches.lastOrNull;
    if (lastMatch is ImperativeRouteMatch) {
      return lastMatch.matches.uri.toString();
    }
    return configuration.uri.toString();
  }
}

/// 端末シェイクまたは Shift+D でデバッグページを開くラッパー。
///
/// kDebugMode / Beta ビルドでのみ有効化することを想定。
class DebugLauncher extends HookConsumerWidget {
  const DebugLauncher({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const shakeGForceThreshold = 2.7;
    const shakeCooldown = Duration(seconds: 1);
    const openCooldown = Duration(milliseconds: 800);

    final accelSubscription =
        useRef<StreamSubscription<UserAccelerometerEvent>?>(null);
    final lastShake = useRef(DateTime.fromMillisecondsSinceEpoch(0));
    final lastOpen = useRef(DateTime.fromMillisecondsSinceEpoch(0));

    useEffect(() {
      bool isLauncherEnabled() {
        if (kDebugMode) {
          return true;
        }
        final buildCfg = ref.read(buildConfigProvider);
        if (!buildCfg.isDeveloperUiEnabled) {
          return false;
        }
        if (buildCfg.isBetaTesting) {
          return true;
        }
        return ref.read(debugProvider).value ?? false;
      }

      void openDebugPage() {
        final now = DateTime.now();
        if (now.difference(lastOpen.value) < openCooldown) {
          return;
        }
        if (!isLauncherEnabled()) {
          return;
        }
        lastOpen.value = now;
        final router = ref.read(goRouterProvider);
        if (GoRouterCurrentLocationResolver.resolve(router)
            .startsWith(const DebugRoute().location)) {
          return;
        }
        unawaited(router.push<void>(const DebugRoute().location));
      }

      void onAccel(UserAccelerometerEvent event) {
        final magnitude = sqrt(
          event.x * event.x + event.y * event.y + event.z * event.z,
        );
        final gForce = magnitude / 9.80665;
        if (gForce < shakeGForceThreshold) {
          return;
        }
        final now = DateTime.now();
        if (now.difference(lastShake.value) < shakeCooldown) {
          return;
        }
        lastShake.value = now;
        openDebugPage();
      }

      void startShakeListener() {
        if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
          return;
        }
        accelSubscription.value = userAccelerometerEventStream(
          samplingPeriod: SensorInterval.gameInterval,
        ).listen(onAccel, onError: (_) {});
      }

      bool handleKey(KeyEvent event) {
        if (event is! KeyDownEvent) {
          return false;
        }
        if (event.logicalKey != LogicalKeyboardKey.keyD) {
          return false;
        }
        final keyboard = HardwareKeyboard.instance;
        final shiftPressed =
            keyboard.isLogicalKeyPressed(LogicalKeyboardKey.shiftLeft) ||
            keyboard.isLogicalKeyPressed(LogicalKeyboardKey.shiftRight);
        if (!shiftPressed) {
          return false;
        }
        openDebugPage();
        return true;
      }

      startShakeListener();
      HardwareKeyboard.instance.addHandler(handleKey);

      return () {
        HardwareKeyboard.instance.removeHandler(handleKey);
        unawaited(accelSubscription.value?.cancel());
      };
    }, const []);

    return child;
  }
}
