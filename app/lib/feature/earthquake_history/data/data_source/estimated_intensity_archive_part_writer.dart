import 'dart:io';

abstract interface class EstimatedIntensityArchivePartWriter {
  Future<void> write(List<int> bytes);

  Future<void> flushAndClose();

  /// Pending write/flushがない状態で呼び出し、handleをcloseする。
  ///
  /// 呼出元は開始済みI/Oを収束させた後にcleanupする。
  Future<void> close();
}

typedef EstimatedIntensityArchivePartWriterCreator =
    Future<EstimatedIntensityArchivePartWriter> Function(File file);

final class EstimatedIntensityArchivePartWriterFactory {
  const new();

  static Future<EstimatedIntensityArchivePartWriter> create(File file) =>
      DartIoEstimatedIntensityArchivePartWriter.open(file);
}

/// `RandomAccessFile.writeFrom`をawaitし、socketへのbackpressureを保つwriter。
final class DartIoEstimatedIntensityArchivePartWriter
    implements EstimatedIntensityArchivePartWriter {
  new({required RandomAccessFile file}) : _file = file;

  static Future<DartIoEstimatedIntensityArchivePartWriter> open(
    File file,
  ) async => DartIoEstimatedIntensityArchivePartWriter(
    file: await file.open(mode: FileMode.writeOnly),
  );

  final RandomAccessFile _file;
  var _closed = false;

  @override
  Future<void> write(List<int> bytes) => _file.writeFrom(bytes);

  @override
  Future<void> flushAndClose() async {
    if (_closed) {
      return;
    }
    await _file.flush();
    await _file.close();
    _closed = true;
  }

  @override
  Future<void> close() async {
    if (_closed) {
      return;
    }
    await _file.close();
    _closed = true;
  }
}
