// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'permission_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PermissionNotifier)
const permissionProvider = PermissionNotifierProvider._();

final class PermissionNotifierProvider
    extends $NotifierProvider<PermissionNotifier, PermissionStateModel> {
  const PermissionNotifierProvider._()
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PermissionStateModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PermissionStateModel>(value),
    );
  }
}

String _$permissionNotifierHash() =>
    r'9148f70192bfa7e7a23b910cd3e111566b64994d';

abstract class _$PermissionNotifier extends $Notifier<PermissionStateModel> {
  PermissionStateModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PermissionStateModel, PermissionStateModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PermissionStateModel, PermissionStateModel>,
              PermissionStateModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
