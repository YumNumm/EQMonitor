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

/// 画像が公開される境目を挟む遅延の区間。
class const KyoshinMonitorDelayEdgeBracket({
  /// これより短い遅延では未公開 (404) とみなしている値
  required final Duration lower,

  /// 公開済みとみなしている遅延
  required final Duration upper,

  /// [upper] で実際に取得できることを確認済みか
  required final bool isUpperVerified,
}) {
  KyoshinMonitorDelayEdgeBracket copyWith({
    Duration? lower,
    Duration? upper,
    bool? isUpperVerified,
  }) => KyoshinMonitorDelayEdgeBracket(
    lower: lower ?? this.lower,
    upper: upper ?? this.upper,
    isUpperVerified: isUpperVerified ?? this.isUpperVerified,
  );
}

/// 画像取得による公開遅延の較正状態。
enum KyoshinMonitorDelayCalibrationStatus {
  /// 較正の条件を満たしていない、または時刻同期の完了待ち
  idle,

  /// 二分探索で公開の境目を探している
  probing,

  /// 較正結果を補正量へ反映済み
  calibrated,

  /// 通信失敗などで較正できなかった (404 フィードバックに任せる)
  failed,
}
