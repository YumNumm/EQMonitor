// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DebugAuthNotifier)
final debugAuthProvider = DebugAuthNotifierProvider._();

final class DebugAuthNotifierProvider
    extends $AsyncNotifierProvider<DebugAuthNotifier, DebugAuthState> {
  DebugAuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugAuthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugAuthNotifierHash();

  @$internal
  @override
  DebugAuthNotifier create() => DebugAuthNotifier();
}

String _$debugAuthNotifierHash() => r'386605ca8c346ecbc13a44d070d143264bac018c';

abstract class _$DebugAuthNotifier extends $AsyncNotifier<DebugAuthState> {
  FutureOr<DebugAuthState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DebugAuthState>, DebugAuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DebugAuthState>, DebugAuthState>,
              AsyncValue<DebugAuthState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
