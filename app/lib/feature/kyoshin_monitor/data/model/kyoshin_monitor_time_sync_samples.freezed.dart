// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_time_sync_samples.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinMonitorTimeSyncSamples {

 List<Duration> get roundTripTimes; List<Duration> get shifts;
/// Create a copy of KyoshinMonitorTimeSyncSamples
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorTimeSyncSamplesCopyWith<KyoshinMonitorTimeSyncSamples> get copyWith => _$KyoshinMonitorTimeSyncSamplesCopyWithImpl<KyoshinMonitorTimeSyncSamples>(this as KyoshinMonitorTimeSyncSamples, _$identity);

  /// Serializes this KyoshinMonitorTimeSyncSamples to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorTimeSyncSamples&&const DeepCollectionEquality().equals(other.roundTripTimes, roundTripTimes)&&const DeepCollectionEquality().equals(other.shifts, shifts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(roundTripTimes),const DeepCollectionEquality().hash(shifts));

@override
String toString() {
  return 'KyoshinMonitorTimeSyncSamples(roundTripTimes: $roundTripTimes, shifts: $shifts)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorTimeSyncSamplesCopyWith<$Res>  {
  factory $KyoshinMonitorTimeSyncSamplesCopyWith(KyoshinMonitorTimeSyncSamples value, $Res Function(KyoshinMonitorTimeSyncSamples) _then) = _$KyoshinMonitorTimeSyncSamplesCopyWithImpl;
@useResult
$Res call({
 List<Duration> roundTripTimes, List<Duration> shifts
});




}
/// @nodoc
class _$KyoshinMonitorTimeSyncSamplesCopyWithImpl<$Res>
    implements $KyoshinMonitorTimeSyncSamplesCopyWith<$Res> {
  _$KyoshinMonitorTimeSyncSamplesCopyWithImpl(this._self, this._then);

  final KyoshinMonitorTimeSyncSamples _self;
  final $Res Function(KyoshinMonitorTimeSyncSamples) _then;

/// Create a copy of KyoshinMonitorTimeSyncSamples
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roundTripTimes = null,Object? shifts = null,}) {
  return _then(KyoshinMonitorTimeSyncSamples(
roundTripTimes: null == roundTripTimes ? _self.roundTripTimes : roundTripTimes // ignore: cast_nullable_to_non_nullable
as List<Duration>,shifts: null == shifts ? _self.shifts : shifts // ignore: cast_nullable_to_non_nullable
as List<Duration>,
  ));
}

}


/// Adds pattern-matching-related methods to [KyoshinMonitorTimeSyncSamples].
extension KyoshinMonitorTimeSyncSamplesPatterns on KyoshinMonitorTimeSyncSamples {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinMonitorTimeSyncSamples value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinMonitorTimeSyncSamples() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinMonitorTimeSyncSamples value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorTimeSyncSamples():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinMonitorTimeSyncSamples value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorTimeSyncSamples() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Duration> roundTripTimes,  List<Duration> shifts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinMonitorTimeSyncSamples() when $default != null:
return $default(_that.roundTripTimes,_that.shifts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Duration> roundTripTimes,  List<Duration> shifts)  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorTimeSyncSamples():
return $default(_that.roundTripTimes,_that.shifts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Duration> roundTripTimes,  List<Duration> shifts)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorTimeSyncSamples() when $default != null:
return $default(_that.roundTripTimes,_that.shifts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KyoshinMonitorTimeSyncSamples implements KyoshinMonitorTimeSyncSamples {
  const _KyoshinMonitorTimeSyncSamples({ List<Duration> roundTripTimes = const [],  List<Duration> shifts = const []}): _roundTripTimes = roundTripTimes,_shifts = shifts;
  factory _KyoshinMonitorTimeSyncSamples.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorTimeSyncSamplesFromJson(json);

 final  List<Duration> _roundTripTimes;
@override@JsonKey() List<Duration> get roundTripTimes {
  if (_roundTripTimes is EqualUnmodifiableListView) return _roundTripTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roundTripTimes);
}

 final  List<Duration> _shifts;
@override@JsonKey() List<Duration> get shifts {
  if (_shifts is EqualUnmodifiableListView) return _shifts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shifts);
}


/// Create a copy of KyoshinMonitorTimeSyncSamples
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorTimeSyncSamplesCopyWith<_KyoshinMonitorTimeSyncSamples> get copyWith => __$KyoshinMonitorTimeSyncSamplesCopyWithImpl<_KyoshinMonitorTimeSyncSamples>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorTimeSyncSamplesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorTimeSyncSamples&&const DeepCollectionEquality().equals(other._roundTripTimes, _roundTripTimes)&&const DeepCollectionEquality().equals(other._shifts, _shifts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_roundTripTimes),const DeepCollectionEquality().hash(_shifts));

@override
String toString() {
  return 'KyoshinMonitorTimeSyncSamples(roundTripTimes: $roundTripTimes, shifts: $shifts)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorTimeSyncSamplesCopyWith<$Res> implements $KyoshinMonitorTimeSyncSamplesCopyWith<$Res> {
  factory _$KyoshinMonitorTimeSyncSamplesCopyWith(_KyoshinMonitorTimeSyncSamples value, $Res Function(_KyoshinMonitorTimeSyncSamples) _then) = __$KyoshinMonitorTimeSyncSamplesCopyWithImpl;
@override @useResult
$Res call({
 List<Duration> roundTripTimes, List<Duration> shifts
});




}
/// @nodoc
class __$KyoshinMonitorTimeSyncSamplesCopyWithImpl<$Res>
    implements _$KyoshinMonitorTimeSyncSamplesCopyWith<$Res> {
  __$KyoshinMonitorTimeSyncSamplesCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorTimeSyncSamples _self;
  final $Res Function(_KyoshinMonitorTimeSyncSamples) _then;

/// Create a copy of KyoshinMonitorTimeSyncSamples
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roundTripTimes = null,Object? shifts = null,}) {
  return _then(_KyoshinMonitorTimeSyncSamples(
roundTripTimes: null == roundTripTimes ? _self._roundTripTimes : roundTripTimes // ignore: cast_nullable_to_non_nullable
as List<Duration>,shifts: null == shifts ? _self._shifts : shifts // ignore: cast_nullable_to_non_nullable
as List<Duration>,
  ));
}


}

// dart format on
