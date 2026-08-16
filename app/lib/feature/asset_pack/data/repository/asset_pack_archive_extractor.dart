import 'dart:io';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;

class AssetPackArchiveException implements Exception {
  const new(this.message);

  final String message;

  @override
  String toString() => 'AssetPackArchiveException: $message';
}

class AssetPackArchiveLimits {
  const new({
    this.maxFiles = 1024,
    this.maxUncompressedBytes = 1024 * 1024 * 1024,
    this.maxSingleFileBytes = 768 * 1024 * 1024,
  });

  final int maxFiles;
  final int maxUncompressedBytes;
  final int maxSingleFileBytes;
}

class AssetPackArchiveExtractor {
  const new({
    this.limits = const AssetPackArchiveLimits(),
  });

  final AssetPackArchiveLimits limits;

  Future<void> extract({
    required File archiveFile,
    required Directory destinationDirectory,
  }) async {
    if (destinationDirectory.existsSync()) {
      throw const AssetPackArchiveException('展開先の一時ディレクトリが既に存在します。');
    }

    final input = InputFileStream(archiveFile.path);
    var destinationCreated = false;
    var extractionCompleted = false;
    try {
      final names = <String>{};
      var fileCount = 0;
      var totalBytes = 0;
      final archive = ZipDecoder().decodeStream(
        input,
        callback: (entry) {
          validateArchiveEntry(entry: entry, names: names, limits: limits);
          fileCount++;
          totalBytes += entry.size;
          if (fileCount > limits.maxFiles) {
            throw const AssetPackArchiveException('ZIP 内のファイル数が上限を超えています。');
          }
          if (totalBytes > limits.maxUncompressedBytes) {
            throw const AssetPackArchiveException('ZIP の展開後サイズが上限を超えています。');
          }
        },
      );

      final rootManifest = archive.find('manifest.json');
      if (rootManifest == null || !rootManifest.isFile) {
        throw const AssetPackArchiveException(
          'ZIP のルートに manifest.json がありません。',
        );
      }

      await destinationDirectory.create(recursive: true);
      destinationCreated = true;
      for (final entry in archive) {
        await extractArchiveEntry(
          entry: entry,
          destinationDirectory: destinationDirectory,
        );
      }
      extractionCompleted = true;
    } on AssetPackArchiveException {
      rethrow;
    } on Object catch (error) {
      throw AssetPackArchiveException('ZIP を安全に展開できませんでした: $error');
    } finally {
      await input.close();
      if (destinationCreated && !extractionCompleted) {
        await destinationDirectory.delete(recursive: true);
      }
    }
  }
}

void validateArchiveEntry({
  required ArchiveFile entry,
  required Set<String> names,
  required AssetPackArchiveLimits limits,
}) {
  final name = entry.name;
  final drivePathPattern = RegExp(r'^[A-Za-z]:');
  if (name.isEmpty ||
      name.startsWith('/') ||
      drivePathPattern.hasMatch(name) ||
      name.contains(r'\')) {
    throw AssetPackArchiveException('ZIP に不正なパスが含まれています: $name');
  }

  final pathWithoutDirectorySuffix = entry.isDirectory && name.endsWith('/')
      ? name.substring(0, name.length - 1)
      : name;
  final segments = pathWithoutDirectorySuffix.split('/');
  if (segments.isEmpty ||
      segments.any(
        (segment) => segment.isEmpty || segment == '.' || segment == '..',
      )) {
    throw AssetPackArchiveException('ZIP に不正なパスが含まれています: $name');
  }
  if (!names.add(name)) {
    throw AssetPackArchiveException('ZIP に重複したパスが含まれています: $name');
  }
  if (entry.isSymbolicLink) {
    throw AssetPackArchiveException('ZIP にシンボリックリンクが含まれています: $name');
  }
  if (entry.size < 0 || entry.size > limits.maxSingleFileBytes) {
    throw AssetPackArchiveException('ZIP 内のファイルサイズが不正です: $name');
  }
}

Future<void> extractArchiveEntry({
  required ArchiveFile entry,
  required Directory destinationDirectory,
}) async {
  final destinationRoot = p.normalize(p.absolute(destinationDirectory.path));
  final destinationPath = p.normalize(p.join(destinationRoot, entry.name));
  if (destinationPath != destinationRoot &&
      !p.isWithin(destinationRoot, destinationPath)) {
    throw AssetPackArchiveException('ZIP の展開先が許可範囲外です: ${entry.name}');
  }

  if (entry.isDirectory) {
    await Directory(destinationPath).create(recursive: true);
    return;
  }

  final outputFile = File(destinationPath);
  await outputFile.parent.create(recursive: true);
  final output = OutputFileStream(outputFile.path);
  try {
    entry.writeContent(output);
  } finally {
    await output.close();
  }
  final actualSize = await outputFile.length();
  if (actualSize != entry.size) {
    throw AssetPackArchiveException('ZIP 内のファイルサイズが一致しません: ${entry.name}');
  }
}
