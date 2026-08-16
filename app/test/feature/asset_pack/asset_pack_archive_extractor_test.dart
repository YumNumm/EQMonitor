import 'dart:io';

import 'package:archive/archive.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_archive_extractor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'asset_pack_archive_extractor_test_',
    );
  });

  tearDown(() async {
    await temporaryDirectory.delete(recursive: true);
  });

  test('extracts a valid pack into staging storage', () async {
    final archiveFile = await writeZip(
      directory: temporaryDirectory,
      entries: [
        ArchiveFile.string('manifest.json', '{}'),
        ArchiveFile.string('map/base.pmtiles', 'map-data'),
      ],
    );
    final destination = Directory('${temporaryDirectory.path}/staging');

    await const AssetPackArchiveExtractor().extract(
      archiveFile: archiveFile,
      destinationDirectory: destination,
    );

    expect(File('${destination.path}/manifest.json').readAsStringSync(), '{}');
    expect(
      File('${destination.path}/map/base.pmtiles').readAsStringSync(),
      'map-data',
    );
  });

  for (final unsafePath in [
    '../outside.txt',
    '/absolute.txt',
    r'C:\outside.txt',
    r'map\base.pmtiles',
    'map//base.pmtiles',
    './manifest.json',
  ]) {
    test('rejects unsafe archive path: $unsafePath', () async {
      final archiveFile = await writeZip(
        directory: temporaryDirectory,
        entries: [ArchiveFile.string(unsafePath, 'unsafe')],
      );
      final destination = Directory('${temporaryDirectory.path}/staging');

      await expectLater(
        const AssetPackArchiveExtractor().extract(
          archiveFile: archiveFile,
          destinationDirectory: destination,
        ),
        throwsA(isA<AssetPackArchiveException>()),
      );

      expect(destination.existsSync(), isFalse);
      expect(
        File('${temporaryDirectory.path}/outside.txt').existsSync(),
        isFalse,
      );
    });
  }

  test('rejects duplicate archive paths', () async {
    final archiveFile = await writeZip(
      directory: temporaryDirectory,
      entries: [
        ArchiveFile.string('manifest.json', 'first'),
        ArchiveFile.string('manifest.json', 'second'),
      ],
      allowDuplicatePaths: true,
    );

    await expectLater(
      const AssetPackArchiveExtractor().extract(
        archiveFile: archiveFile,
        destinationDirectory: Directory('${temporaryDirectory.path}/staging'),
      ),
      throwsA(isA<AssetPackArchiveException>()),
    );
  });

  test('rejects symbolic links', () async {
    final archiveFile = File('${temporaryDirectory.path}/pack.zip');
    await archiveFile.writeAsBytes(
      encodeZipWithUnixSymlink(name: 'manifest.json', target: '../outside.txt'),
      flush: true,
    );

    await expectLater(
      const AssetPackArchiveExtractor().extract(
        archiveFile: archiveFile,
        destinationDirectory: Directory('${temporaryDirectory.path}/staging'),
      ),
      throwsA(isA<AssetPackArchiveException>()),
    );
  });

  test('rejects archives exceeding the file count limit', () async {
    final archiveFile = await writeZip(
      directory: temporaryDirectory,
      entries: [
        ArchiveFile.string('manifest.json', '{}'),
        ArchiveFile.string('asset.json', '{}'),
      ],
    );

    await expectLater(
      const AssetPackArchiveExtractor(
        limits: AssetPackArchiveLimits(maxFiles: 1),
      ).extract(
        archiveFile: archiveFile,
        destinationDirectory: Directory('${temporaryDirectory.path}/staging'),
      ),
      throwsA(isA<AssetPackArchiveException>()),
    );
  });

  test('rejects archives exceeding the uncompressed size limit', () async {
    final archiveFile = await writeZip(
      directory: temporaryDirectory,
      entries: [ArchiveFile.string('manifest.json', '12345')],
    );

    await expectLater(
      const AssetPackArchiveExtractor(
        limits: AssetPackArchiveLimits(maxUncompressedBytes: 4),
      ).extract(
        archiveFile: archiveFile,
        destinationDirectory: Directory('${temporaryDirectory.path}/staging'),
      ),
      throwsA(isA<AssetPackArchiveException>()),
    );
  });

  test('rejects a pack without a root manifest', () async {
    final archiveFile = await writeZip(
      directory: temporaryDirectory,
      entries: [ArchiveFile.string('nested/manifest.json', '{}')],
    );

    await expectLater(
      const AssetPackArchiveExtractor().extract(
        archiveFile: archiveFile,
        destinationDirectory: Directory('${temporaryDirectory.path}/staging'),
      ),
      throwsA(isA<AssetPackArchiveException>()),
    );
  });
}

Future<File> writeZip({
  required Directory directory,
  required List<ArchiveFile> entries,
  bool allowDuplicatePaths = false,
}) async {
  final bytes = allowDuplicatePaths
      ? encodeZipWithDuplicates(entries)
      : ZipEncoder().encodeBytes(Archive()..addFiles(entries));
  final file = File('${directory.path}/pack.zip');
  await file.writeAsBytes(bytes, flush: true);
  return file;
}

List<int> encodeZipWithDuplicates(List<ArchiveFile> entries) {
  final output = OutputMemoryStream();
  final encoder = ZipEncoder()..startEncode(output);
  for (final entry in entries) {
    encoder.add(entry);
  }
  encoder.endEncode();
  return output.getBytes();
}

List<int> encodeZipWithUnixSymlink({
  required String name,
  required String target,
}) {
  final entry = ArchiveFile.string(name, target)..mode = 0xa1ff;
  final bytes = ZipEncoder().encodeBytes(Archive()..add(entry));
  const centralDirectorySignature = [0x50, 0x4b, 0x01, 0x02];
  for (var index = 0; index <= bytes.length - 6; index++) {
    final isCentralDirectory =
        bytes[index] == centralDirectorySignature[0] &&
        bytes[index + 1] == centralDirectorySignature[1] &&
        bytes[index + 2] == centralDirectorySignature[2] &&
        bytes[index + 3] == centralDirectorySignature[3];
    if (isCentralDirectory) {
      bytes[index + 5] = 3;
      return bytes;
    }
  }
  throw StateError('ZIP central directory was not found');
}

extension on Archive {
  void addFiles(List<ArchiveFile> entries) {
    for (final entry in entries) {
      add(entry);
    }
  }
}
