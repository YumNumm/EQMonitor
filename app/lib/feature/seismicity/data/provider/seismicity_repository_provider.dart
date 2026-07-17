import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/dio_base_options.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/seismicity_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'seismicity_repository_provider.g.dart';

@Riverpod(keepAlive: true)
Dio seismicityGeoJsonDio(Ref ref) {
  final dio = Dio(buildApiBaseOptions(baseUrl: ''));
  dio.options.connectTimeout = const Duration(milliseconds: 10000);
  dio.options.sendTimeout = const Duration(milliseconds: 10000);
  return dio;
}

@Riverpod(keepAlive: true)
Future<SeismicityRepository> seismicityRepository(Ref ref) async {
  final manifestDio = await ref.watch(dioProvider.future);
  final geoJsonDio = ref.watch(seismicityGeoJsonDioProvider);
  return SeismicityRepository(manifestDio: manifestDio, geoJsonDio: geoJsonDio);
}
