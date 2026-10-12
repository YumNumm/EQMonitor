// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'screen_wake_lock_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScreenWakeLockController)
final screenWakeLockControllerProvider = ScreenWakeLockControllerProvider._();

final class ScreenWakeLockControllerProvider
    extends $AsyncNotifierProvider<ScreenWakeLockController, void> {
  ScreenWakeLockControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenWakeLockControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenWakeLockControllerHash();

  @$internal
  @override
  ScreenWakeLockController create() => ScreenWakeLockController();
}

String _$screenWakeLockControllerHash() =>
    r'6527cc2c59e13eb1edb2e6580561c20a9d7a4345';

abstract class _$ScreenWakeLockController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
