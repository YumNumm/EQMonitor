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

  final NumberOfMagnitudeCalculation numberOfMagnitudeCalculation;

  /// マグニチュード計算使用観測点数
  Accuracy({
    required this.epicCenterAccuracy,
    required this.depthCalculation,
    required this.magnitudeCalculation,
    required this.numberOfMagnitudeCalculation,
  });

  factory Accuracy.fromJson(Map<String, dynamic> j) {
    final magnitudeCalculationValue =
        int.parse(j['magnitudeCalculation'].toString());
    final numberOfMagnitudeCalculationValue =
        int.parse(j['numberOfMagnitudeCalculation'].toString());

    return Accuracy(
        epicCenterAccuracy: EpicCenters.fromList(
          (j['epiccenters'] as List<dynamic>)
              .map((dynamic e) => int.parse(e.toString()))
              .toList(),
        ),
        depthCalculation: DepthCalculation.values.firstWhere(
          (element) => element.code == int.parse(j['depth'].toString()),
          orElse: () => DepthCalculation.unknown,
        ),
        magnitudeCalculation: MagnitudeCalculation.values.firstWhere(
          (element) => element.code == magnitudeCalculationValue,
          orElse: () => MagnitudeCalculation.unknown,
        ),
        numberOfMagnitudeCalculation:
            NumberOfMagnitudeCalculation.values.firstWhere(
          (element) => element.code == numberOfMagnitudeCalculationValue,
          orElse: () => NumberOfMagnitudeCalculation.unknown,
        ));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'epicenters': epicCenterAccuracy.toJson(),
        'depth': depthCalculation.code,
        'magnitudeCalculation': magnitudeCalculation.code,
        'numberOfMagnitudeCalculation': numberOfMagnitudeCalculation.code,
      };
}
