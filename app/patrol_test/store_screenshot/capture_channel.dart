import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// host 側の `tool/store_screenshots/capture.py` とアプリの Documents 配下で同期する。
/// テストが `ready/<scene>` を書くと host が画面全体を撮影し、`captured/<scene>` を書く。
class StoreScreenshotCaptureChannel._(final Directory _directory) {
  // 負荷の高い macOS runner では simctl の応答が分単位で遅れた。
  static const _captureTimeout = Duration(minutes: 15);
  static const _pollInterval = Duration(milliseconds: 200);

  static Future<StoreScreenshotCaptureChannel> open() async {
    final documents = await getApplicationDocumentsDirectory();
    final directory = Directory(p.join(documents.path, 'store_screenshot'));
    if (directory.existsSync()) {
      await directory.delete(recursive: true);
    }
    await directory.create(recursive: true);
    return StoreScreenshotCaptureChannel._(directory);
  }

  Future<void> capture(String scene) async {
    await _write(p.join('ready', scene));
    final marker = File(p.join(_directory.path, 'captured', scene));
    final stopwatch = Stopwatch()..start();
    while (!marker.existsSync()) {
      if (stopwatch.elapsed > _captureTimeout) {
        throw TimeoutException('host did not capture $scene', _captureTimeout);
      }
      await Future<void>.delayed(_pollInterval);
    }
  }

  Future<void> markDone() => _write('done');

  Future<void> _write(String relativePath) async {
    final target = File(p.join(_directory.path, relativePath));
    await target.parent.create(recursive: true);
    final temporary = File('${target.path}.tmp');
    await temporary.writeAsString('', flush: true);
    await temporary.rename(target.path);
  }
}
