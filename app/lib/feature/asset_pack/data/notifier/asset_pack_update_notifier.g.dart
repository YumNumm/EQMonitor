// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_update_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssetPackUpdateNotifier)
final assetPackUpdateProvider = AssetPackUpdateNotifierProvider._();

final class AssetPackUpdateNotifierProvider
    extends $NotifierProvider<AssetPackUpdateNotifier, AssetPackUpdateState> {
  AssetPackUpdateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackUpdateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackUpdateNotifierHash();

  @$internal
  @override
  AssetPackUpdateNotifier create() => AssetPackUpdateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssetPackUpdateState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssetPackUpdateState>(value),
    );
  }
}

String _$assetPackUpdateNotifierHash() =>
    r'3f3c0ba2d9454cb20339e40eacc296ba4246f0a0';

abstract class _$AssetPackUpdateNotifier
    extends $Notifier<AssetPackUpdateState> {
  AssetPackUpdateState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AssetPackUpdateState, AssetPackUpdateState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AssetPackUpdateState, AssetPackUpdateState>,
              AssetPackUpdateState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
