// ignore_for_file: use_string_in_part_of_directives

part of msgpack_dart;

class FormatError(final String message) implements Exception {
  @override
  String toString() {
    return 'FormatError: $message';
  }
}
