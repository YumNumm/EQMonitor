// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_live_activity_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(testLiveActivityAction)
final testLiveActivityActionProvider = TestLiveActivityActionProvider._();

final class TestLiveActivityActionProvider
    extends
        $FunctionalProvider<
          TestLiveActivityAction,
          TestLiveActivityAction,
          TestLiveActivityAction
        >
    with $Provider<TestLiveActivityAction> {
  TestLiveActivityActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testLiveActivityActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testLiveActivityActionHash();

  @$internal
  @override
  $ProviderElement<TestLiveActivityAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TestLiveActivityAction create(Ref ref) {
    return testLiveActivityAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TestLiveActivityAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TestLiveActivityAction>(value),
    );
  }
}

String _$testLiveActivityActionHash() =>
    r'cd08e2e5f977a7e49dd326442a79c8b78f1f95a2';
