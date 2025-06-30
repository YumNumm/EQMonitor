// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinMonitorState {

 RealtimeDataType? get currentRealtimeDataType; RealtimeLayer? get currentRealtimeLayer; KyoshinMonitorStatus get status; DateTime? get lastUpdatedAt; DateTime? get lastImageFetchTargetTime; Duration? get lastImageFetchDuration; List<KyoshinMonitorImageParseObservationPoint>? get analyzedPoints; List<int>? get currentImageRaw;
/// Create a copy of KyoshinMonitorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorStateCopyWith<KyoshinMonitorState> get copyWith => _$KyoshinMonitorStateCopyWithImpl<KyoshinMonitorState>(this as KyoshinMonitorState, _$identity);

  /// Serializes this KyoshinMonitorState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorState&&(identical(other.currentRealtimeDataType, currentRealtimeDataType) || other.currentRealtimeDataType == currentRealtimeDataType)&&(identical(other.currentRealtimeLayer, currentRealtimeLayer) || other.currentRealtimeLayer == currentRealtimeLayer)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt)&&(identical(other.lastImageFetchTargetTime, lastImageFetchTargetTime) || other.lastImageFetchTargetTime == lastImageFetchTargetTime)&&(identical(other.lastImageFetchDuration, lastImageFetchDuration) || other.lastImageFetchDuration == lastImageFetchDuration)&&const DeepCollectionEquality().equals(other.analyzedPoints, analyzedPoints)&&const DeepCollectionEquality().equals(other.currentImageRaw, currentImageRaw));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentRealtimeDataType,currentRealtimeLayer,status,lastUpdatedAt,lastImageFetchTargetTime,lastImageFetchDuration,const DeepCollectionEquality().hash(analyzedPoints),const DeepCollectionEquality().hash(currentImageRaw));

