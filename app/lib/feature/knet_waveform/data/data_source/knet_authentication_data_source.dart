import 'package:eqmonitor/core/data/network/native_dio_factory.dart';
import 'package:knet_api_client/knet_api_client.dart';

final class const KnetAuthenticationDataSource() {
  Future<bool> verify({
    required String userId,
    required String password,
  }) async {
    final dio = const NativeDioFactory().build();
    try {
      return await KnetDownloadClient(
        userId: userId,
        password: password,
        dio: dio,
      ).verifyAuthentication();
    } finally {
      await const NativeDioFactory().close(dio);
    }
  }
}
