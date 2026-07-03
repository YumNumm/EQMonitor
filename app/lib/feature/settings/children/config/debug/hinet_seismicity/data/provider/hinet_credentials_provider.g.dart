// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hinet_credentials_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SecureStorage から Hi-net 認証情報を読み書きするNotifier。
///
/// [KnetCredentialsNotifier](`app/lib/feature/knet_waveform/data/provider/knet_credentials_provider.dart`)
/// と同じ Mutation パターンに従う。

@ProviderFor(HinetCredentialsNotifier)
final hinetCredentialsNotifierProvider = HinetCredentialsNotifierProvider._();

/// SecureStorage から Hi-net 認証情報を読み書きするNotifier。
///
/// [KnetCredentialsNotifier](`app/lib/feature/knet_waveform/data/provider/knet_credentials_provider.dart`)
/// と同じ Mutation パターンに従う。
final class HinetCredentialsNotifierProvider
    extends
        $AsyncNotifierProvider<HinetCredentialsNotifier, HinetCredentials?> {
  /// SecureStorage から Hi-net 認証情報を読み書きするNotifier。
  ///
  /// [KnetCredentialsNotifier](`app/lib/feature/knet_waveform/data/provider/knet_credentials_provider.dart`)
  /// と同じ Mutation パターンに従う。
  HinetCredentialsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hinetCredentialsNotifierProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hinetCredentialsNotifierHash();

  @$internal
  @override
  HinetCredentialsNotifier create() => HinetCredentialsNotifier();
}

String _$hinetCredentialsNotifierHash() =>
    r'966632d7766efd6be63aca9f7f82fca4839e263a';

/// SecureStorage から Hi-net 認証情報を読み書きするNotifier。
///
/// [KnetCredentialsNotifier](`app/lib/feature/knet_waveform/data/provider/knet_credentials_provider.dart`)
/// と同じ Mutation パターンに従う。

abstract class _$HinetCredentialsNotifier
    extends $AsyncNotifier<HinetCredentials?> {
  FutureOr<HinetCredentials?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<HinetCredentials?>, HinetCredentials?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HinetCredentials?>, HinetCredentials?>,
              AsyncValue<HinetCredentials?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
