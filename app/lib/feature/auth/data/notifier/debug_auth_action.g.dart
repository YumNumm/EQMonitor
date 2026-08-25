// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_auth_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugAuthJwtExpiry)
final debugAuthJwtExpiryProvider = DebugAuthJwtExpiryProvider._();

final class DebugAuthJwtExpiryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ReadDebugAuthJwtExpiry>,
          ReadDebugAuthJwtExpiry,
          FutureOr<ReadDebugAuthJwtExpiry>
        >
    with
        $FutureModifier<ReadDebugAuthJwtExpiry>,
        $FutureProvider<ReadDebugAuthJwtExpiry> {
  DebugAuthJwtExpiryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugAuthJwtExpiryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugAuthJwtExpiryHash();

  @$internal
  @override
  $FutureProviderElement<ReadDebugAuthJwtExpiry> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ReadDebugAuthJwtExpiry> create(Ref ref) {
    return debugAuthJwtExpiry(ref);
  }
}

String _$debugAuthJwtExpiryHash() =>
    r'332e33b6ad31b7c5187dcdb82fd120332399a1cd';

@ProviderFor(debugAuthSignInAction)
final debugAuthSignInActionProvider = DebugAuthSignInActionProvider._();

final class DebugAuthSignInActionProvider
    extends
        $FunctionalProvider<
          DebugAuthSignInAction,
          DebugAuthSignInAction,
          DebugAuthSignInAction
        >
    with $Provider<DebugAuthSignInAction> {
  DebugAuthSignInActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugAuthSignInActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugAuthSignInActionHash();

  @$internal
  @override
  $ProviderElement<DebugAuthSignInAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugAuthSignInAction create(Ref ref) {
    return debugAuthSignInAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugAuthSignInAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugAuthSignInAction>(value),
    );
  }
}

String _$debugAuthSignInActionHash() =>
    r'931284370d12b7b67e8f998326817abe7e4674e1';

@ProviderFor(debugAuthPasskeyRegistrationAction)
final debugAuthPasskeyRegistrationActionProvider =
    DebugAuthPasskeyRegistrationActionProvider._();

final class DebugAuthPasskeyRegistrationActionProvider
    extends
        $FunctionalProvider<
          DebugAuthPasskeyRegistrationAction,
          DebugAuthPasskeyRegistrationAction,
          DebugAuthPasskeyRegistrationAction
        >
    with $Provider<DebugAuthPasskeyRegistrationAction> {
  DebugAuthPasskeyRegistrationActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugAuthPasskeyRegistrationActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$debugAuthPasskeyRegistrationActionHash();

  @$internal
  @override
  $ProviderElement<DebugAuthPasskeyRegistrationAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugAuthPasskeyRegistrationAction create(Ref ref) {
    return debugAuthPasskeyRegistrationAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugAuthPasskeyRegistrationAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugAuthPasskeyRegistrationAction>(
        value,
      ),
    );
  }
}

String _$debugAuthPasskeyRegistrationActionHash() =>
    r'11da8a066bad13ec5553c69dd42cf95210c1db8c';

@ProviderFor(debugAuthJwtRefreshAction)
final debugAuthJwtRefreshActionProvider = DebugAuthJwtRefreshActionProvider._();

final class DebugAuthJwtRefreshActionProvider
    extends
        $FunctionalProvider<
          DebugAuthJwtRefreshAction,
          DebugAuthJwtRefreshAction,
          DebugAuthJwtRefreshAction
        >
    with $Provider<DebugAuthJwtRefreshAction> {
  DebugAuthJwtRefreshActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugAuthJwtRefreshActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugAuthJwtRefreshActionHash();

  @$internal
  @override
  $ProviderElement<DebugAuthJwtRefreshAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugAuthJwtRefreshAction create(Ref ref) {
    return debugAuthJwtRefreshAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugAuthJwtRefreshAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugAuthJwtRefreshAction>(value),
    );
  }
}

String _$debugAuthJwtRefreshActionHash() =>
    r'6615805bbfc6793c9978e19f237e621a53417b38';

@ProviderFor(debugAuthUserMeAction)
final debugAuthUserMeActionProvider = DebugAuthUserMeActionProvider._();

final class DebugAuthUserMeActionProvider
    extends
        $FunctionalProvider<
          DebugAuthUserMeAction,
          DebugAuthUserMeAction,
          DebugAuthUserMeAction
        >
    with $Provider<DebugAuthUserMeAction> {
  DebugAuthUserMeActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugAuthUserMeActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugAuthUserMeActionHash();

  @$internal
  @override
  $ProviderElement<DebugAuthUserMeAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugAuthUserMeAction create(Ref ref) {
    return debugAuthUserMeAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugAuthUserMeAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugAuthUserMeAction>(value),
    );
  }
}

String _$debugAuthUserMeActionHash() =>
    r'7b4f8a19e4d2d7088266fccded3fde7294317c9b';

@ProviderFor(debugAuthSignOutAction)
final debugAuthSignOutActionProvider = DebugAuthSignOutActionProvider._();

final class DebugAuthSignOutActionProvider
    extends
        $FunctionalProvider<
          DebugAuthSignOutAction,
          DebugAuthSignOutAction,
          DebugAuthSignOutAction
        >
    with $Provider<DebugAuthSignOutAction> {
  DebugAuthSignOutActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugAuthSignOutActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugAuthSignOutActionHash();

  @$internal
  @override
  $ProviderElement<DebugAuthSignOutAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugAuthSignOutAction create(Ref ref) {
    return debugAuthSignOutAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugAuthSignOutAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugAuthSignOutAction>(value),
    );
  }
}

String _$debugAuthSignOutActionHash() =>
    r'7e951c04e166a9fa437fcffffd7e6bc2bc7d885b';
