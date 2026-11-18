// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_access_level_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugAccessLevel)
final debugAccessLevelProvider = DebugAccessLevelProvider._();

final class DebugAccessLevelProvider
    extends
        $FunctionalProvider<
          DebugAccessLevel,
          DebugAccessLevel,
          DebugAccessLevel
        >
    with $Provider<DebugAccessLevel> {
  DebugAccessLevelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugAccessLevelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugAccessLevelHash();

  @$internal
  @override
  $ProviderElement<DebugAccessLevel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DebugAccessLevel create(Ref ref) {
    return debugAccessLevel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugAccessLevel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugAccessLevel>(value),
    );
  }
}

String _$debugAccessLevelHash() => r'e122733bf31baa51da718de20333a2d39f1726f2';
