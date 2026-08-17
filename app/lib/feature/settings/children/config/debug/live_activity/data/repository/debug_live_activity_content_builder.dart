import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final debugLiveActivityContentBuilderProvider =
    Provider<DebugLiveActivityContentBuilder>(
      (ref) => const DebugLiveActivityContentBuilder(),
    );

/// Live Activity の ContentState (`Map<String, dynamic>`) を組み立てる。
///
/// 生成される JSON のキーは Widget Extension の Swift `Codable` 構造体
/// (`EewContentState` / `ShakeDetectionContentState` / `LocationInfo`) の
/// プロパティ名と一致させる（デフォルトの CodingKeys = プロパティ名）。
class DebugLiveActivityContentBuilder {
  const new();

  // --- EEW: プリセット ---

  Map<String, dynamic> eewFromPreset({
    required DebugEewPreset preset,
    required String eventId,
    required DateTime now,
  }) {
    return switch (preset) {
      DebugEewPreset.warning => _eew(
        eventId: eventId,
        hypocenterName: '石川県能登地方',
        magnitude: 7.6,
        depth: 10,
        time: now,
        isOriginTime: true,
        maxIntensity: JmaIntensity.sixUpper,
        serialNo: 32,
        isFinal: false,
        isWarning: true,
        isCanceled: false,
        headline: '石川県で地震 北陸で強い揺れ',
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
        location: _location(
          regionName: '東京都23区',
          forecastIntensity: JmaIntensity.fiveLower,
          forecastLpgmIntensity: JmaLpgmIntensity.two,
          arrivalTime: now.add(const Duration(seconds: 30)),
        ),
      ),
      DebugEewPreset.finalReport => _eew(
        eventId: eventId,
        hypocenterName: '石川県能登地方',
        magnitude: 7.6,
        depth: 16,
        time: now,
        isOriginTime: true,
        maxIntensity: JmaIntensity.seven,
        serialNo: 47,
        isFinal: true,
        isWarning: true,
        isCanceled: false,
        headline: '石川県で地震 北陸で強い揺れ',
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
      ),
      DebugEewPreset.forecast => _eew(
        eventId: eventId,
        hypocenterName: '茨城県沖',
        magnitude: 4.2,
        depth: 40,
        time: now,
        isOriginTime: true,
        maxIntensity: JmaIntensity.three,
        serialNo: 1,
        isFinal: false,
        isWarning: false,
        isCanceled: false,
        headline: '茨城県沖で地震',
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
      ),
      DebugEewPreset.plum => _eew(
        eventId: eventId,
        hypocenterName: '関東地方',
        time: now,
        isOriginTime: true,
        maxIntensity: JmaIntensity.fiveLower,
        serialNo: 1,
        isFinal: false,
        isWarning: false,
        isCanceled: false,
        headline: '関東地方で地震',
        isPlum: true,
        isLevel: false,
        isOnePoint: false,
        location: _location(
          regionName: '東京都23区',
          forecastIntensity: JmaIntensity.four,
        ),
      ),
      DebugEewPreset.levelMethod => _eew(
        eventId: eventId,
        hypocenterName: '仮定震源',
        time: now,
        isOriginTime: false,
        maxIntensity: JmaIntensity.four,
        serialNo: 1,
        isFinal: false,
        isWarning: false,
        isCanceled: false,
        headline: '地震発生',
        isPlum: false,
        isLevel: true,
        isOnePoint: false,
        location: _location(
          regionName: '神奈川県東部',
          forecastIntensity: JmaIntensity.three,
        ),
      ),
      DebugEewPreset.onePoint => _eew(
        eventId: eventId,
        hypocenterName: '茨城県沖',
        magnitude: 4,
        depth: 30,
        time: now,
        isOriginTime: true,
        maxIntensity: JmaIntensity.three,
        serialNo: 1,
        isFinal: false,
        isWarning: false,
        isCanceled: false,
        headline: '茨城県沖で地震',
        isPlum: false,
        isLevel: false,
        isOnePoint: true,
      ),
      DebugEewPreset.canceled => _eew(
        eventId: eventId,
        isOriginTime: false,
        serialNo: 2,
        isFinal: true,
        isWarning: false,
        isCanceled: true,
        headline: '地震発生',
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
      ),
    };
  }

  // --- EEW: 実データ変換 ---

  Map<String, dynamic> eewFromTelegram(EewTelegramItem eew) {
    final hideHypocenterDetail = eew.shouldHideMagnitudeAndDepth;
    final happenedTime = eew.originTime ?? eew.arrivalTime;
    return _eew(
      eventId: eew.eventId,
      hypocenterName: eew.isCanceled ? null : eew.hypocenter?.name,
      magnitude: (eew.isCanceled || hideHypocenterDetail)
          ? null
          : eew.hypocenter?.magnitude,
      depth: (eew.isCanceled || hideHypocenterDetail)
          ? null
          : eew.hypocenter?.depth?.toDouble(),
      time: eew.isCanceled ? null : happenedTime,
      isOriginTime: eew.originTime != null,
      maxIntensity: eew.isCanceled
          ? null
          : eew.forecastIntensity?.maxIntensity,
      serialNo: eew.serialNo,
      isFinal: eew.isLastInfo,
      isWarning: eew.isWarning ?? false,
      isCanceled: eew.isCanceled,
      headline: eew.headline,
      isPlum: eew.isPlum,
      isLevel: eew.isLevelMethod,
      isOnePoint: eew.isOnePointDetection,
    );
  }

  // --- 揺れ検知: プリセット ---

