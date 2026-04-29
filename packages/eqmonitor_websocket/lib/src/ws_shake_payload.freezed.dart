// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_shake_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WsShakeLocationPayload {

 double get latitude; double get longitude;
/// Create a copy of WsShakeLocationPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsShakeLocationPayloadCopyWith<WsShakeLocationPayload> get copyWith => _$WsShakeLocationPayloadCopyWithImpl<WsShakeLocationPayload>(this as WsShakeLocationPayload, _$identity);

  /// Serializes this WsShakeLocationPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsShakeLocationPayload&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'WsShakeLocationPayload(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $WsShakeLocationPayloadCopyWith<$Res>  {
  factory $WsShakeLocationPayloadCopyWith(WsShakeLocationPayload value, $Res Function(WsShakeLocationPayload) _then) = _$WsShakeLocationPayloadCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class _$WsShakeLocationPayloadCopyWithImpl<$Res>
    implements $WsShakeLocationPayloadCopyWith<$Res> {
  _$WsShakeLocationPayloadCopyWithImpl(this._self, this._then);

  final WsShakeLocationPayload _self;
  final $Res Function(WsShakeLocationPayload) _then;

/// Create a copy of WsShakeLocationPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WsShakeLocationPayload].
extension WsShakeLocationPayloadPatterns on WsShakeLocationPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsShakeLocationPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsShakeLocationPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsShakeLocationPayload value)  $default,){
final _that = this;
switch (_that) {
case _WsShakeLocationPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsShakeLocationPayload value)?  $default,){
final _that = this;
switch (_that) {
case _WsShakeLocationPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsShakeLocationPayload() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude)  $default,) {final _that = this;
switch (_that) {
case _WsShakeLocationPayload():
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude)?  $default,) {final _that = this;
switch (_that) {
case _WsShakeLocationPayload() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsShakeLocationPayload implements WsShakeLocationPayload {
  const _WsShakeLocationPayload({required this.latitude, required this.longitude});
  factory _WsShakeLocationPayload.fromJson(Map<String, dynamic> json) => _$WsShakeLocationPayloadFromJson(json);

@override final  double latitude;
@override final  double longitude;

/// Create a copy of WsShakeLocationPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsShakeLocationPayloadCopyWith<_WsShakeLocationPayload> get copyWith => __$WsShakeLocationPayloadCopyWithImpl<_WsShakeLocationPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsShakeLocationPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsShakeLocationPayload&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'WsShakeLocationPayload(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$WsShakeLocationPayloadCopyWith<$Res> implements $WsShakeLocationPayloadCopyWith<$Res> {
  factory _$WsShakeLocationPayloadCopyWith(_WsShakeLocationPayload value, $Res Function(_WsShakeLocationPayload) _then) = __$WsShakeLocationPayloadCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class __$WsShakeLocationPayloadCopyWithImpl<$Res>
    implements _$WsShakeLocationPayloadCopyWith<$Res> {
  __$WsShakeLocationPayloadCopyWithImpl(this._self, this._then);

  final _WsShakeLocationPayload _self;
  final $Res Function(_WsShakeLocationPayload) _then;

/// Create a copy of WsShakeLocationPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_WsShakeLocationPayload(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$WsShakeRegionPayload {

 WsShakeLocationPayload get topLeft; WsShakeLocationPayload get bottomRight;
/// Create a copy of WsShakeRegionPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsShakeRegionPayloadCopyWith<WsShakeRegionPayload> get copyWith => _$WsShakeRegionPayloadCopyWithImpl<WsShakeRegionPayload>(this as WsShakeRegionPayload, _$identity);

  /// Serializes this WsShakeRegionPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsShakeRegionPayload&&(identical(other.topLeft, topLeft) || other.topLeft == topLeft)&&(identical(other.bottomRight, bottomRight) || other.bottomRight == bottomRight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topLeft,bottomRight);

@override
String toString() {
  return 'WsShakeRegionPayload(topLeft: $topLeft, bottomRight: $bottomRight)';
}


}

/// @nodoc
abstract mixin class $WsShakeRegionPayloadCopyWith<$Res>  {
  factory $WsShakeRegionPayloadCopyWith(WsShakeRegionPayload value, $Res Function(WsShakeRegionPayload) _then) = _$WsShakeRegionPayloadCopyWithImpl;
@useResult
$Res call({
 WsShakeLocationPayload topLeft, WsShakeLocationPayload bottomRight
});


$WsShakeLocationPayloadCopyWith<$Res> get topLeft;$WsShakeLocationPayloadCopyWith<$Res> get bottomRight;

}
/// @nodoc
class _$WsShakeRegionPayloadCopyWithImpl<$Res>
    implements $WsShakeRegionPayloadCopyWith<$Res> {
  _$WsShakeRegionPayloadCopyWithImpl(this._self, this._then);

  final WsShakeRegionPayload _self;
  final $Res Function(WsShakeRegionPayload) _then;

/// Create a copy of WsShakeRegionPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topLeft = null,Object? bottomRight = null,}) {
  return _then(_self.copyWith(
topLeft: null == topLeft ? _self.topLeft : topLeft // ignore: cast_nullable_to_non_nullable
as WsShakeLocationPayload,bottomRight: null == bottomRight ? _self.bottomRight : bottomRight // ignore: cast_nullable_to_non_nullable
as WsShakeLocationPayload,
  ));
}
/// Create a copy of WsShakeRegionPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeLocationPayloadCopyWith<$Res> get topLeft {
  
  return $WsShakeLocationPayloadCopyWith<$Res>(_self.topLeft, (value) {
    return _then(_self.copyWith(topLeft: value));
  });
}/// Create a copy of WsShakeRegionPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeLocationPayloadCopyWith<$Res> get bottomRight {
  
  return $WsShakeLocationPayloadCopyWith<$Res>(_self.bottomRight, (value) {
    return _then(_self.copyWith(bottomRight: value));
  });
}
}


