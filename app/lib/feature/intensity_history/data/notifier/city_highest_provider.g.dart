// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'city_highest_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 指定都道府県の市区町村ごとの過去最高震度一覧を取得する family provider。

@ProviderFor(cityHighest)
final cityHighestProvider = CityHighestFamily._();

/// 指定都道府県の市区町村ごとの過去最高震度一覧を取得する family provider。

final class CityHighestProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HighestIntensityEntry>>,
          List<HighestIntensityEntry>,
          FutureOr<List<HighestIntensityEntry>>
        >
    with
        $FutureModifier<List<HighestIntensityEntry>>,
        $FutureProvider<List<HighestIntensityEntry>> {
  /// 指定都道府県の市区町村ごとの過去最高震度一覧を取得する family provider。
  CityHighestProvider._({
    required CityHighestFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'cityHighestProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cityHighestHash();

  @override
  String toString() {
    return r'cityHighestProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<HighestIntensityEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HighestIntensityEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return cityHighest(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CityHighestProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cityHighestHash() => r'69023c9912d6ad0a9f4e7f36cc81b21062293da9';

/// 指定都道府県の市区町村ごとの過去最高震度一覧を取得する family provider。

final class CityHighestFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<HighestIntensityEntry>>,
          String
        > {
  CityHighestFamily._()
    : super(
        retry: null,
        name: r'cityHighestProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 指定都道府県の市区町村ごとの過去最高震度一覧を取得する family provider。

  CityHighestProvider call(String prefectureCode) =>
      CityHighestProvider._(argument: prefectureCode, from: this);

  @override
  String toString() => r'cityHighestProvider';
}
