// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_live_activity_json_codec.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugLiveActivityJsonCodec)
final debugLiveActivityJsonCodecProvider =
    DebugLiveActivityJsonCodecProvider._();

final class DebugLiveActivityJsonCodecProvider
    extends
        $FunctionalProvider<
          DebugLiveActivityJsonCodec,
          DebugLiveActivityJsonCodec,
          DebugLiveActivityJsonCodec
        >
    with $Provider<DebugLiveActivityJsonCodec> {
  DebugLiveActivityJsonCodecProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugLiveActivityJsonCodecProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugLiveActivityJsonCodecHash();

  @$internal
  @override
  $ProviderElement<DebugLiveActivityJsonCodec> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugLiveActivityJsonCodec create(Ref ref) {
    return debugLiveActivityJsonCodec(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugLiveActivityJsonCodec value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugLiveActivityJsonCodec>(value),
    );
  }
}

String _$debugLiveActivityJsonCodecHash() =>
    r'cd1dfe631db7d78734fa5d260629c1ea8859de60';
