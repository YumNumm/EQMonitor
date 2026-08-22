enum KyoshinMonitorDelayAdjustType {
  /// latest.jsonの値をそのまま使う
  latestJson,

  /// latest.jsonを複数回取得し、変化した時にその値を使う
  latestJsonMultiple,

  /// 画像取得APIで404が返ってきたら、内部の遅延カウンタを増やす (DateTime.now())
  imageFetch404DeviceTime,

  /// 画像取得APIで404が返ってきたら、内部の遅延カウンタを増やす (NTPサーバーを基準にしている)
  imageFetch404Ntp,
}

/// 公開遅延を学習する単位。
///
/// `latest.json` はどちらのホストから取っても強震モニタのパイプラインの時刻を
/// 返す (長周期地震動モニタの `/img_svr/` は強震モニタへのリバースプロキシ) ため、
/// そこから求まる公開遅延は常に強震モニタ基準になる。
///
/// 学習値を分ける単位は「ホスト」ではなく「画像の生成パイプライン」でなければ
/// ならない。長周期地震動モニタを選んでいても震度などの非 LPGM 系列は
/// `/img_svr/` 経由で強震モニタのパイプラインから配信されるため、
/// ホストで分けると 2 つのパイプラインが 1 つの学習値を取り合ってしまう。
enum KyoshinMonitorDelayProfile {
  /// 強震モニタのパイプライン (`jma_s`, `acmap_s`, `rsp*` など)
  kmoni,

  /// 長周期地震動モニタのパイプライン (`abrspmx_s`, `abrsp1s_s` など)
  lpgm,
}

/// 404 フィードバックによる遅延調整のパラメータ。
class const KyoshinMonitorDelayAdjustConfig({
  /// 1 回の調整量
  final Duration step = const Duration(milliseconds: 100),

  /// 公開遅延の下限
  required final Duration minOffset,

  /// 公開遅延の上限
  required final Duration maxOffset,

  /// 補正量の絶対値の上限
  final Duration maxAdjustment = const Duration(seconds: 5),
});

abstract final class KyoshinMonitorOffsetAdjustments {
  static Map<KyoshinMonitorDelayProfile, Duration> set({
    required Map<KyoshinMonitorDelayProfile, Duration> adjustments,
    required KyoshinMonitorDelayProfile profile,
    required Duration adjustment,
    required KyoshinMonitorDelayAdjustConfig config,
  }) {
    final clamped = adjustment < -config.maxAdjustment
        ? -config.maxAdjustment
        : adjustment > config.maxAdjustment
        ? config.maxAdjustment
        : adjustment;
    return {...adjustments, profile: clamped};
  }

  static Map<KyoshinMonitorDelayProfile, Duration> reset({
    required Map<KyoshinMonitorDelayProfile, Duration> adjustments,
    required KyoshinMonitorDelayProfile profile,
  }) => Map.of(adjustments)..remove(profile);
}

/// `latest.json` で測った公開遅延を、画像取得の 404 を手がかりに詰めていくロジック。
///
/// `latest.json` の `latest_time` は 1 秒粒度で、かつ実際の画像公開より
/// 保守的に遅れている (実測: 長周期地震動モニタは画像が 0.57 秒で公開されるのに
/// `latest_time` は約 1 秒遅れ)。そのぶんをここで取り戻す。
///
/// 補正は公開遅延そのものではなく「測定値からの差分」として保持する。
/// こうすることで、`latest.json` の再同期が端末時計のドリフトやサーバ側の
/// 遅延変動を追従し続ける一方で、学習した詰めぶんは維持される。
abstract final class KyoshinMonitorDelayAdjuster {
  /// 実際に画像取得へ使う公開遅延。
  static Duration effectiveOffset({
    required Duration publishDelay,
    required Duration adjustment,
    required KyoshinMonitorDelayAdjustConfig config,
  }) => _clamp(
    publishDelay + adjustment,
    min: config.minOffset,
    max: config.maxOffset,
  );

  /// 画像が未公開 (404) だったときの補正量。
  ///
  /// 取得対象が新しすぎるということなので、より過去を見るように増やす。
  static Duration onFetchFailed({
    required Duration adjustment,
    required KyoshinMonitorDelayAdjustConfig config,
  }) => _clampAdjustment(adjustment + config.step, config);

  /// 取得に成功したときの補正量。
  ///
  /// 毎ティック詰めると 404 と往復して発振するため、
  /// KyoshinEewViewer と同じく毎分 1 回だけ試す。
  static Duration onFetchSucceeded({
    required Duration adjustment,
    required Duration publishDelay,
    required DateTime targetTime,
    required KyoshinMonitorDelayAdjustConfig config,
  }) {
    if (targetTime.second != 0) {
      return adjustment;
    }
    final current = effectiveOffset(
      publishDelay: publishDelay,
      adjustment: adjustment,
      config: config,
    );
    if (current <= config.minOffset) {
      return adjustment;
    }
    return _clampAdjustment(adjustment - config.step, config);
  }

  static Duration _clampAdjustment(
    Duration value,
    KyoshinMonitorDelayAdjustConfig config,
  ) => _clamp(value, min: -config.maxAdjustment, max: config.maxAdjustment);

  static Duration _clamp(
    Duration value, {
    required Duration min,
    required Duration max,
  }) {
    if (value < min) {
      return min;
    }
    if (value > max) {
      return max;
    }
    return value;
  }
}
