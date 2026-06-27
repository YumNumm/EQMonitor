import 'package:eqmonitor/core/provider/cache_only_dio_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_only_api_client_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ApiClient> cacheOnlyApiClient(Ref ref) async {
  final dio = await ref.watch(cacheOnlyDioProvider.future);
  return ApiClient(dio);
}
