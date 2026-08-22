// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_delay_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorDelayResolver)
final kyoshinMonitorDelayResolverProvider =
    KyoshinMonitorDelayResolverProvider._();

final class KyoshinMonitorDelayResolverProvider
    extends
        $FunctionalProvider<
          KyoshinMonitorDelayResolver,
          KyoshinMonitorDelayResolver,
          KyoshinMonitorDelayResolver
        >
    with $Provider<KyoshinMonitorDelayResolver> {
  KyoshinMonitorDelayResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorDelayResolverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorDelayResolverHash();

  @$internal
  @override
  $ProviderElement<KyoshinMonitorDelayResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KyoshinMonitorDelayResolver create(Ref ref) {
    return kyoshinMonitorDelayResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorDelayResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinMonitorDelayResolver>(value),
    );
  }
}

String _$kyoshinMonitorDelayResolverHash() =>
    r'be3b1740e6fb512d5e0c9be2dd52575dbc8dd4b9';
