// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'v3_migration_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Runs the v2.6 → v3 device migration once per app lifecycle.
///
/// - If migration was already completed (persisted), resolves immediately.
/// - If `old_device_key` is absent from legacy storage, resolves with
///   [V3MigrationState.noLegacyId] so the caller can start onboarding.
/// - Otherwise runs the durable workflow (GET → PUT → POST migrate).

@ProviderFor(v3Migration)
final v3MigrationProvider = V3MigrationProvider._();

/// Runs the v2.6 → v3 device migration once per app lifecycle.
///
/// - If migration was already completed (persisted), resolves immediately.
/// - If `old_device_key` is absent from legacy storage, resolves with
///   [V3MigrationState.noLegacyId] so the caller can start onboarding.
/// - Otherwise runs the durable workflow (GET → PUT → POST migrate).

final class V3MigrationProvider
    extends
        $FunctionalProvider<
          AsyncValue<V3MigrationState>,
          V3MigrationState,
          FutureOr<V3MigrationState>
        >
    with $FutureModifier<V3MigrationState>, $FutureProvider<V3MigrationState> {
  /// Runs the v2.6 → v3 device migration once per app lifecycle.
  ///
  /// - If migration was already completed (persisted), resolves immediately.
  /// - If `old_device_key` is absent from legacy storage, resolves with
  ///   [V3MigrationState.noLegacyId] so the caller can start onboarding.
  /// - Otherwise runs the durable workflow (GET → PUT → POST migrate).
  V3MigrationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'v3MigrationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$v3MigrationHash();

  @$internal
  @override
  $FutureProviderElement<V3MigrationState> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<V3MigrationState> create(Ref ref) {
    return v3Migration(ref);
  }
}

String _$v3MigrationHash() => r'262ac4cdd0c4a6d31b66d0df9683ba738af4ba1d';
