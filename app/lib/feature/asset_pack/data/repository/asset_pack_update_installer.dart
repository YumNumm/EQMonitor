import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_archive_extractor.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_storage_repository.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/r2_asset_pack_archive_downloader.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_pack_update_installer.g.dart';

typedef DownloadAssetPackArchive = Future<File> Function({
  required AssetPackDistributionEntry entry,
  required void Function(double progress) onProgress,
});

enum AssetPackInstallPhase {
  downloading,
  verifying,
  extracting,
  activating,
  completed,
}

class AssetPackInstallProgress {
  const new({required this.phase, required this.progress});

  final AssetPackInstallPhase phase;
  final double progress;
}

class AssetPackInstallException implements Exception {
  const new(this.message);

  final String message;

  @override
  String toString() => 'AssetPackInstallException: $message';
}

class AssetPackUpdateInstaller {
  new({
    required this.storageRepository,
    required DownloadAssetPackArchive downloadArchive,
    AssetPackArchiveExtractor archiveExtractor =
        const AssetPackArchiveExtractor(),
  }) : _downloadArchive = downloadArchive,
       _archiveExtractor = archiveExtractor;

  final AssetPackStorageRepository storageRepository;
  final DownloadAssetPackArchive _downloadArchive;
  final AssetPackArchiveExtractor _archiveExtractor;

  Future<void> install({
    required AssetPackDistributionEntry entry,
    required void Function(AssetPackInstallProgress progress) onProgress,
  }) async {
    File? archiveFile;
    Directory? stagingWorkspace;
    try {
      onProgress(
        const AssetPackInstallProgress(
          phase: AssetPackInstallPhase.downloading,
          progress: 0,
        ),
      );
      archiveFile = await _downloadArchive(
        entry: entry,
        onProgress: (progress) => onProgress(
          AssetPackInstallProgress(
            phase: AssetPackInstallPhase.downloading,
            progress: progress.clamp(0, 1),
          ),
        ),
      );
      onProgress(
        const AssetPackInstallProgress(
          phase: AssetPackInstallPhase.verifying,
          progress: 1,
        ),
      );
      await verifyAssetPackArchive(archiveFile: archiveFile, entry: entry);
      stagingWorkspace = await storageRepository.createStagingDirectory(
        version: entry.version,
      );
      final extractedDirectory = Directory(
        p.join(stagingWorkspace.path, 'payload'),
      );
      onProgress(
        const AssetPackInstallProgress(
          phase: AssetPackInstallPhase.extracting,
          progress: 1,
        ),
      );
      await _archiveExtractor.extract(
        archiveFile: archiveFile,
        destinationDirectory: extractedDirectory,
      );
      onProgress(
        const AssetPackInstallProgress(
          phase: AssetPackInstallPhase.activating,
          progress: 1,
        ),
      );
      await storageRepository.activate(
        stagingDirectory: extractedDirectory,
        version: entry.version,
      );
      onProgress(
        const AssetPackInstallProgress(
          phase: AssetPackInstallPhase.completed,
          progress: 1,
        ),
      );
    } on AssetPackInstallException {
      rethrow;
    } on Object catch (error) {
      throw AssetPackInstallException('Asset Pack の更新を適用できませんでした: $error');
    } finally {
      await deleteAssetPackTemporaryFile(file: archiveFile);
      await deleteAssetPackTemporaryDirectory(directory: stagingWorkspace);
    }
  }
}

@Riverpod(keepAlive: true)
Future<AssetPackUpdateInstaller> assetPackUpdateInstaller(Ref ref) async {
  final storage = await ref.watch(assetPackStorageRepositoryProvider.future);
  final downloader = R2AssetPackArchiveDownloader();
  return AssetPackUpdateInstaller(
    storageRepository: storage,
    downloadArchive: downloader.download,
  );
}

Future<void> verifyAssetPackArchive({
  required File archiveFile,
  required AssetPackDistributionEntry entry,
}) async {
  if (!archiveFile.existsSync() ||
      await archiveFile.length() != entry.archiveSizeBytes) {
    throw const AssetPackInstallException('ダウンロードした ZIP のサイズが配信情報と一致しません。');
  }
  final digest = await sha256.bind(archiveFile.openRead()).first;
  if (digest.toString() != entry.archiveSha256) {
    throw const AssetPackInstallException('ダウンロードした ZIP のハッシュが配信情報と一致しません。');
  }
}

Future<void> deleteAssetPackTemporaryFile({required File? file}) async {
  try {
    if (file != null && file.existsSync()) {
      await file.delete();
    }
  } on FileSystemException {
    // Temporary storage is never activated. The OS can reclaim it later.
  }
}

Future<void> deleteAssetPackTemporaryDirectory({
  required Directory? directory,
}) async {
  try {
    if (directory != null && directory.existsSync()) {
      await directory.delete(recursive: true);
    }
  } on FileSystemException {
    // Temporary storage is never activated. The OS can reclaim it later.
  }
}
