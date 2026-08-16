import 'package:version/version.dart';

final _semVerPattern = RegExp(r'^\d+\.\d+\.\d+$');
final _sha256Pattern = RegExp(r'^[0-9a-f]{64}$');
final _datePattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');

class AssetPackDistributionManifest {
  const AssetPackDistributionManifest({
    required this.schemaVersion,
    required this.revision,
    required this.latestVersion,
    required this.generatedAt,
    required this.packs,
  });

  factory AssetPackDistributionManifest.fromJson(Map<String, dynamic> json) {
    final schemaVersion = requireInt(json, 'schema_version');
    final revision = requireInt(json, 'revision');
    final latestVersion = requireSemVer(json, 'latest_version');
    final generatedAt = requireString(json, 'generated_at');
    final rawPacks = json['packs'];
    if (schemaVersion != 1 || revision < 1) {
      throw const FormatException('Unsupported distribution manifest header');
    }
    if (DateTime.tryParse(generatedAt) == null ||
        rawPacks is! List ||
        rawPacks.isEmpty) {
      throw const FormatException('Invalid generated_at or packs');
    }
    final packs = rawPacks
        .map((value) {
          if (value is! Map<String, dynamic>) {
            throw const FormatException('packs entries must be objects');
          }
          return AssetPackDistributionEntry.fromJson(value);
        })
        .toList(growable: false);
    if (packs.first.version != latestVersion) {
      throw const FormatException('latest_version must match the first pack');
    }
    for (var index = 1; index < packs.length; index += 1) {
      if (Version.parse(packs[index - 1].version) <=
          Version.parse(packs[index].version)) {
        throw const FormatException('packs must be unique and newest-first');
      }
    }
    return AssetPackDistributionManifest(
      schemaVersion: schemaVersion,
      revision: revision,
      latestVersion: latestVersion,
      generatedAt: generatedAt,
      packs: packs,
    );
  }

  final int schemaVersion;
  final int revision;
  final String latestVersion;
  final String generatedAt;
  final List<AssetPackDistributionEntry> packs;

  List<AssetPackDistributionEntry> entriesNewerThan(String version) {
    if (!_semVerPattern.hasMatch(version)) {
      throw FormatException('Invalid active Asset Pack version: $version');
    }
    final activeVersion = Version.parse(version);
    return packs
        .where((entry) => Version.parse(entry.version) > activeVersion)
        .toList(growable: false);
  }
}

class AssetPackDistributionEntry {
  const AssetPackDistributionEntry({
    required this.version,
    required this.publishedAt,
    required this.minimumAppVersion,
    required this.archivePath,
    required this.archiveSizeBytes,
    required this.archiveSha256,
    required this.localizations,
  });

  factory AssetPackDistributionEntry.fromJson(Map<String, dynamic> json) {
    final version = requireSemVer(json, 'version');
    final publishedAt = requireString(json, 'published_at');
    final minimumAppVersion = requireSemVer(json, 'minimum_app_version');
    final archivePath = requireString(json, 'archive_path');
    final archiveSizeBytes = requireInt(json, 'archive_size_bytes');
    final archiveSha256 = requireString(json, 'archive_sha256');
    if (!_datePattern.hasMatch(publishedAt) ||
        archivePath != 'packs/$version/asset-pack-v$version.zip' ||
        archiveSizeBytes < 1 ||
        !_sha256Pattern.hasMatch(archiveSha256)) {
      throw FormatException('Invalid distribution entry for $version');
    }
    final rawLocalizations = json['localizations'];
    if (rawLocalizations is! Map<String, dynamic>) {
      throw const FormatException('localizations must be an object');
    }
    final localizations = <String, AssetPackChangelogLocalization>{};
    for (final languageCode in const ['ja', 'en']) {
      final rawLocalization = rawLocalizations[languageCode];
      if (rawLocalization is! Map<String, dynamic>) {
        throw FormatException('Missing $languageCode localization');
      }
      localizations[languageCode] = AssetPackChangelogLocalization.fromJson(
        rawLocalization,
      );
    }
    return AssetPackDistributionEntry(
      version: version,
      publishedAt: publishedAt,
      minimumAppVersion: minimumAppVersion,
      archivePath: archivePath,
      archiveSizeBytes: archiveSizeBytes,
      archiveSha256: archiveSha256,
      localizations: Map.unmodifiable(localizations),
    );
  }

  final String version;
  final String publishedAt;
  final String minimumAppVersion;
  final String archivePath;
  final int archiveSizeBytes;
  final String archiveSha256;
  final Map<String, AssetPackChangelogLocalization> localizations;

  AssetPackChangelogLocalization localization({required String languageCode}) =>
      localizations[languageCode] ??
      localizations['en'] ??
      (throw const FormatException('English localization is missing'));
}

class AssetPackChangelogLocalization {
  const AssetPackChangelogLocalization({required this.sections});

  factory AssetPackChangelogLocalization.fromJson(Map<String, dynamic> json) {
    final rawSections = json['sections'];
    if (rawSections is! List || rawSections.isEmpty) {
      throw const FormatException('Changelog sections must not be empty');
    }
    return AssetPackChangelogLocalization(
      sections: rawSections
          .map((value) {
            if (value is! Map<String, dynamic>) {
              throw const FormatException(
                'Changelog section must be an object',
              );
            }
            return AssetPackChangelogSection.fromJson(value);
          })
          .toList(growable: false),
    );
  }

  final List<AssetPackChangelogSection> sections;
}

class AssetPackChangelogSection {
  const AssetPackChangelogSection({required this.title, required this.items});

  factory AssetPackChangelogSection.fromJson(Map<String, dynamic> json) {
    final title = requireString(json, 'title');
    final rawItems = json['items'];
    if (title.isEmpty || rawItems is! List || rawItems.isEmpty) {
      throw const FormatException(
        'Changelog title and items must not be empty',
      );
    }
    final items = rawItems
        .map((value) {
          if (value is! String || value.isEmpty) {
            throw const FormatException('Changelog item must not be empty');
          }
          return value;
        })
        .toList(growable: false);
    return AssetPackChangelogSection(title: title, items: items);
  }

  final String title;
  final List<String> items;
}

String requireSemVer(Map<String, dynamic> json, String key) {
  final value = requireString(json, key);
  if (!_semVerPattern.hasMatch(value)) {
    throw FormatException('$key must be MAJOR.MINOR.PATCH');
  }
  return value;
}

String requireString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! String || value.isEmpty) {
    throw FormatException('$key must be a non-empty string');
  }
  return value;
}

int requireInt(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! int) {
    throw FormatException('$key must be an integer');
  }
  return value;
}
