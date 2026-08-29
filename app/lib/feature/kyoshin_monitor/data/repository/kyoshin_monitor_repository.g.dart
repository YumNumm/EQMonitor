// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorRepository)
final kyoshinMonitorRepositoryProvider = KyoshinMonitorRepositoryProvider._();

final class KyoshinMonitorRepositoryProvider
    extends
        $FunctionalProvider<
          KyoshinMonitorRepository,
          KyoshinMonitorRepository,
          KyoshinMonitorRepository
        >
    with $Provider<KyoshinMonitorRepository> {
  KyoshinMonitorRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorRepositoryHash();

  @$internal
  @override
  $ProviderElement<KyoshinMonitorRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KyoshinMonitorRepository create(Ref ref) {
    return kyoshinMonitorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinMonitorRepository>(value),
    );
  }
}

String _$kyoshinMonitorRepositoryHash() =>
    r'2fa5941428d8d9f8ccb45274c46706fff866ec5d';
