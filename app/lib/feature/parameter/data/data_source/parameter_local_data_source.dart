import 'dart:io';

import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';

final class ParameterLocalDataSource {
  const ParameterLocalDataSource({required Directory documentsDirectory})
    : _documentsDirectory = documentsDirectory;

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

  Future<bool> hasParameterJson(ParameterType type) =>
      parameterFile(type).exists();

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
