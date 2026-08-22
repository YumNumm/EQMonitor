// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_image_request_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorImageRequestResolver)
final kyoshinMonitorImageRequestResolverProvider =
    KyoshinMonitorImageRequestResolverProvider._();

final class KyoshinMonitorImageRequestResolverProvider
    extends
        $FunctionalProvider<
          KyoshinMonitorImageRequestResolver,
          KyoshinMonitorImageRequestResolver,
          KyoshinMonitorImageRequestResolver
        >
    with $Provider<KyoshinMonitorImageRequestResolver> {
  KyoshinMonitorImageRequestResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorImageRequestResolverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$kyoshinMonitorImageRequestResolverHash();

  @$internal
  @override
  $ProviderElement<KyoshinMonitorImageRequestResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KyoshinMonitorImageRequestResolver create(Ref ref) {
    return kyoshinMonitorImageRequestResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorImageRequestResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinMonitorImageRequestResolver>(
        value,
      ),
    );
  }
}

String _$kyoshinMonitorImageRequestResolverHash() =>
    r'83a912a4468dfeefbc51f4d5dd10b88ed59c952c';
