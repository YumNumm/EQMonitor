// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_fallback_polling_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isRealtimeFallbackPollingActive)
final isRealtimeFallbackPollingActiveProvider =
    IsRealtimeFallbackPollingActiveProvider._();

final class IsRealtimeFallbackPollingActiveProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsRealtimeFallbackPollingActiveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isRealtimeFallbackPollingActiveProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isRealtimeFallbackPollingActiveHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isRealtimeFallbackPollingActive(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isRealtimeFallbackPollingActiveHash() =>
    r'dc83f3c879aac348aafab0df0021443017051180';
