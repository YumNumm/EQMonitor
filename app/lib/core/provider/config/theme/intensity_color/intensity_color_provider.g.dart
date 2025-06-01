// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'intensity_color_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

<<<<<<< HEAD
<<<<<<< HEAD
String _$intensityColorConfigurationHash() => r'12c5f1148d0001d84e37f1a0bb14d65cdaee14795';

/// See also [IntensityColorConfiguration].
@ProviderFor(IntensityColorConfiguration)
final intensityColorConfigurationProvider =
    NotifierProvider<IntensityColorConfiguration, IntensityColorConfiguration>.internal(
      IntensityColorConfiguration.new,
      name: r'intensityColorConfigurationProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$intensityColorConfigurationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$IntensityColorConfiguration = Notifier<IntensityColorConfiguration>;
=======
=======
>>>>>>> 8f9f0c38 (feat: Add NHK earthquake intensity color scheme and custom RGB color configuration)
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

  @$internal
  @override
  $NotifierProviderElement<IntensityColor, IntensityColorModel> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IntensityColorModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<IntensityColorModel>(value),
    );
  }
}
<<<<<<< HEAD
>>>>>>> 2dea66be (format)
=======
=======
String _$intensityColorConfigurationHash() => r'12c5f1148d0001d84e37f1a0bb14d65cdaee14795';

/// See also [IntensityColorConfiguration].
@ProviderFor(IntensityColorConfiguration)
final intensityColorConfigurationProvider =
    NotifierProvider<IntensityColorConfiguration, IntensityColorConfiguration>.internal(
      IntensityColorConfiguration.new,
      name: r'intensityColorConfigurationProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$intensityColorConfigurationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$IntensityColorConfiguration = Notifier<IntensityColorConfiguration>;
>>>>>>> 969fa59d (feat: Add NHK earthquake intensity color scheme and custom RGB color configuration)
>>>>>>> 8f9f0c38 (feat: Add NHK earthquake intensity color scheme and custom RGB color configuration)

String _$intensityColorHash() => r'9c5f1148d0001d84e37f1a0bb14d65cdaee14795';

abstract class _$IntensityColor extends $Notifier<IntensityColorModel> {
  IntensityColorModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<IntensityColorModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IntensityColorModel>,
              IntensityColorModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
