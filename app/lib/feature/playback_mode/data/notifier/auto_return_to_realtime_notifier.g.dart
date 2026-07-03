// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'auto_return_to_realtime_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// タイムシフト/リプレイ再生中にリアルタイムの EEW・揺れ検知イベントが発生した際、
/// 通常再生（ライブ）へ自動的に戻すかどうかの設定。
///
/// 防災アプリの性質上、デフォルトは有効（戻す）。

@ProviderFor(AutoReturnToRealtimeNotifier)
final autoReturnToRealtimeProvider = AutoReturnToRealtimeNotifierProvider._();

/// タイムシフト/リプレイ再生中にリアルタイムの EEW・揺れ検知イベントが発生した際、
/// 通常再生（ライブ）へ自動的に戻すかどうかの設定。
///
/// 防災アプリの性質上、デフォルトは有効（戻す）。
final class AutoReturnToRealtimeNotifierProvider
    extends $NotifierProvider<AutoReturnToRealtimeNotifier, bool> {
  /// タイムシフト/リプレイ再生中にリアルタイムの EEW・揺れ検知イベントが発生した際、
  /// 通常再生（ライブ）へ自動的に戻すかどうかの設定。
  ///
  /// 防災アプリの性質上、デフォルトは有効（戻す）。
  AutoReturnToRealtimeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'autoReturnToRealtimeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$autoReturnToRealtimeNotifierHash();

  @$internal
  @override
  AutoReturnToRealtimeNotifier create() => AutoReturnToRealtimeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$autoReturnToRealtimeNotifierHash() =>
    r'19659d7582526b76108bfb8df2d427eb9c241b47';

/// タイムシフト/リプレイ再生中にリアルタイムの EEW・揺れ検知イベントが発生した際、
/// 通常再生（ライブ）へ自動的に戻すかどうかの設定。
///
/// 防災アプリの性質上、デフォルトは有効（戻す）。

abstract class _$AutoReturnToRealtimeNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
