// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'background_location_permission_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// バックグラウンド位置情報のパーミッション状態を保持する。
/// アプリがフォアグラウンドに復帰した時に自動で再取得する。

@ProviderFor(backgroundLocationPermission)
final backgroundLocationPermissionProvider =
    BackgroundLocationPermissionProvider._();

/// バックグラウンド位置情報のパーミッション状態を保持する。
/// アプリがフォアグラウンドに復帰した時に自動で再取得する。

final class BackgroundLocationPermissionProvider
    extends
        $FunctionalProvider<
          AsyncValue<LocationPermission>,
          LocationPermission,
          FutureOr<LocationPermission>
        >
    with
        $FutureModifier<LocationPermission>,
        $FutureProvider<LocationPermission> {
  /// バックグラウンド位置情報のパーミッション状態を保持する。
  /// アプリがフォアグラウンドに復帰した時に自動で再取得する。
  BackgroundLocationPermissionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backgroundLocationPermissionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backgroundLocationPermissionHash();

  @$internal
  @override
  $FutureProviderElement<LocationPermission> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LocationPermission> create(Ref ref) {
    return backgroundLocationPermission(ref);
  }
}

String _$backgroundLocationPermissionHash() =>
    r'0394ca365fe2979f20965e34a10ce8cd312f8a33';
