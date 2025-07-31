// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Eew)
const eewProvider = EewProvider._();

final class EewProvider
    extends $NotifierProvider<Eew, AsyncValue<List<EewV1>>> {
  const EewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewHash();

  @$internal
  @override
  Eew create() => Eew();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<EewV1>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<EewV1>>>(value),
    );
  }
}

String _$eewHash() => r'f0c94508bca061cdcff270591236dc235a91abdb';

abstract class _$Eew extends $Notifier<AsyncValue<List<EewV1>>> {
  AsyncValue<List<EewV1>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<EewV1>>, AsyncValue<List<EewV1>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<EewV1>>, AsyncValue<List<EewV1>>>,
              AsyncValue<List<EewV1>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(_eewRest)
const _eewRestProvider = _EewRestProvider._();

final class _EewRestProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EewV1>>,
          List<EewV1>,
          FutureOr<List<EewV1>>
        >
    with $FutureModifier<List<EewV1>>, $FutureProvider<List<EewV1>> {
  const _EewRestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_eewRestProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewRestHash();

  @$internal
  @override
  $FutureProviderElement<List<EewV1>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EewV1>> create(Ref ref) {
    return _eewRest(ref);
  }
}

String _$eewRestHash() => r'69fa253ca95a018a286351ead0b2f662f5e47626';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
