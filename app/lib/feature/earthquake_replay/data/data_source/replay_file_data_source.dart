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
    if (Platform.isIOS && source.pathSegments.contains('Inbox')) {
      await file.delete();
    }
    return (bytes: bytes, name: source.pathSegments.last);
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
