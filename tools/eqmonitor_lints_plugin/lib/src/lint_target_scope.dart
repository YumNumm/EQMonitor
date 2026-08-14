/// 自作 lint ルールの適用対象を判定する。
///
/// テストコードは本番コードと設計上の要求が異なるため、
/// 自作ルールの適用対象外とする（標準 lint は従来どおり適用される）。
class LintTargetScope {
  const LintTargetScope._();

  static const _excludedDirectories = {
    'test',
    'integration_test',
    'test_driver',
  };

  static bool isExcluded({required String path}) {
    final segments = path.replaceAll(r'\', '/').split('/');
    return segments.any(_excludedDirectories.contains);
  }
}
