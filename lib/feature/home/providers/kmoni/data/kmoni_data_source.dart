import 'package:dio/dio.dart';
import 'package:eqmonitor/common/provider/dio_provider.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/util/kmoni_web_api_url_generator.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/util/realtime_data_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_data_source.g.dart';

@Riverpod(dependencies: [dio], keepAlive: true)
KmoniDataSource kmoniDataSource(KmoniDataSourceRef ref) =>
    KmoniDataSource(Dio());

class KmoniDataSource {
  KmoniDataSource(this.dio);
  final Dio dio;

  final _urlGenerator = KmoniWebApiUrlGenerator();

  Future<Response<List<int>>> fetchRealtimeImage({
    required DateTime dateTime,
    required RealtimeDataType dataType,
    required GroundType groundType,
  }) async {
    final url = _urlGenerator.realtimeBase(
      dateTime: dateTime,
      dataType: dataType,
      groundType: groundType,
    );

    final res = await dio.get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    return res;
  }
}
