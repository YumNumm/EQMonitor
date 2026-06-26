import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

class AvoidTopLevelFunctions extends AnalysisRule {
  AvoidTopLevelFunctions()
    : super(
        name: _code.name,
        description: _code.problemMessage,
      );

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
  ) => registry.addFunctionDeclaration(this, _Visitor(this));
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final AnalysisRule rule;

  static const _riverpodNames = {'riverpod', 'Riverpod'};

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (node.parent is! CompilationUnit) {
      return;
    }
    // @riverpod / @Riverpod 付き関数プロバイダは慣用的なため自動で除外する。
    if (_hasRiverpodAnnotation(node.metadata)) {
      return;
    }
    rule.reportAtToken(node.name);
  }

  bool _hasRiverpodAnnotation(NodeList<Annotation> metadata) {
    for (final annotation in metadata) {
      if (_riverpodNames.contains(annotation.name.name)) {
        return true;
      }
    }
    return false;
  }
}
