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

String _$eewHash() => r'70c0c1ab9802a63c05d4f541511aed78b368794b';

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

@ProviderFor(eewRest)
final eewRestProvider = EewRestProvider._();

final class EewRestProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EewTelegramItem>>,
          List<EewTelegramItem>,
          FutureOr<List<EewTelegramItem>>
        >
    with
        $FutureModifier<List<EewTelegramItem>>,
        $FutureProvider<List<EewTelegramItem>> {
  EewRestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewRestProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewRestHash();

  @$internal
  @override
  $FutureProviderElement<List<EewTelegramItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EewTelegramItem>> create(Ref ref) {
    return eewRest(ref);
  }
}

String _$eewRestHash() => r'd69f4421e4998eb4cbdbee58c222a0a7c63c37a8';
