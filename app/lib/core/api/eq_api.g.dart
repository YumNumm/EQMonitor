// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'eq_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(eqApi)
const eqApiProvider = EqApiProvider._();

final class EqApiProvider extends $FunctionalProvider<EqApi, EqApi>
    with $Provider<EqApi> {
  const EqApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqApiHash();

  @$internal
  @override
  $ProviderElement<EqApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EqApi create(Ref ref) {
    return eqApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EqApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<EqApi>(value),
    );
  }
}

String _$eqApiHash() => r'e9c1e9be905ca9b7fcd56b1715c1e2426c95b5b0';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
