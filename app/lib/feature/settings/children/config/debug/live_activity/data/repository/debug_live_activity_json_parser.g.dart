// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_live_activity_json_parser.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugLiveActivityJsonParser)
final debugLiveActivityJsonParserProvider =
    DebugLiveActivityJsonParserProvider._();

final class DebugLiveActivityJsonParserProvider
    extends
        $FunctionalProvider<
          DebugLiveActivityJsonParser,
          DebugLiveActivityJsonParser,
          DebugLiveActivityJsonParser
        >
    with $Provider<DebugLiveActivityJsonParser> {
  DebugLiveActivityJsonParserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugLiveActivityJsonParserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugLiveActivityJsonParserHash();

  @$internal
  @override
  $ProviderElement<DebugLiveActivityJsonParser> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugLiveActivityJsonParser create(Ref ref) {
    return debugLiveActivityJsonParser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugLiveActivityJsonParser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugLiveActivityJsonParser>(value),
    );
  }
}

String _$debugLiveActivityJsonParserHash() =>
    r'abff57d62a2905d09fad3f5c6d3f9134ce8b24ef';
