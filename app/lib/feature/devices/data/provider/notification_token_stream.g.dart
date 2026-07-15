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
    r'96d738c2e26bc8a093ea3339679da532ffe7cedf';

@ProviderFor(firebaseMessagingTokenStream)
final firebaseMessagingTokenStreamProvider =
    FirebaseMessagingTokenStreamProvider._();

final class FirebaseMessagingTokenStreamProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  FirebaseMessagingTokenStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseMessagingTokenStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseMessagingTokenStreamHash();

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    return firebaseMessagingTokenStream(ref);
  }
}

String _$firebaseMessagingTokenStreamHash() =>
    r'08ec88426a6ac8f26480814d87c5752bb64216ad';

@ProviderFor(apnsTokenStream)
final apnsTokenStreamProvider = ApnsTokenStreamProvider._();

final class ApnsTokenStreamProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  ApnsTokenStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apnsTokenStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apnsTokenStreamHash();

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    return apnsTokenStream(ref);
  }
}

String _$apnsTokenStreamHash() => r'51242c680d71d7330e05fc94e8adafb1d2e4498c';

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
    r'b7acb6a618cee1e3ae3771670a661b8f73a4617c';
