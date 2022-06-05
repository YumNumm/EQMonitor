import 'accuracy/depth_calculation.dart';
import 'accuracy/epicCenterAccuracy.dart';
import 'accuracy/magnitude_calculation.dart';
import 'accuracy/number_of_magnitude_calculation.dart';

/// 震源及びマグニチュードの計算精度情報を記載します。
class Accuracy {
  /// 震央位置の精度値
  final EpicCenters epicCenterAccuracy;

  /// 深さの精度値
  final DepthCalculation depthCalculation;

  /// マグニチュードの精度値
  final MagnitudeCalculation magnitudeCalculation;

  /// マグニチュードの確からしさ
  final NumberOfMagnitudeCalculation numberOfMagnitudeCalculation;

  /// マグニチュード計算使用観測点数
  Accuracy({
    required this.epicCenterAccuracy,
    required this.depthCalculation,
    required this.magnitudeCalculation,
    required this.numberOfMagnitudeCalculation,
  });

  Accuracy.fromJson(Map<String, dynamic> j)
      : epicCenterAccuracy = EpicCenters.fromList(
          (j['Epicenter'] as List<dynamic>)
              .map((dynamic e) => int.parse(e.toString()))
              .toList(),
        ),
        depthCalculation = int.parse(j['Depth'].toString()).getDepthCalculation,
        magnitudeCalculation = int.parse(j['MagnitudeCalculation'].toString())
            .getMagnitudeCalculation,
        numberOfMagnitudeCalculation =
            int.parse(j['NumberOfMagnitudeCalculation'].toString())
                .getNumberOfMagnitudeCalculation;
}
