// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_timer_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// `latest.json` を定期的に取得し、サーバ時刻と端末時計のずれを測り続ける。
///
/// 単発の測定では往復時間のゆらぎがそのまま残るため、往復時間とずれの
/// どちらもトリム平均 (直近5件から最小・最大を除いた平均) で扱う。

@ProviderFor(KyoshinMonitorTimerNotifier)
final kyoshinMonitorTimerProvider = KyoshinMonitorTimerNotifierProvider._();

/// `latest.json` を定期的に取得し、サーバ時刻と端末時計のずれを測り続ける。
///
/// 単発の測定では往復時間のゆらぎがそのまま残るため、往復時間とずれの
/// どちらもトリム平均 (直近5件から最小・最大を除いた平均) で扱う。
final class KyoshinMonitorTimerNotifierProvider
    extends
        $StreamNotifierProvider<
          KyoshinMonitorTimerNotifier,
          KyoshinMonitorTimerState
        > {
  /// `latest.json` を定期的に取得し、サーバ時刻と端末時計のずれを測り続ける。
  ///
  /// 単発の測定では往復時間のゆらぎがそのまま残るため、往復時間とずれの
  /// どちらもトリム平均 (直近5件から最小・最大を除いた平均) で扱う。
  KyoshinMonitorTimerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorTimerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorTimerNotifierHash();

  @$internal
  @override
  KyoshinMonitorTimerNotifier create() => KyoshinMonitorTimerNotifier();
}

String _$kyoshinMonitorTimerNotifierHash() =>
    r'b813ee35518589098a9cefbeea7f75176dc9bcd7';

/// `latest.json` を定期的に取得し、サーバ時刻と端末時計のずれを測り続ける。
///
/// 単発の測定では往復時間のゆらぎがそのまま残るため、往復時間とずれの
/// どちらもトリム平均 (直近5件から最小・最大を除いた平均) で扱う。

abstract class _$KyoshinMonitorTimerNotifier
    extends $StreamNotifier<KyoshinMonitorTimerState> {
  Stream<KyoshinMonitorTimerState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<KyoshinMonitorTimerState>,
              KyoshinMonitorTimerState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<KyoshinMonitorTimerState>,
                KyoshinMonitorTimerState
              >,
              AsyncValue<KyoshinMonitorTimerState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
