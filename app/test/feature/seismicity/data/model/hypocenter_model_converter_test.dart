import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_partition.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_model_converter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('manifest archiveをJSTの日付IDへ変換する', () {
    final response = api.HypocenterManifestResponse(
      data: api.Data2(
        archives: [
          api.Archives(
            partition: api.Partition.day,
            period: api.HypocenterCoverage(
              from: DateTime.utc(2026, 8, 1, 15),
              to: DateTime.utc(2026, 8, 2, 15),
            ),
            queryRevision: '1234567890abcdef12345678',
            url: 'https://tiles.example/day.pmtiles',
            featureCount: 10,
            sizeBytes: 100,
          ),
        ],
      ),
      meta: api.HypocenterMeta(
        datasetRevision: 'abcdef1234567890abcdef12',
        dataUpdatedAt: DateTime.utc(2026, 8, 2),
        coverage: api.HypocenterCoverage(
          from: DateTime.utc(2026, 8, 1),
          to: DateTime.utc(2026, 8, 2),
        ),
      ),
    );

    final result = response.toModel();

    expect(result.archives.single.id.partition, HypocenterArchivePartition.day);
    expect(result.archives.single.id.jstLabel, '2026-08-02');
    expect(result.archives.single.queryRevision, '1234567890abcdef12345678');
  });
}
