import 'package:eqmonitor/feature/tsunami_history/models/tsunami_comments.dart';
import 'package:eqmonitor/feature/tsunami_history/models/tsunami_height.dart';
import 'package:eqmonitor/feature/tsunami_history/models/tsunami_observation.dart';
import 'package:eqmonitor/feature/tsunami_history/models/tsunami_warning.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_forecast.freezed.dart';

/// 津波情報（VTSE41とVTSE51をマージした統一モデル）
@freezed
abstract class TsunamiInfo with _$TsunamiInfo {
  const factory TsunamiInfo({
    /// 地域別津波情報
    required List<TsunamiArea> areas,

    /// 津波観測データ（VTSE51から）
    List<TsunamiObservation>? observations,

    /// テキスト情報
    String? text,

    /// コメント
    TsunamiComments? comments,
  }) = _TsunamiInfo;
}

/// 地域別津波情報
@freezed
abstract class TsunamiArea with _$TsunamiArea {
  const factory TsunamiArea({
    required String code,
    required String name,
    TsunamiWarning? warning,
    TsunamiWarning? lastWarning,
    TsunamiHeight? firstHeight,
    TsunamiHeight? maxHeight,
    List<TsunamiAreaStation>? stations,
  }) = _TsunamiArea;
}

/// 地域内観測点情報
@freezed
abstract class TsunamiAreaStation with _$TsunamiAreaStation {
  const factory TsunamiAreaStation({
    required String code,
    required String name,
    DateTime? highTideTime,
    DateTime? firstHeightTime,
    String? condition,
  }) = _TsunamiAreaStation;
}
