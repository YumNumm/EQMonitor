// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_estimated_intensity_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WsEstimatedIntensityPayload {

 String get eventId; String get estimatedIntensityKey; DateTime get createdAt; WsEstimatedIntensityHypocenter? get hypocenter;
/// Create a copy of WsEstimatedIntensityPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsEstimatedIntensityPayloadCopyWith<WsEstimatedIntensityPayload> get copyWith => _$WsEstimatedIntensityPayloadCopyWithImpl<WsEstimatedIntensityPayload>(this as WsEstimatedIntensityPayload, _$identity);

  /// Serializes this WsEstimatedIntensityPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsEstimatedIntensityPayload&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.estimatedIntensityKey, estimatedIntensityKey) || other.estimatedIntensityKey == estimatedIntensityKey)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,estimatedIntensityKey,createdAt,hypocenter);

@override
String toString() {
  return 'WsEstimatedIntensityPayload(eventId: $eventId, estimatedIntensityKey: $estimatedIntensityKey, createdAt: $createdAt, hypocenter: $hypocenter)';
}


}

/// @nodoc
abstract mixin class $WsEstimatedIntensityPayloadCopyWith<$Res>  {
  factory $WsEstimatedIntensityPayloadCopyWith(WsEstimatedIntensityPayload value, $Res Function(WsEstimatedIntensityPayload) _then) = _$WsEstimatedIntensityPayloadCopyWithImpl;
@useResult
$Res call({
 String eventId, String estimatedIntensityKey, DateTime createdAt, WsEstimatedIntensityHypocenter? hypocenter
});


$WsEstimatedIntensityHypocenterCopyWith<$Res>? get hypocenter;

}
/// @nodoc
class _$WsEstimatedIntensityPayloadCopyWithImpl<$Res>
    implements $WsEstimatedIntensityPayloadCopyWith<$Res> {
  _$WsEstimatedIntensityPayloadCopyWithImpl(this._self, this._then);

  final WsEstimatedIntensityPayload _self;
  final $Res Function(WsEstimatedIntensityPayload) _then;

/// Create a copy of WsEstimatedIntensityPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? estimatedIntensityKey = null,Object? createdAt = null,Object? hypocenter = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,estimatedIntensityKey: null == estimatedIntensityKey ? _self.estimatedIntensityKey : estimatedIntensityKey // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as WsEstimatedIntensityHypocenter?,
  ));
}
/// Create a copy of WsEstimatedIntensityPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsEstimatedIntensityHypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $WsEstimatedIntensityHypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}


