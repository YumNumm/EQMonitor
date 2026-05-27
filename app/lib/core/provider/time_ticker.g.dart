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
/// NTP 補正に追従する。モードや NTP offset が変化した場合はストリームを張り直す。

@ProviderFor(timeTicker)
final timeTickerProvider = TimeTickerFamily._();

/// [duration] 周期で現在時刻を配信するティッカー。
///
/// 時刻は [AppClock] を経由するため、再生モード（通常/タイムシフト/リプレイ）と
/// NTP 補正に追従する。モードや NTP offset が変化した場合はストリームを張り直す。

final class TimeTickerProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime>, DateTime, Stream<DateTime>>
    with $FutureModifier<DateTime>, $StreamProvider<DateTime> {
  /// [duration] 周期で現在時刻を配信するティッカー。
  ///
  /// 時刻は [AppClock] を経由するため、再生モード（通常/タイムシフト/リプレイ）と
  /// NTP 補正に追従する。モードや NTP offset が変化した場合はストリームを張り直す。
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

String _$timeTickerHash() => r'a3193d2c43a5d0925907de84e2b921e61347dae4';

/// [duration] 周期で現在時刻を配信するティッカー。
///
/// 時刻は [AppClock] を経由するため、再生モード（通常/タイムシフト/リプレイ）と
/// NTP 補正に追従する。モードや NTP offset が変化した場合はストリームを張り直す。

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
  /// NTP 補正に追従する。モードや NTP offset が変化した場合はストリームを張り直す。

  TimeTickerProvider call([Duration duration = const Duration(seconds: 1)]) =>
      TimeTickerProvider._(argument: duration, from: this);

  @override
  String toString() => r'timeTickerProvider';
}
