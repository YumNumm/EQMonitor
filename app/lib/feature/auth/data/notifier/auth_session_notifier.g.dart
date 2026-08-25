// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'auth_session_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthSessionRevision)
final authSessionRevisionProvider = AuthSessionRevisionProvider._();

final class AuthSessionRevisionProvider
    extends $NotifierProvider<AuthSessionRevision, int> {
  AuthSessionRevisionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSessionRevisionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSessionRevisionHash();

  @$internal
  @override
  AuthSessionRevision create() => AuthSessionRevision();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$authSessionRevisionHash() =>
    r'2ae2ddcb2f9fc6c854046261ee5d92af816a86d0';

abstract class _$AuthSessionRevision extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(AuthSessionNotifier)
final authSessionProvider = AuthSessionNotifierProvider._();

final class AuthSessionNotifierProvider
    extends $AsyncNotifierProvider<AuthSessionNotifier, AuthSession> {
  AuthSessionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSessionNotifierHash();

  @$internal
  @override
  AuthSessionNotifier create() => AuthSessionNotifier();
}

String _$authSessionNotifierHash() =>
    r'3d3fbcd157afe597aa961e029d61388ac1f6ee96';

abstract class _$AuthSessionNotifier extends $AsyncNotifier<AuthSession> {
  FutureOr<AuthSession> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AuthSession>, AuthSession>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthSession>, AuthSession>,
              AsyncValue<AuthSession>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