/// Adds pattern-matching-related methods to [WsShakeRegionPayload].
extension WsShakeRegionPayloadPatterns on WsShakeRegionPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsShakeRegionPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsShakeRegionPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsShakeRegionPayload value)  $default,){
final _that = this;
switch (_that) {
case _WsShakeRegionPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsShakeRegionPayload value)?  $default,){
final _that = this;
switch (_that) {
case _WsShakeRegionPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WsShakeLocationPayload topLeft,  WsShakeLocationPayload bottomRight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsShakeRegionPayload() when $default != null:
return $default(_that.topLeft,_that.bottomRight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WsShakeLocationPayload topLeft,  WsShakeLocationPayload bottomRight)  $default,) {final _that = this;
switch (_that) {
case _WsShakeRegionPayload():
return $default(_that.topLeft,_that.bottomRight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WsShakeLocationPayload topLeft,  WsShakeLocationPayload bottomRight)?  $default,) {final _that = this;
switch (_that) {
case _WsShakeRegionPayload() when $default != null:
return $default(_that.topLeft,_that.bottomRight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsShakeRegionPayload implements WsShakeRegionPayload {
  const _WsShakeRegionPayload({required this.topLeft, required this.bottomRight});
  factory _WsShakeRegionPayload.fromJson(Map<String, dynamic> json) => _$WsShakeRegionPayloadFromJson(json);

@override final  WsShakeLocationPayload topLeft;
@override final  WsShakeLocationPayload bottomRight;

/// Create a copy of WsShakeRegionPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsShakeRegionPayloadCopyWith<_WsShakeRegionPayload> get copyWith => __$WsShakeRegionPayloadCopyWithImpl<_WsShakeRegionPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsShakeRegionPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsShakeRegionPayload&&(identical(other.topLeft, topLeft) || other.topLeft == topLeft)&&(identical(other.bottomRight, bottomRight) || other.bottomRight == bottomRight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topLeft,bottomRight);

@override
String toString() {
  return 'WsShakeRegionPayload(topLeft: $topLeft, bottomRight: $bottomRight)';
}


}

/// @nodoc
abstract mixin class _$WsShakeRegionPayloadCopyWith<$Res> implements $WsShakeRegionPayloadCopyWith<$Res> {
  factory _$WsShakeRegionPayloadCopyWith(_WsShakeRegionPayload value, $Res Function(_WsShakeRegionPayload) _then) = __$WsShakeRegionPayloadCopyWithImpl;
@override @useResult
$Res call({
 WsShakeLocationPayload topLeft, WsShakeLocationPayload bottomRight
});


@override $WsShakeLocationPayloadCopyWith<$Res> get topLeft;@override $WsShakeLocationPayloadCopyWith<$Res> get bottomRight;

}
/// @nodoc
class __$WsShakeRegionPayloadCopyWithImpl<$Res>
    implements _$WsShakeRegionPayloadCopyWith<$Res> {
  __$WsShakeRegionPayloadCopyWithImpl(this._self, this._then);

  final _WsShakeRegionPayload _self;
  final $Res Function(_WsShakeRegionPayload) _then;

/// Create a copy of WsShakeRegionPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topLeft = null,Object? bottomRight = null,}) {
  return _then(_WsShakeRegionPayload(
topLeft: null == topLeft ? _self.topLeft : topLeft // ignore: cast_nullable_to_non_nullable
as WsShakeLocationPayload,bottomRight: null == bottomRight ? _self.bottomRight : bottomRight // ignore: cast_nullable_to_non_nullable
as WsShakeLocationPayload,
  ));
}

/// Create a copy of WsShakeRegionPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeLocationPayloadCopyWith<$Res> get topLeft {
  
  return $WsShakeLocationPayloadCopyWith<$Res>(_self.topLeft, (value) {
    return _then(_self.copyWith(topLeft: value));
  });
}/// Create a copy of WsShakeRegionPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeLocationPayloadCopyWith<$Res> get bottomRight {
  
  return $WsShakeLocationPayloadCopyWith<$Res>(_self.bottomRight, (value) {
    return _then(_self.copyWith(bottomRight: value));
  });
}
}

// dart format on
