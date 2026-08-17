import 'package:analyzer/dart/ast/ast.dart';

/// トップレベル関数のうち、言語仕様・フレームワーク上その形でしか
/// 書けないものを [AvoidTopLevelFunctions] の対象外と判定する。
class TopLevelFunctionExemption {
  const new _();

  static const _entryPointFunctionName = 'main';
  static const _riverpodAnnotationNames = {'riverpod', 'Riverpod'};
  static const _pragmaAnnotationName = 'pragma';
  static const _vmEntryPointPragma = 'vm:entry-point';

  static bool isExempt({required FunctionDeclaration node}) {
    if (node.name.lexeme == _entryPointFunctionName) {
      return true;
    }
    return node.metadata.any(_isExemptAnnotation);
  }

  static bool _isExemptAnnotation(Annotation annotation) {
    final name = annotation.name.name;
    if (_riverpodAnnotationNames.contains(name)) {
      return true;
    }
    if (name != _pragmaAnnotationName) {
      return false;
    }
    final arguments = annotation.arguments?.arguments;
    if (arguments == null || arguments.isEmpty) {
      return false;
    }
    final firstArgument = arguments.first;
    return firstArgument is SimpleStringLiteral &&
        firstArgument.value == _vmEntryPointPragma;
  }
}
