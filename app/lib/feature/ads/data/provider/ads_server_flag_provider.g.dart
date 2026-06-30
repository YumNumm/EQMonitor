// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ads_server_flag_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adsServerFlag)
final adsServerFlagProvider = AdsServerFlagProvider._();

final class AdsServerFlagProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  AdsServerFlagProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adsServerFlagProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adsServerFlagHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return adsServerFlag(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$adsServerFlagHash() => r'16e99704d3100060368507c0b7def5b45942ccfe';
