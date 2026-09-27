import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:eqmonitor_lints_plugin/src/manual_provider_detection.dart';
import 'package:test/test.dart';

Expression _initializerOf(String source) {
  final unit = parseString(content: source, throwIfDiagnostics: false).unit;
  final declaration = unit.declarations
      .whereType<TopLevelVariableDeclaration>()
      .single;
  return declaration.variables.variables.single.initializer!;
}

bool _isManualProvider(String source) =>
    ManualProviderDetection.isManualProviderCreation(
      expression: _initializerOf(source),
    );

void main() {
  group('ManualProviderDetection.isManualProviderCreation', () {
    test('Provider(...) を検出する', () {
      expect(_isManualProvider('final a = Provider((ref) => 0);'), isTrue);
    });

    test('型引数付きの Provider を検出する', () {
      expect(_isManualProvider('final a = Provider<int>((ref) => 0);'), isTrue);
    });

    test('new 付きの生成式を検出する', () {
      expect(_isManualProvider('final a = new Provider((ref) => 0);'), isTrue);
    });

    test('FutureProvider / StateNotifierProvider を検出する', () {
      expect(
        _isManualProvider('final a = FutureProvider((ref) async => 0);'),
        isTrue,
      );
      expect(
        _isManualProvider(
          'final a = StateNotifierProvider<A, B>((ref) => A());',
        ),
        isTrue,
      );
    });

    test('autoDispose / family ビルダー経由でも検出する', () {
      expect(
        _isManualProvider('final a = Provider.autoDispose((ref) => 0);'),
        isTrue,
      );
      expect(
        _isManualProvider(
          'final a = Provider.family<int, int>((ref, i) => i);',
        ),
        isTrue,
      );
      expect(
        _isManualProvider(
          'final a = StreamProvider.autoDispose.family<int, int>'
          '((ref, i) => Stream.value(i));',
        ),
        isTrue,
      );
    });

    test('プレフィックス付き import でも検出する', () {
      expect(
        _isManualProvider('final a = riverpod.Provider((ref) => 0);'),
        isTrue,
      );
    });

    test('生成済み Provider の参照は検出しない', () {
      expect(_isManualProvider('final a = fooProvider;'), isFalse);
      expect(
        _isManualProvider('final a = fooProvider.overrideWith((ref) => 0);'),
        isFalse,
      );
    });

    test('Provider 以外の生成式は検出しない', () {
      expect(_isManualProvider('final a = ProviderScope(child: b);'), isFalse);
      expect(_isManualProvider('final a = ProviderContainer();'), isFalse);
      expect(_isManualProvider('final a = MyProvider();'), isFalse);
    });
  });
}
