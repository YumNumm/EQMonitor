import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:eqmonitor_lints_plugin/src/lint_target_scope.dart';
import 'package:eqmonitor_lints_plugin/src/primary_constructor_convertibility.dart';

class PreferPrimaryConstructor extends AnalysisRule {
  new() : super(name: _code.name, description: _code.problemMessage);

  static const _code = LintCode(
    'prefer_primary_constructor',
    'class 本体の `const new(...)` ではなく Primary Constructor を使用してください。',
    correctionMessage:
        'フィールド宣言をコンストラクタ引数へ移し、'
        ' `class const Foo({required final int a});` の形に変換してください。',
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
    if (path != null &&
        (LintTargetScope.isExcluded(path: path) ||
            LintTargetScope.isGenerated(path: path))) {
      return;
    }
    registry.addConstructorDeclaration(this, _Visitor(this));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  new(this.rule);

  final AnalysisRule rule;

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    if (!PrimaryConstructorConvertibility.isConvertible(node: node)) {
      return;
    }
    rule.reportAtToken(node.constKeyword!);
  }
}
