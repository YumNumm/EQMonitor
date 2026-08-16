import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:eqmonitor_lints_plugin/src/lint_target_scope.dart';

class AvoidNullAssertionOperator extends AnalysisRule {
  AvoidNullAssertionOperator()
    : super(name: _code.name, description: _code.problemMessage);

  static const _code = LintCode(
    'avoid_null_assertion_operator',
    'null アサーション演算子 (!) の使用は禁止です。'
        ' ? 演算子とフロー解析 (if (x != null)) で安全に扱ってください。',
    correctionMessage:
        '! を削除し、null チェックを使用してください。'
        ' 例: if (x != null) { ... } または x?.method()',
    severity: DiagnosticSeverity.WARNING,
  );

  @override
  DiagnosticCode get diagnosticCode => _code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final path = context.definingUnit.unit.declaredFragment?.source.fullName;
    if (path != null && LintTargetScope.isExcluded(path: path)) {
      return;
    }
    registry.addPostfixExpression(this, _Visitor(this));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final AnalysisRule rule;

  @override
  void visitPostfixExpression(PostfixExpression node) {
    if (node.operator.type == TokenType.BANG) {
      rule.reportAtToken(node.operator);
    }
  }
}
