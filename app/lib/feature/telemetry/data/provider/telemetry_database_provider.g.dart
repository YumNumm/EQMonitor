// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telemetry_database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(telemetryDatabase)
final telemetryDatabaseProvider = TelemetryDatabaseProvider._();

final class TelemetryDatabaseProvider
    extends
        $FunctionalProvider<
          TelemetryDatabase,
          TelemetryDatabase,
          TelemetryDatabase
        >
    with $Provider<TelemetryDatabase> {
  TelemetryDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telemetryDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telemetryDatabaseHash();

  @$internal
  @override
  $ProviderElement<TelemetryDatabase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TelemetryDatabase create(Ref ref) {
    return telemetryDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TelemetryDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TelemetryDatabase>(value),
    );
  }
}

String _$telemetryDatabaseHash() => r'e27dd1aae61e7399e275dd1aab1232dfb9f87206';

@ProviderFor(telemetryDbPath)
final telemetryDbPathProvider = TelemetryDbPathProvider._();

final class TelemetryDbPathProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  TelemetryDbPathProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telemetryDbPathProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telemetryDbPathHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return telemetryDbPath(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$telemetryDbPathHash() => r'afb529fcfdde78cbef4999b457f892252d89d0fd';
