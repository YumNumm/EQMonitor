sealed class KyoshinImageParseException implements Exception {
  const new(this.type);

  final KyoshinImageParseExceptionType type;
}

class KyoshinImageParseInvalidGifException extends KyoshinImageParseException {
  const new()
    : super(KyoshinImageParseExceptionType.invalidGif);
}

class KyoshinImageParseInvalidImageSizeException
    extends KyoshinImageParseException {
  const new()
    : super(KyoshinImageParseExceptionType.invalidImageSize);
}

enum KyoshinImageParseExceptionType { invalidGif, invalidImageSize }
