import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:eqmonitor_lints_plugin/src/top_level_function_exemption.dart';
import 'package:test/test.dart';

List<FunctionDeclaration> _declarationsOf(String source) {
  final unit = parseString(content: source, throwIfDiagnostics: false).unit;
  return unit.declarations.whereType<FunctionDeclaration>().toList();
}

void main() {
  group('TopLevelFunctionExemption.isExempt', () {
    test('main は許可する', () {
      final declarations = _declarationsOf('void main() {}');
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isTrue,
      );
    });

    test('@riverpod は許可する', () {
      final declarations = _declarationsOf('@riverpod\nint foo(Ref ref) => 0;');
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isTrue,
      );
    });

    test('@Riverpod(keepAlive: true) は許可する', () {
      final declarations = _declarationsOf(
        '@Riverpod(keepAlive: true)\nint foo(Ref ref) => 0;',
      );
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isTrue,
      );
    });

    test("@pragma('vm:entry-point') は許可する", () {
      final declarations = _declarationsOf(
        "@pragma('vm:entry-point')\nvoid worker(SendPort port) {}",
      );
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isTrue,
      );
    });

    test("@pragma('vm:prefer-inline') は許可しない", () {
      final declarations = _declarationsOf(
        "@pragma('vm:prefer-inline')\nvoid helper() {}",
      );
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isFalse,
      );
    });

    test('引数のない @pragma は許可しない', () {
      final declarations = _declarationsOf('@pragma\nvoid helper() {}');
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isFalse,
      );
    });

    test('素のトップレベル関数は許可しない', () {
      final declarations = _declarationsOf('void helper() {}');
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isFalse,
      );
    });

    test('main という名前でもクラスのメソッドは対象外（トップレベルのみ判定）', () {
      final declarations = _declarationsOf('void mainHandler() {}');
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isFalse,
      );
    });
  });
}
