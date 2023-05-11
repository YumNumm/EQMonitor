import 'package:eqmonitor/common/provider/ntp/ntp_model.dart';
import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ntp_provider.g.dart';

@Riverpod(keepAlive: true)
class NtpState extends _$NtpState {
  @override
  FutureOr<NtpModel> build() async {
    try {
      final offset = await getDelay();
      return NtpModel(
        delay: offset,
        lastUpdatedAt: DateTime.now(),
      );
    } on Exception catch (_) {
      return NtpModel(
        delay: 0,
        lastUpdatedAt: DateTime.now(),
      );
    }
  }

  Future<int> getDelay() async {
    final startDateTime = DateTime.now();
    final offset = await NTP.getNtpOffset(
      localTime: startDateTime,
      lookUpAddress: 'ntp.nict.jp',
    );
    return offset;
  }
}
