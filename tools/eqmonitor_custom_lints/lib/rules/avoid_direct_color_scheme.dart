import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import '../src/color_scheme_violation_finder.dart';

class AvoidDirectColorScheme extends AnalysisRule {
  AvoidDirectColorScheme()
    : super(
        name: _code.name,
        description: _code.problemMessage,
      );

  static const _code = LintCode(
    'avoid_direct_color_scheme',
    'Theme.of(context).colorScheme を直接参照せず、'
        'designSystem.colorTheme を使用してください。',
    correctionMessage:
        'context.designSystem.colorTheme 経由でカラーを参照してください。',
    severity: DiagnosticSeverity.WARNING,
  );

  static const _allowedPathSuffixes = [
    '/core/theme/build_theme.dart',
    '.g.dart',
    '.freezed.dart',
  ];

  @override
  DiagnosticCode get diagnosticCode => _code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final path = context.definingUnit.unit.declaredFragment?.source.fullName;
    if (path != null && _isAllowed(path)) {
      return;
    }
    final visitor = _Visitor(this);
    registry.addPropertyAccess(this, visitor);
    registry.addPrefixedIdentifier(this, visitor);
  }

  static bool _isAllowed(String path) {
    final normalized = path.replaceAll(r'\', '/');
    return _allowedPathSuffixes.any(normalized.endsWith);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final AnalysisRule rule;

  @override
  void visitPropertyAccess(PropertyAccess node) {
    if (isColorSchemeOnThemeOf(node.propertyName, node.target)) {
      rule.reportAtNode(node.propertyName);
    }
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    if (isColorSchemeOnThemeOf(node.identifier, node.prefix)) {
      rule.reportAtNode(node.identifier);
    }
  }
}
