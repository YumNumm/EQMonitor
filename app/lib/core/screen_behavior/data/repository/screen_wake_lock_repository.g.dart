// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'screen_wake_lock_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(screenWakeLockRepository)
final screenWakeLockRepositoryProvider = ScreenWakeLockRepositoryProvider._();

final class ScreenWakeLockRepositoryProvider
    extends
        $FunctionalProvider<
          ScreenWakeLockRepository,
          ScreenWakeLockRepository,
          ScreenWakeLockRepository
        >
    with $Provider<ScreenWakeLockRepository> {
  ScreenWakeLockRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenWakeLockRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenWakeLockRepositoryHash();

  @$internal
  @override
  $ProviderElement<ScreenWakeLockRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ScreenWakeLockRepository create(Ref ref) {
    return screenWakeLockRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScreenWakeLockRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScreenWakeLockRepository>(value),
    );
  }
}

String _$screenWakeLockRepositoryHash() =>
    r'b2895d0c77df6febde6559e5a24865d3d804ac57';
