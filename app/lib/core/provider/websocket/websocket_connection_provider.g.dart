// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'websocket_connection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WsConnectionStatus)
final wsConnectionStatusProvider = WsConnectionStatusProvider._();

final class WsConnectionStatusProvider
    extends $NotifierProvider<WsConnectionStatus, WsConnectionState> {
  WsConnectionStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wsConnectionStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wsConnectionStatusHash();

  @$internal
  @override
  WsConnectionStatus create() => WsConnectionStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WsConnectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WsConnectionState>(value),
    );
  }
}

String _$wsConnectionStatusHash() =>
    r'46a8c954ce43d68b6e7135b024748c1533691167';

abstract class _$WsConnectionStatus extends $Notifier<WsConnectionState> {
  WsConnectionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<WsConnectionState, WsConnectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WsConnectionState, WsConnectionState>,
              WsConnectionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(WsCurrentUrl)
final wsCurrentUrlProvider = WsCurrentUrlProvider._();

final class WsCurrentUrlProvider
    extends $NotifierProvider<WsCurrentUrl, String?> {
  WsCurrentUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wsCurrentUrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wsCurrentUrlHash();

  @$internal
  @override
  WsCurrentUrl create() => WsCurrentUrl();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$wsCurrentUrlHash() => r'2a97bb4ca2d252d6329a2bff530b25f078f69b15';

abstract class _$WsCurrentUrl extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(WsLastPingAt)
final wsLastPingAtProvider = WsLastPingAtProvider._();

final class WsLastPingAtProvider
    extends $NotifierProvider<WsLastPingAt, DateTime?> {
  WsLastPingAtProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wsLastPingAtProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wsLastPingAtHash();

  @$internal
  @override
  WsLastPingAt create() => WsLastPingAt();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime?>(value),
    );
  }
}

String _$wsLastPingAtHash() => r'7d0fde3f9887650f9446b8e7f1b9bb2b400206d1';

abstract class _$WsLastPingAt extends $Notifier<DateTime?> {
  DateTime? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime?, DateTime?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime?, DateTime?>,
              DateTime?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(WsConnection)
final wsConnectionProvider = WsConnectionProvider._();

final class WsConnectionProvider
    extends $StreamNotifierProvider<WsConnection, WsMessage> {
  WsConnectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wsConnectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wsConnectionHash();

  @$internal
  @override
  WsConnection create() => WsConnection();
}

String _$wsConnectionHash() => r'c0ed48d37c723b81973626c359e3e28f84179863';

abstract class _$WsConnection extends $StreamNotifier<WsMessage> {
  Stream<WsMessage> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<WsMessage>, WsMessage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WsMessage>, WsMessage>,
              AsyncValue<WsMessage>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
