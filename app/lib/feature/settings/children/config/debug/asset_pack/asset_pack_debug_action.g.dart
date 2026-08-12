// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_debug_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assetPackDebugAction)
final assetPackDebugActionProvider = AssetPackDebugActionProvider._();

final class AssetPackDebugActionProvider
    extends
        $FunctionalProvider<
          AssetPackDebugAction,
          AssetPackDebugAction,
          AssetPackDebugAction
        >
    with $Provider<AssetPackDebugAction> {
  AssetPackDebugActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackDebugActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackDebugActionHash();

  @$internal
  @override
  $ProviderElement<AssetPackDebugAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AssetPackDebugAction create(Ref ref) {
    return assetPackDebugAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssetPackDebugAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssetPackDebugAction>(value),
    );
  }
}

String _$assetPackDebugActionHash() =>
    r'b61caa47f723a89ecccbf57f2142a2945987c0c0';

@ProviderFor(AssetPackLastUpdateResult)
final assetPackLastUpdateResultProvider = AssetPackLastUpdateResultProvider._();

final class AssetPackLastUpdateResultProvider
    extends
        $NotifierProvider<AssetPackLastUpdateResult, AssetPackUpdateResult?> {
  AssetPackLastUpdateResultProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackLastUpdateResultProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackLastUpdateResultHash();

  @$internal
  @override
  AssetPackLastUpdateResult create() => AssetPackLastUpdateResult();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssetPackUpdateResult? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssetPackUpdateResult?>(value),
    );
  }
}

String _$assetPackLastUpdateResultHash() =>
    r'a5d965a7cdc5a873b807b0930102c299f944409e';

abstract class _$AssetPackLastUpdateResult
    extends $Notifier<AssetPackUpdateResult?> {
  AssetPackUpdateResult? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AssetPackUpdateResult?, AssetPackUpdateResult?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AssetPackUpdateResult?, AssetPackUpdateResult?>,
              AssetPackUpdateResult?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
