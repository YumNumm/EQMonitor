class SceneSpikeMetrics {
  var _frameCount = 0;
  var _partialUpdateCount = 0;
  var _lifecycleResumeCount = 0;
  var _disposeAndRemountCount = 0;
  var _resourceRebuildCount = 0;
  var _exceptionCount = 0;

  int get frameCount => _frameCount;

  int get partialUpdateCount => _partialUpdateCount;

  int get lifecycleResumeCount => _lifecycleResumeCount;

  int get disposeAndRemountCount => _disposeAndRemountCount;

  int get resourceRebuildCount => _resourceRebuildCount;

  int get exceptionCount => _exceptionCount;

  void recordFrame() {
    _frameCount += 1;
  }

  void recordPartialUpdate() {
    _partialUpdateCount += 1;
  }

  void recordLifecycleResume() {
    _lifecycleResumeCount += 1;
  }

  void recordDisposeAndRemount() {
    _disposeAndRemountCount += 1;
  }

  void recordResourceRebuild() {
    _resourceRebuildCount += 1;
  }

  void recordException() {
    _exceptionCount += 1;
  }
}
