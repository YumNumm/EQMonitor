import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_distribution_manifest_validator.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> entry(String version) => {
  'version': version,
  'published_at': '2026-08-16',
  'minimum_app_version': '3.0.0',
  'archive_path': 'packs/$version/asset-pack-v$version.zip',
  'archive_size_bytes': 1024,
  'archive_sha256': 'a' * 64,
  'localizations': {
    'ja': {
      'sections': [
        {
          'title': '更新',
          'items': ['地図を更新しました'],
        },
      ],
    },
    'en': {
      'sections': [
        {
          'title': 'Changes',
          'items': ['Updated the map'],
        },
      ],
    },
  },
};

Map<String, dynamic> manifest() => {
  'schema_version': 1,
  'revision': 2,
  'latest_version': '1.2.0',
  'generated_at': '2026-08-16T00:00:00Z',
  'packs': [entry('1.2.0'), entry('1.1.0')],
};

void main() {
  const validator = AssetPackDistributionManifestValidator();

  group('AssetPackDistributionManifestValidator', () {
    test('parses newest-first immutable archive metadata', () {
      final parsed = validator.parse(manifest());

      expect(parsed.revision, 2);
      expect(parsed.latestVersion, '1.2.0');
      expect(
        parsed.packs.first.archivePath,
        'packs/1.2.0/asset-pack-v1.2.0.zip',
      );
      expect(
        parsed.packs.first
            .localization(languageCode: 'ja')
            .sections
            .first
            .title,
        '更新',
      );
      expect(
        parsed.packs.first
            .localization(languageCode: 'fr')
            .sections
            .first
            .title,
        'Changes',
      );
    });

    test(
      'rejects invalid top-level versions, revision, and latest pointer',
      () {
        for (final invalid in [
          {...manifest(), 'latest_version': '1.2.0-rc.1'},
          {...manifest(), 'revision': 0},
          {...manifest(), 'latest_version': '1.1.0'},
        ]) {
          expect(() => validator.parse(invalid), throwsFormatException);
        }
      },
    );

    test('rejects duplicate and non-descending pack versions', () {
      for (final packs in [
        [entry('1.2.0'), entry('1.2.0')],
        [entry('1.1.0'), entry('1.2.0')],
      ]) {
        expect(
          () => validator.parse({
            ...manifest(),
            'latest_version': packs.first['version'],
            'packs': packs,
          }),
          throwsFormatException,
        );
      }
    });

    test('rejects an archive path not fixed to the entry version', () {
      final invalid = manifest();
      final packs = invalid['packs'];
      if (packs is! List || packs.first is! Map<String, dynamic>) {
        fail('test manifest packs shape is invalid');
      }
      final first = packs.first as Map<String, dynamic>;
      first['archive_path'] = '../pack.zip';

      expect(() => validator.parse(invalid), throwsFormatException);
    });

    test('rejects a malformed structure as a FormatException', () {
      for (final invalid in [
        {...manifest(), 'revision': '2'},
        {...manifest()}..remove('packs'),
      ]) {
        expect(() => validator.parse(invalid), throwsFormatException);
      }
    });

    test('requires Japanese and English non-empty changelog sections', () {
      final validLocalization = <String, dynamic>{
        'sections': <Map<String, dynamic>>[
          {
            'title': '更新',
            'items': ['地図を更新しました'],
          },
        ],
      };
      final invalidLocalizations = <Map<String, dynamic>>[
        {'ja': validLocalization},
        {
          'ja': <String, dynamic>{'sections': <Map<String, dynamic>>[]},
          'en': validLocalization,
        },
        {
          'ja': validLocalization,
          'en': <String, dynamic>{
            'sections': <Map<String, dynamic>>[
              {'title': '', 'items': <String>[]},
            ],
          },
        },
      ];

      for (final localizations in invalidLocalizations) {
        final invalid = manifest();
        final packs = invalid['packs'];
        if (packs is! List || packs.first is! Map<String, dynamic>) {
          fail('test manifest packs shape is invalid');
        }
        (packs.first as Map<String, dynamic>)['localizations'] = localizations;

        expect(() => validator.parse(invalid), throwsFormatException);
      }
    });

    test('returns all changelog entries newer than the active version', () {
      final parsed = validator.parse({
        ...manifest(),
        'revision': 3,
        'latest_version': '1.3.0',
        'packs': [entry('1.3.0'), entry('1.2.0'), entry('1.1.0')],
      });

      expect(parsed.entriesNewerThan('1.1.0').map((value) => value.version), [
        '1.3.0',
        '1.2.0',
      ]);
    });
  });
}
