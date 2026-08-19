// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'permission_request_processing_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// [PermissionNotifier] のいずれかの許可リクエストが実行中かどうか。

@ProviderFor(permissionRequestProcessing)
final permissionRequestProcessingProvider =
    PermissionRequestProcessingProvider._();

/// [PermissionNotifier] のいずれかの許可リクエストが実行中かどうか。

final class PermissionRequestProcessingProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// [PermissionNotifier] のいずれかの許可リクエストが実行中かどうか。
  PermissionRequestProcessingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'permissionRequestProcessingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$permissionRequestProcessingHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return permissionRequestProcessing(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$permissionRequestProcessingHash() =>
    r'6a05f0167a2768605f34df09d1eb3a67dd51d50a';
