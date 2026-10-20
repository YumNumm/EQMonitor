// Flutter imports:
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_lifecycle.g.dart';

/// ref: https://zenn.dev/riscait/books/flutter-riverpod-practical-introduction/viewer/v2-app-lifecycle
@Riverpod(keepAlive: true)
class AppLifecycle extends _$AppLifecycle with WidgetsBindingObserver {
  @override
  AppLifecycleState build() {
    // プロバイダ構築時に監視を開始。
    final binding = WidgetsBinding.instance..addObserver(this);
    // プロバイダが破棄された時に監視を解除。
    ref.onDispose(() => binding.removeObserver(this));
    // 非同期の起動処理中に background へ移った場合も実際の状態から開始する。
    return binding.lifecycleState ?? AppLifecycleState.detached;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // `AppLifecycleState` の変更を検知してNotifierが持つ状態を更新。
    this.state = state;
    super.didChangeAppLifecycleState(state);
  }
}
