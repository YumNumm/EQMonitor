import 'package:eqmonitor_map/src/tile/map_tile_pipeline_budget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('createMapTilePipelineBudget', () {
    MapTilePipelineBudget build({
      int schemaVersion = 1,
      int maxInFlightDecodes = 4,
      int maxCacheEntries = 256,
      int maxPinnedEntries = 32,
      int cpuWorkUnitsPerFrame = 8,
      int? maxGpuUploadBytesPerFrame = 1 << 20,
    }) => createMapTilePipelineBudget(
      schemaVersion: schemaVersion,
      maxInFlightDecodes: maxInFlightDecodes,
      maxCacheEntries: maxCacheEntries,
      maxPinnedEntries: maxPinnedEntries,
      cpuWorkUnitsPerFrame: cpuWorkUnitsPerFrame,
      maxGpuUploadBytesPerFrame: maxGpuUploadBytesPerFrame,
    );

    test('builds a versioned budget with value equality', () {
      final budget = build();
      expect(budget.schemaVersion, 1);
      expect(budget.maxInFlightDecodes, 4);
      expect(budget.maxGpuUploadBytesPerFrame, 1 << 20);
      expect(budget, build());
    });

    test('allows an absent optional GPU upload budget', () {
      final budget = build(maxGpuUploadBytesPerFrame: null);
      expect(budget.maxGpuUploadBytesPerFrame, isNull);
    });

    test('rejects non-positive schema version and in-flight limits', () {
      expect(() => build(schemaVersion: 0), throwsArgumentError);
      expect(() => build(maxInFlightDecodes: 0), throwsArgumentError);
      expect(() => build(cpuWorkUnitsPerFrame: 0), throwsArgumentError);
    });

    test('rejects pinned entries exceeding cache capacity', () {
      expect(
        () => build(maxCacheEntries: 16, maxPinnedEntries: 17),
        throwsArgumentError,
      );
    });

    test('rejects a present but non-positive GPU upload budget', () {
      expect(
        () => build(maxGpuUploadBytesPerFrame: 0),
        throwsArgumentError,
      );
    });
  });
}
