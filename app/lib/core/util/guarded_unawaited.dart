import 'dart:async';

/// [action] を fire-and-forget で実行し、例外/非同期エラーを [onError] に渡す。
///
/// `unawaited` の代替。エラーを握りつぶさず必ず記録経路へ流すために使う。
void guardedUnawaited(
  Future<void> Function() action, {
  required void Function(Object error, StackTrace stack) onError,
}) {
  unawaited(Future<void>.sync(action).catchError(onError));
}
