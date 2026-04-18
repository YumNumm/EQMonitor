// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_observation_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinMonitorObservationPoint {

 String get code; int get x; int get y;
/// Create a copy of KyoshinMonitorObservationPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorObservationPointCopyWith<KyoshinMonitorObservationPoint> get copyWith => _$KyoshinMonitorObservationPointCopyWithImpl<KyoshinMonitorObservationPoint>(this as KyoshinMonitorObservationPoint, _$identity);

  /// Serializes this KyoshinMonitorObservationPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorObservationPoint&&(identical(other.code, code) || other.code == code)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,x,y);

@override
String toString() {
  return 'KyoshinMonitorObservationPoint(code: $code, x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorObservationPointCopyWith<$Res>  {
  factory $KyoshinMonitorObservationPointCopyWith(KyoshinMonitorObservationPoint value, $Res Function(KyoshinMonitorObservationPoint) _then) = _$KyoshinMonitorObservationPointCopyWithImpl;
@useResult
$Res call({
 String code, int x, int y
});




}
/// @nodoc
class _$KyoshinMonitorObservationPointCopyWithImpl<$Res>
    implements $KyoshinMonitorObservationPointCopyWith<$Res> {
  _$KyoshinMonitorObservationPointCopyWithImpl(this._self, this._then);

  final KyoshinMonitorObservationPoint _self;
  final $Res Function(KyoshinMonitorObservationPoint) _then;

/// Create a copy of KyoshinMonitorObservationPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? x = null,Object? y = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [KyoshinMonitorObservationPoint].
extension KyoshinMonitorObservationPointPatterns on KyoshinMonitorObservationPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinMonitorObservationPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinMonitorObservationPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinMonitorObservationPoint value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorObservationPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinMonitorObservationPoint value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorObservationPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  int x,  int y)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinMonitorObservationPoint() when $default != null:
return $default(_that.code,_that.x,_that.y);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  int x,  int y)  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorObservationPoint():
return $default(_that.code,_that.x,_that.y);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  int x,  int y)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorObservationPoint() when $default != null:
return $default(_that.code,_that.x,_that.y);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KyoshinMonitorObservationPoint implements KyoshinMonitorObservationPoint {
  const _KyoshinMonitorObservationPoint({required this.code, required this.x, required this.y});
  factory _KyoshinMonitorObservationPoint.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorObservationPointFromJson(json);

@override final  String code;
@override final  int x;
@override final  int y;

/// Create a copy of KyoshinMonitorObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorObservationPointCopyWith<_KyoshinMonitorObservationPoint> get copyWith => __$KyoshinMonitorObservationPointCopyWithImpl<_KyoshinMonitorObservationPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorObservationPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorObservationPoint&&(identical(other.code, code) || other.code == code)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,x,y);

@override
String toString() {
  return 'KyoshinMonitorObservationPoint(code: $code, x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorObservationPointCopyWith<$Res> implements $KyoshinMonitorObservationPointCopyWith<$Res> {
  factory _$KyoshinMonitorObservationPointCopyWith(_KyoshinMonitorObservationPoint value, $Res Function(_KyoshinMonitorObservationPoint) _then) = __$KyoshinMonitorObservationPointCopyWithImpl;
@override @useResult
$Res call({
 String code, int x, int y
});




}
/// @nodoc
class __$KyoshinMonitorObservationPointCopyWithImpl<$Res>
    implements _$KyoshinMonitorObservationPointCopyWith<$Res> {
  __$KyoshinMonitorObservationPointCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorObservationPoint _self;
  final $Res Function(_KyoshinMonitorObservationPoint) _then;

/// Create a copy of KyoshinMonitorObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? x = null,Object? y = null,}) {
  return _then(_KyoshinMonitorObservationPoint(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$KyoshinMonitorObservationAnalyzedPoint {

 KyoshinMonitorObservationPoint get point; double get scale; int get r; int get g; int get b;
/// Create a copy of KyoshinMonitorObservationAnalyzedPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorObservationAnalyzedPointCopyWith<KyoshinMonitorObservationAnalyzedPoint> get copyWith => _$KyoshinMonitorObservationAnalyzedPointCopyWithImpl<KyoshinMonitorObservationAnalyzedPoint>(this as KyoshinMonitorObservationAnalyzedPoint, _$identity);

  /// Serializes this KyoshinMonitorObservationAnalyzedPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorObservationAnalyzedPoint&&(identical(other.point, point) || other.point == point)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.r, r) || other.r == r)&&(identical(other.g, g) || other.g == g)&&(identical(other.b, b) || other.b == b));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,point,scale,r,g,b);

@override
String toString() {
  return 'KyoshinMonitorObservationAnalyzedPoint(point: $point, scale: $scale, r: $r, g: $g, b: $b)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res>  {
  factory $KyoshinMonitorObservationAnalyzedPointCopyWith(KyoshinMonitorObservationAnalyzedPoint value, $Res Function(KyoshinMonitorObservationAnalyzedPoint) _then) = _$KyoshinMonitorObservationAnalyzedPointCopyWithImpl;
@useResult
$Res call({
 KyoshinMonitorObservationPoint point, double scale, int r, int g, int b
});


$KyoshinMonitorObservationPointCopyWith<$Res> get point;

}
/// @nodoc
class _$KyoshinMonitorObservationAnalyzedPointCopyWithImpl<$Res>
    implements $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> {
  _$KyoshinMonitorObservationAnalyzedPointCopyWithImpl(this._self, this._then);

  final KyoshinMonitorObservationAnalyzedPoint _self;
  final $Res Function(KyoshinMonitorObservationAnalyzedPoint) _then;

/// Create a copy of KyoshinMonitorObservationAnalyzedPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? point = null,Object? scale = null,Object? r = null,Object? g = null,Object? b = null,}) {
  return _then(_self.copyWith(
point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorObservationPoint,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as int,g: null == g ? _self.g : g // ignore: cast_nullable_to_non_nullable
as int,b: null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of KyoshinMonitorObservationAnalyzedPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinMonitorObservationPointCopyWith<$Res> get point {
  
  return $KyoshinMonitorObservationPointCopyWith<$Res>(_self.point, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}


/// Adds pattern-matching-related methods to [KyoshinMonitorObservationAnalyzedPoint].
extension KyoshinMonitorObservationAnalyzedPointPatterns on KyoshinMonitorObservationAnalyzedPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinMonitorObservationAnalyzedPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinMonitorObservationAnalyzedPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinMonitorObservationAnalyzedPoint value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorObservationAnalyzedPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinMonitorObservationAnalyzedPoint value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorObservationAnalyzedPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KyoshinMonitorObservationPoint point,  double scale,  int r,  int g,  int b)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinMonitorObservationAnalyzedPoint() when $default != null:
return $default(_that.point,_that.scale,_that.r,_that.g,_that.b);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KyoshinMonitorObservationPoint point,  double scale,  int r,  int g,  int b)  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorObservationAnalyzedPoint():
return $default(_that.point,_that.scale,_that.r,_that.g,_that.b);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KyoshinMonitorObservationPoint point,  double scale,  int r,  int g,  int b)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorObservationAnalyzedPoint() when $default != null:
return $default(_that.point,_that.scale,_that.r,_that.g,_that.b);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KyoshinMonitorObservationAnalyzedPoint extends KyoshinMonitorObservationAnalyzedPoint {
  const _KyoshinMonitorObservationAnalyzedPoint({required this.point, required this.scale, required this.r, required this.g, required this.b}): super._();
  factory _KyoshinMonitorObservationAnalyzedPoint.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorObservationAnalyzedPointFromJson(json);

@override final  KyoshinMonitorObservationPoint point;
@override final  double scale;
@override final  int r;
@override final  int g;
@override final  int b;

/// Create a copy of KyoshinMonitorObservationAnalyzedPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorObservationAnalyzedPointCopyWith<_KyoshinMonitorObservationAnalyzedPoint> get copyWith => __$KyoshinMonitorObservationAnalyzedPointCopyWithImpl<_KyoshinMonitorObservationAnalyzedPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorObservationAnalyzedPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorObservationAnalyzedPoint&&(identical(other.point, point) || other.point == point)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.r, r) || other.r == r)&&(identical(other.g, g) || other.g == g)&&(identical(other.b, b) || other.b == b));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,point,scale,r,g,b);

@override
String toString() {
  return 'KyoshinMonitorObservationAnalyzedPoint(point: $point, scale: $scale, r: $r, g: $g, b: $b)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> implements $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> {
  factory _$KyoshinMonitorObservationAnalyzedPointCopyWith(_KyoshinMonitorObservationAnalyzedPoint value, $Res Function(_KyoshinMonitorObservationAnalyzedPoint) _then) = __$KyoshinMonitorObservationAnalyzedPointCopyWithImpl;
@override @useResult
$Res call({
 KyoshinMonitorObservationPoint point, double scale, int r, int g, int b
});


@override $KyoshinMonitorObservationPointCopyWith<$Res> get point;

}
/// @nodoc
class __$KyoshinMonitorObservationAnalyzedPointCopyWithImpl<$Res>
    implements _$KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> {
  __$KyoshinMonitorObservationAnalyzedPointCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorObservationAnalyzedPoint _self;
  final $Res Function(_KyoshinMonitorObservationAnalyzedPoint) _then;

/// Create a copy of KyoshinMonitorObservationAnalyzedPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? point = null,Object? scale = null,Object? r = null,Object? g = null,Object? b = null,}) {
  return _then(_KyoshinMonitorObservationAnalyzedPoint(
point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorObservationPoint,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as int,g: null == g ? _self.g : g // ignore: cast_nullable_to_non_nullable
as int,b: null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of KyoshinMonitorObservationAnalyzedPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinMonitorObservationPointCopyWith<$Res> get point {
  
  return $KyoshinMonitorObservationPointCopyWith<$Res>(_self.point, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}


/// @nodoc
mixin _$NamedObservationPoint {

 String get code; String get name; double get latitude; double get longitude; int get x; int get y;
/// Create a copy of NamedObservationPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NamedObservationPointCopyWith<NamedObservationPoint> get copyWith => _$NamedObservationPointCopyWithImpl<NamedObservationPoint>(this as NamedObservationPoint, _$identity);

  /// Serializes this NamedObservationPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NamedObservationPoint&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,latitude,longitude,x,y);

@override
String toString() {
  return 'NamedObservationPoint(code: $code, name: $name, latitude: $latitude, longitude: $longitude, x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $NamedObservationPointCopyWith<$Res>  {
  factory $NamedObservationPointCopyWith(NamedObservationPoint value, $Res Function(NamedObservationPoint) _then) = _$NamedObservationPointCopyWithImpl;
@useResult
$Res call({
 String code, String name, double latitude, double longitude, int x, int y
});




}
/// @nodoc
class _$NamedObservationPointCopyWithImpl<$Res>
    implements $NamedObservationPointCopyWith<$Res> {
  _$NamedObservationPointCopyWithImpl(this._self, this._then);

  final NamedObservationPoint _self;
  final $Res Function(NamedObservationPoint) _then;

/// Create a copy of NamedObservationPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? latitude = null,Object? longitude = null,Object? x = null,Object? y = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NamedObservationPoint].
extension NamedObservationPointPatterns on NamedObservationPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NamedObservationPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NamedObservationPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NamedObservationPoint value)  $default,){
final _that = this;
switch (_that) {
case _NamedObservationPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NamedObservationPoint value)?  $default,){
final _that = this;
switch (_that) {
case _NamedObservationPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  double latitude,  double longitude,  int x,  int y)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NamedObservationPoint() when $default != null:
return $default(_that.code,_that.name,_that.latitude,_that.longitude,_that.x,_that.y);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  double latitude,  double longitude,  int x,  int y)  $default,) {final _that = this;
switch (_that) {
case _NamedObservationPoint():
return $default(_that.code,_that.name,_that.latitude,_that.longitude,_that.x,_that.y);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  double latitude,  double longitude,  int x,  int y)?  $default,) {final _that = this;
switch (_that) {
case _NamedObservationPoint() when $default != null:
return $default(_that.code,_that.name,_that.latitude,_that.longitude,_that.x,_that.y);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NamedObservationPoint implements NamedObservationPoint {
  const _NamedObservationPoint({required this.code, required this.name, required this.latitude, required this.longitude, required this.x, required this.y});
  factory _NamedObservationPoint.fromJson(Map<String, dynamic> json) => _$NamedObservationPointFromJson(json);

@override final  String code;
@override final  String name;
@override final  double latitude;
@override final  double longitude;
@override final  int x;
@override final  int y;

/// Create a copy of NamedObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NamedObservationPointCopyWith<_NamedObservationPoint> get copyWith => __$NamedObservationPointCopyWithImpl<_NamedObservationPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NamedObservationPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NamedObservationPoint&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,latitude,longitude,x,y);

@override
String toString() {
  return 'NamedObservationPoint(code: $code, name: $name, latitude: $latitude, longitude: $longitude, x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class _$NamedObservationPointCopyWith<$Res> implements $NamedObservationPointCopyWith<$Res> {
  factory _$NamedObservationPointCopyWith(_NamedObservationPoint value, $Res Function(_NamedObservationPoint) _then) = __$NamedObservationPointCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, double latitude, double longitude, int x, int y
});




}
/// @nodoc
class __$NamedObservationPointCopyWithImpl<$Res>
    implements _$NamedObservationPointCopyWith<$Res> {
  __$NamedObservationPointCopyWithImpl(this._self, this._then);

  final _NamedObservationPoint _self;
  final $Res Function(_NamedObservationPoint) _then;

/// Create a copy of NamedObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? latitude = null,Object? longitude = null,Object? x = null,Object? y = null,}) {
  return _then(_NamedObservationPoint(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
