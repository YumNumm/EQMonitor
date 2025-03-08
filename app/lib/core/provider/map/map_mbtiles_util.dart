import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_mbtiles_util.g.dart';

@Riverpod(keepAlive: true)
MapMbtilesUtil mapMbtilesUtil(Ref ref) => MapMbtilesUtil();

@Riverpod(keepAlive: true)
Future<String> overviewMbtilesPath(Ref ref) async =>
    ref.watch(mapMbtilesUtilProvider).getOverviewMbtilesPath();

class MapMbtilesUtil {
  /// Aseetのoverview.mbtilesをCacheディレクトリにコピーし、そのパスを取得する
  Future<String> getOverviewMbtilesPath() async {
    if (kIsWeb) {
      throw UnimplementedError('Web ではサポートされていません');
    }
    final bundle = await rootBundle.load(Assets.map.overview);

    final hash = md5.convert(bundle.buffer.asUint8List());

    final dir = await getApplicationCacheDirectory();
    final file = File('$dir/overview_$hash.mbtiles');
    if (file.existsSync()) {
      return file.path;
    }

    // overview_* を削除
    for (final file in dir.listSync()) {
      if (file.path.startsWith('overview_') && file.path.endsWith('.mbtiles')) {
        await file.delete();
      }
    }

    await file.writeAsBytes(bundle.buffer.asUint8List());
    return file.path;
  }
}
