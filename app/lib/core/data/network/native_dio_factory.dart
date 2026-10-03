import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/network/native_dio_adapter.dart';
import 'package:eqmonitor/core/data/network/native_dio_transport.dart';

final class const NativeDioFactory() {
  Dio build({BaseOptions? options}) {
    final transport = NativeDioTransport();
    return Dio(options)
      ..httpClientAdapter = NativeDioAdapter(
        adapter: transport.adapter,
        closeTransport: transport.close,
      );
  }

  Future<void> close(Dio dio) async {
    dio.close(force: true);
    final adapter = dio.httpClientAdapter;
    if (adapter is NativeDioAdapter) {
      await adapter.whenClosed;
    }
  }
}
