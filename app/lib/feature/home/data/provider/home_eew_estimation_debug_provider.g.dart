// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'home_eew_estimation_debug_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ホーム画面の推計震度・到達予想時刻の表示設定を変更できるかどうか。
///
/// Device API のロールが Admin であり、かつデバッグモードが有効な場合のみ true。

@ProviderFor(isHomeEewEstimationDebugAvailable)
final isHomeEewEstimationDebugAvailableProvider =
    IsHomeEewEstimationDebugAvailableProvider._();

/// ホーム画面の推計震度・到達予想時刻の表示設定を変更できるかどうか。
///
/// Device API のロールが Admin であり、かつデバッグモードが有効な場合のみ true。

final class IsHomeEewEstimationDebugAvailableProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// ホーム画面の推計震度・到達予想時刻の表示設定を変更できるかどうか。
  ///
  /// Device API のロールが Admin であり、かつデバッグモードが有効な場合のみ true。
  IsHomeEewEstimationDebugAvailableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isHomeEewEstimationDebugAvailableProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$isHomeEewEstimationDebugAvailableHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return isHomeEewEstimationDebugAvailable(ref);
  }
}

String _$isHomeEewEstimationDebugAvailableHash() =>
    r'1144b14eab0876a9654a0d28535af6a692ee2648';

/// ホーム画面のEEWカードに推計震度・到達予想時刻を表示するかどうか。
///
/// 設定が有効でも、変更権限を失った場合は表示しない。

@ProviderFor(isHomeEewEstimationVisible)
final isHomeEewEstimationVisibleProvider =
    IsHomeEewEstimationVisibleProvider._();

/// ホーム画面のEEWカードに推計震度・到達予想時刻を表示するかどうか。
///
/// 設定が有効でも、変更権限を失った場合は表示しない。

final class IsHomeEewEstimationVisibleProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// ホーム画面のEEWカードに推計震度・到達予想時刻を表示するかどうか。
  ///
  /// 設定が有効でも、変更権限を失った場合は表示しない。
  IsHomeEewEstimationVisibleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isHomeEewEstimationVisibleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isHomeEewEstimationVisibleHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return isHomeEewEstimationVisible(ref);
  }
}

String _$isHomeEewEstimationVisibleHash() =>
    r'ce484783483cbf50d68e1dfd6b874b2bcfe749e0';
