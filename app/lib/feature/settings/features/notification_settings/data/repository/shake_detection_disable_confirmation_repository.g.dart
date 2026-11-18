// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_disable_confirmation_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionDisableConfirmationRepository)
final shakeDetectionDisableConfirmationRepositoryProvider =
    ShakeDetectionDisableConfirmationRepositoryProvider._();

final class ShakeDetectionDisableConfirmationRepositoryProvider
    extends
        $FunctionalProvider<
          ShakeDetectionDisableConfirmationRepository,
          ShakeDetectionDisableConfirmationRepository,
          ShakeDetectionDisableConfirmationRepository
        >
    with $Provider<ShakeDetectionDisableConfirmationRepository> {
  ShakeDetectionDisableConfirmationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionDisableConfirmationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$shakeDetectionDisableConfirmationRepositoryHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionDisableConfirmationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionDisableConfirmationRepository create(Ref ref) {
    return shakeDetectionDisableConfirmationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    ShakeDetectionDisableConfirmationRepository value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<ShakeDetectionDisableConfirmationRepository>(
            value,
          ),
    );
  }
}

String _$shakeDetectionDisableConfirmationRepositoryHash() =>
    r'eed76aa4edaafba60f8e9ff3a7a901051aa41b27';
