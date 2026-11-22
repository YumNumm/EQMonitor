import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/core/provider/application_documents_directory.dart';
import 'package:eqmonitor/feature/store_screenshot/data/model/store_screenshot_session.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_screenshot_session_repository.g.dart';

@Riverpod(keepAlive: true)
StoreScreenshotSessionRepository storeScreenshotSessionRepository(Ref ref) =>
    StoreScreenshotSessionRepository.inDocuments(
      ref.watch(applicationDocumentsDirectoryProvider),
    );

/// host 側の撮影スクリプトと `store_screenshot/` 配下のファイルで同期する。
/// 形式は `tool/store_screenshots/capture.py` と一致させる。
class StoreScreenshotSessionRepository({required Directory directory}) {
  factory inDocuments(Directory documents) => StoreScreenshotSessionRepository(
    directory: Directory(p.join(documents.path, 'store_screenshot')),
  );

  static const _captureTimeout = Duration(minutes: 5);
  static const _pollInterval = Duration(milliseconds: 200);

  final Directory _directory = directory;

  Future<StoreScreenshotSession> readSession() async {
    final text = await File(p.join(_directory.path, 'session.json'))
        .readAsString();
    return StoreScreenshotSession.fromJson(
      jsonDecode(text) as Map<String, dynamic>,
    );
  }

  Uri fixtureUri({required String name}) =>
      Uri.file(p.join(_directory.path, 'fixtures', name));

  Future<void> markReady({required String scene}) =>
      writeMarker(path: p.join('ready', scene), contents: '');

  Future<void> markDone() => writeMarker(path: 'done', contents: '');

  Future<void> markFailed({
    required Object error,
    required StackTrace stackTrace,
  }) => writeMarker(path: 'failed', contents: '$error\n$stackTrace');

  Future<void> waitForCapture({required String scene}) async {
    final marker = File(p.join(_directory.path, 'captured', scene));
    final stopwatch = Stopwatch()..start();
    while (!marker.existsSync()) {
      if (stopwatch.elapsed > _captureTimeout) {
        throw TimeoutException('host did not capture $scene', _captureTimeout);
      }
      await Future<void>.delayed(_pollInterval);
    }
  }

  Future<void> writeMarker({
    required String path,
    required String contents,
  }) async {
    final target = File(p.join(_directory.path, path));
    await target.parent.create(recursive: true);
    final temporary = File('${target.path}.tmp');
    await temporary.writeAsString(contents, flush: true);
    await temporary.rename(target.path);
  }
}
