// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_ws_ping_probe.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// クライアント起因 ping を送出し、往復時間 (RTT) を計測する。
///
/// サーバー起因 ping (`{"type":"ping"}` を 15 秒ごと) は接続の生存確認であり
/// pingId を持たないため、クライアント側から RTT を求められない。そこで
/// `{"type":"ping","pingId":...}` を自分から送り、echo された
/// `{"type":"pong","pingId":...}` との時間差を測る。
///
/// autoDispose。watch されている間だけ ping を送るので、デバッグ画面を閉じれば
/// 計測トラフィックも止まる。
///
/// state は「現在の接続で最後に計測できた RTT」。再接続すると build が
/// 再実行されて null に戻るため、切断をまたいだ値が表示され続けることはない。
/// pong を返さないサーバーに繋がっている場合も null のままになる。

@ProviderFor(EqmonitorWsPingProbe)
final eqmonitorWsPingProbeProvider = EqmonitorWsPingProbeProvider._();

/// クライアント起因 ping を送出し、往復時間 (RTT) を計測する。
///
/// サーバー起因 ping (`{"type":"ping"}` を 15 秒ごと) は接続の生存確認であり
/// pingId を持たないため、クライアント側から RTT を求められない。そこで
/// `{"type":"ping","pingId":...}` を自分から送り、echo された
/// `{"type":"pong","pingId":...}` との時間差を測る。
///
/// autoDispose。watch されている間だけ ping を送るので、デバッグ画面を閉じれば
/// 計測トラフィックも止まる。
///
/// state は「現在の接続で最後に計測できた RTT」。再接続すると build が
/// 再実行されて null に戻るため、切断をまたいだ値が表示され続けることはない。
/// pong を返さないサーバーに繋がっている場合も null のままになる。
final class EqmonitorWsPingProbeProvider
    extends $NotifierProvider<EqmonitorWsPingProbe, WsRttSample?> {
  /// クライアント起因 ping を送出し、往復時間 (RTT) を計測する。
  ///
  /// サーバー起因 ping (`{"type":"ping"}` を 15 秒ごと) は接続の生存確認であり
  /// pingId を持たないため、クライアント側から RTT を求められない。そこで
  /// `{"type":"ping","pingId":...}` を自分から送り、echo された
  /// `{"type":"pong","pingId":...}` との時間差を測る。
  ///
  /// autoDispose。watch されている間だけ ping を送るので、デバッグ画面を閉じれば
  /// 計測トラフィックも止まる。
  ///
  /// state は「現在の接続で最後に計測できた RTT」。再接続すると build が
  /// 再実行されて null に戻るため、切断をまたいだ値が表示され続けることはない。
  /// pong を返さないサーバーに繋がっている場合も null のままになる。
  EqmonitorWsPingProbeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqmonitorWsPingProbeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqmonitorWsPingProbeHash();

  @$internal
  @override
  EqmonitorWsPingProbe create() => EqmonitorWsPingProbe();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WsRttSample? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WsRttSample?>(value),
    );
  }
}

String _$eqmonitorWsPingProbeHash() =>
    r'14db96f94ad9ff95725d03f1f57607f3bdc13011';

/// クライアント起因 ping を送出し、往復時間 (RTT) を計測する。
///
/// サーバー起因 ping (`{"type":"ping"}` を 15 秒ごと) は接続の生存確認であり
/// pingId を持たないため、クライアント側から RTT を求められない。そこで
/// `{"type":"ping","pingId":...}` を自分から送り、echo された
/// `{"type":"pong","pingId":...}` との時間差を測る。
///
/// autoDispose。watch されている間だけ ping を送るので、デバッグ画面を閉じれば
/// 計測トラフィックも止まる。
///
/// state は「現在の接続で最後に計測できた RTT」。再接続すると build が
/// 再実行されて null に戻るため、切断をまたいだ値が表示され続けることはない。
/// pong を返さないサーバーに繋がっている場合も null のままになる。

abstract class _$EqmonitorWsPingProbe extends $Notifier<WsRttSample?> {
  WsRttSample? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<WsRttSample?, WsRttSample?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WsRttSample?, WsRttSample?>,
              WsRttSample?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
