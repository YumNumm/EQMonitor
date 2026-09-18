// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 市区町村別最大震度マップの選択状態を管理する Notifier。
///
/// 初期状態は未選択。[selectCity] / [deselectCity] で選択中の市区町村だけを
/// 出し入れする。

@ProviderFor(IntensityHistoryController)
final intensityHistoryControllerProvider =
    IntensityHistoryControllerProvider._();

/// 市区町村別最大震度マップの選択状態を管理する Notifier。
///
/// 初期状態は未選択。[selectCity] / [deselectCity] で選択中の市区町村だけを
/// 出し入れする。
final class IntensityHistoryControllerProvider
    extends
        $NotifierProvider<IntensityHistoryController, IntensityHistoryState> {
  /// 市区町村別最大震度マップの選択状態を管理する Notifier。
  ///
  /// 初期状態は未選択。[selectCity] / [deselectCity] で選択中の市区町村だけを
  /// 出し入れする。
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
    r'd316932cd1648577d1796ffc27196596add1e27d';

/// 市区町村別最大震度マップの選択状態を管理する Notifier。
///
/// 初期状態は未選択。[selectCity] / [deselectCity] で選択中の市区町村だけを
/// 出し入れする。

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
