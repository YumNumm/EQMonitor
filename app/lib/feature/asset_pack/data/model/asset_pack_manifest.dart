import 'package:json_annotation/json_annotation.dart';

part 'asset_pack_manifest.g.dart';

/// Stable identifiers for assets shipped inside the platform Asset Pack.
///
/// A *subset* of the backend Valibot `AssetId` picklist
/// (`backend/packages/types/src/asset-pack.ts`): the ids this app build knows
/// how to consume. The backend may ship ids that are absent here — those
/// entries are skipped by [AssetPackManifest.fromJson] (see the
/// forward-compatibility note there), so this enum never needs to be updated
/// in lockstep with the backend. Add an id here only when this app actually
/// starts reading that asset.
@JsonEnum()
enum AssetPackAssetId {
  @JsonValue('BASE_MAP_PMTILES')
  baseMapPmtiles,
  @JsonValue('JMA_CODE_TABLE')
  jmaCodeTable,
  @JsonValue('KYOSHIN_OBSERVATION_POINTS')
  kyoshinObservationPoints,
  @JsonValue('EARTHQUAKE_STATIONS')
  earthquakeStations,
  @JsonValue('TSUNAMI_STATIONS')
  tsunamiStations,
  @JsonValue('SHINDO_DB_STATIONS')
  shindoDbStations,
}

/// Matches the backend Valibot `AssetKind` picklist.
@JsonEnum()
enum AssetPackAssetKind {
  @JsonValue('pmtiles')
  pmtiles,
  @JsonValue('json')
  json,
}

const _assetIdByJsonValue = {
  'BASE_MAP_PMTILES': AssetPackAssetId.baseMapPmtiles,
  'JMA_CODE_TABLE': AssetPackAssetId.jmaCodeTable,
  'KYOSHIN_OBSERVATION_POINTS': AssetPackAssetId.kyoshinObservationPoints,
  'EARTHQUAKE_STATIONS': AssetPackAssetId.earthquakeStations,
  'TSUNAMI_STATIONS': AssetPackAssetId.tsunamiStations,
  'SHINDO_DB_STATIONS': AssetPackAssetId.shindoDbStations,
};

const _assetKindByJsonValue = {
  'pmtiles': AssetPackAssetKind.pmtiles,
  'json': AssetPackAssetKind.json,
};

final _packVersionPattern = RegExp(r'^\d+\.\d+\.\d+$');
final _sha256Pattern = RegExp(r'^[0-9a-f]{64}$');

/// Dart representation of the backend Valibot `AssetPackManifest` schema
/// (`backend/packages/types/src/asset-pack.ts`). Read from `manifest.json`
/// at the root of the platform-managed Asset Pack.
///
/// [fromJson] is hand-written (not `json_serializable`-generated) so it
/// performs the same structural validation as the backend Valibot schema
/// and throws a plain [FormatException] directly — not wrapped in
/// `json_annotation`'s `CheckedFromJsonException` — on any mismatch. There
/// is no fake-data fallback: an invalid manifest must fail loudly rather
/// than producing a partially-valid object.
///
/// The one deliberate exception is asset ids unknown to this build, which are
/// skipped rather than rejected — see [fromJson].
@JsonSerializable(createFactory: false)
class AssetPackManifest {
  AssetPackManifest({
    required this.packVersion,
    required this.schemaVersion,
    required this.generatedAt,
    required this.assets,
  });

  /// Parses a manifest, **skipping entries whose `id` this build doesn't
  /// know** while still validating everything else strictly.
  ///
  /// Skipping unknown ids is required for forward compatibility, not a
  /// convenience: signed R2 updates can contain ids introduced after this app
  /// build, so the backend adding an asset id must not make older builds
  /// reject the manifest. Rejecting one entry means rejecting the whole file — and
  /// `AssetPackRepository.readManifest` gates every asset lookup, so the base
  /// map and all parameters would become unreachable at once. That is exactly
  /// what happened when Pack v0.0.3 introduced `KYOSHIN_STATIONS` to app
  /// 3.0.0.
  ///
  /// Only the `id` is treated as an open set. `schema_version` is the
  /// compatibility gate for everything else, so any other mismatch (bad
  /// `sha256`, unknown `kind` for a known id, missing field) still throws.
  factory AssetPackManifest.fromJson(Map<String, dynamic> json) {
    final packVersion = _requireString(json, 'pack_version');
    final schemaVersion = _requireInt(json, 'schema_version');
    final generatedAt = _requireString(json, 'generated_at');
    final assetsJson = json['assets'];
    if (assetsJson is! List) {
      throw const FormatException('assets must be a list');
    }

    // Validated before the per-item parse so that a bumped schema_version is
    // reported as such, rather than as whatever the new schema's items happen
    // to violate.
    if (schemaVersion != 1) {
      throw FormatException(
        'Unsupported manifest schema_version: $schemaVersion (expected 1)',
      );
    }
    if (!_packVersionPattern.hasMatch(packVersion)) {
      throw FormatException('Invalid pack_version: $packVersion');
    }
    if (assetsJson.isEmpty) {
      throw const FormatException('assets must not be empty');
    }

    final assets = <AssetPackManifestItem>[];
    for (var i = 0; i < assetsJson.length; i++) {
      final itemJson = _requireObject(assetsJson[i], 'assets[$i]');
      if (!_assetIdByJsonValue.containsKey(itemJson['id'])) {
        continue;
      }
      assets.add(AssetPackManifestItem.fromJson(itemJson));
    }
    if (assets.isEmpty) {
      throw FormatException(
        'Asset Pack manifest lists no asset id known to this app build: '
        '${assetsJson.map((e) => e is Map ? e['id'] : e).toList()}',
      );
    }

    return AssetPackManifest(
      packVersion: packVersion,
      schemaVersion: schemaVersion,
      generatedAt: generatedAt,
      assets: assets,
    );
  }

