import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_analysis_request.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_id.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_partition.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('論理archive IDと矩形が同じなら安定した分析キーになる', () {
    const id = HypocenterArchiveId(
      partition: HypocenterArchivePartition.day,
      jstLabel: '2026-08-02',
    );
    const bounds = SeismicityBounds(
      minLatitude: 35,
      maxLatitude: 36,
      minLongitude: 139,
      maxLongitude: 140,
    );

    expect(
      const HypocenterAnalysisRequest(archiveIds: [id], bounds: bounds),
      const HypocenterAnalysisRequest(archiveIds: [id], bounds: bounds),
    );
  });
}
