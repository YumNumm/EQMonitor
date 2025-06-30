// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'firebase_messaging.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(firebaseMessaging)
const firebaseMessagingProvider = FirebaseMessagingProvider._();

final class FirebaseMessagingProvider
    extends $FunctionalProvider<FirebaseMessaging, FirebaseMessaging>
    with $Provider<FirebaseMessaging> {
  const FirebaseMessagingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseMessagingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseMessagingHash();

  @$internal
  @override
  $ProviderElement<FirebaseMessaging> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirebaseMessaging create(Ref ref) {
    return firebaseMessaging(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseMessaging value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<FirebaseMessaging>(value),
    );
  }
}

String _$firebaseMessagingHash() => r'6765ce963b9b8c50186b5132356d60eb68265741';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
