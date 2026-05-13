// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_ws_stream_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eqmonitorWsStream)
final eqmonitorWsStreamProvider = EqmonitorWsStreamProvider._();

final class EqmonitorWsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<WebSocketEvent>,
          WebSocketEvent,
          Stream<WebSocketEvent>
        >
    with $FutureModifier<WebSocketEvent>, $StreamProvider<WebSocketEvent> {
  EqmonitorWsStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqmonitorWsStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqmonitorWsStreamHash();

  @$internal
  @override
  $StreamProviderElement<WebSocketEvent> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<WebSocketEvent> create(Ref ref) {
    return eqmonitorWsStream(ref);
  }
}

String _$eqmonitorWsStreamHash() => r'8167bab73cbf3e7c275bc165942feb69494ef6c2';
