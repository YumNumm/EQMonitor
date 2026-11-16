import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_notice_agreement_notifier.g.dart';

@Riverpod(keepAlive: true)
class ShakeDetectionNoticeAgreed extends _$ShakeDetectionNoticeAgreed {
  // 注意事項を改訂して再同意を求めるときに上げる。
  static const currentVersion = 1;

  static final agreeMutation = Mutation<void>();

  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    final agreedVersion =
        await dataSource.getInt(key: .shakeDetectionNoticeAgreedVersion) ?? 0;
    return agreedVersion >= currentVersion;
  }

  Future<void> agree() async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setInt(
      key: .shakeDetectionNoticeAgreedVersion,
      value: currentVersion,
    );
    state = const AsyncData(true);
  }
}
