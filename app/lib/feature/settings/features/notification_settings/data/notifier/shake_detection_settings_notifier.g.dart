// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 揺れ検知の通知条件。
///
/// 起動時には構築しない。設定値が必要になった画面が watch したときに
/// サーバーから取得する。位置情報監視の起動時の判定は、端末に保存した
/// 最後の値（`DeviceLocationConsumersRepository`）で行う。

@ProviderFor(ShakeDetectionSettingsNotifier)
final shakeDetectionSettingsProvider =
    ShakeDetectionSettingsNotifierProvider._();

/// 揺れ検知の通知条件。
///
/// 起動時には構築しない。設定値が必要になった画面が watch したときに
/// サーバーから取得する。位置情報監視の起動時の判定は、端末に保存した
/// 最後の値（`DeviceLocationConsumersRepository`）で行う。
final class ShakeDetectionSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          ShakeDetectionSettingsNotifier,
          ShakeDetectionState
        > {
  /// 揺れ検知の通知条件。
  ///
  /// 起動時には構築しない。設定値が必要になった画面が watch したときに
  /// サーバーから取得する。位置情報監視の起動時の判定は、端末に保存した
  /// 最後の値（`DeviceLocationConsumersRepository`）で行う。
  ShakeDetectionSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionSettingsNotifierHash();

  @$internal
  @override
  ShakeDetectionSettingsNotifier create() => ShakeDetectionSettingsNotifier();
}

String _$shakeDetectionSettingsNotifierHash() =>
    r'80c368680ddbf71a297c3e6aec82170dd0d9d07c';

/// 揺れ検知の通知条件。
///
/// 起動時には構築しない。設定値が必要になった画面が watch したときに
/// サーバーから取得する。位置情報監視の起動時の判定は、端末に保存した
/// 最後の値（`DeviceLocationConsumersRepository`）で行う。

abstract class _$ShakeDetectionSettingsNotifier
    extends $AsyncNotifier<ShakeDetectionState> {
  FutureOr<ShakeDetectionState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ShakeDetectionState>, ShakeDetectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ShakeDetectionState>, ShakeDetectionState>,
              AsyncValue<ShakeDetectionState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
