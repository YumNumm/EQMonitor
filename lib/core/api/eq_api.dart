import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eq_api.g.dart';

@Riverpod(keepAlive: true)
EqApi eqApi(EqApiRef ref) {
  final dio = ref.watch(dioProvider);
  return EqApi(dio: dio);
}
