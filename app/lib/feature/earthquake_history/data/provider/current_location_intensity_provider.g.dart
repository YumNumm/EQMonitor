// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'current_location_intensity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentLocationIntensity)
final currentLocationIntensityProvider = CurrentLocationIntensityFamily._();

final class CurrentLocationIntensityProvider
    extends
        $FunctionalProvider<
          AsyncValue<CurrentLocationIntensityDisplay>,
          CurrentLocationIntensityDisplay,
          FutureOr<CurrentLocationIntensityDisplay>
        >
    with
        $FutureModifier<CurrentLocationIntensityDisplay>,
        $FutureProvider<CurrentLocationIntensityDisplay> {
  CurrentLocationIntensityProvider._({
    required CurrentLocationIntensityFamily super.from,
    required ({String eventId, String? cityAreaCode, String? regionAreaCode})
    super.argument,
  }) : super(
         retry: null,
         name: r'currentLocationIntensityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentLocationIntensityHash();

  @override
  String toString() {
    return r'currentLocationIntensityProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<CurrentLocationIntensityDisplay> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CurrentLocationIntensityDisplay> create(Ref ref) {
    final argument =
        this.argument
            as ({String eventId, String? cityAreaCode, String? regionAreaCode});
    return currentLocationIntensity(
      ref,
      eventId: argument.eventId,
      cityAreaCode: argument.cityAreaCode,
      regionAreaCode: argument.regionAreaCode,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentLocationIntensityProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentLocationIntensityHash() =>
    r'7009c0001eb587192959df037260b0f61c21b11d';

final class CurrentLocationIntensityFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<CurrentLocationIntensityDisplay>,
          ({String eventId, String? cityAreaCode, String? regionAreaCode})
        > {
  CurrentLocationIntensityFamily._()
    : super(
        retry: null,
        name: r'currentLocationIntensityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CurrentLocationIntensityProvider call({
    required String eventId,
    required String? cityAreaCode,
    required String? regionAreaCode,
  }) => CurrentLocationIntensityProvider._(
    argument: (
      eventId: eventId,
      cityAreaCode: cityAreaCode,
      regionAreaCode: regionAreaCode,
    ),
    from: this,
  );

  @override
  String toString() => r'currentLocationIntensityProvider';
}
