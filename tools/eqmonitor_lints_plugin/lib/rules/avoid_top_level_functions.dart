import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:eqmonitor_lints_plugin/src/lint_target_scope.dart';
import 'package:eqmonitor_lints_plugin/src/top_level_function_exemption.dart';

class AvoidTopLevelFunctions extends AnalysisRule {
  new()
    : super(name: _code.name, description: _code.problemMessage);

  static const _code = LintCode(
    'avoid_top_level_functions',
    'トップレベル関数の定義は禁止です。'
        ' プライベートなトップレベル関数 (_xxx) も禁止です。'
        ' 処理を専用クラスに切り出し、Riverpod で DI してください。',
    correctionMessage:
        '専用クラスを作成し、そのメソッドとして実装してください。'
        ' 例: @riverpod MyClass myClass(Ref ref) => MyClass();',
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
    registry.addFunctionDeclaration(this, _Visitor(this));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  new(this.rule);

  final AnalysisRule rule;

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (node.parent is! CompilationUnit) {
      return;
    }
    if (TopLevelFunctionExemption.isExempt(node: node)) {
      return;
    }
    rule.reportAtToken(node.name);
  }
}
