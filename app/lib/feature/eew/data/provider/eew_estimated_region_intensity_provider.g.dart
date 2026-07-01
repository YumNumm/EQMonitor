// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_estimated_region_intensity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eewEstimatedRegionIntensity)
final eewEstimatedRegionIntensityProvider =
    EewEstimatedRegionIntensityFamily._();

final class EewEstimatedRegionIntensityProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EewEstimatedRegion>>,
          List<EewEstimatedRegion>,
          FutureOr<List<EewEstimatedRegion>>
        >
    with
        $FutureModifier<List<EewEstimatedRegion>>,
        $FutureProvider<List<EewEstimatedRegion>> {
  EewEstimatedRegionIntensityProvider._({
    required EewEstimatedRegionIntensityFamily super.from,
    required EewTelegramItem super.argument,
  }) : super(
         retry: null,
         name: r'eewEstimatedRegionIntensityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eewEstimatedRegionIntensityHash();

  @override
  String toString() {
    return r'eewEstimatedRegionIntensityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<EewEstimatedRegion>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EewEstimatedRegion>> create(Ref ref) {
    final argument = this.argument as EewTelegramItem;
    return eewEstimatedRegionIntensity(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EewEstimatedRegionIntensityProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eewEstimatedRegionIntensityHash() =>
    r'7573f16b01b7e1684007055fc18d376141fc0f74';

final class EewEstimatedRegionIntensityFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<EewEstimatedRegion>>,
          EewTelegramItem
        > {
  EewEstimatedRegionIntensityFamily._()
    : super(
        retry: null,
        name: r'eewEstimatedRegionIntensityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EewEstimatedRegionIntensityProvider call(EewTelegramItem eew) =>
      EewEstimatedRegionIntensityProvider._(argument: eew, from: this);

  @override
  String toString() => r'eewEstimatedRegionIntensityProvider';
}
