import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_random_access_reader.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_range_validator.dart';

final class SeismicityReaderMutex {
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

final class FileRandomAccessReader implements SeismicityRandomAccessReader {
  FileRandomAccessReader({
    required RandomAccessFile file,
    required this.sizeBytes,
    required SeismicityPmTilesFileSource source,
    SeismicityRangeValidator rangeValidator = const SeismicityRangeValidator(),
  }) : _file = file,
       _source = source,
       _rangeValidator = rangeValidator;

  static Future<FileRandomAccessReader> open({
    required SeismicityPmTilesFileSource source,
  }) async {
    try {
      final file = await File(source.path).open();
      try {
        final sizeBytes = await file.length();
        return FileRandomAccessReader(
          file: file,
          sizeBytes: sizeBytes,
          source: source,
        );
      } on FileSystemException catch (error) {
        try {
          await file.close();
        } on FileSystemException {
          // Preserve the source failure that prevented reader construction.
        }
        throw SeismicityPmTilesException.sourceReadFailed(
          source: source,
          reason: error.message,
        );
      }
    } on FileSystemException catch (error) {
      throw SeismicityPmTilesException.sourceReadFailed(
        source: source,
        reason: error.message,
      );
    }
  }

  final RandomAccessFile _file;
  final SeismicityPmTilesFileSource _source;
  final SeismicityRangeValidator _rangeValidator;
  final _mutex = SeismicityReaderMutex();

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
        throw SeismicityPmTilesException.sourceReadFailed(
          source: _source,
          reason: 'The file reader is closed.',
        );
      }

      return _mutex.protect(
        action: () async {
          try {
            await _file.setPosition(offset);
            final bytes = await _file.read(length);
            if (bytes.length != length) {
              throw SeismicityPmTilesException.sourceReadFailed(
                source: _source,
                reason: 'Expected $length bytes but read ${bytes.length}.',
              );
            }
            return bytes;
          } on FileSystemException catch (error) {
            throw SeismicityPmTilesException.sourceReadFailed(
              source: _source,
              reason: error.message,
            );
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
          throw SeismicityPmTilesException.sourceReadFailed(
            source: _source,
            reason: error.message,
          );
        }
      },
    );
    _closeFuture = closeFuture;
    return closeFuture;
  }
}
