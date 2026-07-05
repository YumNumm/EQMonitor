// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region_name_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// AsyncValue でラップした riverpod プロバイダ(UI 用)。
///
/// [searchType] 検索対象の地域種別
/// [code] 地域コード

@ProviderFor(regionName)
final regionNameProvider = RegionNameFamily._();

/// AsyncValue でラップした riverpod プロバイダ(UI 用)。
///
/// [searchType] 検索対象の地域種別
/// [code] 地域コード

final class RegionNameProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// AsyncValue でラップした riverpod プロバイダ(UI 用)。
  ///
  /// [searchType] 検索対象の地域種別
  /// [code] 地域コード
  RegionNameProvider._({
    required RegionNameFamily super.from,
    required (RegionSearchType, String) super.argument,
  }) : super(
         retry: null,
         name: r'regionNameProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$regionNameHash();

  @override
  String toString() {
    return r'regionNameProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    final argument = this.argument as (RegionSearchType, String);
    return regionName(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is RegionNameProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$regionNameHash() => r'15fcafb1930da4ee216931340e1a8fa0db99e3f9';

/// AsyncValue でラップした riverpod プロバイダ(UI 用)。
///
/// [searchType] 検索対象の地域種別
/// [code] 地域コード

final class RegionNameFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<String?>,
          (RegionSearchType, String)
        > {
  RegionNameFamily._()
    : super(
        retry: null,
        name: r'regionNameProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// AsyncValue でラップした riverpod プロバイダ(UI 用)。
  ///
  /// [searchType] 検索対象の地域種別
  /// [code] 地域コード

  RegionNameProvider call(RegionSearchType searchType, String code) =>
      RegionNameProvider._(argument: (searchType, code), from: this);

  @override
  String toString() => r'regionNameProvider';
}
