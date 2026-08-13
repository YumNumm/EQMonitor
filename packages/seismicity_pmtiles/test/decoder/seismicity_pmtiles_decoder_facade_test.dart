import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker.dart';
import 'package:test/test.dart';

void main() {
  test('public facade uses real factory and archive-only start', () {
    final decoder = SeismicityPmTilesDecoder();
    expect(
      decoder.defaultWorkerFactory,
      isA<IsolateSeismicityDecoderWorkerFactory>(),
    );
    final start = decoder.start;
    expect(start, isA<Function>());
    // Public start accepts only archive + chunkCapacity (no factory/descriptor).
    expect(
      start,
      isA<
        SeismicityPmTilesDecodeOperation Function({
          required SeismicityPmTilesArchive archive,
          required int chunkCapacity,
        })
      >(),
    );
  });
}
