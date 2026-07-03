// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'estimated_intensity_color_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EstimatedIntensityColor)
final estimatedIntensityColorProvider = EstimatedIntensityColorProvider._();

final class EstimatedIntensityColorProvider
    extends $NotifierProvider<EstimatedIntensityColor, IntensityColorModel> {
  EstimatedIntensityColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'estimatedIntensityColorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$estimatedIntensityColorHash();

  @$internal
  @override
  EstimatedIntensityColor create() => EstimatedIntensityColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IntensityColorModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IntensityColorModel>(value),
    );
  }
}

String _$estimatedIntensityColorHash() =>
    r'9cf9d19d057e0dff769a168bc43603fa5a4dd769';

abstract class _$EstimatedIntensityColor
    extends $Notifier<IntensityColorModel> {
  IntensityColorModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<IntensityColorModel, IntensityColorModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IntensityColorModel, IntensityColorModel>,
              IntensityColorModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
