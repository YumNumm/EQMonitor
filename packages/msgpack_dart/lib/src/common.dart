// ignore_for_file: use_string_in_part_of_directives

part of msgpack_dart;

class FormatError implements Exception {
  FormatError(this.message);
  final String message;

  @override
  String toString() {
    return 'FormatError: $message';
  }
}
