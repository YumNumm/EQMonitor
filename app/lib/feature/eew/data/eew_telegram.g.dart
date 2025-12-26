// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Eew)
const eewProvider = EewProvider._();

final class EewProvider
    extends $NotifierProvider<Eew, AsyncValue<List<EewItemWithRelations>>> {
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
  Override overrideWithValue(AsyncValue<List<EewItemWithRelations>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<List<EewItemWithRelations>>>(value),
    );
  }
}

String _$eewHash() => r'e50717622616bc55537d3bd768100aa08a97fa05';

abstract class _$Eew extends $Notifier<AsyncValue<List<EewItemWithRelations>>> {
  AsyncValue<List<EewItemWithRelations>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<EewItemWithRelations>>,
              AsyncValue<List<EewItemWithRelations>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<EewItemWithRelations>>,
                AsyncValue<List<EewItemWithRelations>>
              >,
              AsyncValue<List<EewItemWithRelations>>,
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
          AsyncValue<List<EewItemWithRelations>>,
          List<EewItemWithRelations>,
          FutureOr<List<EewItemWithRelations>>
        >
    with
        $FutureModifier<List<EewItemWithRelations>>,
        $FutureProvider<List<EewItemWithRelations>> {
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
  String debugGetCreateSourceHash() => _$_eewRestHash();

  @$internal
  @override
  $FutureProviderElement<List<EewItemWithRelations>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EewItemWithRelations>> create(Ref ref) {
    return _eewRest(ref);
  }
}

String _$_eewRestHash() => r'a56a6977a4e5e3985f1e435f78ee8b8627c508ae';
