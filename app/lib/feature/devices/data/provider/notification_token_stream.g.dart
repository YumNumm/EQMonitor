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
    r'e826d309f71108269159d135cfb266fa7a5a2f81';

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
    r'591364b9f4a43387d577e93968f9c92ca3136354';

@ProviderFor(apnsNotificationTokenStream)
final apnsNotificationTokenStreamProvider =
    ApnsNotificationTokenStreamProvider._();

final class ApnsNotificationTokenStreamProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  ApnsNotificationTokenStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apnsNotificationTokenStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apnsNotificationTokenStreamHash();

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    return apnsNotificationTokenStream(ref);
  }
}

String _$apnsNotificationTokenStreamHash() =>
    r'1bebe9e03f8351df51eef0a40b955116781c51f1';

@ProviderFor(apnsPushToStartTokenStream)
final apnsPushToStartTokenStreamProvider =
    ApnsPushToStartTokenStreamProvider._();

final class ApnsPushToStartTokenStreamProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  ApnsPushToStartTokenStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apnsPushToStartTokenStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apnsPushToStartTokenStreamHash();

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    return apnsPushToStartTokenStream(ref);
  }
}

String _$apnsPushToStartTokenStreamHash() =>
    r'0a91ffc010baa1780c915d89551ba026c96ae692';
