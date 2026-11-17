// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'subscription_pending_retry.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 購入情報の反映を自動で再試行している間、その再試行の番号を持つ。
///
/// 再試行していない間は `null`。反映待ちの案内で、手動の同期を出すかの判断に使う。

@ProviderFor(SubscriptionPendingRetry)
final subscriptionPendingRetryProvider = SubscriptionPendingRetryProvider._();

/// 購入情報の反映を自動で再試行している間、その再試行の番号を持つ。
///
/// 再試行していない間は `null`。反映待ちの案内で、手動の同期を出すかの判断に使う。
final class SubscriptionPendingRetryProvider
    extends $NotifierProvider<SubscriptionPendingRetry, int?> {
  /// 購入情報の反映を自動で再試行している間、その再試行の番号を持つ。
  ///
  /// 再試行していない間は `null`。反映待ちの案内で、手動の同期を出すかの判断に使う。
  SubscriptionPendingRetryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionPendingRetryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionPendingRetryHash();

  @$internal
  @override
  SubscriptionPendingRetry create() => SubscriptionPendingRetry();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$subscriptionPendingRetryHash() =>
    r'893cd6096075e758017057a0c99c6333a29be2a8';

/// 購入情報の反映を自動で再試行している間、その再試行の番号を持つ。
///
/// 再試行していない間は `null`。反映待ちの案内で、手動の同期を出すかの判断に使う。

abstract class _$SubscriptionPendingRetry extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
