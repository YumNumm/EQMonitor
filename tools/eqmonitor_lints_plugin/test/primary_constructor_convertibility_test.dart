import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:eqmonitor_lints_plugin/src/primary_constructor_convertibility.dart';
import 'package:test/test.dart';

bool _isConvertible(String source) {
  final unit = parseString(content: source, throwIfDiagnostics: false).unit;
  final classDeclaration = unit.declarations
      .whereType<ClassDeclaration>()
      .single;
  final constructor = classDeclaration.body.members
      .whereType<ConstructorDeclaration>()
      .first;
  return PrimaryConstructorConvertibility.isConvertible(node: constructor);
}

void main() {
  group('PrimaryConstructorConvertibility.isConvertible', () {
    test('const new(...) とフィールド宣言だけの class は変換できる', () {
      expect(
        _isConvertible('''
class Foo {
  const new({required this.a, this.b});

  final int a;
  final String? b;
}
'''),
        isTrue,
      );
    });

    test('位置引数でも変換できる', () {
      expect(
        _isConvertible('''
class Foo {
  const new(this.a);

  final int a;
}
'''),
        isTrue,
      );
    });

    test('const でないコンストラクタは対象外', () {
      expect(
        _isConvertible('''
class Foo {
  new(this.a);

  final int a;
}
'''),
        isFalse,
      );
    });

    test('名前付きコンストラクタは対象外', () {
      expect(
        _isConvertible('''
class Foo {
  const new _(this.a);

  final int a;
}
'''),
        isFalse,
      );
    });

    test('初期化子リストがある場合は対象外', () {
      expect(
        _isConvertible('''
class Foo {
  const new(this.a) : assert(a > 0);

  final int a;
}
'''),
        isFalse,
      );
    });

    test('本体がある場合は対象外', () {
      expect(
        _isConvertible('''
class Foo {
  const new(this.a) {}

  final int a;
}
'''),
        isFalse,
      );
    });

    test('Widget など親クラスを持つ class は対象外', () {
      expect(
        _isConvertible('''
class Foo extends StatelessWidget {
  const new({super.key});
}
'''),
        isFalse,
      );
    });

    test('this.x 以外の引数を取る場合は対象外', () {
      expect(
        _isConvertible('''
class Foo {
  const new(int a);

  final int b = 0;
}
'''),
        isFalse,
      );
    });

    test('対応するフィールドが final でない場合は対象外', () {
      expect(
        _isConvertible('''
class Foo {
  const new(this.a);

  int a;
}
'''),
        isFalse,
      );
    });

    test('他のコンストラクタが同居する class は対象外', () {
      expect(
        _isConvertible('''
class Foo {
  const new({required this.a});

  const new zero() : a = 0;

  final int a;
}
'''),
        isFalse,
      );
    });

    test('factory コンストラクタは対象外', () {
      expect(
        _isConvertible('''
class Foo {
  const factory new(int a) = Bar;
}
'''),
        isFalse,
      );
    });
  });
}
