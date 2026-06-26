// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'similar_earthquakes_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(similarEarthquakes)
final similarEarthquakesProvider = SimilarEarthquakesFamily._();

final class SimilarEarthquakesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SimilarEarthquakeGroup>>,
          List<SimilarEarthquakeGroup>,
          FutureOr<List<SimilarEarthquakeGroup>>
        >
    with
        $FutureModifier<List<SimilarEarthquakeGroup>>,
        $FutureProvider<List<SimilarEarthquakeGroup>> {
  SimilarEarthquakesProvider._({
    required SimilarEarthquakesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'similarEarthquakesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$similarEarthquakesHash();

  @override
  String toString() {
    return r'similarEarthquakesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SimilarEarthquakeGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SimilarEarthquakeGroup>> create(Ref ref) {
    final argument = this.argument as String;
    return similarEarthquakes(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SimilarEarthquakesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$similarEarthquakesHash() =>
    r'67ecad9ccbbdad4df4e4063f21422d620ded90a2';

final class SimilarEarthquakesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<SimilarEarthquakeGroup>>,
          String
        > {
  SimilarEarthquakesFamily._()
    : super(
        retry: null,
        name: r'similarEarthquakesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SimilarEarthquakesProvider call(String eventId) =>
      SimilarEarthquakesProvider._(argument: eventId, from: this);

  @override
  String toString() => r'similarEarthquakesProvider';
}
