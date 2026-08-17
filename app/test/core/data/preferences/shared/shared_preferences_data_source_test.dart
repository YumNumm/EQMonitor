import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utils/configurable_shared_preferences.dart';

void main() {
  test('setBool はプラットフォームが false を返した場合に例外を送出する', () async {
    final preferences = ConfigurableSharedPreferences(setBoolResult: false);
    final dataSource = SharedPreferencesDataSource(
      sharedPreferences: preferences,
    );

    await expectLater(
      dataSource.setBool(key: .eewHistoryNoticeShown, value: true),
      throwsStateError,
    );
  });

  test('setBool はプラットフォームの例外を呼び出し元へ伝える', () async {
    final writeError = Exception('write failed');
    final preferences = ConfigurableSharedPreferences(setBoolError: writeError);
    final dataSource = SharedPreferencesDataSource(
      sharedPreferences: preferences,
    );

    await expectLater(
      dataSource.setBool(key: .eewHistoryNoticeShown, value: true),
      throwsA(same(writeError)),
    );
  });
}
