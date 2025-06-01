part of msgpack_dart;

class FormatError implements Exception {
  FormatError(this.message);
  final String message;

  @override
  String toString() {
    return 'FormatError: $message';
  }
}
