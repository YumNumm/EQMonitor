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
    required (String, String) super.argument,
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
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<CityIntensityListDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CityIntensityListDataSource> create(Ref ref) {
    final argument = this.argument as (String, String);
    return cityIntensityListDataSource(ref, argument.$1, argument.$2);
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
    r'da55d6c2db826c57ef2dc5ff390aa50d7ae6465e';

final class CityIntensityListDataSourceFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<CityIntensityListDataSource>,
          (String, String)
        > {
  CityIntensityListDataSourceFamily._()
    : super(
        retry: null,
        name: r'cityIntensityListDataSourceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CityIntensityListDataSourceProvider call(String cityCode, String cityName) =>
      CityIntensityListDataSourceProvider._(
        argument: (cityCode, cityName),
        from: this,
      );

  @override
  String toString() => r'cityIntensityListDataSourceProvider';
}
