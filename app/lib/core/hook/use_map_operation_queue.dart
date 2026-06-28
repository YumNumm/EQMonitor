import 'dart:async';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// MapLibre の source/layer 操作を直列化して実行するスケジューラ。
typedef MapOperationScheduler =
    Future<void> Function(Future<void> Function() operation);

/// MapLibre の source/layer の追加・削除を直列化して実行するためのフック。
///
/// `useEffect` で素朴に source/layer を追加・削除すると、依存変化時に
/// 「非同期なクリーンアップ(削除)」と「再実行による追加」が互いの完了を
/// 待たずに並行実行され、以下の不具合が発生する:
///
/// - `A Source with the id "..." already exists in the map style.` 例外
///   (削除完了前に追加が走る)
/// - 追加直後に旧クリーンアップの削除が走り、レイヤーが消える
///
/// このフックが返す関数に操作を渡すと、単一の Future チェーンへ積まれ、
/// 常に登録順 (追加 → 削除 → 追加 ...) で逐次実行されることが保証される。
///
/// ```dart
/// final enqueue = useMapOperationQueue();
/// useEffect(() {
///   if (style == null) {
///     return null;
///   }
///   enqueue(() async {
///     await style.addSource(...);
///     await style.addLayer(...);
///   });
///   return () {
///     enqueue(() async {
///       await style.removeLayer(...);
///       await style.removeSource(...);
///     });
///   };
/// }, [style, ...keys]);
/// ```
MapOperationScheduler useMapOperationQueue() {
  final chain = useRef<Future<void>>(Future<void>.value());
  return useCallback<MapOperationScheduler>((operation) {
    // エラーを握りつぶした Future をチェーンに積むことで、ある操作が失敗しても
    // 後続の操作が継続できるようにする。
    final next = chain.value.then((_) => operation()).catchError((
      Object error,
      StackTrace stackTrace,
    ) {
      talker.handle(error, stackTrace);
    });
    chain.value = next;
    return next;
  }, const []);
}
