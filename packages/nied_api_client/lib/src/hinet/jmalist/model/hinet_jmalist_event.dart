import 'package:freezed_annotation/freezed_annotation.dart';

part 'hinet_jmalist_event.freezed.dart';

/// Hi-net 気象庁一元化処理 震源リスト(jmalist.php)の1行。
///
/// NIED により震源情報の二次配布が明示的に禁止されているため、この型は
/// アプリの一般公開機能から到達不可能なデバッグ画面専用として扱うこと。
@freezed
abstract class HinetJmalistEvent with _$HinetJmalistEvent {
  const factory HinetJmalistEvent({
    /// 発生時刻(UTC)
    ///
    /// jmalist.php の出力は JST のため、パーサ側で UTC(-9h)へ変換して
    /// 格納する。
    required DateTime originTime,

    /// 時刻誤差(秒)
    required double timeError,
    required double latitude,

    /// 緯度誤差(度)
    required double latitudeError,
    required double longitude,

    /// 経度誤差(度)
    required double longitudeError,

    /// 深さ(km)
    required double depthKm,

    /// マグニチュード(1つ目)
    required double magnitude1,

    /// マグニチュード(2つ目、欠測時 null)
    required double? magnitude2,

    /// マグニチュード種別フラグ(例: 'V'、欠測時 null)
    required String? magnitudeFlag,

    /// 震央地名(英語)
    required String regionNameEn,

    /// 品質コード
    required String qualityCode,
  }) = _HinetJmalistEvent;
}
