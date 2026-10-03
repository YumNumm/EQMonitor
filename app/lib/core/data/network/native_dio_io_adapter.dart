import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

/// IOの接続処理はabort登録より先に始まるため、接続期限を残す。
final class NativeDioIoAdapter extends IOHttpClientAdapter {
  static const connectionTimeoutKey = 'eqmonitor.nativeDioConnectionTimeout';

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) => super.fetch(
    options.copyWith(
      connectTimeout: switch (options.extra[connectionTimeoutKey]) {
        final Duration timeout => timeout,
        _ => Duration.zero,
      },
    ),
    requestStream,
    cancelFuture,
  );
}
