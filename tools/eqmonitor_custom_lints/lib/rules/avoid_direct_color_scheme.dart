import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDirectColorScheme extends DartLintRule {
  const AvoidDirectColorScheme() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_direct_color_scheme',
    problemMessage: 'Theme.of(context).colorScheme を直接参照せず、'
        'designSystem.colorTheme を使用してください。',
    errorSeverity: ErrorSeverity.WARNING,
  );

  static const _allowedPathSegments = [
    '/core/theme/build_theme.dart',
    '.g.dart',
    '.freezed.dart',
  ];

  bool _isAllowed(String path) {
    final normalized = path.replaceAll(r'\', '/');
    return _allowedPathSegments.any(normalized.endsWith);
  }

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    if (_isAllowed(resolver.path)) {
      return;
    }

    context.registry.addPropertyAccess((node) {
      _reportIfColorSchemeOnThemeData(node.propertyName, node.target, reporter);
    });
    context.registry.addPrefixedIdentifier((node) {
      _reportIfColorSchemeOnThemeData(node.identifier, node.prefix, reporter);
    });
  }

  void _reportIfColorSchemeOnThemeData(
    SimpleIdentifier propertyName,
    Expression? target,
    ErrorReporter reporter,
  ) {
    if (propertyName.name != 'colorScheme') {
      return;
    }
    final targetType = target?.staticType;
    if (targetType == null) {
      return;
    }
    final displayName = targetType.getDisplayString();
    if (displayName == 'ThemeData') {
      reporter.atNode(propertyName, code);
    }
  }
}
