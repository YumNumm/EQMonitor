// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 地域別最大震度マップのフォーカス状態を管理する Notifier。
///
/// - 初期状態は [IntensityHistoryStatePrefecture]（Lv1 全都道府県表示）。
/// - [focusPrefecture] で [IntensityHistoryStateCity]（Lv2）に遷移。
/// - [backToPrefecture] で Lv1 に戻る。

@ProviderFor(IntensityHistoryController)
final intensityHistoryControllerProvider =
    IntensityHistoryControllerProvider._();

/// 地域別最大震度マップのフォーカス状態を管理する Notifier。
///
/// - 初期状態は [IntensityHistoryStatePrefecture]（Lv1 全都道府県表示）。
/// - [focusPrefecture] で [IntensityHistoryStateCity]（Lv2）に遷移。
/// - [backToPrefecture] で Lv1 に戻る。
final class IntensityHistoryControllerProvider
    extends
        $NotifierProvider<IntensityHistoryController, IntensityHistoryState> {
  /// 地域別最大震度マップのフォーカス状態を管理する Notifier。
  ///
  /// - 初期状態は [IntensityHistoryStatePrefecture]（Lv1 全都道府県表示）。
  /// - [focusPrefecture] で [IntensityHistoryStateCity]（Lv2）に遷移。
  /// - [backToPrefecture] で Lv1 に戻る。
  IntensityHistoryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'intensityHistoryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$intensityHistoryControllerHash();

  @$internal
  @override
  IntensityHistoryController create() => IntensityHistoryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IntensityHistoryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IntensityHistoryState>(value),
    );
  }
}

String _$intensityHistoryControllerHash() =>
    r'39ac4878f184430a09694268de5b16fbb76b1bca';

/// 地域別最大震度マップのフォーカス状態を管理する Notifier。
///
/// - 初期状態は [IntensityHistoryStatePrefecture]（Lv1 全都道府県表示）。
/// - [focusPrefecture] で [IntensityHistoryStateCity]（Lv2）に遷移。
/// - [backToPrefecture] で Lv1 に戻る。

abstract class _$IntensityHistoryController
    extends $Notifier<IntensityHistoryState> {
  IntensityHistoryState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<IntensityHistoryState, IntensityHistoryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IntensityHistoryState, IntensityHistoryState>,
              IntensityHistoryState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
