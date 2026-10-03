import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';

final class const NativeDioFactory() {
  Dio build({BaseOptions? options}) => Dio(options)
    ..httpClientAdapter = NativeAdapter(
      createCronetEngine: () => CronetEngine.build(
        enableHttp2: true,
        enableQuic: true,
        cacheMode: CacheMode.disabled,
      ),
      createCupertinoConfiguration: () =>
          URLSessionConfiguration.ephemeralSessionConfiguration()
            // キャッシュと Cookie は既存の Dio interceptor が管理する。
            ..cache = null
            ..requestCachePolicy =
                NSURLRequestCachePolicy.NSURLRequestReloadIgnoringLocalCacheData
            ..httpShouldSetCookies = false
            ..httpCookieAcceptPolicy =
                NSHTTPCookieAcceptPolicy.NSHTTPCookieAcceptPolicyNever,
      createFallbackAdapter: (error, stackTrace) => IOHttpClientAdapter(),
    );
}
