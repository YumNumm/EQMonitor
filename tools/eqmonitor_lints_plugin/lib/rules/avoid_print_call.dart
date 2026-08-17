import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:eqmonitor_lints_plugin/src/lint_target_scope.dart';

class AvoidPrintCall extends AnalysisRule {
  new() : super(name: _code.name, description: _code.problemMessage);

  static const _code = LintCode(
    'avoid_print',
    '{0} の使用は禁止です。talker または dart:developer の log() を使用してください。',
    correctionMessage:
        'talker.log() / talker.error() または'
        ' dart:developer の log() に置き換えてください。',
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
    registry.addMethodInvocation(this, _Visitor(this));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  new(this.rule);

  final AnalysisRule rule;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.target != null) {
      return;
    }

    final name = node.methodName.name;
    final element = node.methodName.element;
    if (element is! TopLevelFunctionElement) {
      return;
    }

    final libraryUri = element.library.uri.toString();
    final isPrint = name == 'print' && libraryUri == 'dart:core';
    final isDebugPrint =
        name == 'debugPrint' && libraryUri.contains('package:flutter/');

    if (isPrint || isDebugPrint) {
      rule.reportAtNode(node, arguments: [name]);
    }
  }
}
