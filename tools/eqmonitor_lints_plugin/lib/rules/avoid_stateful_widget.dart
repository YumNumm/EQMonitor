import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:eqmonitor_lints_plugin/src/lint_target_scope.dart';

class AvoidStatefulWidget extends AnalysisRule {
  AvoidStatefulWidget()
    : super(name: _code.name, description: _code.problemMessage);

  static const _code = LintCode(
    'avoid_stateful_widget',
    'StatefulWidget と ConsumerStatefulWidget の利用は禁止です。'
        ' HookWidget または HookConsumerWidget を使用してください。',
    correctionMessage:
        'HookWidget または HookConsumerWidget に変換し、'
        ' useState / useEffect で状態管理してください。',
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
    registry.addClassDeclaration(this, _Visitor(this));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final AnalysisRule rule;

  static const _forbidden = {'StatefulWidget', 'ConsumerStatefulWidget'};

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final extendsClause = node.extendsClause;
    if (extendsClause == null) {
      return;
    }
    final superName = extendsClause.superclass.name.lexeme;
    if (_forbidden.contains(superName)) {
      rule.reportAtNode(extendsClause);
    }
  }
}
