// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_live_activity_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// テスト表示を自動で終了する時刻。アプリを再起動すると失われる。

@ProviderFor(TestLiveActivityDeadline)
final testLiveActivityDeadlineProvider = TestLiveActivityDeadlineProvider._();

/// テスト表示を自動で終了する時刻。アプリを再起動すると失われる。
final class TestLiveActivityDeadlineProvider
    extends $NotifierProvider<TestLiveActivityDeadline, DateTime?> {
  /// テスト表示を自動で終了する時刻。アプリを再起動すると失われる。
  TestLiveActivityDeadlineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testLiveActivityDeadlineProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testLiveActivityDeadlineHash();

  @$internal
  @override
  TestLiveActivityDeadline create() => TestLiveActivityDeadline();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime?>(value),
    );
  }
}

String _$testLiveActivityDeadlineHash() =>
    r'a30e88a9dd38d277352c2aa296893b16714ce46d';

/// テスト表示を自動で終了する時刻。アプリを再起動すると失われる。

abstract class _$TestLiveActivityDeadline extends $Notifier<DateTime?> {
  DateTime? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DateTime?, DateTime?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime?, DateTime?>,
              DateTime?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

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
        isAutoDispose: false,
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
    r'0653cb593c9ef69b92b30d1c8605e85cd6758a8c';

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
