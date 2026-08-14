import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_factory.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';

/// Benchmark-only spawn counter that delegates unchanged to [delegate].
///
/// Increments [spawnCount] once immediately before each delegate.spawn call,
/// including attempts that later fail.
final class CountingDecoderWorkerFactory
    implements SeismicityDecoderWorkerFactory {
  CountingDecoderWorkerFactory({required this.delegate});

  final SeismicityDecoderWorkerFactory delegate;

  var _spawnCount = 0;
  int get spawnCount => _spawnCount;

  @override
  Future<SeismicityDecoderWorkerHandle> spawn({
    required SeismicityPmTilesArchiveDescriptor acceptedDescriptor,
    required int chunkCapacity,
  }) {
    _spawnCount += 1;
    return delegate.spawn(
      acceptedDescriptor: acceptedDescriptor,
      chunkCapacity: chunkCapacity,
    );
  }
}
