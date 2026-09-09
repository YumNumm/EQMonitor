// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_search_results.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earthquakeHistorySearchResults)
final earthquakeHistorySearchResultsProvider =
    EarthquakeHistorySearchResultsFamily._();

final class EarthquakeHistorySearchResultsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EarthquakeHistorySearchResult>>,
          List<EarthquakeHistorySearchResult>,
          FutureOr<List<EarthquakeHistorySearchResult>>
        >
    with
        $FutureModifier<List<EarthquakeHistorySearchResult>>,
        $FutureProvider<List<EarthquakeHistorySearchResult>> {
  EarthquakeHistorySearchResultsProvider._({
    required EarthquakeHistorySearchResultsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeHistorySearchResultsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistorySearchResultsHash();

  @override
  String toString() {
    return r'earthquakeHistorySearchResultsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<EarthquakeHistorySearchResult>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EarthquakeHistorySearchResult>> create(Ref ref) {
    final argument = this.argument as String;
    return earthquakeHistorySearchResults(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeHistorySearchResultsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeHistorySearchResultsHash() =>
    r'0f25582e09742ee7750ca3b032404a408d7946e9';

final class EarthquakeHistorySearchResultsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<EarthquakeHistorySearchResult>>,
          String
        > {
  EarthquakeHistorySearchResultsFamily._()
    : super(
        retry: null,
        name: r'earthquakeHistorySearchResultsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeHistorySearchResultsProvider call(String query) =>
      EarthquakeHistorySearchResultsProvider._(argument: query, from: this);

  @override
  String toString() => r'earthquakeHistorySearchResultsProvider';
}
