import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_cached_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:path_provider/path_provider.dart';

/// GeoJSON取得失敗時のフォールバック用ローカルキャッシュ。
///
/// span ごとに `<ApplicationSupportDirectory>/seismicity/dataset_<span>.json`
/// へ JSON を書き込む。[directoryProvider] はテストで一時ディレクトリを
/// 注入するためのフック(未指定時は [getApplicationSupportDirectory])。
class SeismicityLocalCacheDataSource {
  SeismicityLocalCacheDataSource({
    Future<Directory> Function()? directoryProvider,
  }) : _directoryProvider = directoryProvider ?? getApplicationSupportDirectory;

  final Future<Directory> Function() _directoryProvider;

  Future<File> _fileFor(SeismicitySpan span) async {
    final baseDir = await _directoryProvider();
    final cacheDir = Directory('${baseDir.path}/seismicity');
    await cacheDir.create(recursive: true);
    return File('${cacheDir.path}/dataset_${span.name}.json');
  }

  Future<void> save(
    SeismicitySpan span,
    SeismicityCachedDataset dataset,
  ) async {
    final file = await _fileFor(span);
    await file.writeAsString(jsonEncode(dataset.toJson()));
  }

  Future<SeismicityCachedDataset?> read(SeismicitySpan span) async {
    final file = await _fileFor(span);
    if (!file.existsSync()) {
      return null;
    }
    final content = await file.readAsString();
    return SeismicityCachedDataset.fromJson(
      jsonDecode(content) as Map<String, dynamic>,
    );
  }
}
