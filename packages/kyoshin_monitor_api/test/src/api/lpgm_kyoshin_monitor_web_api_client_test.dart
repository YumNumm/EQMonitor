import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:test/test.dart';

void main() {
  late _RecordingBytesAdapter adapter;
  late LpgmKyoshinMonitorWebApiDataSource dataSource;

  setUp(() {
    adapter = _RecordingBytesAdapter();
    final dio = Dio()..httpClientAdapter = adapter;
    dataSource = LpgmKyoshinMonitorWebApiDataSource(
      client: LpgmKyoshinMonitorWebApiClient(dio),
    );
  });

  test('通常震度の地表は img_svr の jma_s を取得する', () async {
    await dataSource.getRealtimeImageData(
      type: RealtimeDataType.shindo,
      layer: RealtimeLayer.surface,
      dateTime: DateTime(2026, 8, 16, 22, 58, 3),
    );

    expect(
      adapter.request?.uri.toString(),
      'https://www.lmoni.bosai.go.jp/img_svr/data/map_img/'
      'RealTimeImg/jma_s/20260816/20260816225803.jma_s.gif',
    );
  });

  test('通常震度の地下は img_svr の jma_b を取得する', () async {
    await dataSource.getRealtimeImageData(
      type: RealtimeDataType.shindo,
      layer: RealtimeLayer.underground,
      dateTime: DateTime(2026, 8, 16, 22, 58, 3),
    );

    expect(
      adapter.request?.uri.toString(),
      'https://www.lmoni.bosai.go.jp/img_svr/data/map_img/'
      'RealTimeImg/jma_b/20260816/20260816225803.jma_b.gif',
    );
  });

  test('長周期データは地下設定でも monitor 配下の abrspmx_s を取得する', () async {
    await dataSource.getRealtimeImageData(
      type: RealtimeDataType.abrspmx,
      layer: RealtimeLayer.underground,
      dateTime: DateTime(2026, 8, 16, 22, 58, 3),
    );

    expect(
      adapter.request?.uri.toString(),
      'https://www.lmoni.bosai.go.jp/monitor/data/data/map_img/'
      'RealTimeImg/abrspmx_s/20260816/20260816225803.abrspmx_s.gif',
    );
  });
}

final class _RecordingBytesAdapter implements HttpClientAdapter {
  RequestOptions? request;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    request = options;
    return ResponseBody.fromBytes(const [1, 2, 3], 200);
  }

  @override
  void close({bool force = false}) {}
}
