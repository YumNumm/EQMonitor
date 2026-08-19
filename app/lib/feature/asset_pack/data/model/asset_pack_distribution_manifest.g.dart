// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_distribution_manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssetPackDistributionManifest _$AssetPackDistributionManifestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_AssetPackDistributionManifest',
  json,
  ($checkedConvert) {
    final val = _AssetPackDistributionManifest(
      schemaVersion: $checkedConvert(
        'schema_version',
        (v) => (v as num).toInt(),
      ),
      revision: $checkedConvert('revision', (v) => (v as num).toInt()),
      latestVersion: $checkedConvert('latest_version', (v) => v as String),
      generatedAt: $checkedConvert('generated_at', (v) => v as String),
      packs: $checkedConvert(
        'packs',
        (v) => (v as List<dynamic>)
            .map(
              (e) => AssetPackDistributionEntry.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'schemaVersion': 'schema_version',
    'latestVersion': 'latest_version',
    'generatedAt': 'generated_at',
  },
);

Map<String, dynamic> _$AssetPackDistributionManifestToJson(
  _AssetPackDistributionManifest instance,
) => <String, dynamic>{
  'schema_version': instance.schemaVersion,
  'revision': instance.revision,
  'latest_version': instance.latestVersion,
  'generated_at': instance.generatedAt,
  'packs': instance.packs,
};

_AssetPackDistributionEntry _$AssetPackDistributionEntryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_AssetPackDistributionEntry',
  json,
  ($checkedConvert) {
    final val = _AssetPackDistributionEntry(
      version: $checkedConvert('version', (v) => v as String),
      publishedAt: $checkedConvert('published_at', (v) => v as String),
      minimumAppVersion: $checkedConvert(
        'minimum_app_version',
        (v) => v as String,
      ),
      archivePath: $checkedConvert('archive_path', (v) => v as String),
      archiveSizeBytes: $checkedConvert(
        'archive_size_bytes',
        (v) => (v as num).toInt(),
      ),
      archiveSha256: $checkedConvert('archive_sha256', (v) => v as String),
      localizations: $checkedConvert(
        'localizations',
        (v) =>
            AssetPackChangelogLocalizations.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'publishedAt': 'published_at',
    'minimumAppVersion': 'minimum_app_version',
    'archivePath': 'archive_path',
    'archiveSizeBytes': 'archive_size_bytes',
    'archiveSha256': 'archive_sha256',
  },
);

Map<String, dynamic> _$AssetPackDistributionEntryToJson(
  _AssetPackDistributionEntry instance,
) => <String, dynamic>{
  'version': instance.version,
  'published_at': instance.publishedAt,
  'minimum_app_version': instance.minimumAppVersion,
  'archive_path': instance.archivePath,
  'archive_size_bytes': instance.archiveSizeBytes,
  'archive_sha256': instance.archiveSha256,
  'localizations': instance.localizations,
};

_AssetPackChangelogLocalizations _$AssetPackChangelogLocalizationsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_AssetPackChangelogLocalizations', json, (
  $checkedConvert,
) {
  final val = _AssetPackChangelogLocalizations(
    ja: $checkedConvert(
      'ja',
      (v) => AssetPackChangelogLocalization.fromJson(v as Map<String, dynamic>),
    ),
    en: $checkedConvert(
      'en',
      (v) => AssetPackChangelogLocalization.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AssetPackChangelogLocalizationsToJson(
  _AssetPackChangelogLocalizations instance,
) => <String, dynamic>{'ja': instance.ja, 'en': instance.en};

_AssetPackChangelogLocalization _$AssetPackChangelogLocalizationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_AssetPackChangelogLocalization', json, ($checkedConvert) {
  final val = _AssetPackChangelogLocalization(
    sections: $checkedConvert(
      'sections',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                AssetPackChangelogSection.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$AssetPackChangelogLocalizationToJson(
  _AssetPackChangelogLocalization instance,
) => <String, dynamic>{'sections': instance.sections};

_AssetPackChangelogSection _$AssetPackChangelogSectionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_AssetPackChangelogSection', json, ($checkedConvert) {
  final val = _AssetPackChangelogSection(
    title: $checkedConvert('title', (v) => v as String),
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$AssetPackChangelogSectionToJson(
  _AssetPackChangelogSection instance,
) => <String, dynamic>{'title': instance.title, 'items': instance.items};
