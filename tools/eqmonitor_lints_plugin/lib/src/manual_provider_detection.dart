import 'package:analyzer/dart/ast/ast.dart';

/// Riverpod Generator (`@riverpod`) を使わず手書きされた Provider 宣言を判定する。
class ManualProviderDetection {
  const new _();

  /// 手書きで宣言されうる Riverpod の Provider 型名。
  ///
  /// `Provider.autoDispose(...)` / `Provider.family(...)` のような
  /// ビルダー経由の宣言も、先頭の識別子がこの集合に含まれるため検出できる。
  static const _providerTypeNames = {
    'Provider',
    'StateProvider',
    'StateNotifierProvider',
    'ChangeNotifierProvider',
    'FutureProvider',
    'StreamProvider',
    'NotifierProvider',
    'AsyncNotifierProvider',
    'StreamNotifierProvider',
    'AutoDisposeProvider',
    'AutoDisposeStateProvider',
    'AutoDisposeStateNotifierProvider',
    'AutoDisposeChangeNotifierProvider',
    'AutoDisposeFutureProvider',
    'AutoDisposeStreamProvider',
    'AutoDisposeNotifierProvider',
    'AutoDisposeAsyncNotifierProvider',
    'AutoDisposeStreamNotifierProvider',
  };

  /// [expression] が Provider 型の生成式なら `true`。
  static bool isManualProviderCreation({required Expression expression}) =>
      _typeNameCandidates(expression).any(_providerTypeNames.contains);

  /// 式のうち「型名でありうる」識別子を集める。
  ///
  /// 解決済み AST では `Provider(...)` は [InstanceCreationExpression] だが、
  /// 未解決 AST では [MethodInvocation] になる。さらに `Provider.family(...)`
  /// では型名が左側、`riverpod.Provider(...)`（prefix 付き import）では
  /// 型名が右側に来るため、どちらの位置も候補として扱う。
  static Set<String> _typeNameCandidates(Expression expression) {
    final candidates = <String>{};
    var current = expression;
    while (true) {
      switch (current) {
        case ParenthesizedExpression(expression: final inner):
          current = inner;
        case InstanceCreationExpression(:final constructorName):
          candidates.add(constructorName.type.name.lexeme);
          return candidates;
        case MethodInvocation(:final methodName, :final target):
          candidates.add(methodName.name);
          if (target == null) {
            return candidates;
          }
          current = target;
        case FunctionExpressionInvocation(:final function):
          current = function;
        case PropertyAccess(:final propertyName, :final target):
          candidates.add(propertyName.name);
          if (target == null) {
            return candidates;
          }
          current = target;
        case PrefixedIdentifier(:final prefix, :final identifier):
          candidates.addAll([prefix.name, identifier.name]);
          return candidates;
        case SimpleIdentifier(:final name):
          candidates.add(name);
          return candidates;
        case CascadeExpression(:final target):
          current = target;
        default:
          return candidates;
      }
    }
  }
}
