// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'prefecture_highest_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 全都道府県の過去最高震度一覧をキャッシュする provider。

@ProviderFor(prefectureHighest)
final prefectureHighestProvider = PrefectureHighestProvider._();

/// 全都道府県の過去最高震度一覧をキャッシュする provider。

final class PrefectureHighestProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HighestIntensityEntry>>,
          List<HighestIntensityEntry>,
          FutureOr<List<HighestIntensityEntry>>
        >
    with
        $FutureModifier<List<HighestIntensityEntry>>,
        $FutureProvider<List<HighestIntensityEntry>> {
  /// 全都道府県の過去最高震度一覧をキャッシュする provider。
  PrefectureHighestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prefectureHighestProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prefectureHighestHash();

  @$internal
  @override
  $FutureProviderElement<List<HighestIntensityEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HighestIntensityEntry>> create(Ref ref) {
    return prefectureHighest(ref);
  }
}

String _$prefectureHighestHash() => r'd16d052760ebd71add8225510f58077037eefd8f';
