// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqm_live_activity_util.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eqmLiveActivityUtil)
final eqmLiveActivityUtilProvider = EqmLiveActivityUtilProvider._();

final class EqmLiveActivityUtilProvider
    extends
        $FunctionalProvider<
          EQMLiveActivityUtil,
          EQMLiveActivityUtil,
          EQMLiveActivityUtil
        >
    with $Provider<EQMLiveActivityUtil> {
  EqmLiveActivityUtilProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqmLiveActivityUtilProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqmLiveActivityUtilHash();

  @$internal
  @override
  $ProviderElement<EQMLiveActivityUtil> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EQMLiveActivityUtil create(Ref ref) {
    return eqmLiveActivityUtil(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EQMLiveActivityUtil value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EQMLiveActivityUtil>(value),
    );
  }
}

String _$eqmLiveActivityUtilHash() =>
    r'1189fc2c4b653798415391465004bafb0f9e721c';
