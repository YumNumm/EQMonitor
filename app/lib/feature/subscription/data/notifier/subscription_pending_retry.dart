import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_pending_retry.g.dart';

/// 購入情報の反映を自動で再試行している間、その再試行の番号を持つ。
///
/// 再試行していない間は `null`。反映待ちの案内で、手動の同期を出すかの判断に使う。
@Riverpod(keepAlive: true)
class SubscriptionPendingRetry extends _$SubscriptionPendingRetry {
  @override
  int? build() => null;

  void start({required int token}) => state = token;

  /// [token] の再試行が終わったことを知らせる。後から始まった再試行は止めない。
  void finish({required int token}) {
    if (state == token) {
      state = null;
    }
  }

  void stop() => state = null;
}
