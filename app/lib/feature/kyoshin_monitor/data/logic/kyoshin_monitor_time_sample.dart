/// `latest.json` を 1 回取得したときの観測結果。
///
/// 送信直前と受信直後の端末時計を両方持つことで、往復時間の片道ぶんを
/// 補正できるようにしている。受信後の端末時計だけを使うと往復時間が
/// まるごと遅延に加算されてしまう。
class KyoshinMonitorTimeSample {
  const new({
    required this.sentAt,
    required this.receivedAt,
    required this.latestTime,
  });

  /// リクエスト送信直前の端末時計
  final DateTime sentAt;

  /// レスポンス受信直後の端末時計
  final DateTime receivedAt;

  /// `latest.json` の `latest_time` (絶対時刻)
  final DateTime latestTime;

  /// 往復時間
  Duration get roundTripTime => receivedAt.difference(sentAt);

  /// 端末時計から見た `latest_time` のずれ。
  ///
  /// 送受信の中点で評価することで、往復時間の片道ぶんを打ち消す。
  /// 通常は負の値 (サーバの最新データは端末の現在時刻より過去) になる。
  Duration get shift {
    final midpoint = sentAt.add(
      Duration(microseconds: roundTripTime.inMicroseconds ~/ 2),
    );
    return latestTime.difference(midpoint);
  }
}

abstract final class KyoshinMonitorPublishDelay {
  /// サーバの公開遅延を求める。
  ///
  /// [shift] は「端末時計から見た `latest_time` のずれ」なので、端末時計自体の
  /// 誤差を含んでいる。NTP 補正が得られている場合は [ntpOffset] を差し引くことで、
  /// 端末時計の誤差に依存しない純粋な公開遅延が得られる。
  ///
  /// 端末時計の誤差を `D` (`deviceNow == trueNow + D`)、公開遅延を `P` とすると
  ///
  /// - `shift == -P - D`
  /// - `ntpOffset == -D`
  /// - `-(shift - ntpOffset) == P`
  ///
  /// NTP 未取得時 ([ntpOffset] が null) は `P + D` が返るが、その場合の
  /// `AppClock.now()` も端末時計 (`trueNow + D`) なので、
  /// `AppClock.now() - publishDelay == trueNow - P` となり結果は一致する。
  ///
  /// 重要なのは「[ntpOffset] を考慮したかどうか」を、この値を引く対象の時計と
  /// 必ず揃えること。片方だけ NTP 補正すると端末時計の誤差が二重に効く。
  static Duration resolve({
    required Duration shift,
    required Duration? ntpOffset,
  }) => -(shift - (ntpOffset ?? Duration.zero));
}
