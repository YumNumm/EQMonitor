import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// `Theme.of(context).colorScheme` という直接参照をASTレベルで検出する。
///
/// 型解決には依存しない(analysis_server_plugin として単体の
/// `AnalysisContext` を持たない環境でもテスト可能にするため)。
/// そのため `final theme = Theme.of(context); theme.colorScheme;` のように
/// 変数へ束縛された後の参照は検出対象外となる。
bool isColorSchemeOnThemeOf(SimpleIdentifier propertyName, Expression? target) {
  if (propertyName.name != 'colorScheme') {
    return false;
  }
  return target != null && _isThemeOfInvocation(target);
}

bool _isThemeOfInvocation(Expression target) {
  if (target is! MethodInvocation) {
    return false;
  }
  if (target.methodName.name != 'of') {
    return false;
  }
  final invocationTarget = target.target;
  return invocationTarget is SimpleIdentifier &&
      invocationTarget.name == 'Theme';
}

/// テスト用: [unit] 全体を走査し、違反箇所の [SimpleIdentifier] 一覧を返す。
///
/// 本番の analysis_server_plugin 実行時は `RuleVisitorRegistry` 経由の
/// イベント駆動visitorを使うため、この関数はテストからのみ使用される。
List<SimpleIdentifier> findColorSchemeViolations(CompilationUnit unit) {
  final visitor = _CollectingVisitor();
  unit.accept(visitor);
  return visitor.violations;
}

class _CollectingVisitor extends RecursiveAstVisitor<void> {
  final violations = <SimpleIdentifier>[];

  @override
  void visitPropertyAccess(PropertyAccess node) {
    if (isColorSchemeOnThemeOf(node.propertyName, node.target)) {
      violations.add(node.propertyName);
    }
    super.visitPropertyAccess(node);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    if (isColorSchemeOnThemeOf(node.identifier, node.prefix)) {
      violations.add(node.identifier);
    }
    super.visitPrefixedIdentifier(node);
  }
}
