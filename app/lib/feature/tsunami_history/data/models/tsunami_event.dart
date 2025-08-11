import 'package:eqmonitor/feature/tsunami_history/data/models/tsunami_forecast.dart';
import 'package:eqmonitor/feature/tsunami_history/data/models/tsunami_observation.dart';
import 'package:eqmonitor/feature/tsunami_history/data/models/tsunami_warning.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_event.freezed.dart';

/// 津波イベント全体の情報
@freezed
abstract class TsunamiEvent with _$TsunamiEvent {
  const factory TsunamiEvent({
    required String eventId,
    required DateTime pressAt,
    required DateTime reportAt,
    required String status,
    required String infoType,
    String? headline,
    DateTime? validAt,

    /// 津波警報・注意報・予報 + 津波情報（VTSE41 + VTSE51をマージ）
    TsunamiInfo? info,

    /// 沖合の津波観測（VTSE52）
    TsunamiObservationInfo? observationInfo,
  }) = _TsunamiEvent;

  const TsunamiEvent._();

  /// 最高レベルの津波警報を取得
  TsunamiWarning? get highestWarning {
    final warnings = info?.areas
        .map((area) => area.warning)
        .where((warning) => warning != null)
        .cast<TsunamiWarning>()
        .toList();

    if (warnings == null || warnings.isEmpty) {
      return null;
    }

    warnings.sort((a, b) => b.severityLevel.compareTo(a.severityLevel));
    return warnings.first;
  }

  /// 有効期限が切れているかどうか
  bool get isExpired {
    if (validAt == null) {
      return false;
    }
    return DateTime.now().isAfter(validAt!);
  }

  /// アクティブな津波警報があるかどうか
  bool get hasActiveWarning {
    final highest = highestWarning;
    return (highest?.isActive ?? false) && !isExpired;
  }
}
