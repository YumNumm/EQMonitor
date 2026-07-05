// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'city_highest_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 指定都道府県の市区町村ごとの過去最高震度一覧を取得する family provider。

@ProviderFor(CityHighest)
final cityHighestProvider = CityHighestFamily._();

/// 指定都道府県の市区町村ごとの過去最高震度一覧を取得する family provider。
final class CityHighestProvider
    extends $AsyncNotifierProvider<CityHighest, List<HighestIntensityEntry>> {
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
  CityHighest create() => CityHighest();

  @override
  bool operator ==(Object other) {
    return other is CityHighestProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cityHighestHash() => r'084af087d4caa6514ab6dba0bd5a95c77c58c5f2';

/// 指定都道府県の市区町村ごとの過去最高震度一覧を取得する family provider。

final class CityHighestFamily extends $Family
    with
        $ClassFamilyOverride<
          CityHighest,
          AsyncValue<List<HighestIntensityEntry>>,
          List<HighestIntensityEntry>,
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

/// 指定都道府県の市区町村ごとの過去最高震度一覧を取得する family provider。

abstract class _$CityHighest
    extends $AsyncNotifier<List<HighestIntensityEntry>> {
  late final _$args = ref.$arg as String;
  String get prefectureCode => _$args;

  FutureOr<List<HighestIntensityEntry>> build(String prefectureCode);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<HighestIntensityEntry>>,
              List<HighestIntensityEntry>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<HighestIntensityEntry>>,
                List<HighestIntensityEntry>
              >,
              AsyncValue<List<HighestIntensityEntry>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
