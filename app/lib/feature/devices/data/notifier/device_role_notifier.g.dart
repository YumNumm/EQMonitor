// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_role_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// このデバイスのロール。
///
/// 端末に保存した前回の取得結果を使い、毎起動では問い合わせない。
/// 保存値が Admin のときだけ、取り消しを反映するため起動時に取得し直す。
/// 未登録・未取得・取得失敗は null を返す。権限判定に使うため、
/// 取得できない場合に権限ありへフォールバックしない。

@ProviderFor(DeviceRoleNotifier)
final deviceRoleProvider = DeviceRoleNotifierProvider._();

/// このデバイスのロール。
///
/// 端末に保存した前回の取得結果を使い、毎起動では問い合わせない。
/// 保存値が Admin のときだけ、取り消しを反映するため起動時に取得し直す。
/// 未登録・未取得・取得失敗は null を返す。権限判定に使うため、
/// 取得できない場合に権限ありへフォールバックしない。
final class DeviceRoleNotifierProvider
    extends $AsyncNotifierProvider<DeviceRoleNotifier, DeviceRole?> {
  /// このデバイスのロール。
  ///
  /// 端末に保存した前回の取得結果を使い、毎起動では問い合わせない。
  /// 保存値が Admin のときだけ、取り消しを反映するため起動時に取得し直す。
  /// 未登録・未取得・取得失敗は null を返す。権限判定に使うため、
  /// 取得できない場合に権限ありへフォールバックしない。
  DeviceRoleNotifierProvider._()
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
  String debugGetCreateSourceHash() => _$deviceRoleNotifierHash();

  @$internal
  @override
  DeviceRoleNotifier create() => DeviceRoleNotifier();
}

String _$deviceRoleNotifierHash() =>
    r'e8469b97c5de789b918496a61576e2294fb394ce';

/// このデバイスのロール。
///
/// 端末に保存した前回の取得結果を使い、毎起動では問い合わせない。
/// 保存値が Admin のときだけ、取り消しを反映するため起動時に取得し直す。
/// 未登録・未取得・取得失敗は null を返す。権限判定に使うため、
/// 取得できない場合に権限ありへフォールバックしない。

abstract class _$DeviceRoleNotifier extends $AsyncNotifier<DeviceRole?> {
  FutureOr<DeviceRole?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DeviceRole?>, DeviceRole?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DeviceRole?>, DeviceRole?>,
              AsyncValue<DeviceRole?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
