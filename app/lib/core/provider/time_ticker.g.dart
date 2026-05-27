// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'time_ticker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// [duration] 周期で現在時刻を配信するティッカー。
///
/// 時刻は [AppClock] を経由するため、再生モード（通常/タイムシフト/リプレイ）と
/// NTP 補正に追従する。各 tick で [AppClock] の現在時刻を読むため、
/// リプレイ中の再生位置更新では張り直さず、リプレイ開始/終了と NTP 同期時のみ
/// ストリームを張り直す（毎フレーム張り直しによる周期停止を防ぐ）。

@ProviderFor(timeTicker)
final timeTickerProvider = TimeTickerFamily._();

/// [duration] 周期で現在時刻を配信するティッカー。
///
/// 時刻は [AppClock] を経由するため、再生モード（通常/タイムシフト/リプレイ）と
/// NTP 補正に追従する。各 tick で [AppClock] の現在時刻を読むため、
/// リプレイ中の再生位置更新では張り直さず、リプレイ開始/終了と NTP 同期時のみ
/// ストリームを張り直す（毎フレーム張り直しによる周期停止を防ぐ）。

final class TimeTickerProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime>, DateTime, Stream<DateTime>>
    with $FutureModifier<DateTime>, $StreamProvider<DateTime> {
  /// [duration] 周期で現在時刻を配信するティッカー。
  ///
  /// 時刻は [AppClock] を経由するため、再生モード（通常/タイムシフト/リプレイ）と
  /// NTP 補正に追従する。各 tick で [AppClock] の現在時刻を読むため、
  /// リプレイ中の再生位置更新では張り直さず、リプレイ開始/終了と NTP 同期時のみ
  /// ストリームを張り直す（毎フレーム張り直しによる周期停止を防ぐ）。
  TimeTickerProvider._({
    required TimeTickerFamily super.from,
    required Duration super.argument,
  }) : super(
         retry: null,
         name: r'timeTickerProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$timeTickerHash();

  @override
  String toString() {
    return r'timeTickerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DateTime> create(Ref ref) {
    final argument = this.argument as Duration;
    return timeTicker(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TimeTickerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$timeTickerHash() => r'3a0f645f3e86df31a145fad4d20be52845feb2ac';

/// [duration] 周期で現在時刻を配信するティッカー。
///
/// 時刻は [AppClock] を経由するため、再生モード（通常/タイムシフト/リプレイ）と
/// NTP 補正に追従する。各 tick で [AppClock] の現在時刻を読むため、
/// リプレイ中の再生位置更新では張り直さず、リプレイ開始/終了と NTP 同期時のみ
/// ストリームを張り直す（毎フレーム張り直しによる周期停止を防ぐ）。

final class TimeTickerFamily extends $Family
    with $FunctionalFamilyOverride<Stream<DateTime>, Duration> {
  TimeTickerFamily._()
    : super(
        retry: null,
        name: r'timeTickerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// [duration] 周期で現在時刻を配信するティッカー。
  ///
  /// 時刻は [AppClock] を経由するため、再生モード（通常/タイムシフト/リプレイ）と
  /// NTP 補正に追従する。各 tick で [AppClock] の現在時刻を読むため、
  /// リプレイ中の再生位置更新では張り直さず、リプレイ開始/終了と NTP 同期時のみ
  /// ストリームを張り直す（毎フレーム張り直しによる周期停止を防ぐ）。

  TimeTickerProvider call([Duration duration = const Duration(seconds: 1)]) =>
      TimeTickerProvider._(argument: duration, from: this);

  @override
  String toString() => r'timeTickerProvider';
}
