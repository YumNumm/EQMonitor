/// カメラ変更などで進行中の非同期処理(tile decode等)を無効化するための
/// incarnation token。
///
/// spike期に`flutter_scene/flutter_scene_async_generation.dart`へ置いていた
/// 汎用機構を、Scene 非依存の foundation レイヤーへ昇格させたもの。tile
/// pipeline(cache / worker / scheduler)は本 domain 型を参照し、spike 実装へ
/// 依存しない。
///
/// [begin]で発行した[AsyncGenerationToken]は、その後[cancel]・[dispose]・
/// または新たな[begin]が呼ばれるまで`isCurrent`が`true`のままになる。
/// [cancel]は例外を投げない(古い結果を「捨てる」だけで、待機中の呼び出し側を
/// エラーにしない)。
final class AsyncGenerationOwner {
  var _generation = 0;
  var _isDisposed = false;

  /// 新しい世代を開始し、その世代を指す token を返す。
  ///
  /// [dispose]済みの owner から呼ぶと[StateError]。
  AsyncGenerationToken begin() {
    if (_isDisposed) {
      throw StateError('Disposed async generation owner cannot start work.');
    }
    _generation += 1;
    return AsyncGenerationToken._(owner: this, generation: _generation);
  }

  /// 進行中の世代を無効化する。以後、直前に[begin]した token は
  /// `isCurrent == false` になる。例外は投げない。
  void cancel() {
    if (!_isDisposed) {
      _generation += 1;
    }
  }

  /// owner を破棄する。発行済みの全 token を無効化し、以後の[begin]を禁じる。
  void dispose() {
    _generation += 1;
    _isDisposed = true;
  }

  /// [token]が本 owner の最新世代を指しているか。
  bool isCurrent(AsyncGenerationToken token) =>
      !_isDisposed &&
      identical(token._owner, this) &&
      token._generation == _generation;
}

/// [AsyncGenerationOwner.begin]が発行する不変 token。
final class AsyncGenerationToken {
  const AsyncGenerationToken._({
    required this._owner,
    required this._generation,
  });

  final AsyncGenerationOwner _owner;
  final int _generation;

  /// 発行元 owner の最新世代を指しているか。
  bool get isCurrent => _owner.isCurrent(this);
}
