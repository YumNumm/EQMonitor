// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_debug_report_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// デバッグ表示を出している間だけ計算する。

@ProviderFor(shakeDetectionDebugReport)
final shakeDetectionDebugReportProvider = ShakeDetectionDebugReportProvider._();

/// デバッグ表示を出している間だけ計算する。

final class ShakeDetectionDebugReportProvider
    extends
        $FunctionalProvider<
          ShakeDetectionDebugReport,
          ShakeDetectionDebugReport,
          ShakeDetectionDebugReport
        >
    with $Provider<ShakeDetectionDebugReport> {
  /// デバッグ表示を出している間だけ計算する。
  ShakeDetectionDebugReportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionDebugReportProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionDebugReportHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionDebugReport> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionDebugReport create(Ref ref) {
    return shakeDetectionDebugReport(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionDebugReport value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionDebugReport>(value),
    );
  }
}

String _$shakeDetectionDebugReportHash() =>
    r'6f8507dc9a66519886fe221d30d85d4b18733102';
