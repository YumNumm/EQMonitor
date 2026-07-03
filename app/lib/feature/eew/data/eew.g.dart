// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Eew)
final eewProvider = EewProvider._();

final class EewProvider
    extends $NotifierProvider<Eew, AsyncValue<List<EewTelegramItem>>> {
  EewProvider._()
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
  Override overrideWithValue(AsyncValue<List<EewTelegramItem>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<EewTelegramItem>>>(
        value,
      ),
    );
  }
}

String _$eewHash() => r'5df2ce02be3290cfd80f64b45a64b86eea25533c';

abstract class _$Eew extends $Notifier<AsyncValue<List<EewTelegramItem>>> {
  AsyncValue<List<EewTelegramItem>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<EewTelegramItem>>,
              AsyncValue<List<EewTelegramItem>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<EewTelegramItem>>,
                AsyncValue<List<EewTelegramItem>>
              >,
              AsyncValue<List<EewTelegramItem>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(_eewRest)
final _eewRestProvider = _EewRestProvider._();

final class _EewRestProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EewTelegramItem>>,
          List<EewTelegramItem>,
          FutureOr<List<EewTelegramItem>>
        >
    with
        $FutureModifier<List<EewTelegramItem>>,
        $FutureProvider<List<EewTelegramItem>> {
  _EewRestProvider._()
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
  $FutureProviderElement<List<EewTelegramItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EewTelegramItem>> create(Ref ref) {
    return _eewRest(ref);
  }
}

String _$_eewRestHash() => r'8f688579fc41f21f4679b2c6044b7c922b4c953a';
