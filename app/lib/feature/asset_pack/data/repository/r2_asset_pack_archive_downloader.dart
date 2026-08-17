import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_distribution_repository.dart';

typedef RunAssetPackDownloadTask = Future<TaskStatusUpdate> Function({
  required DownloadTask task,
  required void Function(double progress) onProgress,
});
typedef ResolveAssetPackDownloadTaskFile = Future<File> Function(
  DownloadTask task,
);

class AssetPackArchiveDownloadException implements Exception {
  const new(this.message);

  final String message;

  @override
  String toString() => 'AssetPackArchiveDownloadException: $message';
}

class R2AssetPackArchiveDownloader {
  new({
    RunAssetPackDownloadTask? runTask,
    ResolveAssetPackDownloadTaskFile? resolveTaskFile,
    this.baseUrl = assetPackDistributionBaseUrl,
  }) : _runTask = runTask ?? runBackgroundAssetPackDownloadTask,
       _resolveTaskFile =
           resolveTaskFile ?? resolveBackgroundAssetPackDownloadTaskFile;

  final RunAssetPackDownloadTask _runTask;
  final ResolveAssetPackDownloadTaskFile _resolveTaskFile;
  final String baseUrl;

  Future<File> download({
    required AssetPackDistributionEntry entry,
    required void Function(double progress) onProgress,
  }) async {
    final task = DownloadTask(
      taskId: 'eqmonitor_asset_pack_${entry.version.replaceAll('.', '_')}',
      url: '$baseUrl/${entry.archivePath}',
      filename: 'asset-pack-v${entry.version}.zip',
      directory: 'eqmonitor_asset_packs/downloads',
      baseDirectory: BaseDirectory.temporary,
      group: 'eqmonitor_asset_pack',
      updates: Updates.statusAndProgress,
      retries: 2,
      allowPause: true,
      displayName: 'EQMonitor Asset Pack ${entry.version}',
    );
    final outputFile = await _resolveTaskFile(task);
    if (outputFile.existsSync()) {
      onProgress(1);
      return outputFile;
    }
    final result = await _runTask(task: task, onProgress: onProgress);
    if (result.status != TaskStatus.complete || !outputFile.existsSync()) {
      throw const AssetPackArchiveDownloadException(
        'Asset Pack のダウンロードを完了できませんでした。',
      );
    }
    return outputFile;
  }
}

Future<TaskStatusUpdate> runBackgroundAssetPackDownloadTask({
  required DownloadTask task,
  required void Function(double progress) onProgress,
}) => FileDownloader().download(task, onProgress: onProgress);

Future<File> resolveBackgroundAssetPackDownloadTaskFile(
  DownloadTask task,
) async => File(await task.filePath());
