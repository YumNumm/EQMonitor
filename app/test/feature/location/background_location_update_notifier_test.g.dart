// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'background_location_update_notifier_test.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(testApplyLiveLocation)
final testApplyLiveLocationProvider = TestApplyLiveLocationProvider._();

final class TestApplyLiveLocationProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  TestApplyLiveLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testApplyLiveLocationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testApplyLiveLocationHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return testApplyLiveLocation(ref);
  }
}

String _$testApplyLiveLocationHash() =>
    r'219a349ecd958b34e29cb553b136eae061509b0d';

@ProviderFor(testApplyPendingLocation)
final testApplyPendingLocationProvider = TestApplyPendingLocationProvider._();

final class TestApplyPendingLocationProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  TestApplyPendingLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testApplyPendingLocationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testApplyPendingLocationHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return testApplyPendingLocation(ref);
  }
}

String _$testApplyPendingLocationHash() =>
    r'66758d4d0269b71a4700a9386cc63625a3b84373';

@ProviderFor(testEnsureMonitoring)
final testEnsureMonitoringProvider = TestEnsureMonitoringProvider._();

final class TestEnsureMonitoringProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  TestEnsureMonitoringProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testEnsureMonitoringProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testEnsureMonitoringHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return testEnsureMonitoring(ref);
  }
}

String _$testEnsureMonitoringHash() =>
    r'624bc65ae09990a7e828c7756f31dbae695c7a7e';

@ProviderFor(testApplyPendingLocationWithCoordinator)
final testApplyPendingLocationWithCoordinatorProvider =
    TestApplyPendingLocationWithCoordinatorFamily._();

final class TestApplyPendingLocationWithCoordinatorProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  TestApplyPendingLocationWithCoordinatorProvider._({
    required TestApplyPendingLocationWithCoordinatorFamily super.from,
    required BackgroundLocationSyncCoordinator super.argument,
  }) : super(
         retry: null,
         name: r'testApplyPendingLocationWithCoordinatorProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() =>
      _$testApplyPendingLocationWithCoordinatorHash();

  @override
  String toString() {
    return r'testApplyPendingLocationWithCoordinatorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as BackgroundLocationSyncCoordinator;
    return testApplyPendingLocationWithCoordinator(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TestApplyPendingLocationWithCoordinatorProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$testApplyPendingLocationWithCoordinatorHash() =>
    r'e1a3185b7cd001fae123765e0ef9b40e002880d7';

final class TestApplyPendingLocationWithCoordinatorFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<void>,
          BackgroundLocationSyncCoordinator
        > {
  TestApplyPendingLocationWithCoordinatorFamily._()
    : super(
        retry: null,
        name: r'testApplyPendingLocationWithCoordinatorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  TestApplyPendingLocationWithCoordinatorProvider call(
    BackgroundLocationSyncCoordinator coordinator,
  ) => TestApplyPendingLocationWithCoordinatorProvider._(
    argument: coordinator,
    from: this,
  );

  @override
  String toString() => r'testApplyPendingLocationWithCoordinatorProvider';
}

@ProviderFor(testApplyPendingMessage)
final testApplyPendingMessageProvider = TestApplyPendingMessageFamily._();

final class TestApplyPendingMessageProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  TestApplyPendingMessageProvider._({
    required TestApplyPendingMessageFamily super.from,
    required PendingLocationMessage super.argument,
  }) : super(
         retry: null,
         name: r'testApplyPendingMessageProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$testApplyPendingMessageHash();

  @override
  String toString() {
    return r'testApplyPendingMessageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as PendingLocationMessage;
    return testApplyPendingMessage(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TestApplyPendingMessageProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$testApplyPendingMessageHash() =>
    r'554e84010f199226d2f3464c91437e73f3920d57';

final class TestApplyPendingMessageFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, PendingLocationMessage> {
  TestApplyPendingMessageFamily._()
    : super(
        retry: null,
        name: r'testApplyPendingMessageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  TestApplyPendingMessageProvider call(PendingLocationMessage pending) =>
      TestApplyPendingMessageProvider._(argument: pending, from: this);

  @override
  String toString() => r'testApplyPendingMessageProvider';
}
