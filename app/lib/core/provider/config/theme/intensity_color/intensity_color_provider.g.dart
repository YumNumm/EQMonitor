// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_color_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IntensityColor)
final intensityColorProvider = IntensityColorProvider._();

final class IntensityColorProvider
    extends $NotifierProvider<IntensityColor, IntensityColorModel> {
  IntensityColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'intensityColorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$intensityColorHash();

  @$internal
  @override
  IntensityColor create() => IntensityColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IntensityColorModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IntensityColorModel>(value),
    );
  }
}

String _$intensityColorHash() => r'9c5f1148d0001d84e37f1a0bb14d65cdaee14795';

abstract class _$IntensityColor extends $Notifier<IntensityColorModel> {
  IntensityColorModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<IntensityColorModel, IntensityColorModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IntensityColorModel, IntensityColorModel>,
              IntensityColorModel,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
