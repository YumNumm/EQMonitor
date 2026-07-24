// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_vxse_debug_draft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarthquakeVxse51DebugDraft _$EarthquakeVxse51DebugDraftFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakeVxse51DebugDraft',
  json,
  ($checkedConvert) {
    final val = EarthquakeVxse51DebugDraft(
      eventId: $checkedConvert('event_id', (v) => v as String),
      reportedAt: $checkedConvert(
        'reported_at',
        (v) => DateTime.parse(v as String),
      ),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$TelegramStatusEnumMap, v),
      ),
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      regions: $checkedConvert(
        'regions',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            $enumDecode(_$JmaIntensityEnumMap, k),
            (e as List<dynamic>)
                .map((e) => IntensityRegion.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        ),
      ),
      prefectures: $checkedConvert(
        'prefectures',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            $enumDecode(_$JmaIntensityEnumMap, k),
            (e as List<dynamic>)
                .map(
                  (e) =>
                      IntensityPrefecture.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
        ),
      ),
      comments: $checkedConvert(
        'comments',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  EarthquakeTelegramComment.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      $type: $checkedConvert('type', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'reportedAt': 'reported_at',
    'maxIntensity': 'max_intensity',
    r'$type': 'type',
  },
);

Map<String, dynamic> _$EarthquakeVxse51DebugDraftToJson(
  EarthquakeVxse51DebugDraft instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'reported_at': instance.reportedAt.toIso8601String(),
  'status': _$TelegramStatusEnumMap[instance.status]!,
  'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity]!,
  'regions': instance.regions.map(
    (k, e) => MapEntry(_$JmaIntensityEnumMap[k]!, e),
  ),
  'prefectures': instance.prefectures.map(
    (k, e) => MapEntry(_$JmaIntensityEnumMap[k]!, e),
  ),
  'comments': instance.comments,
  'type': instance.$type,
};

const _$TelegramStatusEnumMap = {
  TelegramStatus.normal: 'NORMAL',
  TelegramStatus.training: 'TRAINING',
  TelegramStatus.test: 'TEST',
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.unknown: 'unknown',
  JmaIntensity.zero: 'zero',
  JmaIntensity.one: 'one',
  JmaIntensity.two: 'two',
  JmaIntensity.three: 'three',
  JmaIntensity.four: 'four',
  JmaIntensity.fiveUnknown: 'fiveUnknown',
  JmaIntensity.fiveLower: 'fiveLower',
  JmaIntensity.fiveUpper: 'fiveUpper',
  JmaIntensity.sixUnknown: 'sixUnknown',
  JmaIntensity.sixLower: 'sixLower',
  JmaIntensity.sixUpper: 'sixUpper',
  JmaIntensity.seven: 'seven',
};

EarthquakeVxse52DebugDraft _$EarthquakeVxse52DebugDraftFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakeVxse52DebugDraft',
  json,
  ($checkedConvert) {
    final val = EarthquakeVxse52DebugDraft(
      eventId: $checkedConvert('event_id', (v) => v as String),
      reportedAt: $checkedConvert(
        'reported_at',
        (v) => DateTime.parse(v as String),
      ),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$TelegramStatusEnumMap, v),
      ),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      hypocenter: $checkedConvert(
        'hypocenter',
        (v) => EarthquakeHypocenter.fromJson(v as Map<String, dynamic>),
      ),
      comments: $checkedConvert(
        'comments',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  EarthquakeTelegramComment.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      $type: $checkedConvert('type', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'reportedAt': 'reported_at',
    'arrivalTime': 'arrival_time',
    'originTime': 'origin_time',
    r'$type': 'type',
  },
);

Map<String, dynamic> _$EarthquakeVxse52DebugDraftToJson(
  EarthquakeVxse52DebugDraft instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'reported_at': instance.reportedAt.toIso8601String(),
  'status': _$TelegramStatusEnumMap[instance.status]!,
  'arrival_time': instance.arrivalTime?.toIso8601String(),
  'origin_time': instance.originTime?.toIso8601String(),
  'hypocenter': instance.hypocenter,
  'comments': instance.comments,
  'type': instance.$type,
};

