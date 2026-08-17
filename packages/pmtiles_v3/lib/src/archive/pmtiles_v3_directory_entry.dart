import 'package:freezed_annotation/freezed_annotation.dart';

part 'pmtiles_v3_directory_entry.freezed.dart';

@freezed
abstract class PmTilesV3DirectoryEntry with _$PmTilesV3DirectoryEntry {
  const factory({
    required int tileId,
    required int offset,
    required int length,
    required int runLength,
  }) = _PmTilesV3DirectoryEntry;
}
