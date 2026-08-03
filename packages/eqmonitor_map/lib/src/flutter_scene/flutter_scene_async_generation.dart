class SceneSpikeAsyncGenerationOwner {
  var _generation = 0;
  var _isDisposed = false;

  SceneSpikeAsyncGenerationToken begin() {
    if (_isDisposed) {
      throw StateError('Disposed async generation owner cannot start work.');
    }
    _generation += 1;
    return SceneSpikeAsyncGenerationToken._(
      owner: this,
      generation: _generation,
    );
  }

  void cancel() {
    if (!_isDisposed) {
      _generation += 1;
    }
  }

  void dispose() {
    _generation += 1;
    _isDisposed = true;
  }

  bool isCurrent(SceneSpikeAsyncGenerationToken token) =>
      !_isDisposed &&
      identical(token._owner, this) &&
      token._generation == _generation;
}

class SceneSpikeAsyncGenerationToken {
  const SceneSpikeAsyncGenerationToken._({
    required SceneSpikeAsyncGenerationOwner owner,
    required int generation,
  }) : _owner = owner,
       _generation = generation;

  final SceneSpikeAsyncGenerationOwner _owner;
  final int _generation;

  bool get isCurrent => _owner.isCurrent(this);
}
