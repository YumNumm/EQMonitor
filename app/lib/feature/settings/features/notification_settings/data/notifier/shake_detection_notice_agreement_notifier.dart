import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/shake_detection_notice_agreement_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_notice_agreement_notifier.g.dart';

@Riverpod(keepAlive: true)
class ShakeDetectionNoticeAgreed extends _$ShakeDetectionNoticeAgreed {
  // 注意事項を改訂して再同意を求めるときに上げる。
  static const currentVersion = 1;

  @override
  Future<bool> build() async {
    final repository = await ref.watch(
      shakeDetectionNoticeAgreementRepositoryProvider.future,
    );
    return await repository.loadAgreedVersion() >= currentVersion;
  }

  static final agreeMutation = Mutation<void>();
  Future<void> agree() async {
    final repository = await ref.read(
      shakeDetectionNoticeAgreementRepositoryProvider.future,
    );
    await repository.saveAgreedVersion(currentVersion);
    state = const AsyncData(true);
  }
}
