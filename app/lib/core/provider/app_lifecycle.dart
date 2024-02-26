// Flutter imports:
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:flutter/widgets.dart';
// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_lifecycle.g.dart';

/// ref: https://zenn.dev/riscait/books/flutter-riverpod-practical-introduction/viewer/v2-app-lifecycle
@Riverpod(keepAlive: true)
AppLifecycleState appLifeCycle(AppLifeCycleRef ref) {
  final observer = _AppLifecycleObserver((value) => ref.state = value, ref);

  final binding = WidgetsBinding.instance..addObserver(observer);
  ref
    ..onDispose(() => binding.removeObserver(observer))
    ..listenSelf(
      (previous, next) => ref
          .read(talkerProvider)
          .logTyped(AppLifeCycleLog('$previous -> $next')),
    );
  return AppLifecycleState.resumed;
}

class _AppLifecycleObserver extends WidgetsBindingObserver {
  _AppLifecycleObserver(this._didChangeState, this.ref);
  final Ref ref;

  final ValueChanged<AppLifecycleState> _didChangeState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _didChangeState(state);
    super.didChangeAppLifecycleState(state);
  }
}

extension AppLifecycleStateExtension on AppLifecycleState {
  bool get isResumed => this == AppLifecycleState.resumed;
}
