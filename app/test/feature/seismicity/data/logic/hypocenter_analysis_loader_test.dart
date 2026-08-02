import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/hypocenter_analysis_loader.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_api_exception.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_id.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_partition.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/hypocenter_analysis_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('同時に取得するアーカイブを2件までに制限する', () async {
    final repository = _RecordingRepository();

    final result = await HypocenterAnalysisLoader(
      repository: repository,
    ).load(archives: List.generate(5, _archive), bounds: _bounds);

    expect(result, isA<Success>());
    expect(repository.maximumActive, 2);
  });

  test('1件でも失敗した場合は部分結果を返さない', () async {
    final result = await HypocenterAnalysisLoader(
      repository: _RecordingRepository(failingLabel: '2'),
    ).load(archives: List.generate(4, _archive), bounds: _bounds);

    expect(result, isA<Failure>());
  });
}

const _bounds = SeismicityBounds(
  minLatitude: 35,
  maxLatitude: 36,
  minLongitude: 139,
  maxLongitude: 140,
);

HypocenterArchive _archive(int index) => HypocenterArchive(
  id: HypocenterArchiveId(
    partition: HypocenterArchivePartition.day,
    jstLabel: '$index',
  ),
  periodFrom: DateTime.utc(2026, 8, index + 1),
  periodTo: DateTime.utc(2026, 8, index + 2),
  url: 'https://tiles.example/$index.pmtiles',
  featureCount: 1,
  sizeBytes: 100,
  queryRevision: '1234567890abcdef12345678',
);

final class _RecordingRepository implements HypocenterArchiveEventRepository {
  _RecordingRepository({this.failingLabel});

  final String? failingLabel;
  int active = 0;
  int maximumActive = 0;

  @override
  Future<Result<List<SeismicityEvent>, HypocenterApiException>> fetchArchive({
    required HypocenterArchive archive,
    required SeismicityBounds bounds,
  }) async {
    active++;
    maximumActive = active > maximumActive ? active : maximumActive;
    await Future<void>.delayed(const Duration(milliseconds: 10));
    active--;
    if (archive.id.jstLabel == failingLabel) {
      return const Failure(HypocenterApiException(message: 'failure'));
    }
    return Success([
      SeismicityEvent(
        eventId: archive.id.jstLabel,
        originTime: archive.periodFrom,
        magnitude: 3,
        depth: 10,
        latitude: 35.5,
        longitude: 139.5,
        maxIntensity: null,
      ),
    ]);
  }
}
