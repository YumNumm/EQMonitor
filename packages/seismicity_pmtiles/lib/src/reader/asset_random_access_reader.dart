import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_pmtiles_asset_loader.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_random_access_reader.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_range_validator.dart';

final class AssetRandomAccessReader implements SeismicityRandomAccessReader {
  AssetRandomAccessReader({
    required Uint8List bytes,
    required SeismicityPmTilesAssetSource source,
    SeismicityRangeValidator rangeValidator = const SeismicityRangeValidator(),
  }) : _bytes = Uint8List.fromList(bytes),
       _source = source,
       _rangeValidator = rangeValidator;

  static Future<AssetRandomAccessReader> open({
    required SeismicityPmTilesAssetSource source,
    required SeismicityPmTilesAssetLoader assetLoader,
  }) async {
    try {
      final bytes = await assetLoader(assetKey: source.assetKey);
      return AssetRandomAccessReader(bytes: bytes, source: source);
    } on SeismicityPmTilesException {
      rethrow;
    } on Exception catch (error) {
      throw SeismicityPmTilesException.sourceReadFailed(
        source: source,
        reason: error.toString(),
      );
      // Flutter asset loaders can report missing assets as FlutterError.
      // ignore: avoid_catching_errors
    } on Error catch (error) {
      throw SeismicityPmTilesException.sourceReadFailed(
        source: source,
        reason: error.toString(),
      );
    }
  }

  final Uint8List _bytes;
  final SeismicityPmTilesAssetSource _source;
  final SeismicityRangeValidator _rangeValidator;
  var _isClosed = false;

  @override
  int get sizeBytes => _bytes.length;

  @override
  Future<Uint8List> readAt({required int offset, required int length}) async {
    _rangeValidator.validate(
      offset: offset,
      length: length,
      sizeBytes: sizeBytes,
    );
    if (_isClosed) {
      throw SeismicityPmTilesException.sourceReadFailed(
        source: _source,
        reason: 'The asset reader is closed.',
      );
    }
    return Uint8List.fromList(
      Uint8List.sublistView(_bytes, offset, offset + length),
    );
  }

  @override
  Future<void> close() {
    _isClosed = true;
    return Future<void>.value();
  }
}
