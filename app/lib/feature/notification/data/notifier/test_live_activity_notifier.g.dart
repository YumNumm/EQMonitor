// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_live_activity_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TestLiveActivityNotifier)
final testLiveActivityProvider = TestLiveActivityNotifierProvider._();

final class TestLiveActivityNotifierProvider
    extends
        $AsyncNotifierProvider<
          TestLiveActivityNotifier,
          TestLiveActivityStatus
        > {
  TestLiveActivityNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testLiveActivityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testLiveActivityNotifierHash();

  @$internal
  @override
  TestLiveActivityNotifier create() => TestLiveActivityNotifier();
}

String _$testLiveActivityNotifierHash() =>
    r'dbd2375f66b2275a93bd0e28fc2e723f0d4d0b71';

abstract class _$TestLiveActivityNotifier
    extends $AsyncNotifier<TestLiveActivityStatus> {
  FutureOr<TestLiveActivityStatus> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<TestLiveActivityStatus>, TestLiveActivityStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<TestLiveActivityStatus>,
                TestLiveActivityStatus
              >,
              AsyncValue<TestLiveActivityStatus>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
