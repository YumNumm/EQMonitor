import 'package:eqmonitor_custom_lints/src/lint_target_scope.dart';
import 'package:test/test.dart';

void main() {
  group('LintTargetScope.isExcluded', () {
    test('test ディレクトリ配下は除外する', () {
      expect(
        LintTargetScope.isExcluded(
          path: '/repo/app/test/feature/eew/a_test.dart',
        ),
        isTrue,
      );
    });

    test('integration_test 配下は除外する', () {
      expect(
        LintTargetScope.isExcluded(
          path: '/repo/app/integration_test/app_test.dart',
        ),
        isTrue,
      );
    });

    test('test_driver 配下は除外する', () {
      expect(
        LintTargetScope.isExcluded(path: '/repo/app/test_driver/driver.dart'),
        isTrue,
      );
    });

    test('lib 配下は除外しない', () {
      expect(
        LintTargetScope.isExcluded(
          path: '/repo/app/lib/feature/eew/eew_page.dart',
        ),
        isFalse,
      );
    });

    test('ファイル名やディレクトリ名の部分一致では除外しない', () {
      expect(
        LintTargetScope.isExcluded(
          path: '/repo/app/lib/core/util/latest_test_helper.dart',
        ),
        isFalse,
      );
      expect(
        LintTargetScope.isExcluded(
          path: '/repo/app/lib/feature/contest/page.dart',
        ),
        isFalse,
      );
    });

    test('Windows 形式の区切り文字でも除外する', () {
      expect(
        LintTargetScope.isExcluded(
          path: r'C:\repo\app\test\feature\a_test.dart',
        ),
        isTrue,
      );
    });

    test('test という名前の祖先ディレクトリ配下でも lib 配下は除外しない', () {
      expect(
        LintTargetScope.isExcluded(
          path: '/home/test/EQMonitor/app/lib/feature/eew/eew_page.dart',
        ),
        isFalse,
      );
      expect(
        LintTargetScope.isExcluded(
          path: '/work/test_driver/EQMonitor/app/lib/main.dart',
        ),
        isFalse,
      );
    });

    test('祖先が test でも test/ 配下の実テストは除外する', () {
      expect(
        LintTargetScope.isExcluded(
          path: '/home/test/EQMonitor/app/test/feature/a_test.dart',
        ),
        isTrue,
      );
    });
  });
}
