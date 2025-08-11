import 'package:eqmonitor/feature/tsunami_history/data/models/tsunami_comments.dart';
import 'package:eqmonitor/feature/tsunami_history/data/models/tsunami_height.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_observation.freezed.dart';

/// 津波観測情報
@freezed
abstract class TsunamiObservation with _$TsunamiObservation {
  const factory TsunamiObservation({
    required List<TsunamiObservationStation> stations,
    String? code,
    String? name,
  }) = _TsunamiObservation;
}

/// 津波観測地点
@freezed
abstract class TsunamiObservationStation with _$TsunamiObservationStation {
  const factory TsunamiObservationStation({
    required String code,
    required String name,
    TsunamiStationFirstHeight? firstHeight,
    TsunamiStationMaxHeight? maxHeight,
    String? condition,
  }) = _TsunamiObservationStation;
}

/// 観測点の第一波情報
@freezed
abstract class TsunamiStationFirstHeight with _$TsunamiStationFirstHeight {
  const factory TsunamiStationFirstHeight({
    DateTime? arrivalTime,
    String? initial,
    String? condition,
  }) = _TsunamiStationFirstHeight;
}

/// 観測点の最大波情報
@freezed
abstract class TsunamiStationMaxHeight with _$TsunamiStationMaxHeight {
  const factory TsunamiStationMaxHeight({
    DateTime? dateTime,
    double? value,
    bool? isOver,
    bool? isRising,
    String? condition,
    String? revise,
  }) = _TsunamiStationMaxHeight;

  const TsunamiStationMaxHeight._();

  /// 最大波高の表示テキスト
  String? get displayText {
    if (condition != null) {
      return condition!;
    }
    if (value == null) {
      return null;
    }
    final over = (isOver ?? false) ? '以上' : '';
    final rising = (isRising ?? false) ? '（上昇中）' : '';
    return '${value!.toStringAsFixed(1)}m$over$rising';
  }
}

/// 沖合津波観測情報（VTSE52専用）
@freezed
abstract class TsunamiObservationInfo with _$TsunamiObservationInfo {
  const factory TsunamiObservationInfo({
    List<TsunamiObservation>? observations,
    List<TsunamiEstimation>? estimations,
    String? text,
    TsunamiComments? comments,
  }) = _TsunamiObservationInfo;
}

/// 津波推定情報
@freezed
abstract class TsunamiEstimation with _$TsunamiEstimation {
  const factory TsunamiEstimation({
    required String code,
    required String name,
    TsunamiHeight? firstHeight,
    TsunamiHeight? maxHeight,
    String? revise,
  }) = _TsunamiEstimation;
}
