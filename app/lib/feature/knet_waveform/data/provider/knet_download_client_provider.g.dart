// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'knet_download_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 認証情報を基に [KnetDownloadClient] を生成するプロバイダ
///
/// 認証情報が未設定の場合は null を返す。

@ProviderFor(knetDownloadClient)
final knetDownloadClientProvider = KnetDownloadClientProvider._();

/// 認証情報を基に [KnetDownloadClient] を生成するプロバイダ
///
/// 認証情報が未設定の場合は null を返す。

final class KnetDownloadClientProvider
    extends
        $FunctionalProvider<
          AsyncValue<KnetDownloadClient?>,
          KnetDownloadClient?,
          FutureOr<KnetDownloadClient?>
        >
    with
        $FutureModifier<KnetDownloadClient?>,
        $FutureProvider<KnetDownloadClient?> {
  /// 認証情報を基に [KnetDownloadClient] を生成するプロバイダ
  ///
  /// 認証情報が未設定の場合は null を返す。
  KnetDownloadClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'knetDownloadClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$knetDownloadClientHash();

  @$internal
  @override
  $FutureProviderElement<KnetDownloadClient?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<KnetDownloadClient?> create(Ref ref) {
    return knetDownloadClient(ref);
  }
}

String _$knetDownloadClientHash() =>
    r'1052415c1f1259a1043870504adb764c0ac002a7';
