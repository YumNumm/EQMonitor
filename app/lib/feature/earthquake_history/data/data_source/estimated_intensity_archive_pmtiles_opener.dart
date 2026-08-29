import 'dart:io';

import 'package:pmtiles_v3/pmtiles_v3.dart';

abstract interface class EstimatedIntensityArchivePmTilesOpener {
  /// 成功時はreader所有権を返値のarchiveへ移す。
  ///
  /// 失敗時は`PmTilesV3Archive.open`がreaderをcloseするため、
  /// 呼出元は返値を受け取った場合にだけcloseする。
  Future<PmTilesV3Archive> open({
    required File file,
    required PmTilesV3Limits limits,
  });
}

/// 検証済み一時fileをPMTiles v3 archiveとして開く本番実装。
/// resource上限は呼出元が必ず[PmTilesV3Limits]で渡す。
final class DartIoEstimatedIntensityArchivePmTilesOpener
    implements EstimatedIntensityArchivePmTilesOpener {
  const new();

  @override
  Future<PmTilesV3Archive> open({
    required File file,
    required PmTilesV3Limits limits,
  }) async {
    final reader = await PmTilesV3FileRandomAccessReader.open(path: file.path);
    return PmTilesV3Archive.open(reader: reader, limits: limits);
  }
}
