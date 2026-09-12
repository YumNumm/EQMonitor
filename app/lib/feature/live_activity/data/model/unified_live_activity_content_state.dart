// ignore_for_file: unnecessary_type_name_in_constructor

import 'package:eqmonitor/feature/live_activity/data/model/unified_earthquake.dart';
import 'package:eqmonitor/feature/live_activity/data/model/unified_eew.dart';
import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_json_converter.dart';
import 'package:eqmonitor/feature/live_activity/data/model/unified_shake_detection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

export 'unified_earthquake.dart';
export 'unified_eew.dart';
export 'unified_live_activity_json_converter.dart';
export 'unified_shake_detection.dart';

part 'unified_live_activity_content_state.freezed.dart';

enum UnifiedLiveActivityPrimary {
  shakeDetection('shake_detection'),
  eew('eew'),
  earthquake('earthquake');

  new(this.wireName);

  final String wireName;

  static UnifiedLiveActivityPrimary fromJson(String value) => switch (value) {
    'shake_detection' => .shakeDetection,
    'eew' => .eew,
    'earthquake' => .earthquake,
    _ => throw FormatException('primary が不正です: $value'),
  };
}

@freezed
abstract class UnifiedLiveActivityAttributes
    with _$UnifiedLiveActivityAttributes {
  const UnifiedLiveActivityAttributes._();

  const factory UnifiedLiveActivityAttributes({required String id}) =
      _UnifiedLiveActivityAttributes;

  factory UnifiedLiveActivityAttributes.fromJson(Map<String, dynamic> json) {
    final reader = UnifiedLiveActivityJsonReader(json, label: 'attributes')
      ..requireOnlyKeys(const {'id'});
    return UnifiedLiveActivityAttributes(
      id: reader.requiredString('id', nonEmpty: true),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'id': id};
}

@freezed
abstract class UnifiedLiveActivityContentState
    with _$UnifiedLiveActivityContentState {
  const UnifiedLiveActivityContentState._();

  const factory UnifiedLiveActivityContentState({
    required int schemaVersion,
    required String id,
    required DateTime updatedAt,
    required UnifiedLiveActivityPrimary primary,
    required UnifiedShakeDetection? shakeDetection,
    required UnifiedEew? eew,
    required UnifiedEarthquake? earthquake,
  }) = _UnifiedLiveActivityContentState;

  factory UnifiedLiveActivityContentState.fromJson(Map<String, dynamic> json) {
    final reader = UnifiedLiveActivityJsonReader(json, label: 'contentState');
    final schemaVersion = reader.requiredInt('schemaVersion');
    if (schemaVersion != 2) {
      throw FormatException('schemaVersion は 2 である必要があります: $schemaVersion');
    }
    final primary = UnifiedLiveActivityPrimary.fromJson(
      reader.requiredString('primary'),
    );
    final shakeJson = reader.requiredNullableMap('shakeDetection');
    final eewJson = reader.requiredNullableMap('eew');
    final earthquakeJson = reader.requiredNullableMap('earthquake');
    final state = UnifiedLiveActivityContentState(
      schemaVersion: schemaVersion,
      id: reader.requiredString('id', nonEmpty: true),
      updatedAt: reader.requiredDateTime('updatedAt'),
      primary: primary,
      shakeDetection: shakeJson == null
          ? null
          : UnifiedShakeDetection.fromJson(shakeJson),
      eew: eewJson == null ? null : UnifiedEew.fromJson(eewJson),
      earthquake: earthquakeJson == null
          ? null
          : UnifiedEarthquake.fromJson(earthquakeJson),
    );
    final primaryBlock = switch (state.primary) {
      .shakeDetection => state.shakeDetection,
      .eew => state.eew,
      .earthquake => state.earthquake,
    };
    if (primaryBlock == null) {
      throw const FormatException('primary が参照する情報ブロックがありません');
    }
    return state;
  }

  /// 直接生成された DTO も含めて Wire 境界の制約を再検証する。
  UnifiedLiveActivityContentState validated() =>
      UnifiedLiveActivityContentState.fromJson(toJson());

  Map<String, dynamic> toJson() => <String, dynamic>{
    'schemaVersion': schemaVersion,
    'id': id,
    'updatedAt': UnifiedLiveActivityWire.dateTimeToJson(updatedAt),
    'primary': primary.wireName,
    'shakeDetection': shakeDetection?.toJson(),
    'eew': eew?.toJson(),
    'earthquake': earthquake?.toJson(),
  };
}
