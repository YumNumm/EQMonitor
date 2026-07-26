// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameter_set_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// パラメータは Asset Pack が唯一のソースであるため、HTTP キャッシュ層
/// （`CachedNotifier`）は使わず、単純に [ParameterRepository.loadAsset] を
/// 呼び出すだけの Notifier とする。Pack 未取得/破損時は
/// `AssetPackNotReadyException` が [build] からそのまま `AsyncError` として
/// 伝播する（偽データへのフォールバックはしない）。

@ProviderFor(ParameterSetNotifier)
final parameterSetProvider = ParameterSetNotifierProvider._();

/// パラメータは Asset Pack が唯一のソースであるため、HTTP キャッシュ層
/// （`CachedNotifier`）は使わず、単純に [ParameterRepository.loadAsset] を
/// 呼び出すだけの Notifier とする。Pack 未取得/破損時は
/// `AssetPackNotReadyException` が [build] からそのまま `AsyncError` として
/// 伝播する（偽データへのフォールバックはしない）。
final class ParameterSetNotifierProvider
    extends $AsyncNotifierProvider<ParameterSetNotifier, ParameterSet> {
  /// パラメータは Asset Pack が唯一のソースであるため、HTTP キャッシュ層
  /// （`CachedNotifier`）は使わず、単純に [ParameterRepository.loadAsset] を
  /// 呼び出すだけの Notifier とする。Pack 未取得/破損時は
  /// `AssetPackNotReadyException` が [build] からそのまま `AsyncError` として
  /// 伝播する（偽データへのフォールバックはしない）。
  ParameterSetNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parameterSetProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parameterSetNotifierHash();

  @$internal
  @override
  ParameterSetNotifier create() => ParameterSetNotifier();
}

String _$parameterSetNotifierHash() =>
    r'c5cc776b32cb28c70d0f5b423641b3d1994c032b';

/// パラメータは Asset Pack が唯一のソースであるため、HTTP キャッシュ層
/// （`CachedNotifier`）は使わず、単純に [ParameterRepository.loadAsset] を
/// 呼び出すだけの Notifier とする。Pack 未取得/破損時は
/// `AssetPackNotReadyException` が [build] からそのまま `AsyncError` として
/// 伝播する（偽データへのフォールバックはしない）。

abstract class _$ParameterSetNotifier extends $AsyncNotifier<ParameterSet> {
  FutureOr<ParameterSet> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ParameterSet>, ParameterSet>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ParameterSet>, ParameterSet>,
              AsyncValue<ParameterSet>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
