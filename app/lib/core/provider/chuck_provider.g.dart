// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'chuck_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chuck)
final chuckProvider = ChuckProvider._();

final class ChuckProvider extends $FunctionalProvider<Chuck, Chuck, Chuck>
    with $Provider<Chuck> {
  ChuckProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chuckProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chuckHash();

  @$internal
  @override
  $ProviderElement<Chuck> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Chuck create(Ref ref) {
    return chuck(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Chuck value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Chuck>(value),
    );
  }
}

String _$chuckHash() => r'69b6bee677be70b1af17f3a1ba9ec26b9755b7b6';
