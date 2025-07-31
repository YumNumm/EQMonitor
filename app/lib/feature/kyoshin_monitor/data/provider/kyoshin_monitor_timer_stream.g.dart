// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_timer_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(kyoshinMonitorTimerStream)
const kyoshinMonitorTimerStreamProvider = KyoshinMonitorTimerStreamProvider._();

final class KyoshinMonitorTimerStreamProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime>, DateTime, Stream<DateTime>>
    with $FutureModifier<DateTime>, $StreamProvider<DateTime> {
  const KyoshinMonitorTimerStreamProvider._()
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
    r'580f6e70bd5a356fbb93595e3eaba6337cfab128';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