EarthquakeVxse53DebugDraft _$EarthquakeVxse53DebugDraftFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakeVxse53DebugDraft',
  json,
  ($checkedConvert) {
    final val = EarthquakeVxse53DebugDraft(
      eventId: $checkedConvert('event_id', (v) => v as String),
      reportedAt: $checkedConvert(
        'reported_at',
        (v) => DateTime.parse(v as String),
      ),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$TelegramStatusEnumMap, v),
      ),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      hypocenter: $checkedConvert(
        'hypocenter',
        (v) => EarthquakeHypocenter.fromJson(v as Map<String, dynamic>),
      ),
      earthquakeType: $checkedConvert(
        'earthquake_type',
        (v) => $enumDecode(_$EarthquakeTypeEnumMap, v),
      ),
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      regions: $checkedConvert(
        'regions',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            $enumDecode(_$JmaIntensityEnumMap, k),
            (e as List<dynamic>)
                .map((e) => IntensityRegion.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        ),
      ),
      intensityTree: $checkedConvert(
        'intensity_tree',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            $enumDecode(_$JmaIntensityEnumMap, k),
            (e as List<dynamic>)
                .map(
                  (e) => PrefectureIntensityNode.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
          ),
        ),
      ),
      comments: $checkedConvert(
        'comments',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  EarthquakeTelegramComment.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      $type: $checkedConvert('type', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'reportedAt': 'reported_at',
    'arrivalTime': 'arrival_time',
    'originTime': 'origin_time',
    'earthquakeType': 'earthquake_type',
    'maxIntensity': 'max_intensity',
    'intensityTree': 'intensity_tree',
    r'$type': 'type',
  },
);

Map<String, dynamic> _$EarthquakeVxse53DebugDraftToJson(
  EarthquakeVxse53DebugDraft instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'reported_at': instance.reportedAt.toIso8601String(),
  'status': _$TelegramStatusEnumMap[instance.status]!,
  'arrival_time': instance.arrivalTime?.toIso8601String(),
  'origin_time': instance.originTime?.toIso8601String(),
  'hypocenter': instance.hypocenter,
  'earthquake_type': _$EarthquakeTypeEnumMap[instance.earthquakeType]!,
  'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity]!,
  'regions': instance.regions.map(
    (k, e) => MapEntry(_$JmaIntensityEnumMap[k]!, e),
  ),
  'intensity_tree': instance.intensityTree.map(
    (k, e) => MapEntry(_$JmaIntensityEnumMap[k]!, e),
  ),
  'comments': instance.comments,
  'type': instance.$type,
};

const _$EarthquakeTypeEnumMap = {
  EarthquakeType.normal: 'NORMAL',
  EarthquakeType.distant: 'DISTANT',
  EarthquakeType.volcano: 'VOLCANO',
};

EarthquakeVxse61DebugDraft _$EarthquakeVxse61DebugDraftFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakeVxse61DebugDraft',
  json,
  ($checkedConvert) {
    final val = EarthquakeVxse61DebugDraft(
      eventId: $checkedConvert('event_id', (v) => v as String),
      reportedAt: $checkedConvert(
        'reported_at',
        (v) => DateTime.parse(v as String),
      ),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$TelegramStatusEnumMap, v),
      ),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      hypocenter: $checkedConvert(
        'hypocenter',
        (v) => EarthquakeHypocenter.fromJson(v as Map<String, dynamic>),
      ),
      comments: $checkedConvert(
        'comments',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  EarthquakeTelegramComment.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      $type: $checkedConvert('type', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'reportedAt': 'reported_at',
    'arrivalTime': 'arrival_time',
    'originTime': 'origin_time',
    r'$type': 'type',
  },
);

Map<String, dynamic> _$EarthquakeVxse61DebugDraftToJson(
  EarthquakeVxse61DebugDraft instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'reported_at': instance.reportedAt.toIso8601String(),
  'status': _$TelegramStatusEnumMap[instance.status]!,
  'arrival_time': instance.arrivalTime?.toIso8601String(),
  'origin_time': instance.originTime?.toIso8601String(),
  'hypocenter': instance.hypocenter,
  'comments': instance.comments,
  'type': instance.$type,
};

