import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/api_dio_factory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Dio> dio(Ref ref) async {
  final factory = await ref.watch(apiDioFactoryProvider.future);
  return factory.build();
}
