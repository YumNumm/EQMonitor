import 'package:dio/dio.dart';
import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eq_api.g.dart';

@Riverpod(keepAlive: true)
EqApi eqApi(EqApiRef ref) {
  final dio = ref.watch(dioProvider);
  return EqApi(dio: dio);
}

/// Repositoryで利用
typedef EqApiV1Response<T> = ({
  int count,
  List<T> items,
});

/// HttpResponse のheaderから`count`の値を取得するために利用
extension ResponseEx<T> on Response<T> {
  int get count => int.parse(headers.value('count')!);
  int? get countOrNull => int.tryParse(headers.value('count').toString());
}
