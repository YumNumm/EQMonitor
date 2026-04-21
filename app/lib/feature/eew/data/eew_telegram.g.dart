// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_telegram.dart';

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

String _$eewHash() => r'98d08648f85e9bdaf4b012903c24fd9118279c5d';

abstract class _$Eew extends $Notifier<AsyncValue<List<EewTelegramItem>>> {
  AsyncValue<List<EewTelegramItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
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

String _$_eewRestHash() => r'86c40a83aeca927f57d8a6897db30fefbcac3b52';
