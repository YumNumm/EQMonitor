// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_live_activity_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugLiveActivityRepository)
final debugLiveActivityRepositoryProvider =
    DebugLiveActivityRepositoryProvider._();

final class DebugLiveActivityRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<DebugLiveActivityRepository>,
          DebugLiveActivityRepository,
          FutureOr<DebugLiveActivityRepository>
        >
    with
        $FutureModifier<DebugLiveActivityRepository>,
        $FutureProvider<DebugLiveActivityRepository> {
  DebugLiveActivityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugLiveActivityRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugLiveActivityRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<DebugLiveActivityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DebugLiveActivityRepository> create(Ref ref) {
    return debugLiveActivityRepository(ref);
  }
}

String _$debugLiveActivityRepositoryHash() =>
    r'f0d79d397cb2b9320c812bdf4f7f2a05401b5adb';
