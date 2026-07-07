// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'permission_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// アプリで利用する権限の状態を保持する Notifier。
///
/// 初期化時に OS の権限状態を読み取り、既に許可済みの権限は granted として反映する。

@ProviderFor(PermissionNotifier)
final permissionProvider = PermissionNotifierProvider._();

/// アプリで利用する権限の状態を保持する Notifier。
///
/// 初期化時に OS の権限状態を読み取り、既に許可済みの権限は granted として反映する。
final class PermissionNotifierProvider
    extends $AsyncNotifierProvider<PermissionNotifier, PermissionState> {
  /// アプリで利用する権限の状態を保持する Notifier。
  ///
  /// 初期化時に OS の権限状態を読み取り、既に許可済みの権限は granted として反映する。
  PermissionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'permissionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$permissionNotifierHash();

  @$internal
  @override
  PermissionNotifier create() => PermissionNotifier();
}

String _$permissionNotifierHash() =>
    r'1f3caa6844623e9a7df0edbcce88c7ce2344a036';

/// アプリで利用する権限の状態を保持する Notifier。
///
/// 初期化時に OS の権限状態を読み取り、既に許可済みの権限は granted として反映する。

abstract class _$PermissionNotifier extends $AsyncNotifier<PermissionState> {
  FutureOr<PermissionState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PermissionState>, PermissionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PermissionState>, PermissionState>,
              AsyncValue<PermissionState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
