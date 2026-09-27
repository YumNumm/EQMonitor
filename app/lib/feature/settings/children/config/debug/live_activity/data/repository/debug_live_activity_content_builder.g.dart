// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_live_activity_content_builder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugLiveActivityContentBuilder)
final debugLiveActivityContentBuilderProvider =
    DebugLiveActivityContentBuilderProvider._();

final class DebugLiveActivityContentBuilderProvider
    extends
        $FunctionalProvider<
          DebugLiveActivityContentBuilder,
          DebugLiveActivityContentBuilder,
          DebugLiveActivityContentBuilder
        >
    with $Provider<DebugLiveActivityContentBuilder> {
  DebugLiveActivityContentBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugLiveActivityContentBuilderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugLiveActivityContentBuilderHash();

  @$internal
  @override
  $ProviderElement<DebugLiveActivityContentBuilder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugLiveActivityContentBuilder create(Ref ref) {
    return debugLiveActivityContentBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugLiveActivityContentBuilder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugLiveActivityContentBuilder>(
        value,
      ),
    );
  }
}

String _$debugLiveActivityContentBuilderHash() =>
    r'2275150a2582b07eed034d1287175f85dd45f884';
