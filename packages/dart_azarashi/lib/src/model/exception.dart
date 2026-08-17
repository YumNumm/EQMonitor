/// Exception thrown when decoding a QZSS DCR message fails.
class QzssDcrDecoderException implements Exception {
  /// Creates a new [QzssDcrDecoderException].
  const new(this.message, {this.sentence});

  /// The error message.
  final String message;

  /// The sentence that failed to decode, if available.
  final String? sentence;

  @override
  String toString() {
    if (sentence == null) {
      return 'QzssDcrDecoderException: $message';
    }
    return 'QzssDcrDecoderException: $message -> $sentence';
  }
}

/// Error thrown when a message type is not implemented.
class QzssDcrDecoderNotImplementedError extends Error {
  /// Creates a new [QzssDcrDecoderNotImplementedError].
  new(this.message, {this.sentence});

  /// The error message.
  final String message;

  /// The sentence that is not implemented, if available.
  final String? sentence;

  @override
  String toString() {
    if (sentence == null) {
      return 'QzssDcrDecoderNotImplementedError: $message';
    }
    return 'QzssDcrDecoderNotImplementedError: $message -> $sentence';
  }
}
