import 'package:eqmonitor/core/provider/http_cached_dio_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_cached_api_client_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ApiClient> httpCachedApiClient(Ref ref) async {
  final dio = await ref.watch(httpCachedDioProvider.future);
  return ApiClient(dio);
}
