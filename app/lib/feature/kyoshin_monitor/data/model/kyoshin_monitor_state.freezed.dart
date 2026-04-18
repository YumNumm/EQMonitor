// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 RealtimeDataType? get currentRealtimeDataType; RealtimeLayer? get currentRealtimeLayer; KyoshinMonitorStatus get status; DateTime? get lastUpdatedAt; DateTime? get lastImageFetchTargetTime; Duration? get lastImageFetchDuration;/// Worker Isolate で生成した GeoJSON 文字列（観測点レイヤー用）
 String? get geoJson;/// [geoJson] に含まれる観測点 Feature 数
 int? get analyzedPointsCount; List<int>? get currentImageRaw;
/// Create a copy of KyoshinMonitorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorStateCopyWith<KyoshinMonitorState> get copyWith => _$KyoshinMonitorStateCopyWithImpl<KyoshinMonitorState>(this as KyoshinMonitorState, _$identity);

  /// Serializes this KyoshinMonitorState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorState&&(identical(other.currentRealtimeDataType, currentRealtimeDataType) || other.currentRealtimeDataType == currentRealtimeDataType)&&(identical(other.currentRealtimeLayer, currentRealtimeLayer) || other.currentRealtimeLayer == currentRealtimeLayer)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt)&&(identical(other.lastImageFetchTargetTime, lastImageFetchTargetTime) || other.lastImageFetchTargetTime == lastImageFetchTargetTime)&&(identical(other.lastImageFetchDuration, lastImageFetchDuration) || other.lastImageFetchDuration == lastImageFetchDuration)&&(identical(other.geoJson, geoJson) || other.geoJson == geoJson)&&(identical(other.analyzedPointsCount, analyzedPointsCount) || other.analyzedPointsCount == analyzedPointsCount)&&const DeepCollectionEquality().equals(other.currentImageRaw, currentImageRaw));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentRealtimeDataType,currentRealtimeLayer,status,lastUpdatedAt,lastImageFetchTargetTime,lastImageFetchDuration,geoJson,analyzedPointsCount,const DeepCollectionEquality().hash(currentImageRaw));

