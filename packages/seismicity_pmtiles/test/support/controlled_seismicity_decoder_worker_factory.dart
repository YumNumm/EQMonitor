import 'dart:async';

import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_factory.dart';

final class ControlledSeismicityDecoderWorkerFactory
    implements SeismicityDecoderWorkerFactory {
  ControlledSeismicityDecoderWorkerFactory({required this.handle});

  final SeismicityDecoderWorkerHandle handle;
  final _spawn = Completer<SeismicityDecoderWorkerHandle>();

  var _spawnCount = 0;
  int get spawnCount => _spawnCount;
  SeismicityPmTilesArchiveDescriptor? _acceptedDescriptor;
  SeismicityPmTilesArchiveDescriptor? get acceptedDescriptor =>
      _acceptedDescriptor;
  int? _chunkCapacity;
  int? get chunkCapacity => _chunkCapacity;

  @override
  Future<SeismicityDecoderWorkerHandle> spawn({
    required SeismicityPmTilesArchiveDescriptor acceptedDescriptor,
    required int chunkCapacity,
  }) {
    _spawnCount++;
    _acceptedDescriptor = acceptedDescriptor;
    _chunkCapacity = chunkCapacity;
    return _spawn.future;
  }

  void succeedSpawn() => _spawn.complete(handle);

  void failSpawn({required SeismicityPmTilesException error}) =>
      _spawn.completeError(error);
}
