// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'knet_credentials_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SecureStorage から BOSAI 認証情報を読み書きする Notifier

@ProviderFor(KnetCredentialsNotifier)
final knetCredentialsProvider = KnetCredentialsNotifierProvider._();

/// SecureStorage から BOSAI 認証情報を読み書きする Notifier
final class KnetCredentialsNotifierProvider
    extends $AsyncNotifierProvider<KnetCredentialsNotifier, KnetCredentials?> {
  /// SecureStorage から BOSAI 認証情報を読み書きする Notifier
  KnetCredentialsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'knetCredentialsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$knetCredentialsNotifierHash();

  @$internal
  @override
  KnetCredentialsNotifier create() => KnetCredentialsNotifier();
}

String _$knetCredentialsNotifierHash() =>
    r'efbea7085eb2e59d9f4411d0fc2d30d73734c487';

/// SecureStorage から BOSAI 認証情報を読み書きする Notifier

abstract class _$KnetCredentialsNotifier
    extends $AsyncNotifier<KnetCredentials?> {
  FutureOr<KnetCredentials?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<KnetCredentials?>, KnetCredentials?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<KnetCredentials?>, KnetCredentials?>,
              AsyncValue<KnetCredentials?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
