import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

/// この package が [PmTilesV3Archive] を開くときに使う上限値。PMTiles v3
/// 仕様そのものではなく運用値であり、汎用package抽出前から変わっていない
/// 固定値をそのまま引数化している。
const _limits = PmTilesV3Limits(
  maxDirectoryDepth: 3,
  rootDirectoryWindowLength: 16384,
  // seismicityデータのproducer契約はclustered orderingとtile件数の一致を
  // 保証しているため、archive全体のeager検証を明示的に有効化し続ける。
  validateEntireArchiveEagerly: true,
);

abstract interface class SeismicityPmTilesArchive {
  static Future<SeismicityPmTilesArchive> open({
    required PmTilesRandomAccessReader reader,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) {
    return const SeismicityPmTilesArchiveOpener().open(
      reader: reader,
      descriptor: descriptor,
    );
  }

  PmTilesV3Header get header;

  SeismicityPmTilesArchiveDescriptor get descriptor;

  Stream<int> occupiedTileIdsAtZoom({required int zoom});

  Future<Uint8List> readTile({required int tileId});

  Future<void> close();
}

final class SeismicityPmTilesArchiveOpener {
  const SeismicityPmTilesArchiveOpener();

  Future<SeismicityPmTilesArchive> open({
    required PmTilesRandomAccessReader reader,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) async {
    try {
      validateDescriptor(reader: reader, descriptor: descriptor);
    } catch (error, stackTrace) {
      await closeAfterOpenFailure(reader: reader);
      Error.throwWithStackTrace(error, stackTrace);
    }

    // pmtiles_v3.open()が失敗した場合はreader.close()まで含めて自身で後始末
    // するため、ここで二重にcloseしてはいけない。PMTiles v3仕様に関する
    // 検証結果だけをこの package自身の例外型へ翻訳する。
    final PmTilesV3Archive innerArchive;
    try {
      innerArchive = await PmTilesV3Archive.open(
        reader: reader,
        limits: _limits,
      );
    } on PmTilesV3Exception catch (exception) {
      throw exception.toSeismicityException(source: descriptor.source);
    }

    try {
      validateDescriptorZoom(
        header: innerArchive.header,
        descriptor: descriptor,
      );
    } catch (error, stackTrace) {
      await closeAfterOpenFailure(reader: reader);
      Error.throwWithStackTrace(error, stackTrace);
    }

    return _SeismicityPmTilesArchiveImpl(
      inner: innerArchive,
      descriptor: descriptor,
    );
  }

  void validateDescriptor({
    required PmTilesRandomAccessReader reader,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) {
    if (descriptor.expectedSizeBytes <= 0 ||
        descriptor.expectedSizeBytes != reader.sizeBytes) {
      throw SeismicityPmTilesException.invalidDescriptor(
        reason:
            'Expected archive size ${descriptor.expectedSizeBytes}, '
            'received ${reader.sizeBytes}.',
      );
    }
    if (descriptor.dataZoom < 0 ||
        descriptor.dataZoom > PmTilesV3TileId.maxZoom) {
      throw SeismicityPmTilesException.invalidDescriptor(
        reason: 'Invalid data zoom ${descriptor.dataZoom}.',
      );
    }
  }

  void validateDescriptorZoom({
    required PmTilesV3Header header,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) {
    if (descriptor.dataZoom < header.minZoom ||
        descriptor.dataZoom > header.maxZoom) {
      throw SeismicityPmTilesException.invalidDescriptor(
        reason:
            'Data zoom ${descriptor.dataZoom} is outside archive zoom range '
            '${header.minZoom}-${header.maxZoom}.',
      );
    }
  }

  Future<void> closeAfterOpenFailure({
    required PmTilesRandomAccessReader reader,
  }) async {
    try {
      await reader.close();
      // Reader implementations may throw any error while closing; cleanup must
      // preserve the original open failure regardless of its type.
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      // The original open failure and stack are the authoritative failure.
    }
  }
}

final class _SeismicityPmTilesArchiveImpl implements SeismicityPmTilesArchive {
  _SeismicityPmTilesArchiveImpl({
    required this.inner,
    required this.descriptor,
  });

  final PmTilesV3Archive inner;

  @override
  final SeismicityPmTilesArchiveDescriptor descriptor;

  @override
  PmTilesV3Header get header => inner.header;

  @override
  Stream<int> occupiedTileIdsAtZoom({required int zoom}) {
    try {
      return inner.occupiedTileIdsAtZoom(zoom: zoom);
    } on PmTilesV3Exception catch (exception) {
      throw exception.toSeismicityException(source: descriptor.source);
    }
  }

  @override
  Future<Uint8List> readTile({required int tileId}) async {
    try {
      final bytes = await inner.readTileById(tileId: tileId);
      if (bytes == null) {
        throw SeismicityPmTilesException.tileNotFound(tileId: tileId);
      }
      return bytes;
    } on PmTilesV3Exception catch (exception) {
      throw exception.toSeismicityException(source: descriptor.source);
    }
  }

  @override
  Future<void> close() => inner.close();
}
