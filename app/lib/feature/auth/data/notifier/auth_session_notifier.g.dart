// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'auth_session_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
    r'e7676d9dffe7a1b8147786be90bb3e268d9e0008';

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
