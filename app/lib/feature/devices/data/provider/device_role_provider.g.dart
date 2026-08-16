// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_role_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// このデバイスに紐づくユーザーのロール。
///
/// デバイス未登録時・取得失敗時・ロール未提供時は null を返す。
/// 権限判定に使うため、取得できない場合に権限ありへフォールバックしない。

@ProviderFor(deviceRole)
final deviceRoleProvider = DeviceRoleProvider._();

/// このデバイスに紐づくユーザーのロール。
///
/// デバイス未登録時・取得失敗時・ロール未提供時は null を返す。
/// 権限判定に使うため、取得できない場合に権限ありへフォールバックしない。

final class DeviceRoleProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeviceRole?>,
          DeviceRole?,
          FutureOr<DeviceRole?>
        >
    with $FutureModifier<DeviceRole?>, $FutureProvider<DeviceRole?> {
  /// このデバイスに紐づくユーザーのロール。
  ///
  /// デバイス未登録時・取得失敗時・ロール未提供時は null を返す。
  /// 権限判定に使うため、取得できない場合に権限ありへフォールバックしない。
  DeviceRoleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceRoleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceRoleHash();

  @$internal
  @override
  $FutureProviderElement<DeviceRole?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DeviceRole?> create(Ref ref) {
    return deviceRole(ref);
  }
}

String _$deviceRoleHash() => r'c7a303a48fdd0416d77917bc8e9503a40deb4701';
