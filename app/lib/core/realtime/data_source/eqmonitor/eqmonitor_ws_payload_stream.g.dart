// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_ws_payload_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 受信フレームを [WsMessage] にパースして流す。

@ProviderFor(EqmonitorWsPayloadStream)
final eqmonitorWsPayloadStreamProvider = EqmonitorWsPayloadStreamProvider._();

/// 受信フレームを [WsMessage] にパースして流す。
final class EqmonitorWsPayloadStreamProvider
    extends $StreamNotifierProvider<EqmonitorWsPayloadStream, WsMessage> {
  /// 受信フレームを [WsMessage] にパースして流す。
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
  EqmonitorWsPayloadStream create() => EqmonitorWsPayloadStream();
}

String _$eqmonitorWsPayloadStreamHash() =>
    r'caa58b05bed949449c6ab777b9866af3a118515d';

/// 受信フレームを [WsMessage] にパースして流す。

abstract class _$EqmonitorWsPayloadStream extends $StreamNotifier<WsMessage> {
  Stream<WsMessage> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<WsMessage>, WsMessage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WsMessage>, WsMessage>,
              AsyncValue<WsMessage>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
