// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_offset_adjustment_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// データソース別の、`latest.json` 実測値からの補正量。
///
/// 画像取得の 404 / 成功をフィードバックとして受け取り、公開遅延の見積もりを
/// 詰めていく。値は設定へ永続化され、次回起動時は収束済みの状態から始まる。

@ProviderFor(KyoshinMonitorOffsetAdjustment)
final kyoshinMonitorOffsetAdjustmentProvider =
    KyoshinMonitorOffsetAdjustmentProvider._();

/// データソース別の、`latest.json` 実測値からの補正量。
///
/// 画像取得の 404 / 成功をフィードバックとして受け取り、公開遅延の見積もりを
/// 詰めていく。値は設定へ永続化され、次回起動時は収束済みの状態から始まる。
final class KyoshinMonitorOffsetAdjustmentProvider
    extends
        $NotifierProvider<
          KyoshinMonitorOffsetAdjustment,
          Map<KyoshinMonitorSource, Duration>
        > {
  /// データソース別の、`latest.json` 実測値からの補正量。
  ///
  /// 画像取得の 404 / 成功をフィードバックとして受け取り、公開遅延の見積もりを
  /// 詰めていく。値は設定へ永続化され、次回起動時は収束済みの状態から始まる。
  KyoshinMonitorOffsetAdjustmentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorOffsetAdjustmentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorOffsetAdjustmentHash();

  @$internal
  @override
  KyoshinMonitorOffsetAdjustment create() => KyoshinMonitorOffsetAdjustment();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<KyoshinMonitorSource, Duration> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<KyoshinMonitorSource, Duration>>(
        value,
      ),
    );
  }
}

String _$kyoshinMonitorOffsetAdjustmentHash() =>
    r'f70c14cd7befc0b38fa31659dd118b87b2b346e9';

/// データソース別の、`latest.json` 実測値からの補正量。
///
/// 画像取得の 404 / 成功をフィードバックとして受け取り、公開遅延の見積もりを
/// 詰めていく。値は設定へ永続化され、次回起動時は収束済みの状態から始まる。

abstract class _$KyoshinMonitorOffsetAdjustment
    extends $Notifier<Map<KyoshinMonitorSource, Duration>> {
  Map<KyoshinMonitorSource, Duration> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              Map<KyoshinMonitorSource, Duration>,
              Map<KyoshinMonitorSource, Duration>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<KyoshinMonitorSource, Duration>,
                Map<KyoshinMonitorSource, Duration>
              >,
              Map<KyoshinMonitorSource, Duration>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