  Map<String, dynamic> shakeFromPreset({
    required DebugShakePreset preset,
    required String eventId,
    required DateTime now,
  }) {
    final level = switch (preset) {
      DebugShakePreset.weaker => ShakeDetectionLevel.weaker,
      DebugShakePreset.weak => ShakeDetectionLevel.weak,
      DebugShakePreset.medium => ShakeDetectionLevel.medium,
      DebugShakePreset.strong => ShakeDetectionLevel.strong,
      DebugShakePreset.stronger => ShakeDetectionLevel.stronger,
    };
    final intensity = switch (preset) {
      DebugShakePreset.weaker => 0.4,
      DebugShakePreset.weak => 0.8,
      DebugShakePreset.medium => 1.6,
      DebugShakePreset.strong => 3.2,
      DebugShakePreset.stronger => 4.8,
    };
    return _shake(
      eventId: eventId,
      level: level,
      detectedAt: now,
      location: _location(regionName: '東京都23区', intensity: intensity),
    );
  }

  // --- 揺れ検知: 実データ変換 ---

  Map<String, dynamic> shakeFromEvent(ShakeDetectionEvent event) {
    return _shake(
      eventId: event.eventId,
      level: event.level,
      detectedAt: event.createdAt,
    );
  }

  // --- 内部ヘルパー ---

  Map<String, dynamic> _eew({
    required String eventId,
    required bool isOriginTime,
    required int serialNo,
    required bool isFinal,
    required bool isWarning,
    required bool isCanceled,
    required bool isPlum,
    required bool isLevel,
    required bool isOnePoint,
    String? hypocenterName,
    double? magnitude,
    double? depth,
    DateTime? time,
    JmaIntensity? maxIntensity,
    String? headline,
    Map<String, dynamic>? location,
  }) {
    return <String, dynamic>{
      'eventId': eventId,
      'type': 'eew',
      'hypocenterName': hypocenterName,
      'magnitude': magnitude,
      'depth': depth,
      'time': time == null ? null : _iso8601Jst(time),
      'isOriginTime': isOriginTime,
      'maxIntensity': maxIntensity == null
          ? null
          : _intensityWireValue(maxIntensity),
      'serialNo': serialNo,
      'isFinal': isFinal,
      'isWarning': isWarning,
      'isCanceled': isCanceled,
      'headline': headline,
      'isPlum': isPlum,
      'isLevel': isLevel,
      'isOnePoint': isOnePoint,
      'location': location,
    };
  }

  Map<String, dynamic> _shake({
    required String eventId,
    required ShakeDetectionLevel level,
    required DateTime detectedAt,
    Map<String, dynamic>? location,
  }) {
    return <String, dynamic>{
      'eventId': eventId,
      'type': 'shake_detection',
      'level': _shakeLevelWireValue(level),
      'detectedAt': _iso8601Jst(detectedAt),
      'location': location,
    };
  }

  Map<String, dynamic> _location({
    required String regionName,
    JmaIntensity? forecastIntensity,
    JmaLpgmIntensity? forecastLpgmIntensity,
    DateTime? arrivalTime,
    double? intensity,
  }) {
    return <String, dynamic>{
      'regionName': regionName,
      'forecastIntensity': forecastIntensity == null
          ? null
          : _intensityWireValue(forecastIntensity),
      'forecastLpgmIntensity': forecastLpgmIntensity == null
          ? null
          : _lpgmWireValue(forecastLpgmIntensity),
      'arrivalTime': arrivalTime == null ? null : _iso8601Jst(arrivalTime),
      'intensity': intensity,
    };
  }

  /// Widget 側 `IntensityValue`(rawValue) と一致する文字列に変換する。
  /// `unknown` は Swift 側でバッジ非表示になるため null を返す。
  String? _intensityWireValue(JmaIntensity intensity) => switch (intensity) {
    JmaIntensity.unknown => null,
    JmaIntensity.zero => '0',
    JmaIntensity.one => '1',
    JmaIntensity.two => '2',
    JmaIntensity.three => '3',
    JmaIntensity.four => '4',
    JmaIntensity.fiveUnknown => '!5-',
    JmaIntensity.fiveLower => '5-',
    JmaIntensity.fiveUpper => '5+',
    JmaIntensity.sixUnknown => '!6-',
    JmaIntensity.sixLower => '6-',
    JmaIntensity.sixUpper => '6+',
    JmaIntensity.seven => '7',
  };

  String? _lpgmWireValue(JmaLpgmIntensity lpgm) => switch (lpgm) {
    JmaLpgmIntensity.unknown => null,
    JmaLpgmIntensity.zero => '0',
    JmaLpgmIntensity.one => '1',
    JmaLpgmIntensity.two => '2',
    JmaLpgmIntensity.three => '3',
    JmaLpgmIntensity.four => '4',
  };

  String _shakeLevelWireValue(ShakeDetectionLevel level) => switch (level) {
    ShakeDetectionLevel.weaker => 'Weaker',
    ShakeDetectionLevel.weak => 'Weak',
    ShakeDetectionLevel.medium => 'Medium',
    ShakeDetectionLevel.strong => 'Strong',
    ShakeDetectionLevel.stronger => 'Stronger',
  };

  /// Swift の `ISO8601DateFormatter`（既定オプション = 小数秒なし）で
  /// パース可能な JST オフセット付き文字列を生成する。
  String _iso8601Jst(DateTime dateTime) {
    final jst = dateTime.toUtc().add(const Duration(hours: 9));
    String two(int value) => value.toString().padLeft(2, '0');
    final year = jst.year.toString().padLeft(4, '0');
    return '$year-${two(jst.month)}-${two(jst.day)}'
        'T${two(jst.hour)}:${two(jst.minute)}:${two(jst.second)}+09:00';
  }
}
