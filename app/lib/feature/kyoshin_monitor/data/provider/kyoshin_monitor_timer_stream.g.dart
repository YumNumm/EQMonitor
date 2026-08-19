// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_timer_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 強震モニタ画像の取得対象時刻を配信するストリーム。

@ProviderFor(kyoshinMonitorTimerStream)
final kyoshinMonitorTimerStreamProvider = KyoshinMonitorTimerStreamProvider._();

/// 強震モニタ画像の取得対象時刻を配信するストリーム。

final class KyoshinMonitorTimerStreamProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime>, DateTime, Stream<DateTime>>
    with $FutureModifier<DateTime>, $StreamProvider<DateTime> {
  /// 強震モニタ画像の取得対象時刻を配信するストリーム。
  KyoshinMonitorTimerStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorTimerStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorTimerStreamHash();

  @$internal
  @override
  $StreamProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DateTime> create(Ref ref) {
    return kyoshinMonitorTimerStream(ref);
  }
}

String _$kyoshinMonitorTimerStreamHash() =>
    r'c649a1af314c0e1c6ad5e5f484196d3a46221e5c';
