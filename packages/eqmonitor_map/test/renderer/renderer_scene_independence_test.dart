import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// 設計正本「domain、reconciler、packed meshはFlutter Scene型へ依存させず、
/// `MapSceneRendererAdapter`境界でGeometry/Material/bufferへ変換する」と
/// README「Flutter Scene型は`flutter_scene/` adapter内へ隔離する」を、
/// doc commentの約束ではなくsource走査で機械的に保証する。
///
/// `flutter_scene`をどこからでも触れる状態のままでは、`foundation/`や
/// `renderer/`へScene型が1つ混ざった瞬間にpacked mesh契約の意味が失われ、
/// しかもGPU初期化を要するためunit testが書けなくなる。この境界は
/// 人手のreviewではなくtestで守る。
void main() {
  final packageRoot = Directory.current;

  List<File> dartFilesUnder(String relativePath) {
    final directory = Directory('${packageRoot.path}/$relativePath');
    expect(
      directory.existsSync(),
      isTrue,
      reason:
          '$relativePath が見つからない。testはpackage rootから実行すること '
          '(cd packages/eqmonitor_map && flutter test)。',
    );
    return directory
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .toList();
  }

  /// `flutter_scene`/`scene`パッケージへのimportを持つファイルのpath。
  List<String> sceneDependentFilesUnder(String relativePath) => [
    for (final file in dartFilesUnder(relativePath))
      if (RegExp(
        r'''^\s*import\s+['"]package:(flutter_scene|scene)/''',
        multiLine: true,
      ).hasMatch(file.readAsStringSync()))
        file.path.substring(packageRoot.path.length + 1),
  ];

  test('foundation does not depend on Flutter Scene', () {
    expect(sceneDependentFilesUnder('lib/src/foundation'), isEmpty);
  });

  test('renderer does not depend on Flutter Scene', () {
    // `renderer/`はpacked byte・行列・uniform byteだけを扱う層であり、
    // Scene型への変換は`flutter_scene/`のadapterが担う。
    expect(sceneDependentFilesUnder('lib/src/renderer'), isEmpty);
  });

  test('mesh, tile, and geo layers do not depend on Flutter Scene', () {
    expect(sceneDependentFilesUnder('lib/src/mesh'), isEmpty);
    expect(sceneDependentFilesUnder('lib/src/tile'), isEmpty);
    expect(sceneDependentFilesUnder('lib/src/geo'), isEmpty);
  });

  test('Flutter Scene is reachable only from flutter_scene/ and widget/', () {
    final sceneDependents = sceneDependentFilesUnder('lib');

    expect(sceneDependents, isNotEmpty, reason: 'adapter層は実際にSceneを使う');
    for (final path in sceneDependents) {
      expect(
        path.startsWith('lib/src/flutter_scene/') ||
            path.startsWith('lib/src/widget/'),
        isTrue,
        reason: '$path がFlutter Sceneへ依存している',
      );
    }
  });
}
