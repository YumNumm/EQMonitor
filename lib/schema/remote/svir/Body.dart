import 'Body/Earthquake.dart';
import 'Body/Intensity.dart';

class SvirBody {
  SvirBody({
    required this.earthquake,
    required this.intensity,
    required this.PLUMFlag,
    required this.warningFlag,
    required this.endFlag,
  });
  SvirBody.fromJson(Map<String, dynamic> j)
      : earthquake = SvirBodyEarthquake.fromJson(
          j['Earthquake'] as Map<String, dynamic>,
        ),
        intensity = (j['Intensity'].toString() == 'null')
            ? null
            : SvirBodyEQIntensity.fromJson(
                j['Intensity'] as Map<String, dynamic>,
              ),
        PLUMFlag = !(j['PLUMFlag'].toString() == '0'),
        warningFlag = !(j['WarningFlag'].toString() == '0'),
        endFlag = !(j['EndFlag'].toString() == '0');

  /// 	震源情報
  final SvirBodyEarthquake earthquake;

  /// 	震度情報
  final SvirBodyEQIntensity? intensity;

  /// 推定震源がなくPLUM法のみによる震度予測
  final bool PLUMFlag;

  /// 警報判定フラグ
  final bool warningFlag;

  /// 	最終報判定フラグ
  final bool endFlag;
}
