// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'jma_map_utility.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(jmaMapUtility)
const jmaMapUtilityProvider = JmaMapUtilityProvider._();

final class JmaMapUtilityProvider
    extends $FunctionalProvider<JmaMapUtility, JmaMapUtility, JmaMapUtility>
    with $Provider<JmaMapUtility> {
  const JmaMapUtilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jmaMapUtilityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jmaMapUtilityHash();

  @$internal
  @override
  $ProviderElement<JmaMapUtility> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JmaMapUtility create(Ref ref) {
    return jmaMapUtility(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JmaMapUtility value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JmaMapUtility>(value),
    );
  }
}

String _$jmaMapUtilityHash() => r'77dac2bee1cbb90d6a20f86baab076df93a94006';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