@override
String toString() {
  return 'KyoshinMonitorState(currentRealtimeDataType: $currentRealtimeDataType, currentRealtimeLayer: $currentRealtimeLayer, status: $status, lastUpdatedAt: $lastUpdatedAt, lastImageFetchTargetTime: $lastImageFetchTargetTime, lastImageFetchDuration: $lastImageFetchDuration, analyzedPoints: $analyzedPoints, currentImageRaw: $currentImageRaw)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorStateCopyWith<$Res>  {
  factory $KyoshinMonitorStateCopyWith(KyoshinMonitorState value, $Res Function(KyoshinMonitorState) _then) = _$KyoshinMonitorStateCopyWithImpl;
@useResult
$Res call({
 RealtimeDataType? currentRealtimeDataType, RealtimeLayer? currentRealtimeLayer, KyoshinMonitorStatus status, DateTime? lastUpdatedAt, DateTime? lastImageFetchTargetTime, Duration? lastImageFetchDuration, List<KyoshinMonitorImageParseObservationPoint>? analyzedPoints, List<int>? currentImageRaw
});




}
/// @nodoc
class _$KyoshinMonitorStateCopyWithImpl<$Res>
    implements $KyoshinMonitorStateCopyWith<$Res> {
  _$KyoshinMonitorStateCopyWithImpl(this._self, this._then);

  final KyoshinMonitorState _self;
  final $Res Function(KyoshinMonitorState) _then;

/// Create a copy of KyoshinMonitorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentRealtimeDataType = freezed,Object? currentRealtimeLayer = freezed,Object? status = null,Object? lastUpdatedAt = freezed,Object? lastImageFetchTargetTime = freezed,Object? lastImageFetchDuration = freezed,Object? analyzedPoints = freezed,Object? currentImageRaw = freezed,}) {
  return _then(_self.copyWith(
currentRealtimeDataType: freezed == currentRealtimeDataType ? _self.currentRealtimeDataType : currentRealtimeDataType // ignore: cast_nullable_to_non_nullable
as RealtimeDataType?,currentRealtimeLayer: freezed == currentRealtimeLayer ? _self.currentRealtimeLayer : currentRealtimeLayer // ignore: cast_nullable_to_non_nullable
as RealtimeLayer?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorStatus,lastUpdatedAt: freezed == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastImageFetchTargetTime: freezed == lastImageFetchTargetTime ? _self.lastImageFetchTargetTime : lastImageFetchTargetTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lastImageFetchDuration: freezed == lastImageFetchDuration ? _self.lastImageFetchDuration : lastImageFetchDuration // ignore: cast_nullable_to_non_nullable
as Duration?,analyzedPoints: freezed == analyzedPoints ? _self.analyzedPoints : analyzedPoints // ignore: cast_nullable_to_non_nullable
as List<KyoshinMonitorImageParseObservationPoint>?,currentImageRaw: freezed == currentImageRaw ? _self.currentImageRaw : currentImageRaw // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _KyoshinMonitorState implements KyoshinMonitorState {
  const _KyoshinMonitorState({this.currentRealtimeDataType, this.currentRealtimeLayer, this.status = KyoshinMonitorStatus.initializing, this.lastUpdatedAt, this.lastImageFetchTargetTime, this.lastImageFetchDuration, final  List<KyoshinMonitorImageParseObservationPoint>? analyzedPoints, final  List<int>? currentImageRaw}): _analyzedPoints = analyzedPoints,_currentImageRaw = currentImageRaw;
  factory _KyoshinMonitorState.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorStateFromJson(json);

@override final  RealtimeDataType? currentRealtimeDataType;
@override final  RealtimeLayer? currentRealtimeLayer;
@override@JsonKey() final  KyoshinMonitorStatus status;
@override final  DateTime? lastUpdatedAt;
@override final  DateTime? lastImageFetchTargetTime;
@override final  Duration? lastImageFetchDuration;
 final  List<KyoshinMonitorImageParseObservationPoint>? _analyzedPoints;
@override List<KyoshinMonitorImageParseObservationPoint>? get analyzedPoints {
  final value = _analyzedPoints;
  if (value == null) return null;
  if (_analyzedPoints is EqualUnmodifiableListView) return _analyzedPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<int>? _currentImageRaw;
@override List<int>? get currentImageRaw {
  final value = _currentImageRaw;
  if (value == null) return null;
  if (_currentImageRaw is EqualUnmodifiableListView) return _currentImageRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of KyoshinMonitorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorStateCopyWith<_KyoshinMonitorState> get copyWith => __$KyoshinMonitorStateCopyWithImpl<_KyoshinMonitorState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorState&&(identical(other.currentRealtimeDataType, currentRealtimeDataType) || other.currentRealtimeDataType == currentRealtimeDataType)&&(identical(other.currentRealtimeLayer, currentRealtimeLayer) || other.currentRealtimeLayer == currentRealtimeLayer)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt)&&(identical(other.lastImageFetchTargetTime, lastImageFetchTargetTime) || other.lastImageFetchTargetTime == lastImageFetchTargetTime)&&(identical(other.lastImageFetchDuration, lastImageFetchDuration) || other.lastImageFetchDuration == lastImageFetchDuration)&&const DeepCollectionEquality().equals(other._analyzedPoints, _analyzedPoints)&&const DeepCollectionEquality().equals(other._currentImageRaw, _currentImageRaw));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentRealtimeDataType,currentRealtimeLayer,status,lastUpdatedAt,lastImageFetchTargetTime,lastImageFetchDuration,const DeepCollectionEquality().hash(_analyzedPoints),const DeepCollectionEquality().hash(_currentImageRaw));

@override
String toString() {
  return 'KyoshinMonitorState(currentRealtimeDataType: $currentRealtimeDataType, currentRealtimeLayer: $currentRealtimeLayer, status: $status, lastUpdatedAt: $lastUpdatedAt, lastImageFetchTargetTime: $lastImageFetchTargetTime, lastImageFetchDuration: $lastImageFetchDuration, analyzedPoints: $analyzedPoints, currentImageRaw: $currentImageRaw)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorStateCopyWith<$Res> implements $KyoshinMonitorStateCopyWith<$Res> {
  factory _$KyoshinMonitorStateCopyWith(_KyoshinMonitorState value, $Res Function(_KyoshinMonitorState) _then) = __$KyoshinMonitorStateCopyWithImpl;
@override @useResult
$Res call({
 RealtimeDataType? currentRealtimeDataType, RealtimeLayer? currentRealtimeLayer, KyoshinMonitorStatus status, DateTime? lastUpdatedAt, DateTime? lastImageFetchTargetTime, Duration? lastImageFetchDuration, List<KyoshinMonitorImageParseObservationPoint>? analyzedPoints, List<int>? currentImageRaw
});




}
/// @nodoc
class __$KyoshinMonitorStateCopyWithImpl<$Res>
    implements _$KyoshinMonitorStateCopyWith<$Res> {
  __$KyoshinMonitorStateCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorState _self;
  final $Res Function(_KyoshinMonitorState) _then;

/// Create a copy of KyoshinMonitorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentRealtimeDataType = freezed,Object? currentRealtimeLayer = freezed,Object? status = null,Object? lastUpdatedAt = freezed,Object? lastImageFetchTargetTime = freezed,Object? lastImageFetchDuration = freezed,Object? analyzedPoints = freezed,Object? currentImageRaw = freezed,}) {
  return _then(_KyoshinMonitorState(
currentRealtimeDataType: freezed == currentRealtimeDataType ? _self.currentRealtimeDataType : currentRealtimeDataType // ignore: cast_nullable_to_non_nullable
as RealtimeDataType?,currentRealtimeLayer: freezed == currentRealtimeLayer ? _self.currentRealtimeLayer : currentRealtimeLayer // ignore: cast_nullable_to_non_nullable
as RealtimeLayer?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorStatus,lastUpdatedAt: freezed == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastImageFetchTargetTime: freezed == lastImageFetchTargetTime ? _self.lastImageFetchTargetTime : lastImageFetchTargetTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lastImageFetchDuration: freezed == lastImageFetchDuration ? _self.lastImageFetchDuration : lastImageFetchDuration // ignore: cast_nullable_to_non_nullable
as Duration?,analyzedPoints: freezed == analyzedPoints ? _self._analyzedPoints : analyzedPoints // ignore: cast_nullable_to_non_nullable
as List<KyoshinMonitorImageParseObservationPoint>?,currentImageRaw: freezed == currentImageRaw ? _self._currentImageRaw : currentImageRaw // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}


/// @nodoc
mixin _$KyoshinMonitorImageParseObservationPoint {

@JsonKey(fromJson: _kyoshinObservationPointFromJson, toJson: _kyoshinObservationPointToJson) KyoshinObservationPoint get point; KyoshinMonitorObservationAnalyzedPoint get observation;
/// Create a copy of KyoshinMonitorImageParseObservationPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorImageParseObservationPointCopyWith<KyoshinMonitorImageParseObservationPoint> get copyWith => _$KyoshinMonitorImageParseObservationPointCopyWithImpl<KyoshinMonitorImageParseObservationPoint>(this as KyoshinMonitorImageParseObservationPoint, _$identity);

  /// Serializes this KyoshinMonitorImageParseObservationPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorImageParseObservationPoint&&(identical(other.point, point) || other.point == point)&&(identical(other.observation, observation) || other.observation == observation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,point,observation);

@override
String toString() {
  return 'KyoshinMonitorImageParseObservationPoint(point: $point, observation: $observation)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorImageParseObservationPointCopyWith<$Res>  {
  factory $KyoshinMonitorImageParseObservationPointCopyWith(KyoshinMonitorImageParseObservationPoint value, $Res Function(KyoshinMonitorImageParseObservationPoint) _then) = _$KyoshinMonitorImageParseObservationPointCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _kyoshinObservationPointFromJson, toJson: _kyoshinObservationPointToJson) KyoshinObservationPoint point, KyoshinMonitorObservationAnalyzedPoint observation
});


$KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> get observation;

}
/// @nodoc
class _$KyoshinMonitorImageParseObservationPointCopyWithImpl<$Res>
    implements $KyoshinMonitorImageParseObservationPointCopyWith<$Res> {
  _$KyoshinMonitorImageParseObservationPointCopyWithImpl(this._self, this._then);

  final KyoshinMonitorImageParseObservationPoint _self;
  final $Res Function(KyoshinMonitorImageParseObservationPoint) _then;

/// Create a copy of KyoshinMonitorImageParseObservationPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? point = null,Object? observation = null,}) {
  return _then(_self.copyWith(
point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPoint,observation: null == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorObservationAnalyzedPoint,
  ));
}
/// Create a copy of KyoshinMonitorImageParseObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> get observation {
  
  return $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res>(_self.observation, (value) {
    return _then(_self.copyWith(observation: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _KyoshinMonitorImageParseObservationPoint implements KyoshinMonitorImageParseObservationPoint {
  const _KyoshinMonitorImageParseObservationPoint({@JsonKey(fromJson: _kyoshinObservationPointFromJson, toJson: _kyoshinObservationPointToJson) required this.point, required this.observation});
  factory _KyoshinMonitorImageParseObservationPoint.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorImageParseObservationPointFromJson(json);

@override@JsonKey(fromJson: _kyoshinObservationPointFromJson, toJson: _kyoshinObservationPointToJson) final  KyoshinObservationPoint point;
@override final  KyoshinMonitorObservationAnalyzedPoint observation;

/// Create a copy of KyoshinMonitorImageParseObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorImageParseObservationPointCopyWith<_KyoshinMonitorImageParseObservationPoint> get copyWith => __$KyoshinMonitorImageParseObservationPointCopyWithImpl<_KyoshinMonitorImageParseObservationPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorImageParseObservationPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorImageParseObservationPoint&&(identical(other.point, point) || other.point == point)&&(identical(other.observation, observation) || other.observation == observation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,point,observation);

@override
String toString() {
  return 'KyoshinMonitorImageParseObservationPoint(point: $point, observation: $observation)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorImageParseObservationPointCopyWith<$Res> implements $KyoshinMonitorImageParseObservationPointCopyWith<$Res> {
  factory _$KyoshinMonitorImageParseObservationPointCopyWith(_KyoshinMonitorImageParseObservationPoint value, $Res Function(_KyoshinMonitorImageParseObservationPoint) _then) = __$KyoshinMonitorImageParseObservationPointCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _kyoshinObservationPointFromJson, toJson: _kyoshinObservationPointToJson) KyoshinObservationPoint point, KyoshinMonitorObservationAnalyzedPoint observation
});


@override $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> get observation;

}
/// @nodoc
class __$KyoshinMonitorImageParseObservationPointCopyWithImpl<$Res>
    implements _$KyoshinMonitorImageParseObservationPointCopyWith<$Res> {
  __$KyoshinMonitorImageParseObservationPointCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorImageParseObservationPoint _self;
  final $Res Function(_KyoshinMonitorImageParseObservationPoint) _then;

/// Create a copy of KyoshinMonitorImageParseObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? point = null,Object? observation = null,}) {
  return _then(_KyoshinMonitorImageParseObservationPoint(
point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPoint,observation: null == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorObservationAnalyzedPoint,
  ));
}

/// Create a copy of KyoshinMonitorImageParseObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> get observation {
  
  return $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res>(_self.observation, (value) {
    return _then(_self.copyWith(observation: value));
  });
}
}

// dart format on
