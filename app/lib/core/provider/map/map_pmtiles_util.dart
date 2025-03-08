import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_pmtiles_util.g.dart';

@Riverpod(keepAlive: true)
MapPmtilesUtil mapPmtilesUtil(Ref ref) => MapPmtilesUtil();

@Riverpod(keepAlive: true)
Future<String> overviewPmtilesPath(Ref ref) async =>
    ref.watch(mapPmtilesUtilProvider).getOverviewPmtilesPath();

class MapPmtilesUtil {
  /// Aseetのoverview.pmtilesをCacheディレクトリにコピーし、そのパスを取得する
  Future<String> getOverviewPmtilesPath() async {
    if (kIsWeb) {
      throw UnimplementedError('Web ではサポートされていません');
    }
    final bundle = await rootBundle.load(Assets.map.overview);

    final hash = md5.convert(bundle.buffer.asUint8List());

    final dir = await getApplicationCacheDirectory();
    final file = File('${dir.path}/overview_$hash.pmtiles');
    if (file.existsSync()) {
      return file.path;
    }

    // overview_* を削除
    for (final file in dir.listSync()) {
      if (file.path.startsWith('overview_') && file.path.endsWith('.pmtiles')) {
        await file.delete();
      }
    }
    await file.create(recursive: true);
    await file.writeAsBytes(bundle.buffer.asUint8List());
    return file.path;
  }
}
