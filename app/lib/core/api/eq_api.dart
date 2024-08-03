import 'package:dio/dio.dart';
import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'eq_api.g.dart';

@Riverpod(keepAlive: true)
EqApi eqApi(EqApiRef ref) {
  final dio = ref.watch(dioProvider);
  dio.options = dio.options.copyWith(
    sendTimeout: const Duration(seconds: 10),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );

  return EqApi(
    dio: dio,
    objectsDio: Dio(
      BaseOptions(
        baseUrl: 'https://object.eqmonitor.app',

      ),
    )..interceptors.add(
        TalkerDioLogger(
          settings: TalkerDioLoggerSettings(
            errorPen: AnsiPen()..red(),
            requestPen: AnsiPen()..yellow(),
            responsePen: AnsiPen()..green(),
          ),
          talker: ref.watch(talkerProvider),
        ),
      ),
  );
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
