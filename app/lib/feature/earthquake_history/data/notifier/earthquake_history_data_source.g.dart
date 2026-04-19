// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earthquakeHistoryDataSource)
final earthquakeHistoryDataSourceProvider =
    EarthquakeHistoryDataSourceFamily._();

final class EarthquakeHistoryDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<EarthquakeHistoryDataSource>,
          EarthquakeHistoryDataSource,
          FutureOr<EarthquakeHistoryDataSource>
        >
    with
        $FutureModifier<EarthquakeHistoryDataSource>,
        $FutureProvider<EarthquakeHistoryDataSource> {
  EarthquakeHistoryDataSourceProvider._({
    required EarthquakeHistoryDataSourceFamily super.from,
    required EarthquakeHistoryParameter super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeHistoryDataSourceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryDataSourceHash();

  @override
  String toString() {
    return r'earthquakeHistoryDataSourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EarthquakeHistoryDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EarthquakeHistoryDataSource> create(Ref ref) {
    final argument = this.argument as EarthquakeHistoryParameter;
    return earthquakeHistoryDataSource(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeHistoryDataSourceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeHistoryDataSourceHash() =>
    r'4f8afd0775f6eae2ea4dc2b25e5e9326b9040bae';

final class EarthquakeHistoryDataSourceFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<EarthquakeHistoryDataSource>,
          EarthquakeHistoryParameter
        > {
  EarthquakeHistoryDataSourceFamily._()
    : super(
        retry: null,
        name: r'earthquakeHistoryDataSourceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeHistoryDataSourceProvider call(
    EarthquakeHistoryParameter parameter,
  ) => EarthquakeHistoryDataSourceProvider._(argument: parameter, from: this);

  @override
  String toString() => r'earthquakeHistoryDataSourceProvider';
}
