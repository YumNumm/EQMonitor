// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'tsunami.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiV1Base _$TsunamiV1BaseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_TsunamiV1Base',
      json,
      ($checkedConvert) {
        final val = _TsunamiV1Base(
          eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
          headline: $checkedConvert('headline', (v) => v as String?),
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          infoType: $checkedConvert('info_type', (v) => v as String),
          pressAt: $checkedConvert(
            'press_at',
            (v) => DateTime.parse(v as String),
          ),
          reportAt: $checkedConvert(
            'report_at',
            (v) => DateTime.parse(v as String),
          ),
          serialNo: $checkedConvert('serial_no', (v) => (v as num?)?.toInt()),
          status: $checkedConvert('status', (v) => v as String),
          type: $checkedConvert('type', (v) => v as String),
          validAt: $checkedConvert(
            'valid_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'infoType': 'info_type',
        'pressAt': 'press_at',
        'reportAt': 'report_at',
        'serialNo': 'serial_no',
        'validAt': 'valid_at',
      },
    );

Map<String, dynamic> _$TsunamiV1BaseToJson(_TsunamiV1Base instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'headline': instance.headline,
      'id': instance.id,
      'info_type': instance.infoType,
      'press_at': instance.pressAt.toIso8601String(),
      'report_at': instance.reportAt.toIso8601String(),
      'serial_no': instance.serialNo,
      'status': instance.status,
      'type': instance.type,
      'valid_at': instance.validAt?.toIso8601String(),
    };

_Comment _$CommentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Comment', json, ($checkedConvert) {
      final val = _Comment(
        free: $checkedConvert('free', (v) => v as String?),
        warning: $checkedConvert(
          'warning',
          (v) => v == null
              ? null
              : CommentWarning.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'free': instance.free,
  'warning': instance.warning,
};

_CommentWarning _$CommentWarningFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CommentWarning', json, ($checkedConvert) {
      final val = _CommentWarning(
        text: $checkedConvert('text', (v) => v as String),
        codes: $checkedConvert(
          'codes',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CommentWarningToJson(_CommentWarning instance) =>
    <String, dynamic>{'text': instance.text, 'codes': instance.codes};

_CancelBody _$CancelBodyFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_CancelBody',
  json,
  ($checkedConvert) {
    final val = _CancelBody(text: $checkedConvert('text', (v) => v as String));
    return val;
  },
);

Map<String, dynamic> _$CancelBodyToJson(_CancelBody instance) =>
    <String, dynamic>{'text': instance.text};

_PublicBodyVTSE41Tsunami _$PublicBodyVTSE41TsunamiFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PublicBodyVTSE41Tsunami', json, ($checkedConvert) {
  final val = _PublicBodyVTSE41Tsunami(
    forecasts: $checkedConvert(
      'forecasts',
      (v) => (v as List<dynamic>)
          .map((e) => TsunamiForecast.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$PublicBodyVTSE41TsunamiToJson(
  _PublicBodyVTSE41Tsunami instance,
) => <String, dynamic>{'forecasts': instance.forecasts};

_PublicBodyVTSE51Tsunami _$PublicBodyVTSE51TsunamiFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PublicBodyVTSE51Tsunami', json, ($checkedConvert) {
  final val = _PublicBodyVTSE51Tsunami(
    forecasts: $checkedConvert(
      'forecasts',
      (v) => (v as List<dynamic>)
          .map((e) => TsunamiForecast.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    observations: $checkedConvert(
      'observations',
      (v) => (v as List<dynamic>?)
          ?.map((e) => TsunamiObservation.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$PublicBodyVTSE51TsunamiToJson(
  _PublicBodyVTSE51Tsunami instance,
) => <String, dynamic>{
  'forecasts': instance.forecasts,
  'observations': instance.observations,
};

_PublicBodyVTSE52Tsunami _$PublicBodyVTSE52TsunamiFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PublicBodyVTSE52Tsunami', json, ($checkedConvert) {
  final val = _PublicBodyVTSE52Tsunami(
    observations: $checkedConvert(
      'observations',
      (v) => (v as List<dynamic>?)
          ?.map((e) => TsunamiObservation.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    estimations: $checkedConvert(
      'estimations',
      (v) => (v as List<dynamic>)
          .map((e) => TsunamiEstimation.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$PublicBodyVTSE52TsunamiToJson(
  _PublicBodyVTSE52Tsunami instance,
) => <String, dynamic>{
  'observations': instance.observations,
  'estimations': instance.estimations,
};

_TsunamiForecast _$TsunamiForecastFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiForecast', json, ($checkedConvert) {
      final val = _TsunamiForecast(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        kind: $checkedConvert('kind', (v) => v as String),
        lastKind: $checkedConvert('lastKind', (v) => v as String),
        firstHeight: $checkedConvert(
          'firstHeight',
          (v) => v == null
              ? null
              : TsunamiForecastFirstHeight.fromJson(v as Map<String, dynamic>),
        ),
        maxHeight: $checkedConvert(
          'maxHeight',
          (v) => v == null
              ? null
              : TsunamiForecastMaxHeight.fromJson(v as Map<String, dynamic>),
        ),
        stations: $checkedConvert(
          'stations',
          (v) => (v as List<dynamic>?)
              ?.map(
                (e) =>
                    TsunamiForecastStation.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TsunamiForecastToJson(_TsunamiForecast instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'kind': instance.kind,
      'lastKind': instance.lastKind,
      'firstHeight': instance.firstHeight,
      'maxHeight': instance.maxHeight,
      'stations': instance.stations,
    };

_TsunamiForecastFirstHeight _$TsunamiForecastFirstHeightFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiForecastFirstHeight', json, ($checkedConvert) {
  final val = _TsunamiForecastFirstHeight(
    arrivalTime: $checkedConvert(
      'arrivalTime',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    condition: $checkedConvert(
      'condition',
      (v) =>
          $enumDecodeNullable(_$TsunamiForecastFirstHeightConditionEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiForecastFirstHeightToJson(
  _TsunamiForecastFirstHeight instance,
) => <String, dynamic>{
  'arrivalTime': instance.arrivalTime?.toIso8601String(),
  'condition': _$TsunamiForecastFirstHeightConditionEnumMap[instance.condition],
};

const _$TsunamiForecastFirstHeightConditionEnumMap = {
  TsunamiForecastFirstHeightCondition.arrival: '津波到達中と推測',
  TsunamiForecastFirstHeightCondition.firstTideDetected: '第１波の到達を確認',
  TsunamiForecastFirstHeightCondition.immediately: 'ただちに津波来襲と予測',
};

_TsunamiForecastMaxHeight _$TsunamiForecastMaxHeightFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiForecastMaxHeight', json, ($checkedConvert) {
  final val = _TsunamiForecastMaxHeight(
    value: $checkedConvert('value', (v) => (v as num?)?.toDouble()),
    isOver: $checkedConvert('isOver', (v) => v as bool?),
    condition: $checkedConvert(
      'condition',
      (v) => $enumDecodeNullable(_$TsunamiMaxHeightConditionEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiForecastMaxHeightToJson(
  _TsunamiForecastMaxHeight instance,
) => <String, dynamic>{
  'value': instance.value,
  'isOver': instance.isOver,
  'condition': _$TsunamiMaxHeightConditionEnumMap[instance.condition],
};

const _$TsunamiMaxHeightConditionEnumMap = {
  TsunamiMaxHeightCondition.high: '高い',
  TsunamiMaxHeightCondition.huge: '巨大',
};

_TsunamiForecastStation _$TsunamiForecastStationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiForecastStation', json, ($checkedConvert) {
  final val = _TsunamiForecastStation(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    highTideTime: $checkedConvert(
      'highTideTime',
      (v) => DateTime.parse(v as String),
    ),
    firstHeightTime: $checkedConvert(
      'firstHeightTime',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    condition: $checkedConvert(
      'condition',
      (v) =>
          $enumDecodeNullable(_$TsunamiForecastFirstHeightConditionEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiForecastStationToJson(
  _TsunamiForecastStation instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'highTideTime': instance.highTideTime.toIso8601String(),
  'firstHeightTime': instance.firstHeightTime?.toIso8601String(),
  'condition': _$TsunamiForecastFirstHeightConditionEnumMap[instance.condition],
};

_TsunamiObservation _$TsunamiObservationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiObservation', json, ($checkedConvert) {
      final val = _TsunamiObservation(
        code: $checkedConvert('code', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        stations: $checkedConvert(
          'stations',
          (v) => (v as List<dynamic>)
              .map(
                (e) => TsunamiObservationStation.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TsunamiObservationToJson(_TsunamiObservation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'stations': instance.stations,
    };

_TsunamiObservationStation _$TsunamiObservationStationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiObservationStation', json, ($checkedConvert) {
  final val = _TsunamiObservationStation(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    firstHeightArrivalTime: $checkedConvert(
      'firstHeightArrivalTime',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    firstHeightInitial: $checkedConvert(
      'firstHeightInitial',
      (v) => $enumDecodeNullable(
        _$TsunamiObservationStationFirstHeightIntialEnumMap,
        v,
      ),
    ),
    maxHeightTime: $checkedConvert(
      'maxHeightTime',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    maxHeightValue: $checkedConvert(
      'maxHeightValue',
      (v) => (v as num?)?.toDouble(),
    ),
    maxHeightIsOver: $checkedConvert('maxHeightIsOver', (v) => v as bool?),
    maxHeightIsRising: $checkedConvert('maxHeightIsRising', (v) => v as bool?),
    condition: $checkedConvert(
      'condition',
      (v) =>
          $enumDecodeNullable(_$TsunamiObservationStationConditionEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiObservationStationToJson(
  _TsunamiObservationStation instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'firstHeightArrivalTime': instance.firstHeightArrivalTime?.toIso8601String(),
  'firstHeightInitial':
      _$TsunamiObservationStationFirstHeightIntialEnumMap[instance
          .firstHeightInitial],
  'maxHeightTime': instance.maxHeightTime?.toIso8601String(),
  'maxHeightValue': instance.maxHeightValue,
  'maxHeightIsOver': instance.maxHeightIsOver,
  'maxHeightIsRising': instance.maxHeightIsRising,
  'condition': _$TsunamiObservationStationConditionEnumMap[instance.condition],
};

const _$TsunamiObservationStationFirstHeightIntialEnumMap = {
  TsunamiObservationStationFirstHeightIntial.push: '押し',
  TsunamiObservationStationFirstHeightIntial.pull: '引き',
};

const _$TsunamiObservationStationConditionEnumMap = {
  TsunamiObservationStationCondition.weak: '微弱',
  TsunamiObservationStationCondition.observing: '観測中',
  TsunamiObservationStationCondition.important: '重要',
};

_TsunamiEstimation _$TsunamiEstimationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiEstimation', json, ($checkedConvert) {
      final val = _TsunamiEstimation(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        firstHeightTime: $checkedConvert(
          'firstHeightTime',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        firstHeightCondition: $checkedConvert(
          'firstHeightCondition',
          (v) => $enumDecodeNullable(
            _$TsunamiEstimationFirstHeightConditionEnumMap,
            v,
          ),
        ),
        maxHeightTime: $checkedConvert(
          'maxHeightTime',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        maxHeightValue: $checkedConvert(
          'maxHeightValue',
          (v) => (v as num?)?.toDouble(),
        ),
        maxHeightIsOver: $checkedConvert('maxHeightIsOver', (v) => v as bool?),
        maxHeightCondition: $checkedConvert(
          'maxHeightCondition',
          (v) => $enumDecodeNullable(_$TsunamiMaxHeightConditionEnumMap, v),
        ),
        isObserving: $checkedConvert('isObserving', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$TsunamiEstimationToJson(_TsunamiEstimation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'firstHeightTime': instance.firstHeightTime?.toIso8601String(),
      'firstHeightCondition':
          _$TsunamiEstimationFirstHeightConditionEnumMap[instance
              .firstHeightCondition],
      'maxHeightTime': instance.maxHeightTime?.toIso8601String(),
      'maxHeightValue': instance.maxHeightValue,
      'maxHeightIsOver': instance.maxHeightIsOver,
      'maxHeightCondition':
          _$TsunamiMaxHeightConditionEnumMap[instance.maxHeightCondition],
      'isObserving': instance.isObserving,
    };

const _$TsunamiEstimationFirstHeightConditionEnumMap = {
  TsunamiEstimationFirstHeightCondition.alreadyArrived: '早いところでは既に津波到達と推定',
};

_PublicBodyVTSE41 _$PublicBodyVTSE41FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PublicBodyVTSE41', json, ($checkedConvert) {
      final val = _PublicBodyVTSE41(
        tsunami: $checkedConvert(
          'tsunami',
          (v) => PublicBodyVTSE41Tsunami.fromJson(v as Map<String, dynamic>),
        ),
        earthquakes: $checkedConvert(
          'earthquakes',
          (v) => (v as List<dynamic>)
              .map((e) => Earthquake.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        text: $checkedConvert('text', (v) => v as String?),
        comment: $checkedConvert(
          'comment',
          (v) => v == null ? null : Comment.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PublicBodyVTSE41ToJson(_PublicBodyVTSE41 instance) =>
    <String, dynamic>{
      'tsunami': instance.tsunami,
      'earthquakes': instance.earthquakes,
      'text': instance.text,
      'comment': instance.comment,
    };

_PublicBodyVTSE51 _$PublicBodyVTSE51FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PublicBodyVTSE51', json, ($checkedConvert) {
      final val = _PublicBodyVTSE51(
        tsunami: $checkedConvert(
          'tsunami',
          (v) => PublicBodyVTSE51Tsunami.fromJson(v as Map<String, dynamic>),
        ),
        earthquakes: $checkedConvert(
          'earthquakes',
          (v) => (v as List<dynamic>)
              .map((e) => Earthquake.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        text: $checkedConvert('text', (v) => v as String?),
        comment: $checkedConvert(
          'comment',
          (v) => v == null ? null : Comment.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PublicBodyVTSE51ToJson(_PublicBodyVTSE51 instance) =>
    <String, dynamic>{
      'tsunami': instance.tsunami,
      'earthquakes': instance.earthquakes,
      'text': instance.text,
      'comment': instance.comment,
    };

_PublicBodyVTSE52 _$PublicBodyVTSE52FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PublicBodyVTSE52', json, ($checkedConvert) {
      final val = _PublicBodyVTSE52(
        tsunami: $checkedConvert(
          'tsunami',
          (v) => PublicBodyVTSE52Tsunami.fromJson(v as Map<String, dynamic>),
        ),
        earthquakes: $checkedConvert(
          'earthquakes',
          (v) => (v as List<dynamic>)
              .map((e) => Earthquake.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        text: $checkedConvert('text', (v) => v as String?),
        comment: $checkedConvert(
          'comment',
          (v) => v == null ? null : Comment.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PublicBodyVTSE52ToJson(_PublicBodyVTSE52 instance) =>
    <String, dynamic>{
      'tsunami': instance.tsunami,
      'earthquakes': instance.earthquakes,
      'text': instance.text,
      'comment': instance.comment,
    };

_Earthquake _$EarthquakeFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Earthquake',
  json,
  ($checkedConvert) {
    final val = _Earthquake(
      originTime: $checkedConvert(
        'origin_time',
        (v) => DateTime.parse(v as String),
      ),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => DateTime.parse(v as String),
      ),
      hypocenter: $checkedConvert(
        'hypocenter',
        (v) => EarthquakeHypocenter.fromJson(v as Map<String, dynamic>),
      ),
      magnitude: $checkedConvert(
        'magnitude',
        (v) => EarthquakeMagnitude.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'originTime': 'origin_time',
    'arrivalTime': 'arrival_time',
  },
);

Map<String, dynamic> _$EarthquakeToJson(_Earthquake instance) =>
    <String, dynamic>{
      'origin_time': instance.originTime.toIso8601String(),
      'arrival_time': instance.arrivalTime.toIso8601String(),
      'hypocenter': instance.hypocenter,
      'magnitude': instance.magnitude,
    };

_EarthquakeHypocenter _$EarthquakeHypocenterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeHypocenter', json, ($checkedConvert) {
  final val = _EarthquakeHypocenter(
    name: $checkedConvert('name', (v) => v as String),
    code: $checkedConvert('code', (v) => v as String),
    depth: $checkedConvert('depth', (v) => (v as num?)?.toInt()),
    detailed: $checkedConvert(
      'detailed',
      (v) => v == null
          ? null
          : EarthquakeHypocenterDetailed.fromJson(v as Map<String, dynamic>),
    ),
    coordinate: $checkedConvert(
      'coordinate',
      (v) => v == null
          ? null
          : EarthquakeHypocenterCoordinate.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeHypocenterToJson(
  _EarthquakeHypocenter instance,
) => <String, dynamic>{
  'name': instance.name,
  'code': instance.code,
  'depth': instance.depth,
  'detailed': instance.detailed,
  'coordinate': instance.coordinate,
};

_EarthquakeHypocenterDetailed _$EarthquakeHypocenterDetailedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeHypocenterDetailed', json, ($checkedConvert) {
  final val = _EarthquakeHypocenterDetailed(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeHypocenterDetailedToJson(
  _EarthquakeHypocenterDetailed instance,
) => <String, dynamic>{'code': instance.code, 'name': instance.name};

_EarthquakeHypocenterCoordinate _$EarthquakeHypocenterCoordinateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeHypocenterCoordinate', json, ($checkedConvert) {
  final val = _EarthquakeHypocenterCoordinate(
    lat: $checkedConvert('lat', (v) => (v as num).toDouble()),
    lon: $checkedConvert('lon', (v) => (v as num).toDouble()),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeHypocenterCoordinateToJson(
  _EarthquakeHypocenterCoordinate instance,
) => <String, dynamic>{'lat': instance.lat, 'lon': instance.lon};

_EarthquakeMagnitude _$EarthquakeMagnitudeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EarthquakeMagnitude', json, ($checkedConvert) {
      final val = _EarthquakeMagnitude(
        value: $checkedConvert('value', (v) => (v as num?)?.toDouble()),
        condition: $checkedConvert(
          'condition',
          (v) => $enumDecodeNullable(_$EarthquakeMagnitudeConditionEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EarthquakeMagnitudeToJson(
  _EarthquakeMagnitude instance,
) => <String, dynamic>{
  'value': instance.value,
  'condition': _$EarthquakeMagnitudeConditionEnumMap[instance.condition],
};

const _$EarthquakeMagnitudeConditionEnumMap = {
  EarthquakeMagnitudeCondition.unknown: 'Ｍ不明',
  EarthquakeMagnitudeCondition.huge: 'Ｍ８を超える巨大地震',
};

TsunamiDataVTSE41 _$TsunamiDataVTSE41FromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TsunamiDataVTSE41',
      json,
      ($checkedConvert) {
        final val = TsunamiDataVTSE41(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
          serialNo: $checkedConvert('serial_no', (v) => (v as num?)?.toInt()),
          body: $checkedConvert(
            'body',
            (v) => TsunamiBody.fromJson(v as Map<String, dynamic>),
          ),
          status: $checkedConvert('status', (v) => v as String),
          headline: $checkedConvert('headline', (v) => v as String?),
          infoType: $checkedConvert('info_type', (v) => v as String),
          pressAt: $checkedConvert(
            'press_at',
            (v) => DateTime.parse(v as String),
          ),
          reportAt: $checkedConvert(
            'report_at',
            (v) => DateTime.parse(v as String),
          ),
          validAt: $checkedConvert(
            'valid_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          $type: $checkedConvert('type', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'serialNo': 'serial_no',
        'infoType': 'info_type',
        'pressAt': 'press_at',
        'reportAt': 'report_at',
        'validAt': 'valid_at',
        r'$type': 'type',
      },
    );

Map<String, dynamic> _$TsunamiDataVTSE41ToJson(TsunamiDataVTSE41 instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'serial_no': instance.serialNo,
      'body': instance.body,
      'status': instance.status,
      'headline': instance.headline,
      'info_type': instance.infoType,
      'press_at': instance.pressAt.toIso8601String(),
      'report_at': instance.reportAt.toIso8601String(),
      'valid_at': instance.validAt?.toIso8601String(),
      'type': instance.$type,
    };

TsunamiDataVTSE51 _$TsunamiDataVTSE51FromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TsunamiDataVTSE51',
      json,
      ($checkedConvert) {
        final val = TsunamiDataVTSE51(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
          serialNo: $checkedConvert('serial_no', (v) => (v as num?)?.toInt()),
          body: $checkedConvert(
            'body',
            (v) => TsunamiBody.fromJson(v as Map<String, dynamic>),
          ),
          status: $checkedConvert('status', (v) => v as String),
          headline: $checkedConvert('headline', (v) => v as String?),
          infoType: $checkedConvert('info_type', (v) => v as String),
          pressAt: $checkedConvert(
            'press_at',
            (v) => DateTime.parse(v as String),
          ),
          reportAt: $checkedConvert(
            'report_at',
            (v) => DateTime.parse(v as String),
          ),
          validAt: $checkedConvert(
            'valid_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          $type: $checkedConvert('type', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'serialNo': 'serial_no',
        'infoType': 'info_type',
        'pressAt': 'press_at',
        'reportAt': 'report_at',
        'validAt': 'valid_at',
        r'$type': 'type',
      },
    );

Map<String, dynamic> _$TsunamiDataVTSE51ToJson(TsunamiDataVTSE51 instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'serial_no': instance.serialNo,
      'body': instance.body,
      'status': instance.status,
      'headline': instance.headline,
      'info_type': instance.infoType,
      'press_at': instance.pressAt.toIso8601String(),
      'report_at': instance.reportAt.toIso8601String(),
      'valid_at': instance.validAt?.toIso8601String(),
      'type': instance.$type,
    };

TsunamiDataVTSE52 _$TsunamiDataVTSE52FromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TsunamiDataVTSE52',
      json,
      ($checkedConvert) {
        final val = TsunamiDataVTSE52(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
          serialNo: $checkedConvert('serial_no', (v) => (v as num?)?.toInt()),
          body: $checkedConvert(
            'body',
            (v) => TsunamiBody.fromJson(v as Map<String, dynamic>),
          ),
          status: $checkedConvert('status', (v) => v as String),
          headline: $checkedConvert('headline', (v) => v as String?),
          $type: $checkedConvert('type', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'serialNo': 'serial_no',
        r'$type': 'type',
      },
    );

Map<String, dynamic> _$TsunamiDataVTSE52ToJson(TsunamiDataVTSE52 instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'serial_no': instance.serialNo,
      'body': instance.body,
      'status': instance.status,
      'headline': instance.headline,
      'type': instance.$type,
    };

_TsunamiGroupedByEvent _$TsunamiGroupedByEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiGroupedByEvent', json, ($checkedConvert) {
  final val = _TsunamiGroupedByEvent(
    eventId: $checkedConvert('event_id', (v) => v as String),
    vtse41: $checkedConvert(
      'vtse41',
      (v) => v == null
          ? null
          : TsunamiDataVTSE41.fromJson(v as Map<String, dynamic>),
    ),
    vtse51: $checkedConvert(
      'vtse51',
      (v) => v == null
          ? null
          : TsunamiDataVTSE51.fromJson(v as Map<String, dynamic>),
    ),
    vtse52: $checkedConvert(
      'vtse52',
      (v) => v == null
          ? null
          : TsunamiDataVTSE52.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$TsunamiGroupedByEventToJson(
  _TsunamiGroupedByEvent instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'vtse41': instance.vtse41,
  'vtse51': instance.vtse51,
  'vtse52': instance.vtse52,
};

_TsunamiSummaryResponse _$TsunamiSummaryResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiSummaryResponse', json, ($checkedConvert) {
  final val = _TsunamiSummaryResponse(
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => TsunamiGroupedByEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiSummaryResponseToJson(
  _TsunamiSummaryResponse instance,
) => <String, dynamic>{'data': instance.data};

_TsunamiDetailResponse _$TsunamiDetailResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiDetailResponse', json, ($checkedConvert) {
  final val = _TsunamiDetailResponse(
    eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => TsunamiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    count: $checkedConvert('count', (v) => (v as num).toInt()),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$TsunamiDetailResponseToJson(
  _TsunamiDetailResponse instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'data': instance.data,
  'count': instance.count,
};
