import 'dart:async';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// MapLibre の source/layer 操作をマップ単位で直列化するキュー。
///
/// 単一の Future チェーンに [enqueue] された操作を登録順に逐次実行する。
/// ある操作が失敗しても、エラーは talker に委譲したうえで後続の操作は
/// 継続する。
class MapOperationQueue {
  Future<void> _chain = Future<void>.value();

  /// [operation] をキューへ積み、既存の操作の完了後に実行する。
  Future<void> enqueue(Future<void> Function() operation) {
    final next = _chain.then((_) => operation()).catchError((
      Object error,
      StackTrace stackTrace,
    ) {
      talker.handle(error, stackTrace);
    });
    _chain = next;
    return next;
  }
}

/// [MapOperationQueue] を Widget ツリーに提供する InheritedWidget。
///
/// 同一マップ上に存在する全レイヤーWidgetの source/layer 追加・削除・更新を
/// 単一の [MapOperationQueue] に集約し、マップ単位で直列化するために使う。
/// 設定トグルや provider の再読込などでレイヤーWidgetのElementが
/// unmount→remountされても、[MapOperationQueue] 自体はこの Scope の
/// State が保持し続けるため、直列化の順序が保証される。
///
/// そのため、この Scope は MapLibreMap 本体（`ValueKey` による remount の
/// 影響を受けるWidget）よりも外側に配置すること。
class MapOperationQueueScope extends HookWidget {
  const new({required this.child, super.key});

  final Widget child;

  static MapOperationQueue of(BuildContext context) =>
      maybeOf(context) ?? (throw Exception('MapOperationQueueScope not found'));

  static MapOperationQueue? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_InheritedMapOperationQueueScope>()
      ?.queue;

  @override
  Widget build(BuildContext context) {
    final queue = useMemoized(MapOperationQueue.new);
    return _InheritedMapOperationQueueScope(queue: queue, child: child);
  }
}

class _InheritedMapOperationQueueScope extends InheritedWidget {
  const new({
    required this.queue,
    required super.child,
  });

  final MapOperationQueue queue;

  @override
  bool updateShouldNotify(_InheritedMapOperationQueueScope oldWidget) => false;
}
