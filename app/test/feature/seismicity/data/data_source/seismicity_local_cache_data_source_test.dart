import 'dart:io';

import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_cached_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_local_cache_data_source.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('保存したデータセットを span ごとに読み戻せる', () async {
    final tempDir = Directory.systemTemp.createTempSync(
      'seismicity_cache_test',
    );
    addTearDown(() => tempDir.deleteSync(recursive: true));

    final dataSource = SeismicityLocalCacheDataSource(
      directoryProvider: () async => tempDir,
    );

    final dataset = SeismicityCachedDataset(
      generatedAt: DateTime.utc(2026, 7, 1),
      events: [
        SeismicityEvent(
          eventId: 'eq-1',
          originTime: DateTime.utc(2026, 6, 1),
          magnitude: 4.5,
          depth: 30,
          latitude: 35.6,
          longitude: 139.7,
          maxIntensity: '4',
        ),
      ],
    );

    await dataSource.save(SeismicitySpan.p1m, dataset);
    final restored = await dataSource.read(SeismicitySpan.p1m);

    expect(restored, isNotNull);
    expect(restored!.generatedAt, DateTime.utc(2026, 7, 1));
    expect(restored.events.single.eventId, 'eq-1');
  });

  test('未保存の span は null を返す', () async {
    final tempDir = Directory.systemTemp.createTempSync(
      'seismicity_cache_test_empty',
    );
    addTearDown(() => tempDir.deleteSync(recursive: true));

    final dataSource = SeismicityLocalCacheDataSource(
      directoryProvider: () async => tempDir,
    );

    expect(await dataSource.read(SeismicitySpan.p12m), isNull);
  });
}
