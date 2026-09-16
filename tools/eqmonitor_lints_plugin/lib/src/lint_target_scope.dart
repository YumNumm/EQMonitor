/// 自作 lint ルールの適用対象を判定する。
///
/// テストコードは本番コードと設計上の要求が異なるため、
/// 自作ルールの適用対象外とする（標準 lint は従来どおり適用される）。
///
/// build_runner 等が生成したコードも、人手で直せないため対象外とする。
class LintTargetScope {
  const new _();

  static const _excludedDirectories = {
    'test',
    'integration_test',
    'test_driver',
  };

  static const _generatedFileSuffixes = {
    '.g.dart',
    '.freezed.dart',
    '.gen.dart',
    '.gr.dart',
    '.mocks.dart',
    '.tailor.dart',
    '.config.dart',
  };

  /// [path] がテストコードなら `true`。
  ///
  /// 本番の Dart コードは必ず `lib/` 配下にあるため、`lib` セグメント
  /// より前（＝祖先ディレクトリ）に `test` 等が現れても除外しない。
  /// これにより `~/test/EQMonitor/app/lib/...` のように、たまたま
  /// `test` という名前の祖先ディレクトリ配下にクローンしても、本番コードの
  /// ルールが無効化されない。
  static bool isExcluded({required String path}) {
    final segments = path.replaceAll(r'\', '/').split('/');
    final lastLibIndex = segments.lastIndexOf('lib');
    for (var i = 0; i < segments.length; i++) {
      // lib セグメント（およびその祖先）までは本番コードの経路として無視する。
      if (i <= lastLibIndex) {
        continue;
      }
      if (_excludedDirectories.contains(segments[i])) {
        return true;
      }
    }
    return false;
  }

  /// [path] が build_runner 等による生成コードなら `true`。
  static bool isGenerated({required String path}) {
    final fileName = path.replaceAll(r'\', '/').split('/').last;
    return _generatedFileSuffixes.any(fileName.endsWith);
  }
}
