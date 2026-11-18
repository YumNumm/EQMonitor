import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_notice_agreement_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ShakeDetectionNoticeAgreementRepository>
shakeDetectionNoticeAgreementRepository(Ref ref) async =>
    ShakeDetectionNoticeAgreementRepository(
      await ref.watch(sharedPreferencesDataSourceProvider.future),
    );

class ShakeDetectionNoticeAgreementRepository(
  final SharedPreferencesDataSource _dataSource,
) {
  Future<int> loadAgreedVersion() async =>
      await _dataSource.getInt(key: .shakeDetectionNoticeAgreedVersion) ?? 0;

  Future<void> saveAgreedVersion(int version) => _dataSource.setInt(
    key: .shakeDetectionNoticeAgreedVersion,
    value: version,
  );
}
