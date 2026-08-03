import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_api_exception.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_id.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_partition.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/hypocenter_analysis_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:retrofit/retrofit.dart';

void main() {
  test('next_tokenがなくなるまで同一revisionでページを取得する', () async {
    final client = _HypocenterClient();
    final cancelToken = CancelToken();
    final fetchedCounts = <int>[];
    final result = await HypocenterAnalysisRepository(client: client)
        .fetchArchive(
          archive: _archive,
          bounds: const SeismicityBounds(
            minLatitude: 35,
            maxLatitude: 36,
            minLongitude: 139,
            maxLongitude: 140,
          ),
          cancelToken: cancelToken,
          onProgress: ({required fetchedEvents}) {
            fetchedCounts.add(fetchedEvents);
          },
        );

    expect(
      result,
      isA<Success<List<SeismicityEvent>, HypocenterApiException>>(),
    );
    expect((result as Success).value, hasLength(2));
    expect(client.cursors, [null, 'next']);
    expect(client.revisions, [_revision, _revision]);
    expect(client.cancelTokens, [cancelToken, cancelToken]);
    expect(fetchedCounts, [1, 2]);
    expect(
      client.areas,
      everyElement('139.0,35.0;140.0,35.0;140.0,36.0;139.0,36.0'),
    );
  });
}

const _revision = '1234567890abcdef12345678';
final _archive = HypocenterArchive(
  id: const HypocenterArchiveId(
    partition: HypocenterArchivePartition.day,
    jstLabel: '2026-08-02',
  ),
  periodFrom: DateTime.utc(2026, 8, 1, 15),
  periodTo: DateTime.utc(2026, 8, 2, 15),
  url: 'https://tiles.example/day.pmtiles',
  featureCount: 2,
  sizeBytes: 100,
  queryRevision: _revision,
);

final class _HypocenterClient implements api.HypocentersApiClient {
  final cursors = <String?>[];
  final revisions = <String?>[];
  final areas = <String?>[];
  final cancelTokens = <CancelToken?>[];

  @override
  Future<HttpResponse<api.HypocenterListResponse>> getV2Hypocenters({
    required DateTime originTimeGte,
    required DateTime originTimeLte,
    int? limit = 100,
    String? area,
    String? magnitudeGte,
    String? magnitudeLte,
    String? depthGte,
    String? depthLte,
    String? determinationFlags,
    String? earthquakeEventId,
    String? cursor,
    String? expectedRevision,
    CancelToken? cancelToken,
    String? ifNoneMatch,
    String? ifModifiedSince,
  }) async {
    cursors.add(cursor);
    revisions.add(expectedRevision);
    areas.add(area);
    cancelTokens.add(cancelToken);
    return HttpResponse(
      api.HypocenterListResponse(
        data: api.Data3(
          items: [_item(cursor == null ? 'first' : 'second')],
          nextToken: cursor == null ? 'next' : null,
        ),
        meta: api.HypocenterMeta(
          datasetRevision: _revision,
          dataUpdatedAt: DateTime.utc(2026, 8, 2),
          coverage: api.HypocenterCoverage(
            from: originTimeGte,
            to: originTimeLte,
          ),
        ),
      ),
      Response(requestOptions: RequestOptions(path: '/v2/hypocenters')),
    );
  }

  @override
  Future<HttpResponse<api.HypocenterManifestResponse>>
  getV2HypocentersManifest({String? ifNoneMatch, String? ifModifiedSince}) =>
      throw UnimplementedError();
}

api.HypocenterResponseItem _item(String id) => api.HypocenterResponseItem(
  hypocenterId: id,
  originTime: DateTime.utc(2026, 8, 2),
  originTimePrecision: api.HypocenterOriginTimePrecision.second,
  latitude: 35.5,
  longitude: 139.5,
  magnitude: 3.2,
  depthKm: 10,
);
