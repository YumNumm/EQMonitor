// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'prefecture_intensity_list_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(prefectureIntensityListDataSource)
final prefectureIntensityListDataSourceProvider =
    PrefectureIntensityListDataSourceFamily._();

final class PrefectureIntensityListDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<PrefectureIntensityListDataSource>,
          PrefectureIntensityListDataSource,
          FutureOr<PrefectureIntensityListDataSource>
        >
    with
        $FutureModifier<PrefectureIntensityListDataSource>,
        $FutureProvider<PrefectureIntensityListDataSource> {
  PrefectureIntensityListDataSourceProvider._({
    required PrefectureIntensityListDataSourceFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'prefectureIntensityListDataSourceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() =>
      _$prefectureIntensityListDataSourceHash();

  @override
  String toString() {
    return r'prefectureIntensityListDataSourceProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<PrefectureIntensityListDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PrefectureIntensityListDataSource> create(Ref ref) {
    final argument = this.argument as (String, String);
    return prefectureIntensityListDataSource(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is PrefectureIntensityListDataSourceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$prefectureIntensityListDataSourceHash() =>
    r'c45e8ed6168544c8f501866aea4561d44fcc9915';

final class PrefectureIntensityListDataSourceFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<PrefectureIntensityListDataSource>,
          (String, String)
        > {
  PrefectureIntensityListDataSourceFamily._()
    : super(
        retry: null,
        name: r'prefectureIntensityListDataSourceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PrefectureIntensityListDataSourceProvider call(
    String prefectureCode,
    String prefectureName,
  ) => PrefectureIntensityListDataSourceProvider._(
    argument: (prefectureCode, prefectureName),
    from: this,
  );

  @override
  String toString() => r'prefectureIntensityListDataSourceProvider';
}