/// Adds pattern-matching-related methods to [WsEstimatedIntensityPayload].
extension WsEstimatedIntensityPayloadPatterns on WsEstimatedIntensityPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsEstimatedIntensityPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsEstimatedIntensityPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsEstimatedIntensityPayload value)  $default,){
final _that = this;
switch (_that) {
case _WsEstimatedIntensityPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsEstimatedIntensityPayload value)?  $default,){
final _that = this;
switch (_that) {
case _WsEstimatedIntensityPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String estimatedIntensityKey,  DateTime createdAt,  WsEstimatedIntensityHypocenter? hypocenter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsEstimatedIntensityPayload() when $default != null:
return $default(_that.eventId,_that.estimatedIntensityKey,_that.createdAt,_that.hypocenter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String estimatedIntensityKey,  DateTime createdAt,  WsEstimatedIntensityHypocenter? hypocenter)  $default,) {final _that = this;
switch (_that) {
case _WsEstimatedIntensityPayload():
return $default(_that.eventId,_that.estimatedIntensityKey,_that.createdAt,_that.hypocenter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String estimatedIntensityKey,  DateTime createdAt,  WsEstimatedIntensityHypocenter? hypocenter)?  $default,) {final _that = this;
switch (_that) {
case _WsEstimatedIntensityPayload() when $default != null:
return $default(_that.eventId,_that.estimatedIntensityKey,_that.createdAt,_that.hypocenter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsEstimatedIntensityPayload implements WsEstimatedIntensityPayload {
  const _WsEstimatedIntensityPayload({required this.eventId, required this.estimatedIntensityKey, required this.createdAt, this.hypocenter});
  factory _WsEstimatedIntensityPayload.fromJson(Map<String, dynamic> json) => _$WsEstimatedIntensityPayloadFromJson(json);

@override final  String eventId;
@override final  String estimatedIntensityKey;
@override final  DateTime createdAt;
@override final  WsEstimatedIntensityHypocenter? hypocenter;

/// Create a copy of WsEstimatedIntensityPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsEstimatedIntensityPayloadCopyWith<_WsEstimatedIntensityPayload> get copyWith => __$WsEstimatedIntensityPayloadCopyWithImpl<_WsEstimatedIntensityPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsEstimatedIntensityPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsEstimatedIntensityPayload&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.estimatedIntensityKey, estimatedIntensityKey) || other.estimatedIntensityKey == estimatedIntensityKey)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,estimatedIntensityKey,createdAt,hypocenter);

@override
String toString() {
  return 'WsEstimatedIntensityPayload(eventId: $eventId, estimatedIntensityKey: $estimatedIntensityKey, createdAt: $createdAt, hypocenter: $hypocenter)';
}


}

/// @nodoc
abstract mixin class _$WsEstimatedIntensityPayloadCopyWith<$Res> implements $WsEstimatedIntensityPayloadCopyWith<$Res> {
  factory _$WsEstimatedIntensityPayloadCopyWith(_WsEstimatedIntensityPayload value, $Res Function(_WsEstimatedIntensityPayload) _then) = __$WsEstimatedIntensityPayloadCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String estimatedIntensityKey, DateTime createdAt, WsEstimatedIntensityHypocenter? hypocenter
});


@override $WsEstimatedIntensityHypocenterCopyWith<$Res>? get hypocenter;

}
/// @nodoc
class __$WsEstimatedIntensityPayloadCopyWithImpl<$Res>
    implements _$WsEstimatedIntensityPayloadCopyWith<$Res> {
  __$WsEstimatedIntensityPayloadCopyWithImpl(this._self, this._then);

  final _WsEstimatedIntensityPayload _self;
  final $Res Function(_WsEstimatedIntensityPayload) _then;

/// Create a copy of WsEstimatedIntensityPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? estimatedIntensityKey = null,Object? createdAt = null,Object? hypocenter = freezed,}) {
  return _then(_WsEstimatedIntensityPayload(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,estimatedIntensityKey: null == estimatedIntensityKey ? _self.estimatedIntensityKey : estimatedIntensityKey // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as WsEstimatedIntensityHypocenter?,
  ));
}

/// Create a copy of WsEstimatedIntensityPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsEstimatedIntensityHypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $WsEstimatedIntensityHypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}


/// @nodoc
mixin _$WsEstimatedIntensityHypocenter {

 int get regionCode; DateTime get originTime; String? get regionName; double? get magnitude; double? get depthKm;
/// Create a copy of WsEstimatedIntensityHypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsEstimatedIntensityHypocenterCopyWith<WsEstimatedIntensityHypocenter> get copyWith => _$WsEstimatedIntensityHypocenterCopyWithImpl<WsEstimatedIntensityHypocenter>(this as WsEstimatedIntensityHypocenter, _$identity);

  /// Serializes this WsEstimatedIntensityHypocenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsEstimatedIntensityHypocenter&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionCode,originTime,regionName,magnitude,depthKm);

@override
String toString() {
  return 'WsEstimatedIntensityHypocenter(regionCode: $regionCode, originTime: $originTime, regionName: $regionName, magnitude: $magnitude, depthKm: $depthKm)';
}


}

/// @nodoc
abstract mixin class $WsEstimatedIntensityHypocenterCopyWith<$Res>  {
  factory $WsEstimatedIntensityHypocenterCopyWith(WsEstimatedIntensityHypocenter value, $Res Function(WsEstimatedIntensityHypocenter) _then) = _$WsEstimatedIntensityHypocenterCopyWithImpl;
@useResult
$Res call({
 int regionCode, DateTime originTime, String? regionName, double? magnitude, double? depthKm
});




}
/// @nodoc
class _$WsEstimatedIntensityHypocenterCopyWithImpl<$Res>
    implements $WsEstimatedIntensityHypocenterCopyWith<$Res> {
  _$WsEstimatedIntensityHypocenterCopyWithImpl(this._self, this._then);

  final WsEstimatedIntensityHypocenter _self;
  final $Res Function(WsEstimatedIntensityHypocenter) _then;

/// Create a copy of WsEstimatedIntensityHypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionCode = null,Object? originTime = null,Object? regionName = freezed,Object? magnitude = freezed,Object? depthKm = freezed,}) {
  return _then(_self.copyWith(
regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as int,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [WsEstimatedIntensityHypocenter].
extension WsEstimatedIntensityHypocenterPatterns on WsEstimatedIntensityHypocenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsEstimatedIntensityHypocenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsEstimatedIntensityHypocenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsEstimatedIntensityHypocenter value)  $default,){
final _that = this;
switch (_that) {
case _WsEstimatedIntensityHypocenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsEstimatedIntensityHypocenter value)?  $default,){
final _that = this;
switch (_that) {
case _WsEstimatedIntensityHypocenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int regionCode,  DateTime originTime,  String? regionName,  double? magnitude,  double? depthKm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsEstimatedIntensityHypocenter() when $default != null:
return $default(_that.regionCode,_that.originTime,_that.regionName,_that.magnitude,_that.depthKm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int regionCode,  DateTime originTime,  String? regionName,  double? magnitude,  double? depthKm)  $default,) {final _that = this;
switch (_that) {
case _WsEstimatedIntensityHypocenter():
return $default(_that.regionCode,_that.originTime,_that.regionName,_that.magnitude,_that.depthKm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int regionCode,  DateTime originTime,  String? regionName,  double? magnitude,  double? depthKm)?  $default,) {final _that = this;
switch (_that) {
case _WsEstimatedIntensityHypocenter() when $default != null:
return $default(_that.regionCode,_that.originTime,_that.regionName,_that.magnitude,_that.depthKm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsEstimatedIntensityHypocenter implements WsEstimatedIntensityHypocenter {
  const _WsEstimatedIntensityHypocenter({required this.regionCode, required this.originTime, this.regionName, this.magnitude, this.depthKm});
  factory _WsEstimatedIntensityHypocenter.fromJson(Map<String, dynamic> json) => _$WsEstimatedIntensityHypocenterFromJson(json);

@override final  int regionCode;
@override final  DateTime originTime;
@override final  String? regionName;
@override final  double? magnitude;
@override final  double? depthKm;

/// Create a copy of WsEstimatedIntensityHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsEstimatedIntensityHypocenterCopyWith<_WsEstimatedIntensityHypocenter> get copyWith => __$WsEstimatedIntensityHypocenterCopyWithImpl<_WsEstimatedIntensityHypocenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsEstimatedIntensityHypocenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsEstimatedIntensityHypocenter&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionCode,originTime,regionName,magnitude,depthKm);

@override
String toString() {
  return 'WsEstimatedIntensityHypocenter(regionCode: $regionCode, originTime: $originTime, regionName: $regionName, magnitude: $magnitude, depthKm: $depthKm)';
}


}

/// @nodoc
abstract mixin class _$WsEstimatedIntensityHypocenterCopyWith<$Res> implements $WsEstimatedIntensityHypocenterCopyWith<$Res> {
  factory _$WsEstimatedIntensityHypocenterCopyWith(_WsEstimatedIntensityHypocenter value, $Res Function(_WsEstimatedIntensityHypocenter) _then) = __$WsEstimatedIntensityHypocenterCopyWithImpl;
@override @useResult
$Res call({
 int regionCode, DateTime originTime, String? regionName, double? magnitude, double? depthKm
});




}
/// @nodoc
class __$WsEstimatedIntensityHypocenterCopyWithImpl<$Res>
    implements _$WsEstimatedIntensityHypocenterCopyWith<$Res> {
  __$WsEstimatedIntensityHypocenterCopyWithImpl(this._self, this._then);

  final _WsEstimatedIntensityHypocenter _self;
  final $Res Function(_WsEstimatedIntensityHypocenter) _then;

/// Create a copy of WsEstimatedIntensityHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionCode = null,Object? originTime = null,Object? regionName = freezed,Object? magnitude = freezed,Object? depthKm = freezed,}) {
  return _then(_WsEstimatedIntensityHypocenter(
regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as int,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
