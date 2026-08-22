// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_image_request_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorImageRequest)
final kyoshinMonitorImageRequestProvider =
    KyoshinMonitorImageRequestProvider._();

final class KyoshinMonitorImageRequestProvider
    extends
        $FunctionalProvider<
          KyoshinMonitorImageRequest,
          KyoshinMonitorImageRequest,
          KyoshinMonitorImageRequest
        >
    with $Provider<KyoshinMonitorImageRequest> {
  KyoshinMonitorImageRequestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorImageRequestProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorImageRequestHash();

  @$internal
  @override
  $ProviderElement<KyoshinMonitorImageRequest> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KyoshinMonitorImageRequest create(Ref ref) {
    return kyoshinMonitorImageRequest(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorImageRequest value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinMonitorImageRequest>(value),
    );
  }
}

String _$kyoshinMonitorImageRequestHash() =>
    r'e0590f165523dd30093d297ef9a9ff0c4aa701d5';
