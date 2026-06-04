// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'auto_return_watcher.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// タイムシフト/リプレイ再生中に、ライブのリアルタイムイベント（EEW・揺れ検知）が
/// 発生したら通常再生へ自動復帰させる常駐ウォッチャ。
///
/// リプレイ中は `eewProvider` 等がライブ受信を遮断するため、ここでは
/// ライブの [realtimeEventsProvider] を直接購読してモード遷移のみを判断する。
/// `main` で起動時に常駐させる。

@ProviderFor(AutoReturnWatcher)
final autoReturnWatcherProvider = AutoReturnWatcherProvider._();

/// タイムシフト/リプレイ再生中に、ライブのリアルタイムイベント（EEW・揺れ検知）が
/// 発生したら通常再生へ自動復帰させる常駐ウォッチャ。
///
/// リプレイ中は `eewProvider` 等がライブ受信を遮断するため、ここでは
/// ライブの [realtimeEventsProvider] を直接購読してモード遷移のみを判断する。
/// `main` で起動時に常駐させる。
final class AutoReturnWatcherProvider
    extends $NotifierProvider<AutoReturnWatcher, void> {
  /// タイムシフト/リプレイ再生中に、ライブのリアルタイムイベント（EEW・揺れ検知）が
  /// 発生したら通常再生へ自動復帰させる常駐ウォッチャ。
  ///
  /// リプレイ中は `eewProvider` 等がライブ受信を遮断するため、ここでは
  /// ライブの [realtimeEventsProvider] を直接購読してモード遷移のみを判断する。
  /// `main` で起動時に常駐させる。
  AutoReturnWatcherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'autoReturnWatcherProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$autoReturnWatcherHash();

  @$internal
  @override
  AutoReturnWatcher create() => AutoReturnWatcher();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$autoReturnWatcherHash() => r'252dead45710689bf4a7c0c66baddef3637eed15';

/// タイムシフト/リプレイ再生中に、ライブのリアルタイムイベント（EEW・揺れ検知）が
/// 発生したら通常再生へ自動復帰させる常駐ウォッチャ。
///
/// リプレイ中は `eewProvider` 等がライブ受信を遮断するため、ここでは
/// ライブの [realtimeEventsProvider] を直接購読してモード遷移のみを判断する。
/// `main` で起動時に常駐させる。

abstract class _$AutoReturnWatcher extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
