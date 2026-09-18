// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 's_wave_travel_time_lookup.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sWaveTravelTimeLookup)
final sWaveTravelTimeLookupProvider = SWaveTravelTimeLookupProvider._();

final class SWaveTravelTimeLookupProvider
    extends
        $FunctionalProvider<
          SWaveTravelTimeLookup,
          SWaveTravelTimeLookup,
          SWaveTravelTimeLookup
        >
    with $Provider<SWaveTravelTimeLookup> {
  SWaveTravelTimeLookupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sWaveTravelTimeLookupProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sWaveTravelTimeLookupHash();

  @$internal
  @override
  $ProviderElement<SWaveTravelTimeLookup> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SWaveTravelTimeLookup create(Ref ref) {
    return sWaveTravelTimeLookup(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SWaveTravelTimeLookup value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SWaveTravelTimeLookup>(value),
    );
  }
}

String _$sWaveTravelTimeLookupHash() =>
    r'a48ac68c38d99e2eb81e8cff1645cf5c2d8ffdd4';
