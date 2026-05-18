// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_token_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationTokenStream)
final notificationTokenStreamProvider = NotificationTokenStreamProvider._();

final class NotificationTokenStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotificationToken>,
          NotificationToken,
          Stream<NotificationToken>
        >
    with
        $FutureModifier<NotificationToken>,
        $StreamProvider<NotificationToken> {
  NotificationTokenStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationTokenStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationTokenStreamHash();

  @$internal
  @override
  $StreamProviderElement<NotificationToken> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<NotificationToken> create(Ref ref) {
    return notificationTokenStream(ref);
  }
}

String _$notificationTokenStreamHash() =>
    r'5ff8cdddccb800be5bb24dbffe925c7520164059';

@ProviderFor(_firebaseMessagingTokenStream)
final _firebaseMessagingTokenStreamProvider =
    _FirebaseMessagingTokenStreamProvider._();

final class _FirebaseMessagingTokenStreamProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  _FirebaseMessagingTokenStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_firebaseMessagingTokenStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_firebaseMessagingTokenStreamHash();

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    return _firebaseMessagingTokenStream(ref);
  }
}

String _$_firebaseMessagingTokenStreamHash() =>
    r'bc3ada82b83f80b7c578abf321eed31675c32fb9';

@ProviderFor(_apnsTokenStream)
final _apnsTokenStreamProvider = _ApnsTokenStreamProvider._();

final class _ApnsTokenStreamProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  _ApnsTokenStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_apnsTokenStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_apnsTokenStreamHash();

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    return _apnsTokenStream(ref);
  }
}

String _$_apnsTokenStreamHash() => r'68d009a70b8d338d7b36bf0d5f28b052b9dbdecb';

@ProviderFor(_apnsPushToStartTokenStream)
final _apnsPushToStartTokenStreamProvider =
    _ApnsPushToStartTokenStreamProvider._();

final class _ApnsPushToStartTokenStreamProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  _ApnsPushToStartTokenStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_apnsPushToStartTokenStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_apnsPushToStartTokenStreamHash();

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    return _apnsPushToStartTokenStream(ref);
  }
}

String _$_apnsPushToStartTokenStreamHash() =>
    r'12c24adfce5b829929c388e17c9bc051e413c3a9';
