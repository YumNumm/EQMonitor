import 'package:analyzer/dart/ast/ast.dart';

/// `const new(...)` 形式のコンストラクタが Primary Constructor
/// (`class const Foo({required final int a});`) へ機械的に変換できるかを判定する。
///
/// 判定は保守的で、変換が非自明な形（親クラスあり・初期化子あり・本体あり等）は
/// 対象外とする。Widget は必ず Widget 系の基底クラスを `extends` するため、
/// 親クラス判定によってまとめて除外される。
class PrimaryConstructorConvertibility {
  const new _();

  static bool isConvertible({required ConstructorDeclaration node}) {
    // `const new(...)` のみを対象とする。
    if (node.constKeyword == null ||
        node.factoryKeyword != null ||
        node.externalKeyword != null ||
        node.augmentKeyword != null) {
      return false;
    }
    // 名前付きコンストラクタ (`const Foo._()`) は対象外。
    if (node.name != null) {
      return false;
    }
    // 初期化子リスト・リダイレクト・本体があると宣言だけには畳めない。
    if (node.initializers.isNotEmpty ||
        node.redirectedConstructor != null ||
        node.body is! EmptyFunctionBody) {
      return false;
    }
    final classDeclaration = node.thisOrAncestorOfType<ClassDeclaration>();
    if (classDeclaration == null) {
      return false;
    }
    // 既に Primary Constructor を持つ class は変換対象にならない。
    if (classDeclaration.namePart is PrimaryConstructorDeclaration) {
      return false;
    }
    // 親クラスを持つ場合は super 呼び出しや継承フィールドが絡むため対象外。
    // Widget / State のサブクラスもここで除外される。
    if (classDeclaration.extendsClause != null) {
      return false;
    }
    // 他のコンストラクタが残る場合、Primary Constructor が宣言するフィールドを
    // そちらの初期化子リストから初期化できず、機械的には変換できない。
    final constructorCount = classDeclaration.body.members
        .whereType<ConstructorDeclaration>()
        .length;
    if (constructorCount != 1) {
      return false;
    }
    return node.parameters.parameters.every(
      (parameter) => _isConvertibleParameter(
        parameter: parameter,
        classDeclaration: classDeclaration,
      ),
    );
  }

  static bool _isConvertibleParameter({
    required FormalParameter parameter,
    required ClassDeclaration classDeclaration,
  }) {
    // `this.x` 以外 (super.x / 素の引数) は宣言へ畳めない。
    if (parameter is! FieldFormalParameter) {
      return false;
    }
    return _hasPlainFinalField(
      classDeclaration: classDeclaration,
      fieldName: parameter.name.lexeme,
    );
  }

  /// `final` かつ初期化子・`late` を伴わないインスタンスフィールドがあるか。
  ///
  /// Primary Constructor はフィールド宣言そのものを引数リストへ移すため、
  /// フィールド側に初期化子等が付いている場合は変換できない。
  static bool _hasPlainFinalField({
    required ClassDeclaration classDeclaration,
    required String fieldName,
  }) {
    for (final member in classDeclaration.body.members) {
      if (member is! FieldDeclaration || member.isStatic) {
        continue;
      }
      final fields = member.fields;
      for (final variable in fields.variables) {
        if (variable.name.lexeme != fieldName) {
          continue;
        }
        return fields.isFinal &&
            !fields.isLate &&
            variable.initializer == null &&
            member.abstractKeyword == null &&
            member.externalKeyword == null;
      }
    }
    return false;
  }
}
