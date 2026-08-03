import 'dart:convert';

enum AssetPackDiagnosticStatus {
  ready,
  unsupportedOs,
  manifestUrlResolutionFailed,
  manifestMissing,
  manifestUnreadable,
  manifestInvalid,
  assetMissing,
  assetSizeMismatch,
}

enum AssetPackSystemAvailability { available, unavailable, apiUnavailable }

enum AssetPackFileDiagnosticStatus {
  ready,
  resolutionFailed,
  missing,
  sizeMismatch,
}

final class AssetPackNativeError {
  const AssetPackNativeError({
    required this.domain,
    required this.code,
    required this.description,
  });

  factory AssetPackNativeError.fromJson(Map<String, dynamic> json) =>
      AssetPackNativeError(
        domain: requireDiagnosticString(json: json, key: 'domain'),
        code: requireDiagnosticInt(json: json, key: 'code'),
        description: requireDiagnosticString(json: json, key: 'description'),
      );

  final String domain;
  final int code;
  final String description;
}

final class AssetPackFileDiagnostic {
  const AssetPackFileDiagnostic({
    required this.path,
    required this.status,
    required this.exists,
    required this.expectedSizeBytes,
    required this.actualSizeBytes,
    required this.resolvedUrl,
    required this.nativeError,
  });

  factory AssetPackFileDiagnostic.fromJson(Map<String, dynamic> json) =>
      AssetPackFileDiagnostic(
        path: requireDiagnosticString(json: json, key: 'path'),
        status: decodeAssetPackFileStatus(
          requireDiagnosticString(json: json, key: 'status'),
        ),
        exists: requireDiagnosticBool(json: json, key: 'exists'),
        expectedSizeBytes: nullableDiagnosticInt(
          json: json,
          key: 'expected_size_bytes',
        ),
        actualSizeBytes: nullableDiagnosticInt(
          json: json,
          key: 'actual_size_bytes',
        ),
        resolvedUrl: nullableDiagnosticString(json: json, key: 'resolved_url'),
        nativeError: nullableDiagnosticNativeError(
          json: json,
          key: 'native_error',
        ),
      );

  final String path;
  final AssetPackFileDiagnosticStatus status;
  final bool exists;
  final int? expectedSizeBytes;
  final int? actualSizeBytes;
  final String? resolvedUrl;
  final AssetPackNativeError? nativeError;
}

final class AssetPackDiagnostics {
  const AssetPackDiagnostics({
    required this.schemaVersion,
    required this.platform,
    required this.osVersion,
    required this.packIdentifier,
    required this.status,
    required this.systemAvailability,
    required this.detail,
    required this.manifestUrl,
    required this.packRoot,
    required this.manifestJson,
    required this.assets,
    required this.nativeError,
  });

  factory AssetPackDiagnostics.fromJsonString(String source) {
    final json = decodeDiagnosticObject(source);
    final schemaVersion = requireDiagnosticInt(
      json: json,
      key: 'schema_version',
    );
    if (schemaVersion != 1 && schemaVersion != 2) {
      throw FormatException(
        'Unsupported Asset Pack diagnostics schema_version: $schemaVersion',
      );
    }
    final rawAssets = json['assets'];
    if (rawAssets is! List) {
      throw const FormatException('assets must be a list');
    }
    final assets = rawAssets
        .map((value) {
          if (value is Map<String, dynamic>) {
            if (schemaVersion == 1) {
              return AssetPackFileDiagnostic.fromJson({
                ...value,
                'resolved_url': null,
                'native_error': null,
              });
            }
            return AssetPackFileDiagnostic.fromJson(value);
          }
          throw const FormatException('assets entries must be objects');
        })
        .toList(growable: false);
    final manifestValue = json['manifest'];
    final nativeErrorValue = json['native_error'];
    if (manifestValue != null && manifestValue is! Map<String, dynamic>) {
      throw const FormatException('manifest must be an object or null');
    }
    if (nativeErrorValue != null && nativeErrorValue is! Map<String, dynamic>) {
      throw const FormatException('native_error must be an object or null');
    }
    return AssetPackDiagnostics(
      schemaVersion: schemaVersion,
      platform: requireDiagnosticString(json: json, key: 'platform'),
      osVersion: requireDiagnosticString(json: json, key: 'os_version'),
      packIdentifier: requireDiagnosticString(json: json, key: 'pack_id'),
      status: decodeAssetPackDiagnosticStatus(
        requireDiagnosticString(json: json, key: 'status'),
      ),
      systemAvailability: decodeAssetPackSystemAvailability(
        requireDiagnosticString(json: json, key: 'system_availability'),
      ),
      detail: requireDiagnosticString(json: json, key: 'detail'),
      manifestUrl: nullableDiagnosticString(json: json, key: 'manifest_url'),
      packRoot: nullableDiagnosticString(json: json, key: 'pack_root'),
      manifestJson: manifestValue == null
          ? null
          : manifestValue as Map<String, dynamic>,
      assets: assets,
      nativeError: nativeErrorValue == null
          ? null
          : AssetPackNativeError.fromJson(nativeErrorValue),
    );
  }

