import 'dart:developer';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_disable_confirmation_repository.g.dart';

@Riverpod(keepAlive: true)
ShakeDetectionDisableConfirmationRepository
shakeDetectionDisableConfirmationRepository(Ref ref) =>
    ShakeDetectionDisableConfirmationRepository(
      dataSource: () => ref.read(sharedPreferencesDataSourceProvider.future),
    );

/// 揺れ検知通知を利用できない端末で、サーバー側の通知条件が無効であることを
/// 確認済みかどうかを端末に保存する。
///
/// 確認済みの間は、起動のたびにサーバーへ問い合わせない。通知条件を有効に
/// し得る操作（保存・有効な条件の読み込み・端末の再登録）で取り消す。
/// 読み書きに失敗した場合は未確認として扱い、サーバーへの確認を省略しない。
class const ShakeDetectionDisableConfirmationRepository({
  required final Future<SharedPreferencesDataSource> Function() dataSource,
}) {
  Future<bool> isConfirmed() async {
    try {
      return await (await dataSource()).getBool(
            key: SharedPreferencesKey
                .shakeDetectionNotificationsDisabledConfirmed,
          ) ??
          false;
    } on Object catch (error, stackTrace) {
      log(
        'failed to read confirmation',
        name: 'ShakeDetectionDisableConfirmationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<void> markConfirmed() async {
    try {
      await (await dataSource()).setBool(
        key: SharedPreferencesKey.shakeDetectionNotificationsDisabledConfirmed,
        value: true,
      );
    } on Object catch (error, stackTrace) {
      log(
        'failed to write confirmation',
        name: 'ShakeDetectionDisableConfirmationRepository',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> clear() async {
    try {
      await (await dataSource()).remove(
        key: SharedPreferencesKey.shakeDetectionNotificationsDisabledConfirmed,
      );
    } on Object catch (error, stackTrace) {
      log(
        'failed to clear confirmation',
        name: 'ShakeDetectionDisableConfirmationRepository',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
