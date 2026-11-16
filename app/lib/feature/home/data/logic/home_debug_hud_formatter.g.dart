// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'home_debug_hud_formatter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeDebugHudFormatter)
final homeDebugHudFormatterProvider = HomeDebugHudFormatterProvider._();

final class HomeDebugHudFormatterProvider
    extends
        $FunctionalProvider<
          HomeDebugHudFormatter,
          HomeDebugHudFormatter,
          HomeDebugHudFormatter
        >
    with $Provider<HomeDebugHudFormatter> {
  HomeDebugHudFormatterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeDebugHudFormatterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeDebugHudFormatterHash();

  @$internal
  @override
  $ProviderElement<HomeDebugHudFormatter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeDebugHudFormatter create(Ref ref) {
    return homeDebugHudFormatter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeDebugHudFormatter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeDebugHudFormatter>(value),
    );
  }
}

String _$homeDebugHudFormatterHash() =>
    r'1a54bc4f187e370403fad98b8f05a2718a10e915';
