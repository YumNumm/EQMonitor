// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'intensity_color_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(IntensityColor)
const intensityColorProvider = IntensityColorProvider._();

final class IntensityColorProvider
    extends $NotifierProvider<IntensityColor, IntensityColorModel> {
  const IntensityColorProvider._()
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
    final created = build();
    final ref = this.ref as $Ref<IntensityColorModel, IntensityColorModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IntensityColorModel, IntensityColorModel>,
              IntensityColorModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
