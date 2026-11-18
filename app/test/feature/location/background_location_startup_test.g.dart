// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'background_location_startup_test.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(testStartupEnsureMonitoring)
final testStartupEnsureMonitoringProvider =
    TestStartupEnsureMonitoringProvider._();

final class TestStartupEnsureMonitoringProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  TestStartupEnsureMonitoringProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testStartupEnsureMonitoringProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testStartupEnsureMonitoringHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return testStartupEnsureMonitoring(ref);
  }
}

String _$testStartupEnsureMonitoringHash() =>
    r'f187eb5b6bb84fd6fe18376191b282d6a9f7b1d4';
