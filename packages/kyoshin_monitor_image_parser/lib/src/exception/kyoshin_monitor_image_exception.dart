sealed class const KyoshinImageParseException(
  final KyoshinImageParseExceptionType type,
) implements Exception;

class KyoshinImageParseInvalidGifException extends KyoshinImageParseException {
  const new() : super(KyoshinImageParseExceptionType.invalidGif);
}

class KyoshinImageParseInvalidImageSizeException
    extends KyoshinImageParseException {
  const new() : super(KyoshinImageParseExceptionType.invalidImageSize);
}

enum KyoshinImageParseExceptionType { invalidGif, invalidImageSize }
