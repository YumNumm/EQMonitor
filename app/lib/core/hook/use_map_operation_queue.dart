import 'dart:async';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
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
/// 直列化の単位は Widget/Element ではなく、祖先の [MapOperationQueueScope]
/// が保持する [MapOperationQueue]（マップ単位で共有）。これにより、同一マップ
/// 上の複数のレイヤーWidgetをまたいだ直列化に加え、レイヤーWidget自身の
/// unmount→remount（設定トグルやprovider再読込によるElement再生成）を
/// またいだ直列化も保証される。祖先に [MapOperationQueueScope] が存在しない
/// 場合は、このフック単体（Element単位）のローカルチェーンにフォールバックする。
///
/// 祖先の参照は `build` の実行中（Elementがactiveな間）にのみ安全に取得できる
/// ため、毎ビルド時に取得して [useRef] へキャッシュしておく。こうすることで、
/// unmount時にElementがdefunctになった後でもキャッシュ済みの参照を使って
/// cleanup操作（削除）を正しく共有キューへ積める。
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
  final context = useContext();
  final sharedQueueRef = useRef<MapOperationQueue?>(null);
  sharedQueueRef.value = MapOperationQueueScope.maybeOf(context);
  final chain = useRef<Future<void>>(Future<void>.value());
  return useCallback<MapOperationScheduler>((operation) {
    final sharedQueue = sharedQueueRef.value;
    if (sharedQueue != null) {
      return sharedQueue.enqueue(operation);
    }
    // フォールバック: エラーを握りつぶした Future をチェーンに積むことで、
    // ある操作が失敗しても後続の操作が継続できるようにする。
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