  /// Pack 全体の版（Release Artifact / ストアアップロード単位）。
  @JsonKey(name: 'pack_version')
  final String packVersion;

  /// manifest スキーマ自体の互換バージョン。常に 1。
  @JsonKey(name: 'schema_version')
  final int schemaVersion;

  @JsonKey(name: 'generated_at')
  final String generatedAt;

  final List<AssetPackManifestItem> assets;

  Map<String, dynamic> toJson() => _$AssetPackManifestToJson(this);

  /// Returns the manifest entry for [id], or `null` if the pack doesn't
  /// list it.
  AssetPackManifestItem? findAsset(AssetPackAssetId id) {
    for (final asset in assets) {
      if (asset.id == id) {
        return asset;
      }
    }
    return null;
  }
}

/// One entry of [AssetPackManifest.assets]. Matches the backend Valibot
/// `AssetPackManifestItem` schema.
///
/// [fromJson] is hand-written for the same reason as
/// [AssetPackManifest.fromJson]: a plain, unwrapped [FormatException] on
/// any validation failure — including an `id` this build doesn't know.
/// [AssetPackManifest.fromJson] filters those entries out before delegating
/// here, so an unknown id only reaches this constructor when it is called
/// directly.
@JsonSerializable(createFactory: false)
class AssetPackManifestItem {
  AssetPackManifestItem({
    required this.id,
    required this.kind,
    required this.path,
    required this.schemaVersion,
    required this.sourceVersion,
    required this.sourceUpdatedAt,
    required this.sourceUrls,
    required this.sha256,
    required this.sizeBytes,
  });

  factory AssetPackManifestItem.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    final id = _assetIdByJsonValue[idValue];
    if (id == null) {
      throw FormatException('Unknown Asset Pack asset id: $idValue');
    }
    final kindValue = json['kind'];
    final kind = _assetKindByJsonValue[kindValue];
    if (kind == null) {
      throw FormatException(
        'Unknown Asset Pack asset kind for $id: $kindValue',
      );
    }
    final path = _requireString(json, 'path');
    final schemaVersion = _requireInt(json, 'schema_version');
    final sourceVersion = _requireString(json, 'source_version');
    final sourceUpdatedAt = json['source_updated_at'] as String?;
    final sourceUrlsJson = json['source_urls'];
    if (sourceUrlsJson is! List) {
      throw FormatException('source_urls must be a list for asset $id');
    }
    final sourceUrls = sourceUrlsJson.map((e) => e as String).toList();
    final sha256 = _requireString(json, 'sha256');
    final sizeBytes = _requireInt(json, 'size_bytes');

    if (schemaVersion != 1) {
      throw FormatException(
        'Unsupported asset schema_version for $id: $schemaVersion '
        '(expected 1)',
      );
    }
    if (path.isEmpty) {
      throw FormatException('path must not be empty for asset $id');
    }
    if (!_sha256Pattern.hasMatch(sha256)) {
      throw FormatException('Invalid sha256 for asset $id: $sha256');
    }
    if (sizeBytes < 0) {
      throw FormatException('size_bytes must be >= 0 for asset $id');
    }

    return AssetPackManifestItem(
      id: id,
      kind: kind,
      path: path,
      schemaVersion: schemaVersion,
      sourceVersion: sourceVersion,
      sourceUpdatedAt: sourceUpdatedAt,
      sourceUrls: sourceUrls,
      sha256: sha256,
      sizeBytes: sizeBytes,
    );
  }

  final AssetPackAssetId id;
  final AssetPackAssetKind kind;

  /// Pack ルートからの相対パス（例: `map/all.pmtiles`）。
  final String path;

  @JsonKey(name: 'schema_version')
  final int schemaVersion;

  @JsonKey(name: 'source_version')
  final String sourceVersion;

  @JsonKey(name: 'source_updated_at')
  final String? sourceUpdatedAt;

  @JsonKey(name: 'source_urls')
  final List<String> sourceUrls;

  final String sha256;

  @JsonKey(name: 'size_bytes')
  final int sizeBytes;

  Map<String, dynamic> toJson() => _$AssetPackManifestItemToJson(this);
}

String _requireString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is String) {
    return value;
  }
  throw FormatException('$key must be a string, got: $value');
}

int _requireInt(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is num) {
    return value.toInt();
  }
  throw FormatException('$key must be a number, got: $value');
}

Map<String, dynamic> _requireObject(Object? value, String context) {
  if (value is Map<String, dynamic>) {
    return value;
  }
  if (value is Map) {
    return value.map((key, v) => MapEntry(key as String, v));
  }
  throw FormatException('$context must be an object, got: $value');
}
