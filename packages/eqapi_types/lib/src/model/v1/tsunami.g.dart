// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'tsunami.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TsunamiV1BaseImpl _$$_TsunamiV1BaseImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TsunamiV1BaseImpl',
      json,
      ($checkedConvert) {
        final val = _$_TsunamiV1BaseImpl(
          eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
          headline: $checkedConvert('headline', (v) => v as String?),
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          infoType: $checkedConvert('info_type', (v) => v as String),
          pressAt:
              $checkedConvert('press_at', (v) => DateTime.parse(v as String)),
          reportAt:
              $checkedConvert('report_at', (v) => DateTime.parse(v as String)),
          serialNo: $checkedConvert('serial_no', (v) => (v as num?)?.toInt()),
          status: $checkedConvert('status', (v) => v as String),
          type: $checkedConvert('type', (v) => v as String),
          validAt: $checkedConvert('valid_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'infoType': 'info_type',
        'pressAt': 'press_at',
        'reportAt': 'report_at',
        'serialNo': 'serial_no',
        'validAt': 'valid_at'
      },
    );

Map<String, dynamic> _$$_TsunamiV1BaseImplToJson(
        _$_TsunamiV1BaseImpl instance) =>
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

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$CommentImpl',
      json,
      ($checkedConvert) {
        final val = _$CommentImpl(
          free: $checkedConvert('free', (v) => v as String?),
          warning: $checkedConvert(
              'warning',
              (v) => v == null
                  ? null
                  : CommentWarning.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'free': instance.free,
      'warning': instance.warning,
    };

_$CommentWarningImpl _$$CommentWarningImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$CommentWarningImpl',
      json,
      ($checkedConvert) {
        final val = _$CommentWarningImpl(
          text: $checkedConvert('text', (v) => v as String),
          codes: $checkedConvert('codes',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$CommentWarningImplToJson(
        _$CommentWarningImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'codes': instance.codes,
    };

_$CancelBodyImpl _$$CancelBodyImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$CancelBodyImpl',
      json,
      ($checkedConvert) {
        final val = _$CancelBodyImpl(
          text: $checkedConvert('text', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$CancelBodyImplToJson(_$CancelBodyImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

_$PublicBodyVTSE41TsunamiImpl _$$PublicBodyVTSE41TsunamiImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PublicBodyVTSE41TsunamiImpl',
      json,
      ($checkedConvert) {
        final val = _$PublicBodyVTSE41TsunamiImpl(
          forecasts: $checkedConvert(
              'forecasts',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      TsunamiForecast.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$PublicBodyVTSE41TsunamiImplToJson(
        _$PublicBodyVTSE41TsunamiImpl instance) =>
    <String, dynamic>{
      'forecasts': instance.forecasts,
    };

_$PublicBodyVTSE51TsunamiImpl _$$PublicBodyVTSE51TsunamiImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PublicBodyVTSE51TsunamiImpl',
      json,
      ($checkedConvert) {
        final val = _$PublicBodyVTSE51TsunamiImpl(
          forecasts: $checkedConvert(
              'forecasts',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      TsunamiForecast.fromJson(e as Map<String, dynamic>))
                  .toList()),
          observations: $checkedConvert(
              'observations',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      TsunamiObservation.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$PublicBodyVTSE51TsunamiImplToJson(
        _$PublicBodyVTSE51TsunamiImpl instance) =>
    <String, dynamic>{
      'forecasts': instance.forecasts,
      'observations': instance.observations,
    };

_$PublicBodyVTSE52TsunamiImpl _$$PublicBodyVTSE52TsunamiImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PublicBodyVTSE52TsunamiImpl',
      json,
      ($checkedConvert) {
        final val = _$PublicBodyVTSE52TsunamiImpl(
          observations: $checkedConvert(
              'observations',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      TsunamiObservation.fromJson(e as Map<String, dynamic>))
                  .toList()),
          estimations: $checkedConvert(
              'estimations',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      TsunamiEstimation.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$PublicBodyVTSE52TsunamiImplToJson(
        _$PublicBodyVTSE52TsunamiImpl instance) =>
    <String, dynamic>{
      'observations': instance.observations,
      'estimations': instance.estimations,
    };

_$TsunamiForecastImpl _$$TsunamiForecastImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiForecastImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiForecastImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          kind: $checkedConvert('kind', (v) => v as String),
          lastKind: $checkedConvert('lastKind', (v) => v as String),
          firstHeight: $checkedConvert(
              'firstHeight',
              (v) => v == null
                  ? null
                  : TsunamiForecastFirstHeight.fromJson(
                      v as Map<String, dynamic>)),
          maxHeight: $checkedConvert(
              'maxHeight',
              (v) => v == null
                  ? null
                  : TsunamiForecastMaxHeight.fromJson(
                      v as Map<String, dynamic>)),
          stations: $checkedConvert(
              'stations',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => TsunamiForecastStation.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiForecastImplToJson(
        _$TsunamiForecastImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'kind': instance.kind,
      'lastKind': instance.lastKind,
      'firstHeight': instance.firstHeight,
      'maxHeight': instance.maxHeight,
      'stations': instance.stations,
    };

_$TsunamiForecastFirstHeightImpl _$$TsunamiForecastFirstHeightImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiForecastFirstHeightImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiForecastFirstHeightImpl(
          arrivalTime: $checkedConvert('arrivalTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          condition: $checkedConvert(
              'condition',
              (v) => $enumDecodeNullable(
                  _$TsunamiForecastFirstHeightConditionEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiForecastFirstHeightImplToJson(
        _$TsunamiForecastFirstHeightImpl instance) =>
    <String, dynamic>{
      'arrivalTime': instance.arrivalTime?.toIso8601String(),
      'condition':
          _$TsunamiForecastFirstHeightConditionEnumMap[instance.condition],
    };

const _$TsunamiForecastFirstHeightConditionEnumMap = {
  TsunamiForecastFirstHeightCondition.arrival: '津波到達中と推測',
  TsunamiForecastFirstHeightCondition.firstTideDetected: '第１波の到達を確認',
  TsunamiForecastFirstHeightCondition.immediately: 'ただちに津波来襲と予測',
};

_$TsunamiForecastMaxHeightImpl _$$TsunamiForecastMaxHeightImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiForecastMaxHeightImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiForecastMaxHeightImpl(
          value: $checkedConvert('value', (v) => (v as num?)?.toDouble()),
          isOver: $checkedConvert('isOver', (v) => v as bool?),
          condition: $checkedConvert(
              'condition',
              (v) =>
                  $enumDecodeNullable(_$TsunamiMaxHeightConditionEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiForecastMaxHeightImplToJson(
        _$TsunamiForecastMaxHeightImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'isOver': instance.isOver,
      'condition': _$TsunamiMaxHeightConditionEnumMap[instance.condition],
    };

const _$TsunamiMaxHeightConditionEnumMap = {
  TsunamiMaxHeightCondition.high: '高い',
  TsunamiMaxHeightCondition.huge: '巨大',
};

_$TsunamiForecastStationImpl _$$TsunamiForecastStationImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiForecastStationImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiForecastStationImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          highTideTime: $checkedConvert(
              'highTideTime', (v) => DateTime.parse(v as String)),
          firstHeightTime: $checkedConvert('firstHeightTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          condition: $checkedConvert(
              'condition',
              (v) => $enumDecodeNullable(
                  _$TsunamiForecastFirstHeightConditionEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiForecastStationImplToJson(
        _$TsunamiForecastStationImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'highTideTime': instance.highTideTime.toIso8601String(),
      'firstHeightTime': instance.firstHeightTime?.toIso8601String(),
      'condition':
          _$TsunamiForecastFirstHeightConditionEnumMap[instance.condition],
    };

_$TsunamiObservationImpl _$$TsunamiObservationImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiObservationImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiObservationImpl(
          code: $checkedConvert('code', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          stations: $checkedConvert(
              'stations',
              (v) => (v as List<dynamic>)
                  .map((e) => TsunamiObservationStation.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiObservationImplToJson(
        _$TsunamiObservationImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'stations': instance.stations,
    };

_$TsunamiObservationStationImpl _$$TsunamiObservationStationImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiObservationStationImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiObservationStationImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          firstHeightArrivalTime: $checkedConvert('firstHeightArrivalTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          firstHeightInitial: $checkedConvert(
              'firstHeightInitial',
              (v) => $enumDecodeNullable(
                  _$TsunamiObservationStationFirstHeightIntialEnumMap, v)),
          maxHeightTime: $checkedConvert('maxHeightTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          maxHeightValue:
              $checkedConvert('maxHeightValue', (v) => (v as num?)?.toDouble()),
          maxHeightIsOver:
              $checkedConvert('maxHeightIsOver', (v) => v as bool?),
          maxHeightIsRising:
              $checkedConvert('maxHeightIsRising', (v) => v as bool?),
          condition: $checkedConvert(
              'condition',
              (v) => $enumDecodeNullable(
                  _$TsunamiObservationStationConditionEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiObservationStationImplToJson(
        _$TsunamiObservationStationImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'firstHeightArrivalTime':
          instance.firstHeightArrivalTime?.toIso8601String(),
      'firstHeightInitial': _$TsunamiObservationStationFirstHeightIntialEnumMap[
          instance.firstHeightInitial],
      'maxHeightTime': instance.maxHeightTime?.toIso8601String(),
      'maxHeightValue': instance.maxHeightValue,
      'maxHeightIsOver': instance.maxHeightIsOver,
      'maxHeightIsRising': instance.maxHeightIsRising,
      'condition':
          _$TsunamiObservationStationConditionEnumMap[instance.condition],
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

_$TsunamiEstimationImpl _$$TsunamiEstimationImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiEstimationImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiEstimationImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          firstHeightTime: $checkedConvert('firstHeightTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          firstHeightCondition: $checkedConvert(
              'firstHeightCondition',
              (v) => $enumDecodeNullable(
                  _$TsunamiEstimationFirstHeightConditionEnumMap, v)),
          maxHeightTime: $checkedConvert('maxHeightTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          maxHeightValue:
              $checkedConvert('maxHeightValue', (v) => (v as num?)?.toDouble()),
          maxHeightIsOver:
              $checkedConvert('maxHeightIsOver', (v) => v as bool?),
          maxHeightCondition: $checkedConvert(
              'maxHeightCondition',
              (v) =>
                  $enumDecodeNullable(_$TsunamiMaxHeightConditionEnumMap, v)),
          isObserving: $checkedConvert('isObserving', (v) => v as bool?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiEstimationImplToJson(
        _$TsunamiEstimationImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'firstHeightTime': instance.firstHeightTime?.toIso8601String(),
      'firstHeightCondition': _$TsunamiEstimationFirstHeightConditionEnumMap[
          instance.firstHeightCondition],
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

_$PublicBodyVTSE41Impl _$$PublicBodyVTSE41ImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PublicBodyVTSE41Impl',
      json,
      ($checkedConvert) {
        final val = _$PublicBodyVTSE41Impl(
          tsunami: $checkedConvert(
              'tsunami',
              (v) =>
                  PublicBodyVTSE41Tsunami.fromJson(v as Map<String, dynamic>)),
          earthquakes: $checkedConvert(
              'earthquakes',
              (v) => (v as List<dynamic>)
                  .map((e) => Earthquake.fromJson(e as Map<String, dynamic>))
                  .toList()),
          text: $checkedConvert('text', (v) => v as String?),
          comment: $checkedConvert(
              'comment',
              (v) => v == null
                  ? null
                  : Comment.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$PublicBodyVTSE41ImplToJson(
        _$PublicBodyVTSE41Impl instance) =>
    <String, dynamic>{
      'tsunami': instance.tsunami,
      'earthquakes': instance.earthquakes,
      'text': instance.text,
      'comment': instance.comment,
    };

_$PublicBodyVTSE51Impl _$$PublicBodyVTSE51ImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PublicBodyVTSE51Impl',
      json,
      ($checkedConvert) {
        final val = _$PublicBodyVTSE51Impl(
          tsunami: $checkedConvert(
              'tsunami',
              (v) =>
                  PublicBodyVTSE51Tsunami.fromJson(v as Map<String, dynamic>)),
          earthquakes: $checkedConvert(
              'earthquakes',
              (v) => (v as List<dynamic>)
                  .map((e) => Earthquake.fromJson(e as Map<String, dynamic>))
                  .toList()),
          text: $checkedConvert('text', (v) => v as String?),
          comment: $checkedConvert(
              'comment',
              (v) => v == null
                  ? null
                  : Comment.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$PublicBodyVTSE51ImplToJson(
        _$PublicBodyVTSE51Impl instance) =>
    <String, dynamic>{
      'tsunami': instance.tsunami,
      'earthquakes': instance.earthquakes,
      'text': instance.text,
      'comment': instance.comment,
    };

_$PublicBodyVTSE52Impl _$$PublicBodyVTSE52ImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PublicBodyVTSE52Impl',
      json,
      ($checkedConvert) {
        final val = _$PublicBodyVTSE52Impl(
          tsunami: $checkedConvert(
              'tsunami',
              (v) =>
                  PublicBodyVTSE52Tsunami.fromJson(v as Map<String, dynamic>)),
          earthquakes: $checkedConvert(
              'earthquakes',
              (v) => (v as List<dynamic>)
                  .map((e) => Earthquake.fromJson(e as Map<String, dynamic>))
                  .toList()),
          text: $checkedConvert('text', (v) => v as String?),
          comment: $checkedConvert(
              'comment',
              (v) => v == null
                  ? null
                  : Comment.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$PublicBodyVTSE52ImplToJson(
        _$PublicBodyVTSE52Impl instance) =>
    <String, dynamic>{
      'tsunami': instance.tsunami,
      'earthquakes': instance.earthquakes,
      'text': instance.text,
      'comment': instance.comment,
    };

_$EarthquakeImpl _$$EarthquakeImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeImpl(
          originTime: $checkedConvert(
              'origin_time', (v) => DateTime.parse(v as String)),
          arrivalTime: $checkedConvert(
              'arrival_time', (v) => DateTime.parse(v as String)),
          hypocenter: $checkedConvert('hypocenter',
              (v) => EarthquakeHypocenter.fromJson(v as Map<String, dynamic>)),
          magnitude: $checkedConvert('magnitude',
              (v) => EarthquakeMagnitude.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'originTime': 'origin_time',
        'arrivalTime': 'arrival_time'
      },
    );

Map<String, dynamic> _$$EarthquakeImplToJson(_$EarthquakeImpl instance) =>
    <String, dynamic>{
      'origin_time': instance.originTime.toIso8601String(),
      'arrival_time': instance.arrivalTime.toIso8601String(),
      'hypocenter': instance.hypocenter,
      'magnitude': instance.magnitude,
    };

_$EarthquakeHypocenterImpl _$$EarthquakeHypocenterImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeHypocenterImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeHypocenterImpl(
          name: $checkedConvert('name', (v) => v as String),
          code: $checkedConvert('code', (v) => v as String),
          depth: $checkedConvert('depth', (v) => (v as num?)?.toInt()),
          detailed: $checkedConvert(
              'detailed',
              (v) => v == null
                  ? null
                  : EarthquakeHypocenterDetailed.fromJson(
                      v as Map<String, dynamic>)),
          coordinate: $checkedConvert(
              'coordinate',
              (v) => v == null
                  ? null
                  : EarthquakeHypocenterCoordinate.fromJson(
                      v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeHypocenterImplToJson(
        _$EarthquakeHypocenterImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'depth': instance.depth,
      'detailed': instance.detailed,
      'coordinate': instance.coordinate,
    };

_$EarthquakeHypocenterDetailedImpl _$$EarthquakeHypocenterDetailedImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeHypocenterDetailedImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeHypocenterDetailedImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeHypocenterDetailedImplToJson(
        _$EarthquakeHypocenterDetailedImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

_$EarthquakeHypocenterCoordinateImpl
    _$$EarthquakeHypocenterCoordinateImplFromJson(Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$EarthquakeHypocenterCoordinateImpl',
          json,
          ($checkedConvert) {
            final val = _$EarthquakeHypocenterCoordinateImpl(
              lat: $checkedConvert('lat', (v) => (v as num).toDouble()),
              lon: $checkedConvert('lon', (v) => (v as num).toDouble()),
            );
            return val;
          },
        );

Map<String, dynamic> _$$EarthquakeHypocenterCoordinateImplToJson(
        _$EarthquakeHypocenterCoordinateImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };

_$EarthquakeMagnitudeImpl _$$EarthquakeMagnitudeImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeMagnitudeImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeMagnitudeImpl(
          value: $checkedConvert('value', (v) => (v as num?)?.toDouble()),
          condition: $checkedConvert(
              'condition',
              (v) => $enumDecodeNullable(
                  _$EarthquakeMagnitudeConditionEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeMagnitudeImplToJson(
        _$EarthquakeMagnitudeImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'condition': _$EarthquakeMagnitudeConditionEnumMap[instance.condition],
    };

const _$EarthquakeMagnitudeConditionEnumMap = {
  EarthquakeMagnitudeCondition.unknown: 'Ｍ不明',
  EarthquakeMagnitudeCondition.huge: 'Ｍ８を超える巨大地震',
};
