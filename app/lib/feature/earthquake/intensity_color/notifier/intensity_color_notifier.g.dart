// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'intensity_color_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(IntensityColorNotifier)
const intensityColorNotifierProvider = IntensityColorNotifierProvider._();

final class IntensityColorNotifierProvider
    extends
        $NotifierProvider<IntensityColorNotifier, IntensityColorConfiguration> {
  const IntensityColorNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'intensityColorNotifierProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$intensityColorNotifierHash();

  @$internal
  @override
  IntensityColorNotifier create() => IntensityColorNotifier();

  @$internal
  @override
  $NotifierProviderElement<IntensityColorNotifier, IntensityColorConfiguration>
  $createElement($ProviderPointer pointer) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IntensityColorConfiguration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<IntensityColorConfiguration>(value),
    );
  }
}

String _$intensityColorNotifierHash() =>
    r'e2fde0c2ea5f2b6eee53060b3f64c731154a5911';

abstract class _$IntensityColorNotifier
    extends $Notifier<IntensityColorConfiguration> {
  IntensityColorConfiguration build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<IntensityColorConfiguration>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IntensityColorConfiguration>,
              IntensityColorConfiguration,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
