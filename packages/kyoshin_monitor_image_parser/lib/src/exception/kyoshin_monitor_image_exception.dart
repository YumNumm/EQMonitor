sealed class KyoshinImageParseException implements Exception {
  const KyoshinImageParseException(this.type);
  final KyoshinImageParseExceptionType type;
}

class KyoshinImageParseInvalidGifException extends KyoshinImageParseException {
  const KyoshinImageParseInvalidGifException()
    : super(KyoshinImageParseExceptionType.invalidGif);
}

class KyoshinImageParseInvalidImageSizeException
    extends KyoshinImageParseException {
  const KyoshinImageParseInvalidImageSizeException()
    : super(KyoshinImageParseExceptionType.invalidImageSize);
}

enum KyoshinImageParseExceptionType { invalidGif, invalidImageSize }
