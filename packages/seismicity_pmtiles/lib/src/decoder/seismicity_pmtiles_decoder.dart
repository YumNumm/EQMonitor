import 'package:seismicity_pmtiles/src/archive/seismicity_pmtiles_archive.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decode_operation.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decoder_runner.dart';

/// Public decoder facade. Always uses the real isolate worker factory.
final class SeismicityPmTilesDecoder {
  SeismicityPmTilesDecoder()
    : _runner = SeismicityPmTilesDecoderRunner(
        factory: IsolateSeismicityDecoderWorkerFactory(),
      );

  final SeismicityPmTilesDecoderRunner _runner;

  SeismicityPmTilesDecodeOperation start({
    required SeismicityPmTilesArchive archive,
    required int chunkCapacity,
  }) => _runner.start(archive: archive, chunkCapacity: chunkCapacity);
}
