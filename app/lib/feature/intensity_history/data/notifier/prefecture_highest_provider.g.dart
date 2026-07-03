// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'prefecture_highest_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 全都道府県の過去最高震度一覧をキャッシュする provider。

@ProviderFor(PrefectureHighest)
final prefectureHighestProvider = PrefectureHighestProvider._();

/// 全都道府県の過去最高震度一覧をキャッシュする provider。
final class PrefectureHighestProvider
    extends
        $AsyncNotifierProvider<PrefectureHighest, List<HighestIntensityEntry>> {
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
  PrefectureHighest create() => PrefectureHighest();
}

String _$prefectureHighestHash() => r'7107dade5fb59d7eaefc99e821a86ee4d90bb3fe';

/// 全都道府県の過去最高震度一覧をキャッシュする provider。

abstract class _$PrefectureHighest
    extends $AsyncNotifier<List<HighestIntensityEntry>> {
  FutureOr<List<HighestIntensityEntry>> build();
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
    return element.handleCreate(ref, build);
  }
}
