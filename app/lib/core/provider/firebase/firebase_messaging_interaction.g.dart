// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'firebase_messaging_interaction.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pendingNotificationDeepLinkGate)
final pendingNotificationDeepLinkGateProvider =
    PendingNotificationDeepLinkGateProvider._();

final class PendingNotificationDeepLinkGateProvider
    extends
        $FunctionalProvider<
          PendingNotificationDeepLinkGate,
          PendingNotificationDeepLinkGate,
          PendingNotificationDeepLinkGate
        >
    with $Provider<PendingNotificationDeepLinkGate> {
  PendingNotificationDeepLinkGateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingNotificationDeepLinkGateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingNotificationDeepLinkGateHash();

  @$internal
  @override
  $ProviderElement<PendingNotificationDeepLinkGate> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PendingNotificationDeepLinkGate create(Ref ref) {
    return pendingNotificationDeepLinkGate(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PendingNotificationDeepLinkGate value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PendingNotificationDeepLinkGate>(
        value,
      ),
    );
  }
}

String _$pendingNotificationDeepLinkGateHash() =>
    r'f22b93a62946472c962434aed9a35a8da8b8cea6';

@ProviderFor(firebaseMessagingInteraction)
final firebaseMessagingInteractionProvider =
    FirebaseMessagingInteractionProvider._();

final class FirebaseMessagingInteractionProvider
    extends
        $FunctionalProvider<
          AsyncValue<RemoteMessage>,
          RemoteMessage,
          Stream<RemoteMessage>
        >
    with $FutureModifier<RemoteMessage>, $StreamProvider<RemoteMessage> {
  FirebaseMessagingInteractionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseMessagingInteractionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseMessagingInteractionHash();

  @$internal
  @override
  $StreamProviderElement<RemoteMessage> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<RemoteMessage> create(Ref ref) {
    return firebaseMessagingInteraction(ref);
  }
}

String _$firebaseMessagingInteractionHash() =>
    r'd6318d4cec7f464d6300db643b279c5377a152d4';
