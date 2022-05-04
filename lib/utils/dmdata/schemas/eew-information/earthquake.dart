import '../eq-information/earthquake.dart';
import 'earthquake/hypocenter.dart';

/// 緊急地震速報が対象とする地震の発生時刻、震央地名、震源要素、マグニチュード等を記載します。
/// 取消報の場合は出現しません。
/// 震源とマグニチュードによる震度推定手法において、震源要素が推定できず PLUM 法による震度予測のみが有効である場合は、
/// PLUM 法でトリガー条件を最初に満足した観測点直下の深さ 10km を震源と仮定した震源要素を記載します。
/// （以後、この値を「仮定震源要素」といいます。）
class EarthQuake {
  EarthQuake({
    required this.originTime,
    required this.arrivalTime,
    required this.isAssuming,
    required this.hypoCenter,
    required this.magnitude,
  });

  /// 地震発生時刻を秒単位で、ISO8601の日本時間で記載する
  /// 仮定震源要素時や、100gal検知報などの場合には出現しない
  /// 発生時刻がない場合は出現しない
  final DateTime? originTime;

  /// 地震検知時刻を秒単位で、ISO8601の日本時間で記載する
  final DateTime arrivalTime;

  /// 仮定震源要素かどうか
  final bool isAssuming;

  /// 地震の震源要素 #7.4. hypocenterを参照
  final HypoCenter hypoCenter;

  /// 地震の規模 #7.5. magnitudeを参照
  final Magnitude magnitude;
}
