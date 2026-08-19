import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:pmtiles_v3/src/model/pmtiles_v3_exception.dart';
import 'package:pmtiles_v3/src/reader/pmtiles_random_access_reader.dart';
import 'package:pmtiles_v3/src/reader/pmtiles_v3_range_validator.dart';

final class PmTilesV3ReaderMutex {
  var _tail = Future<void>.value();

  Future<T> protect<T>({required Future<T> Function() action}) async {
    final previous = _tail;
    final release = Completer<void>();
    _tail = release.future;
    await previous;
    try {
      return await action();
    } finally {
      release.complete();
    }
  }
}

final class PmTilesV3FileRandomAccessReader
    implements PmTilesRandomAccessReader {
  new({
    required this._file,
    required this.sizeBytes,
    this._rangeValidator = const PmTilesV3RangeValidator(),
  });

  static Future<PmTilesV3FileRandomAccessReader> open({
    required String path,
  }) async {
    try {
      final file = await File(path).open();
      try {
        final sizeBytes = await file.length();
        return PmTilesV3FileRandomAccessReader(
          file: file,
          sizeBytes: sizeBytes,
        );
      } on FileSystemException catch (error) {
        try {
          await file.close();
        } on FileSystemException {
          // Preserve the source failure that prevented reader construction.
        }
        throw PmTilesV3Exception.sourceReadFailed(reason: error.message);
      }
    } on FileSystemException catch (error) {
      throw PmTilesV3Exception.sourceReadFailed(reason: error.message);
    }
  }

  final RandomAccessFile _file;
  final PmTilesV3RangeValidator _rangeValidator;
  final _mutex = PmTilesV3ReaderMutex();

  @override
  final int sizeBytes;

  var _isCloseRequested = false;
  Future<void>? _closeFuture;

  @override
  Future<Uint8List> readAt({required int offset, required int length}) {
    return Future<Uint8List>.sync(() {
      _rangeValidator.validate(
        offset: offset,
        length: length,
        sizeBytes: sizeBytes,
      );
      if (_isCloseRequested) {
        throw const PmTilesV3Exception.sourceReadFailed(
          reason: 'The file reader is closed.',
        );
      }

      return _mutex.protect(
        action: () async {
          try {
            await _file.setPosition(offset);
            final bytes = await _file.read(length);
            if (bytes.length != length) {
              throw PmTilesV3Exception.sourceReadFailed(
                reason: 'Expected $length bytes but read ${bytes.length}.',
              );
            }
            return bytes;
          } on FileSystemException catch (error) {
            throw PmTilesV3Exception.sourceReadFailed(reason: error.message);
          }
        },
      );
    });
  }

  @override
  Future<void> close() {
    final existingClose = _closeFuture;
    if (existingClose != null) {
      return existingClose;
    }

    _isCloseRequested = true;
    final closeFuture = _mutex.protect<void>(
      action: () async {
        try {
          await _file.close();
        } on FileSystemException catch (error) {
          throw PmTilesV3Exception.sourceReadFailed(reason: error.message);
        }
      },
    );
    _closeFuture = closeFuture;
    return closeFuture;
  }
}
