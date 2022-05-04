import 'tsunami/estimation.dart';
import 'tsunami/forecast.dart';
import 'tsunami/observation.dart';

/// ## 1. tsunami
/// VTSE41、VTSE51、VTSE52で共通化された部分が多いため統一標準化しています。

class Tsunami {
  Tsunami({
    required this.forecasts,
    required this.observations,
    required this.estimations,
  });
  Tsunami.fromJson(Map<String, dynamic> j)
      : forecasts = (j['forecasts'].toString() == 'null')
            ? null
            : List<Forecast>.generate(
                (j['forecasts'] as List<dynamic>).length,
                (index) => Forecast.fromJson(
                  (j['forecasts'] as List<dynamic>)[index]
                      as Map<String, dynamic>,
                ),
              ),
        observations = (j['observations'].toString() == 'null')
            ? null
            : List<Observation>.generate(
                (j['observations'] as List<dynamic>).length,
                (index) => Observation.fromJson(
                  (j['observations'] as List<dynamic>)[index]
                      as Map<String, dynamic>,
                ),
              ),
        estimations = (j['estimations'].toString() == 'null')
            ? null
            : List<Estimation>.generate(
                (j['estimations'] as List<dynamic>).length,
                (index) => Estimation.fromJson(
                  (j['estimations'] as List<dynamic>)[index]
                      as Map<String, dynamic>,
                ),
              );

  /// 津波の予測情報を配列で格納する #1. 1. forecast
  /// VTSE41、VTSE51の時出現
  final List<Forecast>? forecasts;

  /// 津波の観測地情報を配列で格納する #1. 2. observation
  /// VTSE51、VTSE52の時で、観測値がある場合にのみ出現
  final List<Observation>? observations;

  /// 津波の推定情報を配列で格納する #1. 3. estimation
  /// VTSE52の時出現
  final List<Estimation>? estimations;
}
