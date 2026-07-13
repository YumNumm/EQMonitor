// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shindo_db_intensity_tree_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 震度データベース表示に切り替えたときに初めて watch され、遅延計算される

@ProviderFor(shindoDbIntensityTree)
final shindoDbIntensityTreeProvider = ShindoDbIntensityTreeFamily._();

/// 震度データベース表示に切り替えたときに初めて watch され、遅延計算される

final class ShindoDbIntensityTreeProvider
    extends
        $FunctionalProvider<
          AsyncValue<ShindoDbIntensityTree?>,
          ShindoDbIntensityTree?,
          FutureOr<ShindoDbIntensityTree?>
        >
    with
        $FutureModifier<ShindoDbIntensityTree?>,
        $FutureProvider<ShindoDbIntensityTree?> {
  /// 震度データベース表示に切り替えたときに初めて watch され、遅延計算される
  ShindoDbIntensityTreeProvider._({
    required ShindoDbIntensityTreeFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'shindoDbIntensityTreeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$shindoDbIntensityTreeHash();

  @override
  String toString() {
    return r'shindoDbIntensityTreeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ShindoDbIntensityTree?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ShindoDbIntensityTree?> create(Ref ref) {
    final argument = this.argument as String;
    return shindoDbIntensityTree(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ShindoDbIntensityTreeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shindoDbIntensityTreeHash() =>
    r'47f9ec878ee060fc8e888125abdf4bd0298362a6';

/// 震度データベース表示に切り替えたときに初めて watch され、遅延計算される

final class ShindoDbIntensityTreeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ShindoDbIntensityTree?>, String> {
  ShindoDbIntensityTreeFamily._()
    : super(
        retry: null,
        name: r'shindoDbIntensityTreeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 震度データベース表示に切り替えたときに初めて watch され、遅延計算される

  ShindoDbIntensityTreeProvider call(String eventId) =>
      ShindoDbIntensityTreeProvider._(argument: eventId, from: this);

  @override
  String toString() => r'shindoDbIntensityTreeProvider';
}