  final int schemaVersion;
  final String platform;
  final String osVersion;
  final String packIdentifier;
  final AssetPackDiagnosticStatus status;
  final AssetPackSystemAvailability systemAvailability;
  final String detail;
  final String? manifestUrl;
  final String? packRoot;
  final Map<String, dynamic>? manifestJson;
  final List<AssetPackFileDiagnostic> assets;
  final AssetPackNativeError? nativeError;
}

AssetPackNativeError? nullableDiagnosticNativeError({
  required Map<String, dynamic> json,
  required String key,
}) {
  final value = json[key];
  if (value == null) {
    return null;
  }
  if (value is Map<String, dynamic>) {
    return AssetPackNativeError.fromJson(value);
  }
  throw const FormatException('native_error must be an object or null');
}

final class AssetPackUpdateResult {
  const AssetPackUpdateResult({
    required this.schemaVersion,
    required this.packIdentifier,
    required this.success,
    required this.checkedAt,
    required this.updatingIdentifiers,
    required this.removedIdentifiers,
    required this.nativeError,
  });

  factory AssetPackUpdateResult.fromJsonString(String source) {
    final json = decodeDiagnosticObject(source);
    final schemaVersion = requireDiagnosticInt(
      json: json,
      key: 'schema_version',
    );
    if (schemaVersion != 1) {
      throw FormatException(
        'Unsupported Asset Pack update schema_version: $schemaVersion',
      );
    }
    final nativeErrorValue = json['native_error'];
    if (nativeErrorValue != null && nativeErrorValue is! Map<String, dynamic>) {
      throw const FormatException('native_error must be an object or null');
    }
    return AssetPackUpdateResult(
      schemaVersion: schemaVersion,
      packIdentifier: requireDiagnosticString(json: json, key: 'pack_id'),
      success: requireDiagnosticBool(json: json, key: 'success'),
      checkedAt: requireDiagnosticString(json: json, key: 'checked_at'),
      updatingIdentifiers: requireDiagnosticStringList(
        json: json,
        key: 'updating_ids',
      ),
      removedIdentifiers: requireDiagnosticStringList(
        json: json,
        key: 'removed_ids',
      ),
      nativeError: nativeErrorValue == null
          ? null
          : AssetPackNativeError.fromJson(nativeErrorValue),
    );
  }

  final int schemaVersion;
  final String packIdentifier;
  final bool success;
  final String checkedAt;
  final List<String> updatingIdentifiers;
  final List<String> removedIdentifiers;
  final AssetPackNativeError? nativeError;
}

Map<String, dynamic> decodeDiagnosticObject(String source) {
  final value = jsonDecode(source);
  if (value is Map<String, dynamic>) {
    return value;
  }
  throw const FormatException('root must be an object');
}

String requireDiagnosticString({
  required Map<String, dynamic> json,
  required String key,
}) {
  final value = json[key];
  if (value is String) {
    return value;
  }
  throw FormatException('$key must be a string');
}

String? nullableDiagnosticString({
  required Map<String, dynamic> json,
  required String key,
}) {
  final value = json[key];
  if (value == null || value is String) {
    return value as String?;
  }
  throw FormatException('$key must be a string or null');
}

int requireDiagnosticInt({
  required Map<String, dynamic> json,
  required String key,
}) {
  final value = json[key];
  if (value is int) {
    return value;
  }
  throw FormatException('$key must be an integer');
}

int? nullableDiagnosticInt({
  required Map<String, dynamic> json,
  required String key,
}) {
  final value = json[key];
  if (value == null || value is int) {
    return value as int?;
  }
  throw FormatException('$key must be an integer or null');
}

bool requireDiagnosticBool({
  required Map<String, dynamic> json,
  required String key,
}) {
  final value = json[key];
  if (value is bool) {
    return value;
  }
  throw FormatException('$key must be a boolean');
}

List<String> requireDiagnosticStringList({
  required Map<String, dynamic> json,
  required String key,
}) {
  final value = json[key];
  if (value is! List || value.any((item) => item is! String)) {
    throw FormatException('$key must be a string list');
  }
  return value.cast<String>().toList(growable: false);
}

AssetPackDiagnosticStatus decodeAssetPackDiagnosticStatus(String value) =>
    switch (value) {
      'ready' => .ready,
      'unsupportedOs' => .unsupportedOs,
      'manifestUrlResolutionFailed' => .manifestUrlResolutionFailed,
      'manifestMissing' => .manifestMissing,
      'manifestUnreadable' => .manifestUnreadable,
      'manifestInvalid' => .manifestInvalid,
      'assetMissing' => .assetMissing,
      'assetSizeMismatch' => .assetSizeMismatch,
      _ => throw FormatException('Unknown Asset Pack status: $value'),
    };

AssetPackSystemAvailability decodeAssetPackSystemAvailability(String value) =>
    switch (value) {
      'available' => .available,
      'unavailable' => .unavailable,
      'apiUnavailable' => .apiUnavailable,
      _ => throw FormatException('Unknown system availability: $value'),
    };

AssetPackFileDiagnosticStatus decodeAssetPackFileStatus(String value) =>
    switch (value) {
      'ready' => .ready,
      'resolutionFailed' => .resolutionFailed,
      'missing' => .missing,
      'sizeMismatch' => .sizeMismatch,
      _ => throw FormatException('Unknown Asset Pack file status: $value'),
    };
