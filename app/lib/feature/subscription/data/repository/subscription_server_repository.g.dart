// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'subscription_server_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(subscriptionServerRepository)
final subscriptionServerRepositoryProvider =
    SubscriptionServerRepositoryProvider._();

final class SubscriptionServerRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<SubscriptionServerRepository>,
          SubscriptionServerRepository,
          FutureOr<SubscriptionServerRepository>
        >
    with
        $FutureModifier<SubscriptionServerRepository>,
        $FutureProvider<SubscriptionServerRepository> {
  SubscriptionServerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionServerRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionServerRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<SubscriptionServerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SubscriptionServerRepository> create(Ref ref) {
    return subscriptionServerRepository(ref);
  }
}

String _$subscriptionServerRepositoryHash() =>
    r'6df18cf6986fccb6e8702601b815c775644663a4';
