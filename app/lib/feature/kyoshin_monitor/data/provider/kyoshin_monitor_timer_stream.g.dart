// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_timer_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorTimerStream)
final kyoshinMonitorTimerStreamProvider = KyoshinMonitorTimerStreamProvider._();

final class KyoshinMonitorTimerStreamProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime>, DateTime, Stream<DateTime>>
    with $FutureModifier<DateTime>, $StreamProvider<DateTime> {
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
    r'0fb1faeb6a6caa57af18793eb33a4850911451e7';
