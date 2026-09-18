import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart';
import 'package:version/version.dart';

final _semVerPattern = RegExp(r'^\d+\.\d+\.\d+$');
final _sha256Pattern = RegExp(r'^[0-9a-f]{64}$');
final _datePattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');

class const AssetPackDistributionManifestValidator() {
  AssetPackDistributionManifest parse(Map<String, dynamic> json) {
    final AssetPackDistributionManifest manifest;
    try {
      manifest = AssetPackDistributionManifest.fromJson(json);
    } on FormatException {
      rethrow;
    } on Object catch (error) {
      throw FormatException('Invalid distribution manifest: $error');
    }
    validate(manifest);
    return manifest;
  }

  void validate(AssetPackDistributionManifest manifest) {
    if (manifest.schemaVersion != 1 || manifest.revision < 1) {
      throw const FormatException('Unsupported distribution manifest header');
    }
    if (!_semVerPattern.hasMatch(manifest.latestVersion) ||
        DateTime.tryParse(manifest.generatedAt) == null ||
        manifest.packs.isEmpty) {
      throw const FormatException(
        'Invalid latest_version, generated_at or packs',
      );
    }
    for (final entry in manifest.packs) {
      validateEntry(entry);
    }
    if (manifest.packs.first.version != manifest.latestVersion) {
      throw const FormatException('latest_version must match the first pack');
    }
    validateNewestFirst(manifest.packs);
  }

  void validateEntry(AssetPackDistributionEntry entry) {
    if (!_semVerPattern.hasMatch(entry.version) ||
        !_semVerPattern.hasMatch(entry.minimumAppVersion) ||
        !_datePattern.hasMatch(entry.publishedAt) ||
        entry.archivePath !=
            'packs/${entry.version}/asset-pack-v${entry.version}.zip' ||
        entry.archiveSizeBytes < 1 ||
        !_sha256Pattern.hasMatch(entry.archiveSha256)) {
      throw FormatException('Invalid distribution entry for ${entry.version}');
    }
    validateChangelog(
      entry.localizations.ja,
      version: entry.version,
      languageCode: 'ja',
    );
    validateChangelog(
      entry.localizations.en,
      version: entry.version,
      languageCode: 'en',
    );
  }

  void validateChangelog(
    AssetPackChangelogLocalization localization, {
    required String version,
    required String languageCode,
  }) {
    final hasEmptyContent = localization.sections.any(
      (section) =>
          section.title.isEmpty ||
          section.items.isEmpty ||
          section.items.any((item) => item.isEmpty),
    );
    if (localization.sections.isEmpty || hasEmptyContent) {
      throw FormatException(
        'Invalid $languageCode changelog for $version',
      );
    }
  }

  void validateNewestFirst(List<AssetPackDistributionEntry> packs) {
    for (var index = 1; index < packs.length; index += 1) {
      if (Version.parse(packs[index - 1].version) <=
          Version.parse(packs[index].version)) {
        throw const FormatException('packs must be unique and newest-first');
      }
    }
  }
}
