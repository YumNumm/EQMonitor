sealed class const KyoshinImageParseException(
  final KyoshinImageParseExceptionType type,
) implements Exception;

class const KyoshinImageParseInvalidGifException()
    extends KyoshinImageParseException {
  this : super(KyoshinImageParseExceptionType.invalidGif);
}

class const KyoshinImageParseInvalidImageSizeException()
    extends KyoshinImageParseException {
  this : super(KyoshinImageParseExceptionType.invalidImageSize);
}

enum KyoshinImageParseExceptionType { invalidGif, invalidImageSize }
