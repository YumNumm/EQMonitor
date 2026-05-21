// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_ws_payload_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eqmonitorWsPayloadStream)
final eqmonitorWsPayloadStreamProvider = EqmonitorWsPayloadStreamProvider._();

final class EqmonitorWsPayloadStreamProvider
    extends
        $FunctionalProvider<AsyncValue<WsMessage>, WsMessage, Stream<WsMessage>>
    with $FutureModifier<WsMessage>, $StreamProvider<WsMessage> {
  EqmonitorWsPayloadStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqmonitorWsPayloadStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqmonitorWsPayloadStreamHash();

  @$internal
  @override
  $StreamProviderElement<WsMessage> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<WsMessage> create(Ref ref) {
    return eqmonitorWsPayloadStream(ref);
  }
}

String _$eqmonitorWsPayloadStreamHash() =>
    r'd711623abbc83ab007a21570ab66e995bddeb93b';
