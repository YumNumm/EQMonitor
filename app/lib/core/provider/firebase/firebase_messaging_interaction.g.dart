// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'firebase_messaging_interaction.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
    r'2b7d073a58cae205ecb67ff83b8c64be3ff670d7';
