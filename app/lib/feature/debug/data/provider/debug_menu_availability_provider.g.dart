// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_menu_availability_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isDebugMenuAvailable)
final isDebugMenuAvailableProvider = IsDebugMenuAvailableProvider._();

final class IsDebugMenuAvailableProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsDebugMenuAvailableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isDebugMenuAvailableProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isDebugMenuAvailableHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isDebugMenuAvailable(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isDebugMenuAvailableHash() =>
    r'fa6a340d9ef3294e2d35522c5df4cc3eedd6dbf3';
