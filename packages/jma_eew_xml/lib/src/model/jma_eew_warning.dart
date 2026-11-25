import 'package:jma_eew_xml/src/model/jma_code_name.dart';
import 'package:jma_eew_xml/src/model/jma_eew_enums.dart';

final class const JmaEewWarningItem({
  required final JmaEewWarningAreaLevel level,
  required final JmaCodeName kind,
  required final JmaCodeName lastKind,
  required final List<JmaCodeName> areas,
}) {
  static const warningKindCode = '31';

  bool get hadWarning => lastKind.code == warningKindCode;
}

final class const JmaEewWarningComment({
  required final String text,
  required final List<String> codes,
}) {
  static const strongShakingCode = '0201';
}
