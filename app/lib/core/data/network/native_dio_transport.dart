import 'package:cronet_http/cronet_http.dart';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:eqmonitor/core/data/network/native_dio_io_adapter.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart' show NativeAdapter;

final class NativeDioTransport {
  new() {
    final nativeAdapter = NativeAdapter(
      createCronetEngine: () => _engine = CronetEngine.build(
        enableHttp2: true,
        enableQuic: true,
        cacheMode: CacheMode.disabled,
      ),
      createCupertinoConfiguration: () =>
          URLSessionConfiguration.ephemeralSessionConfiguration()
            // キャッシュとCookieの所有者は既存のDio interceptorに統一する。
            ..cache = null
            ..requestCachePolicy =
                NSURLRequestCachePolicy.NSURLRequestReloadIgnoringLocalCacheData
            ..httpShouldSetCookies = false
            ..httpCookieAcceptPolicy =
                NSHTTPCookieAcceptPolicy.NSHTTPCookieAcceptPolicyNever,
      // providerがすべて無効なAndroid端末だけで標準アダプターへ縮退する。
      createFallbackAdapter: (error, stackTrace) => NativeDioIoAdapter(),
    );
    // native非対応のdesktopも同じIO接続期限を適用する。
    adapter = nativeAdapter.adapter is IOHttpClientAdapter
        ? NativeDioIoAdapter()
        : nativeAdapter;
  }

  late final HttpClientAdapter adapter;
  CronetEngine? _engine;

  Future<void> close() async {
    while (true) {
      try {
        // fallback wrapperはclose失敗後に再試行できないため、engineを先に閉じる。
        _engine?.close();
        adapter.close(force: true);
        return;
      } on StateError catch (error) {
        if (error.message != 'cannot close with running requests') {
          rethrow;
        }
      } on Exception catch (error) {
        if (!error.toString().contains(
          'java.lang.IllegalStateException: Cannot shutdown with active requests.',
        )) {
          rethrow;
        }
      }
      // nativeの完了callbackとshutdownの間に残る短い競合だけを待つ。
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}
