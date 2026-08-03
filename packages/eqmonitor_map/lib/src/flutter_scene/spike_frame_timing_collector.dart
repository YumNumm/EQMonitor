import 'dart:math' as math;

class SpikeFrameTimingSnapshot {
  const SpikeFrameTimingSnapshot({
    required this.sampleCount,
    required this.retainedSampleCount,
    required this.maxBuildDurationMicroseconds,
    required this.maxRasterDurationMicroseconds,
  });

  final int sampleCount;
  final int retainedSampleCount;
  final int maxBuildDurationMicroseconds;
  final int maxRasterDurationMicroseconds;
}

class SpikeFrameTimingCollector {
  SpikeFrameTimingCollector({required int capacity})
    : _capacity = capacity,
      _buildDurations = List<int>.filled(capacity > 0 ? capacity : 1, 0),
      _rasterDurations = List<int>.filled(capacity > 0 ? capacity : 1, 0) {
    if (capacity <= 0) {
      throw ArgumentError.value(capacity, 'capacity', 'Must be positive.');
    }
  }

  final int _capacity;
  final List<int> _buildDurations;
  final List<int> _rasterDurations;
  var _sampleCount = 0;
  var _retainedSampleCount = 0;
  var _nextIndex = 0;
  var _maxBuildDurationMicroseconds = 0;
  var _maxRasterDurationMicroseconds = 0;

  int get sampleCount => _sampleCount;

  int get retainedSampleCount => _retainedSampleCount;

  void add({
    required Duration buildDuration,
    required Duration rasterDuration,
  }) {
    if (buildDuration.isNegative || rasterDuration.isNegative) {
      throw RangeError('Frame durations must be non-negative.');
    }
    final buildMicroseconds = buildDuration.inMicroseconds;
    final rasterMicroseconds = rasterDuration.inMicroseconds;
    _buildDurations[_nextIndex] = buildMicroseconds;
    _rasterDurations[_nextIndex] = rasterMicroseconds;
    _nextIndex = (_nextIndex + 1) % _capacity;
    _sampleCount += 1;
    _retainedSampleCount = math.min(_retainedSampleCount + 1, _capacity);
    _maxBuildDurationMicroseconds = math.max(
      _maxBuildDurationMicroseconds,
      buildMicroseconds,
    );
    _maxRasterDurationMicroseconds = math.max(
      _maxRasterDurationMicroseconds,
      rasterMicroseconds,
    );
  }

  SpikeFrameTimingSnapshot snapshot() => SpikeFrameTimingSnapshot(
    sampleCount: _sampleCount,
    retainedSampleCount: _retainedSampleCount,
    maxBuildDurationMicroseconds: _maxBuildDurationMicroseconds,
    maxRasterDurationMicroseconds: _maxRasterDurationMicroseconds,
  );
}
