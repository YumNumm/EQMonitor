// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'firebase_messaging_interaction.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(firebaseMessagingInteraction)
const firebaseMessagingInteractionProvider =
    FirebaseMessagingInteractionProvider._();

final class FirebaseMessagingInteractionProvider
    extends
        $FunctionalProvider<
          AsyncValue<RemoteMessage>,
          RemoteMessage,
          Stream<RemoteMessage>
        >
    with $FutureModifier<RemoteMessage>, $StreamProvider<RemoteMessage> {
  const FirebaseMessagingInteractionProvider._()
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
    r'51d01acd3aeffbeb731537057efbc3e2e2f6af6a';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
