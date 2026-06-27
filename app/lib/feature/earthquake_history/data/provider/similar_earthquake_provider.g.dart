// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'similar_earthquake_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(similarEarthquake)
final similarEarthquakeProvider = SimilarEarthquakeFamily._();

final class SimilarEarthquakeProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SimilarEarthquakeItem>>,
          List<SimilarEarthquakeItem>,
          FutureOr<List<SimilarEarthquakeItem>>
        >
    with
        $FutureModifier<List<SimilarEarthquakeItem>>,
        $FutureProvider<List<SimilarEarthquakeItem>> {
  SimilarEarthquakeProvider._({
    required SimilarEarthquakeFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'similarEarthquakeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$similarEarthquakeHash();

  @override
  String toString() {
    return r'similarEarthquakeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SimilarEarthquakeItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SimilarEarthquakeItem>> create(Ref ref) {
    final argument = this.argument as String;
    return similarEarthquake(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SimilarEarthquakeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$similarEarthquakeHash() => r'484e2ad3e85bc2fdebd8d279ae12fd66f18242e1';

final class SimilarEarthquakeFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<SimilarEarthquakeItem>>,
          String
        > {
  SimilarEarthquakeFamily._()
    : super(
        retry: null,
        name: r'similarEarthquakeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SimilarEarthquakeProvider call(String eventId) =>
      SimilarEarthquakeProvider._(argument: eventId, from: this);

  @override
  String toString() => r'similarEarthquakeProvider';
}
