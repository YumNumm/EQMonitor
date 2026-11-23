import 'dart:io';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_file_exception.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_file_data_source.g.dart';

@Riverpod(keepAlive: true)
ReplayFileDataSource replayFileDataSource(Ref ref) =>
    const ReplayFileDataSource(
      MethodChannel('net.yumnumm.eqmonitor/replay_file'),
    );

typedef ReplayFileDocument = ({Uint8List bytes, String name});

class const ReplayFileDataSource(final MethodChannel _channel) {
  Future<Uri?> pick() async {
    final file = await FilePicker.pickFile();
    if (file == null) {
      return null;
    }
    final path = file.path;
    if (path == null || path.isEmpty) {
      throw const ReplayFileException(.unreadable);
    }
    return Uri.file(path);
  }

  // file_picker は選んだファイルを一時領域へ複製する。取り込み後に残すと、その分の容量を使い続ける。
  Future<void> clearPickedFiles() async {
    try {
      await FilePicker.clearTemporaryFiles();
    } on Exception catch (error, stackTrace) {
      talker.warning(
        '[Replay] failed to clear picked files',
        error,
        stackTrace,
      );
    }
  }

  Future<ReplayFileDocument> read({required Uri source}) async {
    try {
      return switch (source.scheme) {
        'file' => await readFile(source: source),
        'content' => await readContentUri(source: source),
        _ => throw const ReplayFileException(.unsupportedSource),
      };
    } on ReplayFileException {
      rethrow;
    } on Object catch (error, stackTrace) {
      talker.error('[Replay] failed to read $source', error, stackTrace);
      throw const ReplayFileException(.unreadable);
    }
  }

  Future<ReplayFileDocument> readFile({required Uri source}) async {
    final file = File.fromUri(source);
    final bytes = await file.readAsBytes();
    // iOS は「ファイルで開く」で受け取った書類を Documents/Inbox へ複製して渡す。
    // 読み込み後に残しても再利用されないため削除する。
    if (Platform.isIOS && isInbox(source: source)) {
      await file.delete();
    }
    return (bytes: bytes, name: source.pathSegments.last);
  }

  // 保存先のフォルダ名は利用者が決められるため、Documents 直下の Inbox だけを対象にする。
  bool isInbox({required Uri source}) {
    final segments = source.pathSegments;
    final index = segments.length - 2;
    return index >= 1 &&
        segments[index] == 'Inbox' &&
        segments[index - 1] == 'Documents';
  }

  Future<ReplayFileDocument> readContentUri({required Uri source}) async {
    final result = await _channel.invokeMapMethod<String, Object?>(
      'readContentUri',
      {'uri': source.toString()},
    );
    final bytes = result?['bytes'];
    if (bytes is! Uint8List) {
      throw const ReplayFileException(.unreadable);
    }
    final name = result?['name'];
    return (
      bytes: bytes,
      name: name is String && name.isNotEmpty ? name : source.pathSegments.last,
    );
  }
}
