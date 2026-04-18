import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ApiClient> apiClient(Ref ref) async {
  final dio = await ref.watch(dioProvider.future);
  return ApiClient(dio);
}
