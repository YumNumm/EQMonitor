// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'subscription_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SubscriptionNotifier)
final subscriptionProvider = SubscriptionNotifierProvider._();

final class SubscriptionNotifierProvider
    extends $AsyncNotifierProvider<SubscriptionNotifier, SubscriptionStatus> {
  SubscriptionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionNotifierHash();

  @$internal
  @override
  SubscriptionNotifier create() => SubscriptionNotifier();
}

String _$subscriptionNotifierHash() =>
    r'4f21bd603641bfa4983cd72257fd6452f12bf08f';

abstract class _$SubscriptionNotifier
    extends $AsyncNotifier<SubscriptionStatus> {
  FutureOr<SubscriptionStatus> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SubscriptionStatus>, SubscriptionStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SubscriptionStatus>, SubscriptionStatus>,
              AsyncValue<SubscriptionStatus>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
