import 'dart:typed_data';

import 'package:pmtiles_v3/src/model/pmtiles_v3_exception.dart';
import 'package:pmtiles_v3/src/reader/pmtiles_random_access_reader.dart';
import 'package:pmtiles_v3/src/reader/pmtiles_v3_asset_loader.dart';
import 'package:pmtiles_v3/src/reader/pmtiles_v3_range_validator.dart';

final class PmTilesV3AssetRandomAccessReader
    implements PmTilesRandomAccessReader {
  new({
    required Uint8List bytes,
    this._rangeValidator = const PmTilesV3RangeValidator(),
  }) : _bytes = Uint8List.fromList(bytes);

  static Future<PmTilesV3AssetRandomAccessReader> open({
    required String assetKey,
    required PmTilesV3AssetLoader assetLoader,
  }) async {
    try {
      final bytes = await assetLoader(assetKey: assetKey);
      return PmTilesV3AssetRandomAccessReader(bytes: bytes);
    } on PmTilesV3Exception {
      rethrow;
    } on Exception catch (error) {
      throw PmTilesV3Exception.sourceReadFailed(reason: error.toString());
      // Flutter asset loaders can report missing assets as FlutterError.
      // ignore: avoid_catching_errors
    } on Error catch (error) {
      throw PmTilesV3Exception.sourceReadFailed(reason: error.toString());
    }
  }

  final Uint8List _bytes;
  final PmTilesV3RangeValidator _rangeValidator;
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
      throw const PmTilesV3Exception.sourceReadFailed(
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
