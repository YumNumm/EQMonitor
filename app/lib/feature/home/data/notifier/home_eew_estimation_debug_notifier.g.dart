// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'home_eew_estimation_debug_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ホーム画面のEEWカードに、距離減衰式による推計震度と到達予想時刻を
/// 表示するかどうかのデバッグ設定。
///
/// この設定単体では表示可否を決めない。実際の表示可否は
/// `isHomeEewEstimationVisibleProvider` を参照する。

@ProviderFor(HomeEewEstimationDebug)
final homeEewEstimationDebugProvider = HomeEewEstimationDebugProvider._();

/// ホーム画面のEEWカードに、距離減衰式による推計震度と到達予想時刻を
/// 表示するかどうかのデバッグ設定。
///
/// この設定単体では表示可否を決めない。実際の表示可否は
/// `isHomeEewEstimationVisibleProvider` を参照する。
final class HomeEewEstimationDebugProvider
    extends $AsyncNotifierProvider<HomeEewEstimationDebug, bool> {
  /// ホーム画面のEEWカードに、距離減衰式による推計震度と到達予想時刻を
  /// 表示するかどうかのデバッグ設定。
  ///
  /// この設定単体では表示可否を決めない。実際の表示可否は
  /// `isHomeEewEstimationVisibleProvider` を参照する。
  HomeEewEstimationDebugProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeEewEstimationDebugProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeEewEstimationDebugHash();

  @$internal
  @override
  HomeEewEstimationDebug create() => HomeEewEstimationDebug();
}

String _$homeEewEstimationDebugHash() =>
    r'326bf9587dc69edcd3e57afc9bc3f5d13c2b77d3';

/// ホーム画面のEEWカードに、距離減衰式による推計震度と到達予想時刻を
/// 表示するかどうかのデバッグ設定。
///
/// この設定単体では表示可否を決めない。実際の表示可否は
/// `isHomeEewEstimationVisibleProvider` を参照する。

abstract class _$HomeEewEstimationDebug extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
