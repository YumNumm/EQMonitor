import 'dart:io';

import 'package:eqmonitor/core/provider/application_documents_directory.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parameter_local_data_source.g.dart';

@Riverpod(keepAlive: true)
Future<ParameterLocalDataSource> parameterLocalDataSource(Ref ref) async =>
    ParameterLocalDataSource(
      documentsDirectory: ref.watch(applicationDocumentsDirectoryProvider),
    );

final class ParameterLocalDataSource {
  const ParameterLocalDataSource({
    required Directory documentsDirectory,
  }) : _documentsDirectory = documentsDirectory;

  final Directory _documentsDirectory;

  Directory get directory =>
      Directory('${_documentsDirectory.path}/parameters');

  File get manifestFile => File('${directory.path}/manifest.json');

  File get etagFile => File('${directory.path}/etag.txt');

  File parameterFile(ParameterType type) =>
      File('${directory.path}/${type.pathSegment}.json');

  Future<String?> readManifestJson() async {
    final file = manifestFile;
    if (!file.existsSync()) {
      return null;
    }
    return file.readAsString();
  }

  Future<String?> readParameterJson(ParameterType type) async {
    final file = parameterFile(type);
    if (!file.existsSync()) {
      return null;
    }
    return file.readAsString();
  }

  bool hasParameterJson(ParameterType type) => parameterFile(type).existsSync();

  Future<String?> readEtag() async {
    final file = etagFile;
    if (!file.existsSync()) {
      return null;
    }
    final value = await file.readAsString();
    return value.isEmpty ? null : value;
  }

  Future<void> writeManifestJson(String json) async {
    await directory.create(recursive: true);
    await manifestFile.writeAsString(json);
  }

  Future<void> writeParameterJson({
    required ParameterType type,
    required String json,
  }) async {
    await directory.create(recursive: true);
    await parameterFile(type).writeAsString(json);
  }

  Future<void> writeEtag(String? etag) async {
    await directory.create(recursive: true);
    if (etag == null || etag.isEmpty) {
      if (etagFile.existsSync()) {
        await etagFile.delete();
      }
      return;
    }
    await etagFile.writeAsString(etag);
  }
}
