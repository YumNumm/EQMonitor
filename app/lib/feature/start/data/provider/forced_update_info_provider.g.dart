// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'forced_update_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// UI 層がドメイン型のみを参照できるよう、
/// Start API レスポンスから強制アップデート判定情報のみを抽出したドメインモデルを返す。

@ProviderFor(forcedUpdateInfo)
final forcedUpdateInfoProvider = ForcedUpdateInfoProvider._();

/// UI 層がドメイン型のみを参照できるよう、
/// Start API レスポンスから強制アップデート判定情報のみを抽出したドメインモデルを返す。

final class ForcedUpdateInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<ForcedUpdateInfoModel>,
          AsyncValue<ForcedUpdateInfoModel>,
          AsyncValue<ForcedUpdateInfoModel>
        >
    with $Provider<AsyncValue<ForcedUpdateInfoModel>> {
  /// UI 層がドメイン型のみを参照できるよう、
  /// Start API レスポンスから強制アップデート判定情報のみを抽出したドメインモデルを返す。
  ForcedUpdateInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forcedUpdateInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forcedUpdateInfoHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<ForcedUpdateInfoModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<ForcedUpdateInfoModel> create(Ref ref) {
    return forcedUpdateInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<ForcedUpdateInfoModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<ForcedUpdateInfoModel>>(
        value,
      ),
    );
  }
}

String _$forcedUpdateInfoHash() => r'3ad59e7d16e55ce1c74c8667ecd30c26d516154f';
