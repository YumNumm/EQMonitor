import 'dart:typed_data';

abstract interface class SeismicityRandomAccessReader {
  int get sizeBytes;

  Future<Uint8List> readAt({required int offset, required int length});

  Future<void> close();
}