@override
String toString() {
  return 'KyoshinMonitorState(currentRealtimeDataType: $currentRealtimeDataType, currentRealtimeLayer: $currentRealtimeLayer, status: $status, lastUpdatedAt: $lastUpdatedAt, lastImageFetchTargetTime: $lastImageFetchTargetTime, lastImageFetchDuration: $lastImageFetchDuration, geoJson: $geoJson, analyzedPointsCount: $analyzedPointsCount, currentImageRaw: $currentImageRaw)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorStateCopyWith<$Res>  {
  factory $KyoshinMonitorStateCopyWith(KyoshinMonitorState value, $Res Function(KyoshinMonitorState) _then) = _$KyoshinMonitorStateCopyWithImpl;
@useResult
$Res call({
 RealtimeDataType? currentRealtimeDataType, RealtimeLayer? currentRealtimeLayer, KyoshinMonitorStatus status, DateTime? lastUpdatedAt, DateTime? lastImageFetchTargetTime, Duration? lastImageFetchDuration, String? geoJson, int? analyzedPointsCount, List<int>? currentImageRaw
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
@pragma('vm:prefer-inline') @override $Res call({Object? currentRealtimeDataType = freezed,Object? currentRealtimeLayer = freezed,Object? status = null,Object? lastUpdatedAt = freezed,Object? lastImageFetchTargetTime = freezed,Object? lastImageFetchDuration = freezed,Object? geoJson = freezed,Object? analyzedPointsCount = freezed,Object? currentImageRaw = freezed,}) {
  return _then(_self.copyWith(
currentRealtimeDataType: freezed == currentRealtimeDataType ? _self.currentRealtimeDataType : currentRealtimeDataType // ignore: cast_nullable_to_non_nullable
as RealtimeDataType?,currentRealtimeLayer: freezed == currentRealtimeLayer ? _self.currentRealtimeLayer : currentRealtimeLayer // ignore: cast_nullable_to_non_nullable
as RealtimeLayer?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorStatus,lastUpdatedAt: freezed == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastImageFetchTargetTime: freezed == lastImageFetchTargetTime ? _self.lastImageFetchTargetTime : lastImageFetchTargetTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lastImageFetchDuration: freezed == lastImageFetchDuration ? _self.lastImageFetchDuration : lastImageFetchDuration // ignore: cast_nullable_to_non_nullable
as Duration?,geoJson: freezed == geoJson ? _self.geoJson : geoJson // ignore: cast_nullable_to_non_nullable
as String?,analyzedPointsCount: freezed == analyzedPointsCount ? _self.analyzedPointsCount : analyzedPointsCount // ignore: cast_nullable_to_non_nullable
as int?,currentImageRaw: freezed == currentImageRaw ? _self.currentImageRaw : currentImageRaw // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [KyoshinMonitorState].
extension KyoshinMonitorStatePatterns on KyoshinMonitorState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinMonitorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinMonitorState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinMonitorState value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinMonitorState value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RealtimeDataType? currentRealtimeDataType,  RealtimeLayer? currentRealtimeLayer,  KyoshinMonitorStatus status,  DateTime? lastUpdatedAt,  DateTime? lastImageFetchTargetTime,  Duration? lastImageFetchDuration,  String? geoJson,  int? analyzedPointsCount,  List<int>? currentImageRaw)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinMonitorState() when $default != null:
return $default(_that.currentRealtimeDataType,_that.currentRealtimeLayer,_that.status,_that.lastUpdatedAt,_that.lastImageFetchTargetTime,_that.lastImageFetchDuration,_that.geoJson,_that.analyzedPointsCount,_that.currentImageRaw);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RealtimeDataType? currentRealtimeDataType,  RealtimeLayer? currentRealtimeLayer,  KyoshinMonitorStatus status,  DateTime? lastUpdatedAt,  DateTime? lastImageFetchTargetTime,  Duration? lastImageFetchDuration,  String? geoJson,  int? analyzedPointsCount,  List<int>? currentImageRaw)  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorState():
return $default(_that.currentRealtimeDataType,_that.currentRealtimeLayer,_that.status,_that.lastUpdatedAt,_that.lastImageFetchTargetTime,_that.lastImageFetchDuration,_that.geoJson,_that.analyzedPointsCount,_that.currentImageRaw);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RealtimeDataType? currentRealtimeDataType,  RealtimeLayer? currentRealtimeLayer,  KyoshinMonitorStatus status,  DateTime? lastUpdatedAt,  DateTime? lastImageFetchTargetTime,  Duration? lastImageFetchDuration,  String? geoJson,  int? analyzedPointsCount,  List<int>? currentImageRaw)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorState() when $default != null:
return $default(_that.currentRealtimeDataType,_that.currentRealtimeLayer,_that.status,_that.lastUpdatedAt,_that.lastImageFetchTargetTime,_that.lastImageFetchDuration,_that.geoJson,_that.analyzedPointsCount,_that.currentImageRaw);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KyoshinMonitorState implements KyoshinMonitorState {
  const _KyoshinMonitorState({this.currentRealtimeDataType, this.currentRealtimeLayer, this.status = KyoshinMonitorStatus.initializing, this.lastUpdatedAt, this.lastImageFetchTargetTime, this.lastImageFetchDuration, this.geoJson, this.analyzedPointsCount, final  List<int>? currentImageRaw}): _currentImageRaw = currentImageRaw;
  factory _KyoshinMonitorState.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorStateFromJson(json);

@override final  RealtimeDataType? currentRealtimeDataType;
@override final  RealtimeLayer? currentRealtimeLayer;
@override@JsonKey() final  KyoshinMonitorStatus status;
@override final  DateTime? lastUpdatedAt;
@override final  DateTime? lastImageFetchTargetTime;
@override final  Duration? lastImageFetchDuration;
/// Worker Isolate で生成した GeoJSON 文字列（観測点レイヤー用）
@override final  String? geoJson;
/// [geoJson] に含まれる観測点 Feature 数
@override final  int? analyzedPointsCount;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorState&&(identical(other.currentRealtimeDataType, currentRealtimeDataType) || other.currentRealtimeDataType == currentRealtimeDataType)&&(identical(other.currentRealtimeLayer, currentRealtimeLayer) || other.currentRealtimeLayer == currentRealtimeLayer)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt)&&(identical(other.lastImageFetchTargetTime, lastImageFetchTargetTime) || other.lastImageFetchTargetTime == lastImageFetchTargetTime)&&(identical(other.lastImageFetchDuration, lastImageFetchDuration) || other.lastImageFetchDuration == lastImageFetchDuration)&&(identical(other.geoJson, geoJson) || other.geoJson == geoJson)&&(identical(other.analyzedPointsCount, analyzedPointsCount) || other.analyzedPointsCount == analyzedPointsCount)&&const DeepCollectionEquality().equals(other._currentImageRaw, _currentImageRaw));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentRealtimeDataType,currentRealtimeLayer,status,lastUpdatedAt,lastImageFetchTargetTime,lastImageFetchDuration,geoJson,analyzedPointsCount,const DeepCollectionEquality().hash(_currentImageRaw));

@override
String toString() {
  return 'KyoshinMonitorState(currentRealtimeDataType: $currentRealtimeDataType, currentRealtimeLayer: $currentRealtimeLayer, status: $status, lastUpdatedAt: $lastUpdatedAt, lastImageFetchTargetTime: $lastImageFetchTargetTime, lastImageFetchDuration: $lastImageFetchDuration, geoJson: $geoJson, analyzedPointsCount: $analyzedPointsCount, currentImageRaw: $currentImageRaw)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorStateCopyWith<$Res> implements $KyoshinMonitorStateCopyWith<$Res> {
  factory _$KyoshinMonitorStateCopyWith(_KyoshinMonitorState value, $Res Function(_KyoshinMonitorState) _then) = __$KyoshinMonitorStateCopyWithImpl;
@override @useResult
$Res call({
 RealtimeDataType? currentRealtimeDataType, RealtimeLayer? currentRealtimeLayer, KyoshinMonitorStatus status, DateTime? lastUpdatedAt, DateTime? lastImageFetchTargetTime, Duration? lastImageFetchDuration, String? geoJson, int? analyzedPointsCount, List<int>? currentImageRaw
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
@override @pragma('vm:prefer-inline') $Res call({Object? currentRealtimeDataType = freezed,Object? currentRealtimeLayer = freezed,Object? status = null,Object? lastUpdatedAt = freezed,Object? lastImageFetchTargetTime = freezed,Object? lastImageFetchDuration = freezed,Object? geoJson = freezed,Object? analyzedPointsCount = freezed,Object? currentImageRaw = freezed,}) {
  return _then(_KyoshinMonitorState(
currentRealtimeDataType: freezed == currentRealtimeDataType ? _self.currentRealtimeDataType : currentRealtimeDataType // ignore: cast_nullable_to_non_nullable
as RealtimeDataType?,currentRealtimeLayer: freezed == currentRealtimeLayer ? _self.currentRealtimeLayer : currentRealtimeLayer // ignore: cast_nullable_to_non_nullable
as RealtimeLayer?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorStatus,lastUpdatedAt: freezed == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastImageFetchTargetTime: freezed == lastImageFetchTargetTime ? _self.lastImageFetchTargetTime : lastImageFetchTargetTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lastImageFetchDuration: freezed == lastImageFetchDuration ? _self.lastImageFetchDuration : lastImageFetchDuration // ignore: cast_nullable_to_non_nullable
as Duration?,geoJson: freezed == geoJson ? _self.geoJson : geoJson // ignore: cast_nullable_to_non_nullable
as String?,analyzedPointsCount: freezed == analyzedPointsCount ? _self.analyzedPointsCount : analyzedPointsCount // ignore: cast_nullable_to_non_nullable
as int?,currentImageRaw: freezed == currentImageRaw ? _self._currentImageRaw : currentImageRaw // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}

// dart format on
