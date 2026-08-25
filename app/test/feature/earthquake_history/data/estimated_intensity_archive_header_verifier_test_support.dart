import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_pmtiles_opener.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';

const estimatedIntensityHeaderTestLimits = PmTilesV3Limits(
  maxDirectoryDepth: 3,
  rootDirectoryWindowLength: 16384,
  maxDirectoryEncodedBytes: 1024,
  maxDirectoryDecodedBytes: 4096,
  maxDirectoryEntries: 32,
  maxCachedLeafDirectories: 2,
  maxTileEncodedBytes: 1024,
  maxTileDecodedBytes: 4096,
);

final class ControlledEstimatedIntensityArchiveOpener
    implements EstimatedIntensityArchivePmTilesOpener {
  const new({this.archive, this.failure});

  final PmTilesV3Archive? archive;
  final PmTilesV3Exception? failure;

  @override
  Future<PmTilesV3Archive> open({
    required File file,
    required PmTilesV3Limits limits,
  }) async {
    if (failure case final value?) {
      throw value;
    }
    return switch (archive) {
      final value? => value,
      null => throw StateError('archive fixture is missing'),
    };
  }
}

final class RecordingEstimatedIntensityArchive extends Fake
    implements PmTilesV3Archive {
  RecordingEstimatedIntensityArchive({required this.header});

  @override
  final PmTilesV3Header header;
  var closeCount = 0;

  @override
  Future<void> close() async {
    closeCount += 1;
  }
}
