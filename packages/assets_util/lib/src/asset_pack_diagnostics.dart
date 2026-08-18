import 'dart:convert';

enum AssetPackDiagnosticStatus { ready, manifestMissing }

final class AssetPackDiagnostics {
  const new({
    required this.schemaVersion,
    required this.platform,
    required this.osVersion,
    required this.packIdentifier,
    required this.status,
    required this.detail,
    required this.packRoot,
  });

  factory fromJsonString(String source) {
    final json = decodeDiagnosticObject(source);
    final schemaVersion = requireDiagnosticInt(
      json: json,
      key: 'schema_version',
    );
    if (schemaVersion != 3) {
      throw FormatException(
        'Unsupported Asset Pack diagnostics schema_version: $schemaVersion',
      );
    }
    return AssetPackDiagnostics(
      schemaVersion: schemaVersion,
      platform: requireDiagnosticString(json: json, key: 'platform'),
      osVersion: requireDiagnosticString(json: json, key: 'os_version'),
      packIdentifier: requireDiagnosticString(json: json, key: 'pack_id'),
      status: decodeAssetPackDiagnosticStatus(
        requireDiagnosticString(json: json, key: 'status'),
      ),
      detail: requireDiagnosticString(json: json, key: 'detail'),
      packRoot: nullableDiagnosticString(json: json, key: 'pack_root'),
    );
  }

  final int schemaVersion;
  final String platform;
  final String osVersion;
  final String packIdentifier;
  final AssetPackDiagnosticStatus status;
  final String detail;
  final String? packRoot;
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

AssetPackDiagnosticStatus decodeAssetPackDiagnosticStatus(String value) =>
    switch (value) {
      'ready' => .ready,
      'manifestMissing' => .manifestMissing,
      _ => throw FormatException('Unknown Asset Pack status: $value'),
    };
