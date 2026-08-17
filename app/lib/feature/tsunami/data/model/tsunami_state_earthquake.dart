import 'package:eqmonitor/feature/tsunami/data/model/tsunami_earthquake_hypocenter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_state_earthquake.freezed.dart';

/// 津波情報の起因となった地震のドメインモデル
@freezed
abstract class TsunamiStateEarthquake with _$TsunamiStateEarthquake {
  const factory TsunamiStateEarthquake({
    required DateTime originTime,
    required TsunamiEarthquakeHypocenter hypocenter,
    DateTime? arrivalTime,
  }) = _TsunamiStateEarthquake;
}

extension TsunamiStateEarthquakeApiExt on api.TsunamiStateEarthquake {
  TsunamiStateEarthquake toDomain() => TsunamiStateEarthquake(
    originTime: originTime,
    hypocenter: hypocenter.toTsunamiEarthquakeHypocenter(),
    arrivalTime: arrivalTime,
  );
}
