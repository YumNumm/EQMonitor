import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:eqmonitor_lints_plugin/src/lint_target_scope.dart';

class AvoidMixedDeclarationCategories extends AnalysisRule {
  AvoidMixedDeclarationCategories()
    : super(name: _code.name, description: _code.problemMessage);

  static const _code = LintCode(
    'avoid_mixed_declaration_categories',
    'freezed モデルは他の class / Riverpod プロバイダと同一ファイルに定義できません。'
        ' 専用ファイルに分離してください。',
    correctionMessage:
        'freezed モデルを専用ファイルへ分離してください。'
        ' Riverpod プロバイダと、それが DI する通常 class の同居のみ許可されます。',
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
    registry.addCompilationUnit(this, _Visitor(this));
  }
}

/// ファイル内のトップレベル class 系宣言のカテゴリ。
/// enum / mixin / extension / typedef / 通常のトップレベル変数は判定対象外。
enum _Category {
  /// `@freezed` / `@Freezed(...)` 付き class
  freezed,

  /// `@riverpod` / `@Riverpod(...)` 付き class (Notifier) または関数 (関数プロバイダ)
  riverpod,

  /// 上記以外の通常 class
  plain,
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final AnalysisRule rule;

  static const _freezedNames = {'freezed', 'Freezed'};
  static const _riverpodNames = {'riverpod', 'Riverpod'};

  @override
  void visitCompilationUnit(CompilationUnit node) {
    // analyzer 13 で ClassDeclaration.name ゲッターが廃止されたため、
    // 報告対象は @freezed アノテーションノードとする。
    final freezedAnnotations = <Annotation>[];
    final categories = <_Category>{};

    for (final declaration in node.declarations) {
      final category = _categoryOf(declaration);
      if (category == null) {
        continue;
      }
      categories.add(category);
      if (category == _Category.freezed && declaration is ClassDeclaration) {
        final annotation = _annotationOf(declaration.metadata, _freezedNames);
        if (annotation != null) {
          freezedAnnotations.add(annotation);
        }
      }
    }

    // 「1ファイル1カテゴリ」 + Riverpod DI 例外 ({riverpod, plain} は許可)。
    // freezed が他カテゴリと混在している場合のみ違反とする。
    if (categories.contains(_Category.freezed) && categories.length > 1) {
      for (final annotation in freezedAnnotations) {
        rule.reportAtNode(annotation);
      }
    }
  }

  _Category? _categoryOf(CompilationUnitMember declaration) {
    switch (declaration) {
      case ClassDeclaration():
        if (_annotationOf(declaration.metadata, _freezedNames) != null) {
          return _Category.freezed;
        }
        if (_annotationOf(declaration.metadata, _riverpodNames) != null) {
          return _Category.riverpod;
        }
        return _Category.plain;
      case FunctionDeclaration():
        // @riverpod 関数プロバイダのみカテゴリ対象。
        // 通常のトップレベル関数は avoid_top_level_functions の責務。
        if (_annotationOf(declaration.metadata, _riverpodNames) != null) {
          return _Category.riverpod;
        }
        return null;
      default:
        return null;
    }
  }

  Annotation? _annotationOf(NodeList<Annotation> metadata, Set<String> names) {
    for (final annotation in metadata) {
      if (names.contains(annotation.name.name)) {
        return annotation;
      }
    }
    return null;
  }
}
