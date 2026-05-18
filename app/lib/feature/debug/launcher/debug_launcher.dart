import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// 端末シェイクまたは Shift+D でデバッグページを開くラッパー。
///
/// kDebugMode / Beta ビルドでのみ有効化することを想定。
class DebugLauncher extends ConsumerStatefulWidget {
  const DebugLauncher({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<DebugLauncher> createState() => _DebugLauncherState();
}

class _DebugLauncherState extends ConsumerState<DebugLauncher> {
  static const _shakeGForceThreshold = 2.7;
  static const _shakeCooldown = Duration(seconds: 1);
  static const _openCooldown = Duration(milliseconds: 800);

  StreamSubscription<UserAccelerometerEvent>? _accelSubscription;
  var _lastShake = DateTime.fromMillisecondsSinceEpoch(0);
  var _lastOpen = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  void initState() {
    super.initState();
    _startShakeListener();
    HardwareKeyboard.instance.addHandler(_handleKey);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKey);
    unawaited(_accelSubscription?.cancel());
    super.dispose();
  }

  void _startShakeListener() {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      return;
    }
    _accelSubscription = userAccelerometerEventStream(
      samplingPeriod: SensorInterval.gameInterval,
    ).listen(_onAccel, onError: (_) {});
  }

  void _onAccel(UserAccelerometerEvent event) {
    final magnitude = sqrt(
      event.x * event.x + event.y * event.y + event.z * event.z,
    );
    final gForce = magnitude / 9.80665;
    if (gForce < _shakeGForceThreshold) {
      return;
    }
    final now = DateTime.now();
    if (now.difference(_lastShake) < _shakeCooldown) {
      return;
    }
    _lastShake = now;
    _openDebugPage();
  }

  bool _handleKey(KeyEvent event) {
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
    _openDebugPage();
    return true;
  }

  void _openDebugPage() {
    final now = DateTime.now();
    if (now.difference(_lastOpen) < _openCooldown) {
      return;
    }
    if (!_isLauncherEnabled) {
      return;
    }
    _lastOpen = now;
    final router = ref.read(goRouterProvider);
    final currentLocation = router.routerDelegate.currentConfiguration.uri
        .toString();
    if (currentLocation.startsWith(const DebugRoute().location)) {
      return;
    }
    unawaited(router.push<void>(const DebugRoute().location));
  }

  bool get _isLauncherEnabled {
    if (kDebugMode) {
      return true;
    }
    final buildCfg = ref.read(buildConfigProvider);
    if (buildCfg.isBetaTesting) {
      return true;
    }
    return ref.read(debugProvider).value ?? false;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
