import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/background_asset_pack_archive_downloader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'background_asset_pack_archive_downloader_test_',
    );
  });

  tearDown(() async {
    await temporaryDirectory.delete(recursive: true);
  });

  test('builds a background task on R2 and forwards progress', () async {
    DownloadTask? capturedTask;
    final output = File('${temporaryDirectory.path}/pack.zip');
    final progress = <double>[];
    final downloader = BackgroundAssetPackArchiveDownloader(
      runTask: ({required task, required onProgress}) async {
        capturedTask = task;
        await output.writeAsString('zip');
        onProgress(0.5);
        return TaskStatusUpdate(task, TaskStatus.complete);
      },
      resolveTaskFile: (task) async => output,
    );

    final file = await downloader.download(
      entry: distributionEntry,
      onProgress: progress.add,
    );

    expect(file.path, output.path);
    expect(capturedTask?.url, contains(distributionEntry.archivePath));
    expect(capturedTask?.baseDirectory, BaseDirectory.temporary);
    expect(capturedTask?.updates, Updates.statusAndProgress);
    expect(capturedTask?.retries, 2);
    expect(progress, [0.5]);
  });

  test('reports a safe exception when the background task fails', () async {
    final downloader = BackgroundAssetPackArchiveDownloader(
      runTask: ({required task, required onProgress}) async =>
          TaskStatusUpdate(task, TaskStatus.failed),
      resolveTaskFile: (task) async => File('${temporaryDirectory.path}/none'),
    );

    await expectLater(
      downloader.download(entry: distributionEntry, onProgress: (_) {}),
      throwsA(isA<AssetPackArchiveDownloadException>()),
    );
  });
}

const distributionEntry = AssetPackDistributionEntry(
  version: '1.2.3',
  publishedAt: '2026-08-16',
  minimumAppVersion: '3.0.0',
  archivePath: 'packs/1.2.3/asset-pack-v1.2.3.zip',
  archiveSizeBytes: 3,
  archiveSha256:
      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  localizations: {},
);
