// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_time.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DataTime {

 Security? get security; Result? get result;@JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) DateTime get latestTime;@JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) DateTime get requestTime;
/// Create a copy of DataTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataTimeCopyWith<DataTime> get copyWith => _$DataTimeCopyWithImpl<DataTime>(this as DataTime, _$identity);

  /// Serializes this DataTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataTime&&(identical(other.security, security) || other.security == security)&&(identical(other.result, result) || other.result == result)&&(identical(other.latestTime, latestTime) || other.latestTime == latestTime)&&(identical(other.requestTime, requestTime) || other.requestTime == requestTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,security,result,latestTime,requestTime);

@override
String toString() {
  return 'DataTime(security: $security, result: $result, latestTime: $latestTime, requestTime: $requestTime)';
}


}

/// @nodoc
abstract mixin class $DataTimeCopyWith<$Res>  {
  factory $DataTimeCopyWith(DataTime value, $Res Function(DataTime) _then) = _$DataTimeCopyWithImpl;
@useResult
$Res call({
 Security? security, Result? result,@JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) DateTime latestTime,@JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) DateTime requestTime
});


$SecurityCopyWith<$Res>? get security;$ResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$DataTimeCopyWithImpl<$Res>
    implements $DataTimeCopyWith<$Res> {
  _$DataTimeCopyWithImpl(this._self, this._then);

  final DataTime _self;
  final $Res Function(DataTime) _then;

/// Create a copy of DataTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? security = freezed,Object? result = freezed,Object? latestTime = null,Object? requestTime = null,}) {
  return _then(_self.copyWith(
security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as Security?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result?,latestTime: null == latestTime ? _self.latestTime : latestTime // ignore: cast_nullable_to_non_nullable
as DateTime,requestTime: null == requestTime ? _self.requestTime : requestTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of DataTime
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityCopyWith<$Res>? get security {
    if (_self.security == null) {
    return null;
  }

  return $SecurityCopyWith<$Res>(_self.security!, (value) {
    return _then(_self.copyWith(security: value));
  });
}/// Create a copy of DataTime
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [DataTime].
extension DataTimePatterns on DataTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DataTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DataTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DataTime value)  $default,){
final _that = this;
switch (_that) {
case _DataTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DataTime value)?  $default,){
final _that = this;
switch (_that) {
case _DataTime() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Security? security,  Result? result, @JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString)  DateTime latestTime, @JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString)  DateTime requestTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DataTime() when $default != null:
return $default(_that.security,_that.result,_that.latestTime,_that.requestTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Security? security,  Result? result, @JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString)  DateTime latestTime, @JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString)  DateTime requestTime)  $default,) {final _that = this;
switch (_that) {
case _DataTime():
return $default(_that.security,_that.result,_that.latestTime,_that.requestTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Security? security,  Result? result, @JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString)  DateTime latestTime, @JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString)  DateTime requestTime)?  $default,) {final _that = this;
switch (_that) {
case _DataTime() when $default != null:
return $default(_that.security,_that.result,_that.latestTime,_that.requestTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DataTime implements DataTime {
  const _DataTime({required this.security, required this.result, @JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) required this.latestTime, @JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) required this.requestTime});
  factory _DataTime.fromJson(Map<String, dynamic> json) => _$DataTimeFromJson(json);

@override final  Security? security;
@override final  Result? result;
@override@JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) final  DateTime latestTime;
@override@JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) final  DateTime requestTime;

/// Create a copy of DataTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataTimeCopyWith<_DataTime> get copyWith => __$DataTimeCopyWithImpl<_DataTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DataTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DataTime&&(identical(other.security, security) || other.security == security)&&(identical(other.result, result) || other.result == result)&&(identical(other.latestTime, latestTime) || other.latestTime == latestTime)&&(identical(other.requestTime, requestTime) || other.requestTime == requestTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,security,result,latestTime,requestTime);

@override
String toString() {
  return 'DataTime(security: $security, result: $result, latestTime: $latestTime, requestTime: $requestTime)';
}


}

/// @nodoc
abstract mixin class _$DataTimeCopyWith<$Res> implements $DataTimeCopyWith<$Res> {
  factory _$DataTimeCopyWith(_DataTime value, $Res Function(_DataTime) _then) = __$DataTimeCopyWithImpl;
@override @useResult
$Res call({
 Security? security, Result? result,@JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) DateTime latestTime,@JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) DateTime requestTime
});


@override $SecurityCopyWith<$Res>? get security;@override $ResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$DataTimeCopyWithImpl<$Res>
    implements _$DataTimeCopyWith<$Res> {
  __$DataTimeCopyWithImpl(this._self, this._then);

  final _DataTime _self;
  final $Res Function(_DataTime) _then;

/// Create a copy of DataTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? security = freezed,Object? result = freezed,Object? latestTime = null,Object? requestTime = null,}) {
  return _then(_DataTime(
security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as Security?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result?,latestTime: null == latestTime ? _self.latestTime : latestTime // ignore: cast_nullable_to_non_nullable
as DateTime,requestTime: null == requestTime ? _self.requestTime : requestTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of DataTime
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityCopyWith<$Res>? get security {
    if (_self.security == null) {
    return null;
  }

  return $SecurityCopyWith<$Res>(_self.security!, (value) {
    return _then(_self.copyWith(security: value));
  });
}/// Create a copy of DataTime
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
