import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/test.dart';

void main() {
  test('public facade start is archive-only through the barrel', () {
    final decoder = SeismicityPmTilesDecoder();
    expect(
      decoder.start,
      isA<
        SeismicityPmTilesDecodeOperation Function({
          required SeismicityPmTilesArchive archive,
          required int chunkCapacity,
        })
      >(),
    );
  });
}
