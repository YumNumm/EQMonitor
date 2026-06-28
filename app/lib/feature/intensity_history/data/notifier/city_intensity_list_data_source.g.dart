// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'city_intensity_list_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cityIntensityListDataSource)
final cityIntensityListDataSourceProvider =
    CityIntensityListDataSourceFamily._();

final class CityIntensityListDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<CityIntensityListDataSource>,
          CityIntensityListDataSource,
          FutureOr<CityIntensityListDataSource>
        >
    with
        $FutureModifier<CityIntensityListDataSource>,
        $FutureProvider<CityIntensityListDataSource> {
  CityIntensityListDataSourceProvider._({
    required CityIntensityListDataSourceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'cityIntensityListDataSourceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cityIntensityListDataSourceHash();

  @override
  String toString() {
    return r'cityIntensityListDataSourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CityIntensityListDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CityIntensityListDataSource> create(Ref ref) {
    final argument = this.argument as String;
    return cityIntensityListDataSource(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CityIntensityListDataSourceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cityIntensityListDataSourceHash() =>
    r'2ca34b78ad73c76ad2ae0a941b961c3377434469';

final class CityIntensityListDataSourceFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<CityIntensityListDataSource>,
          String
        > {
  CityIntensityListDataSourceFamily._()
    : super(
        retry: null,
        name: r'cityIntensityListDataSourceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CityIntensityListDataSourceProvider call(String cityCode) =>
      CityIntensityListDataSourceProvider._(argument: cityCode, from: this);

  @override
  String toString() => r'cityIntensityListDataSourceProvider';
}
