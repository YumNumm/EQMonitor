import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_router.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

void main() {
  test(
    'router completes matching decode futures in order after ready',
    () async {
      final router = SeismicityDecoderWorkerRouter();
      final initializeRequestId = router.registerInitialize();
      final first = router.registerDecode();
      final second = router.registerDecode();

      expect(initializeRequestId, 0);
      expect(first.requestId, 1);
      expect(second.requestId, 2);

      router.handleResponse(
        response: SeismicityDecoderWorkerResponse.ready(
          requestId: initializeRequestId,
        ),
      );
      router.handleResponse(
        response: SeismicityDecoderWorkerResponse.progress(
          requestId: first.requestId,
          progress: const SeismicityPmTilesDecodeProgress(
            decodedTileCount: 1,
            rawFeatureCount: 1,
            uniqueFeatureCount: 1,
          ),
        ),
      );
      router.handleResponse(
        response: SeismicityDecoderWorkerResponse.progress(
          requestId: second.requestId,
          progress: const SeismicityPmTilesDecodeProgress(
            decodedTileCount: 2,
            rawFeatureCount: 2,
            uniqueFeatureCount: 2,
          ),
        ),
      );

      expect(
        await first.completion,
        const SeismicityPmTilesDecodeProgress(
          decodedTileCount: 1,
          rawFeatureCount: 1,
          uniqueFeatureCount: 1,
        ),
      );
      expect(
        await second.completion,
        const SeismicityPmTilesDecodeProgress(
          decodedTileCount: 2,
          rawFeatureCount: 2,
          uniqueFeatureCount: 2,
        ),
      );
      expect(router.forwardedProgress, [
        const SeismicityPmTilesDecodeProgress(
          decodedTileCount: 1,
          rawFeatureCount: 1,
          uniqueFeatureCount: 1,
        ),
        const SeismicityPmTilesDecodeProgress(
          decodedTileCount: 2,
          rawFeatureCount: 2,
          uniqueFeatureCount: 2,
        ),
      ]);
    },
  );

  test('router rejects invalid routing transitions', () {
    final router = SeismicityDecoderWorkerRouter();
    final initializeRequestId = router.registerInitialize();
    final pending = router.registerDecode();

    expect(
      () => router.handleResponse(
        response: SeismicityDecoderWorkerResponse.progress(
          requestId: pending.requestId,
          progress: const SeismicityPmTilesDecodeProgress(
            decodedTileCount: 1,
            rawFeatureCount: 1,
            uniqueFeatureCount: 1,
          ),
        ),
      ),
      throwsA(isA<SeismicityPmTilesDecoderWorkerFailedException>()),
    );
    expect(
      () => router.handleResponse(
        response: const SeismicityDecoderWorkerResponse.ready(requestId: 99),
      ),
      throwsA(isA<SeismicityPmTilesDecoderWorkerFailedException>()),
    );

    router.handleResponse(
      response: SeismicityDecoderWorkerResponse.ready(
        requestId: initializeRequestId,
      ),
    );
    expect(
      () => router.handleResponse(
        response: SeismicityDecoderWorkerResponse.ready(
          requestId: initializeRequestId,
        ),
      ),
      throwsA(isA<SeismicityPmTilesDecoderWorkerFailedException>()),
    );
    expect(
      router.registerInitialize,
      throwsA(isA<SeismicityPmTilesDecoderWorkerFailedException>()),
    );

    router.handleResponse(
      response: SeismicityDecoderWorkerResponse.progress(
        requestId: pending.requestId,
        progress: const SeismicityPmTilesDecodeProgress(
          decodedTileCount: 1,
          rawFeatureCount: 1,
          uniqueFeatureCount: 1,
        ),
      ),
    );

    expect(
      () => router.handleResponse(
        response: SeismicityDecoderWorkerResponse.progress(
          requestId: pending.requestId,
          progress: const SeismicityPmTilesDecodeProgress(
            decodedTileCount: 2,
            rawFeatureCount: 2,
            uniqueFeatureCount: 2,
          ),
        ),
      ),
      throwsA(isA<SeismicityPmTilesDecoderWorkerFailedException>()),
    );
    expect(
      () => router.handleResponse(
        response: const SeismicityDecoderWorkerResponse.progress(
          requestId: 99,
          progress: SeismicityPmTilesDecodeProgress(
            decodedTileCount: 2,
            rawFeatureCount: 2,
            uniqueFeatureCount: 2,
          ),
        ),
      ),
      throwsA(isA<SeismicityPmTilesDecoderWorkerFailedException>()),
    );

    final next = router.registerDecode();
    expect(
      () => router.handleResponse(
        response: SeismicityDecoderWorkerResponse.progress(
          requestId: next.requestId,
          progress: const SeismicityPmTilesDecodeProgress(
            decodedTileCount: 0,
            rawFeatureCount: 0,
            uniqueFeatureCount: 0,
          ),
        ),
      ),
      throwsA(isA<SeismicityPmTilesDecoderWorkerFailedException>()),
    );

    router.markTerminal();
    expect(
      router.registerDecode,
      throwsA(isA<SeismicityPmTilesDecoderWorkerFailedException>()),
    );
  });
}
