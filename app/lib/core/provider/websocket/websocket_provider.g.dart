// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'websocket_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SseConnection)
final sseConnectionProvider = SseConnectionProvider._();

final class SseConnectionProvider
    extends $StreamNotifierProvider<SseConnection, Map<String, dynamic>> {
  SseConnectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sseConnectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sseConnectionHash();

  @$internal
  @override
  SseConnection create() => SseConnection();
}

String _$sseConnectionHash() => r'b3327095591ced5256de3b170d90a1c9e3e44fdb';

abstract class _$SseConnection extends $StreamNotifier<Map<String, dynamic>> {
  Stream<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, dynamic>>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>>,
                Map<String, dynamic>
              >,
              AsyncValue<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SseConnectionStatus)
final sseConnectionStatusProvider = SseConnectionStatusProvider._();

final class SseConnectionStatusProvider
    extends $NotifierProvider<SseConnectionStatus, SseConnectionState> {
  SseConnectionStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sseConnectionStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sseConnectionStatusHash();

  @$internal
  @override
  SseConnectionStatus create() => SseConnectionStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SseConnectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SseConnectionState>(value),
    );
  }
}

String _$sseConnectionStatusHash() =>
    r'8a101020be906071cf4634947b62d2ba0f205d39';

abstract class _$SseConnectionStatus extends $Notifier<SseConnectionState> {
  SseConnectionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SseConnectionState, SseConnectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SseConnectionState, SseConnectionState>,
              SseConnectionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