EarthquakeVxse62DebugDraft _$EarthquakeVxse62DebugDraftFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakeVxse62DebugDraft',
  json,
  ($checkedConvert) {
    final val = EarthquakeVxse62DebugDraft(
      eventId: $checkedConvert('event_id', (v) => v as String),
      reportedAt: $checkedConvert(
        'reported_at',
        (v) => DateTime.parse(v as String),
      ),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$TelegramStatusEnumMap, v),
      ),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      hypocenter: $checkedConvert(
        'hypocenter',
        (v) => EarthquakeHypocenter.fromJson(v as Map<String, dynamic>),
      ),
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      maxLpgmIntensity: $checkedConvert(
        'max_lpgm_intensity',
        (v) => $enumDecode(_$JmaLpgmIntensityEnumMap, v),
      ),
      regions: $checkedConvert(
        'regions',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            $enumDecode(_$JmaIntensityEnumMap, k),
            (e as List<dynamic>)
                .map((e) => IntensityRegion.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        ),
      ),
      intensityTree: $checkedConvert(
        'intensity_tree',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            $enumDecode(_$JmaIntensityEnumMap, k),
            (e as List<dynamic>)
                .map(
                  (e) => PrefectureIntensityNode.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
          ),
        ),
      ),
      lpgmRegions: $checkedConvert(
        'lpgm_regions',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            $enumDecode(_$JmaLpgmIntensityEnumMap, k),
            (e as List<dynamic>)
                .map(
                  (e) =>
                      LpgmIntensityRegion.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
        ),
      ),
      lpgmIntensityTree: $checkedConvert(
        'lpgm_intensity_tree',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            $enumDecode(_$JmaLpgmIntensityEnumMap, k),
            (e as List<dynamic>)
                .map(
                  (e) => PrefectureLpgmIntensityNode.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
          ),
        ),
      ),
      comments: $checkedConvert(
        'comments',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  EarthquakeTelegramComment.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      $type: $checkedConvert('type', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'reportedAt': 'reported_at',
    'arrivalTime': 'arrival_time',
    'originTime': 'origin_time',
    'maxIntensity': 'max_intensity',
    'maxLpgmIntensity': 'max_lpgm_intensity',
    'intensityTree': 'intensity_tree',
    'lpgmRegions': 'lpgm_regions',
    'lpgmIntensityTree': 'lpgm_intensity_tree',
    r'$type': 'type',
  },
);

Map<String, dynamic> _$EarthquakeVxse62DebugDraftToJson(
  EarthquakeVxse62DebugDraft instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'reported_at': instance.reportedAt.toIso8601String(),
  'status': _$TelegramStatusEnumMap[instance.status]!,
  'arrival_time': instance.arrivalTime?.toIso8601String(),
  'origin_time': instance.originTime?.toIso8601String(),
  'hypocenter': instance.hypocenter,
  'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity]!,
  'max_lpgm_intensity': _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensity]!,
  'regions': instance.regions.map(
    (k, e) => MapEntry(_$JmaIntensityEnumMap[k]!, e),
  ),
  'intensity_tree': instance.intensityTree.map(
    (k, e) => MapEntry(_$JmaIntensityEnumMap[k]!, e),
  ),
  'lpgm_regions': instance.lpgmRegions.map(
    (k, e) => MapEntry(_$JmaLpgmIntensityEnumMap[k]!, e),
  ),
  'lpgm_intensity_tree': instance.lpgmIntensityTree.map(
    (k, e) => MapEntry(_$JmaLpgmIntensityEnumMap[k]!, e),
  ),
  'comments': instance.comments,
  'type': instance.$type,
};

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.unknown: 'unknown',
  JmaLpgmIntensity.zero: 'zero',
  JmaLpgmIntensity.one: 'one',
  JmaLpgmIntensity.two: 'two',
  JmaLpgmIntensity.three: 'three',
  JmaLpgmIntensity.four: 'four',
};
