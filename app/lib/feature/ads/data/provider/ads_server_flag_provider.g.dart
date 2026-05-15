// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ads_server_flag_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Start API実装前のスタブ。サーバから取得した ads_enabled フラグに置き換える。

@ProviderFor(adsServerFlag)
final adsServerFlagProvider = AdsServerFlagProvider._();

/// Start API実装前のスタブ。サーバから取得した ads_enabled フラグに置き換える。

final class AdsServerFlagProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Start API実装前のスタブ。サーバから取得した ads_enabled フラグに置き換える。
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

String _$adsServerFlagHash() => r'0bdda0b35cfe3662737d173f830ff5c8942f832b';
