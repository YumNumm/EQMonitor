// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_live_activity_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(testLiveActivityRepository)
final testLiveActivityRepositoryProvider =
    TestLiveActivityRepositoryProvider._();

final class TestLiveActivityRepositoryProvider
    extends
        $FunctionalProvider<
          TestLiveActivityRepository,
          TestLiveActivityRepository,
          TestLiveActivityRepository
        >
    with $Provider<TestLiveActivityRepository> {
  TestLiveActivityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testLiveActivityRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testLiveActivityRepositoryHash();

  @$internal
  @override
  $ProviderElement<TestLiveActivityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TestLiveActivityRepository create(Ref ref) {
    return testLiveActivityRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TestLiveActivityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TestLiveActivityRepository>(value),
    );
  }
}

String _$testLiveActivityRepositoryHash() =>
    r'a4b7b8ab0caeaa1a00aae253e7fddec36c8856e8';
