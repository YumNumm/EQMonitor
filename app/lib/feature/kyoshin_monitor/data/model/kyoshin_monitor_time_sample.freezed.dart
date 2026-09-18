// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_time_sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinMonitorTimeSample {

/// リクエスト送信直前の端末時計
 DateTime get sentAt;/// レスポンス受信直後の端末時計
 DateTime get receivedAt;/// `latest.json` の `latest_time` (絶対時刻)
 DateTime get latestTime;
/// Create a copy of KyoshinMonitorTimeSample
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorTimeSampleCopyWith<KyoshinMonitorTimeSample> get copyWith => _$KyoshinMonitorTimeSampleCopyWithImpl<KyoshinMonitorTimeSample>(this as KyoshinMonitorTimeSample, _$identity);

  /// Serializes this KyoshinMonitorTimeSample to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorTimeSample&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.latestTime, latestTime) || other.latestTime == latestTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sentAt,receivedAt,latestTime);

@override
String toString() {
  return 'KyoshinMonitorTimeSample(sentAt: $sentAt, receivedAt: $receivedAt, latestTime: $latestTime)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorTimeSampleCopyWith<$Res>  {
  factory $KyoshinMonitorTimeSampleCopyWith(KyoshinMonitorTimeSample value, $Res Function(KyoshinMonitorTimeSample) _then) = _$KyoshinMonitorTimeSampleCopyWithImpl;
@useResult
$Res call({
 DateTime sentAt, DateTime receivedAt, DateTime latestTime
});




}
/// @nodoc
class _$KyoshinMonitorTimeSampleCopyWithImpl<$Res>
    implements $KyoshinMonitorTimeSampleCopyWith<$Res> {
  _$KyoshinMonitorTimeSampleCopyWithImpl(this._self, this._then);

  final KyoshinMonitorTimeSample _self;
  final $Res Function(KyoshinMonitorTimeSample) _then;

/// Create a copy of KyoshinMonitorTimeSample
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sentAt = null,Object? receivedAt = null,Object? latestTime = null,}) {
  return _then(KyoshinMonitorTimeSample(
sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,latestTime: null == latestTime ? _self.latestTime : latestTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [KyoshinMonitorTimeSample].
extension KyoshinMonitorTimeSamplePatterns on KyoshinMonitorTimeSample {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinMonitorTimeSample value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinMonitorTimeSample() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinMonitorTimeSample value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorTimeSample():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinMonitorTimeSample value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorTimeSample() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime sentAt,  DateTime receivedAt,  DateTime latestTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinMonitorTimeSample() when $default != null:
return $default(_that.sentAt,_that.receivedAt,_that.latestTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime sentAt,  DateTime receivedAt,  DateTime latestTime)  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorTimeSample():
return $default(_that.sentAt,_that.receivedAt,_that.latestTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime sentAt,  DateTime receivedAt,  DateTime latestTime)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorTimeSample() when $default != null:
return $default(_that.sentAt,_that.receivedAt,_that.latestTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KyoshinMonitorTimeSample implements KyoshinMonitorTimeSample {
  const _KyoshinMonitorTimeSample({required this.sentAt, required this.receivedAt, required this.latestTime});
  factory _KyoshinMonitorTimeSample.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorTimeSampleFromJson(json);

/// リクエスト送信直前の端末時計
@override final  DateTime sentAt;
/// レスポンス受信直後の端末時計
@override final  DateTime receivedAt;
/// `latest.json` の `latest_time` (絶対時刻)
@override final  DateTime latestTime;

/// Create a copy of KyoshinMonitorTimeSample
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorTimeSampleCopyWith<_KyoshinMonitorTimeSample> get copyWith => __$KyoshinMonitorTimeSampleCopyWithImpl<_KyoshinMonitorTimeSample>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorTimeSampleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorTimeSample&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.latestTime, latestTime) || other.latestTime == latestTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sentAt,receivedAt,latestTime);

@override
String toString() {
  return 'KyoshinMonitorTimeSample(sentAt: $sentAt, receivedAt: $receivedAt, latestTime: $latestTime)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorTimeSampleCopyWith<$Res> implements $KyoshinMonitorTimeSampleCopyWith<$Res> {
  factory _$KyoshinMonitorTimeSampleCopyWith(_KyoshinMonitorTimeSample value, $Res Function(_KyoshinMonitorTimeSample) _then) = __$KyoshinMonitorTimeSampleCopyWithImpl;
@override @useResult
$Res call({
 DateTime sentAt, DateTime receivedAt, DateTime latestTime
});




}
/// @nodoc
class __$KyoshinMonitorTimeSampleCopyWithImpl<$Res>
    implements _$KyoshinMonitorTimeSampleCopyWith<$Res> {
  __$KyoshinMonitorTimeSampleCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorTimeSample _self;
  final $Res Function(_KyoshinMonitorTimeSample) _then;

/// Create a copy of KyoshinMonitorTimeSample
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentAt = null,Object? receivedAt = null,Object? latestTime = null,}) {
  return _then(_KyoshinMonitorTimeSample(
sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,latestTime: null == latestTime ? _self.latestTime : latestTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
