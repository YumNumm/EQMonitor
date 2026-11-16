// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_debug_report_builder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionDebugReportBuilder)
final shakeDetectionDebugReportBuilderProvider =
    ShakeDetectionDebugReportBuilderProvider._();

final class ShakeDetectionDebugReportBuilderProvider
    extends
        $FunctionalProvider<
          ShakeDetectionDebugReportBuilder,
          ShakeDetectionDebugReportBuilder,
          ShakeDetectionDebugReportBuilder
        >
    with $Provider<ShakeDetectionDebugReportBuilder> {
  ShakeDetectionDebugReportBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionDebugReportBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionDebugReportBuilderHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionDebugReportBuilder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionDebugReportBuilder create(Ref ref) {
    return shakeDetectionDebugReportBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionDebugReportBuilder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionDebugReportBuilder>(
        value,
      ),
    );
  }
}

String _$shakeDetectionDebugReportBuilderHash() =>
    r'e9fdafb4e8db2790614334bd2a9f71c982f28909';
