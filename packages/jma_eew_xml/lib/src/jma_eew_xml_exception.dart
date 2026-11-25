sealed class const JmaEewXmlException(final String message)
    implements Exception {
  @override
  String toString() => '$runtimeType: $message';
}

final class JmaEewXmlSyntaxException(final int offset, String message)
    extends JmaEewXmlException {
  this : super('$message (offset: $offset)');
}

final class const JmaEewXmlStructureException(super.message)
    extends JmaEewXmlException;

final class JmaEewXmlUnsupportedTitleException(final String title)
    extends JmaEewXmlException {
  this : super('緊急地震速報の電文ではありません: $title');
}
