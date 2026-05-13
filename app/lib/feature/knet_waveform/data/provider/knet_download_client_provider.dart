import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_credentials_provider.dart';
import 'package:knet_api_client/knet_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'knet_download_client_provider.g.dart';

/// 認証情報を基に [KnetDownloadClient] を生成するプロバイダ
///
/// 認証情報が未設定の場合は null を返す。
@Riverpod(keepAlive: true)
Future<KnetDownloadClient?> knetDownloadClient(Ref ref) async {
  final credentials = await ref.watch(knetCredentialsProvider.future);
  if (credentials == null) {
    return null;
  }
  return KnetDownloadClient(
    userId: credentials.userId,
    password: credentials.password,
  );
}
