import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:eqmonitor_lints_plugin/src/lint_target_scope.dart';

class AvoidEqmonitorApiInUi extends AnalysisRule {
  AvoidEqmonitorApiInUi()
    : super(name: _code.name, description: _code.problemMessage);

  static const _code = LintCode(
    'avoid_eqmonitor_api_in_ui',
    'UI 層 (ui/ 配下) で package:eqmonitor_api を import してはいけません。',
    correctionMessage:
        'data 層でアプリ用ドメインモデルへ変換し、'
        ' UI からはドメイン型のみ参照してください。',
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
    if (path == null ||
        LintTargetScope.isExcluded(path: path) ||
        !_isInUiLayer(path)) {
      return;
    }
    registry.addImportDirective(this, _Visitor(this));
  }

  static bool _isInUiLayer(String path) {
    final normalized = path.replaceAll(r'\', '/');
    return normalized.contains('/ui/');
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final AnalysisRule rule;

  @override
  void visitImportDirective(ImportDirective node) {
    final uri = node.uri.stringValue;
    if (uri != null && uri.startsWith('package:eqmonitor_api')) {
      rule.reportAtNode(node);
    }
  }
}
