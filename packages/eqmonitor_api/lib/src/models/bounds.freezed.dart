// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bounds.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Bounds {

@JsonKey(name: 'min_longitude') num get minLongitude;@JsonKey(name: 'min_latitude') num get minLatitude;@JsonKey(name: 'max_longitude') num get maxLongitude;@JsonKey(name: 'max_latitude') num get maxLatitude;
/// Create a copy of Bounds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoundsCopyWith<Bounds> get copyWith => _$BoundsCopyWithImpl<Bounds>(this as Bounds, _$identity);

  /// Serializes this Bounds to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bounds&&(identical(other.minLongitude, minLongitude) || other.minLongitude == minLongitude)&&(identical(other.minLatitude, minLatitude) || other.minLatitude == minLatitude)&&(identical(other.maxLongitude, maxLongitude) || other.maxLongitude == maxLongitude)&&(identical(other.maxLatitude, maxLatitude) || other.maxLatitude == maxLatitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minLongitude,minLatitude,maxLongitude,maxLatitude);

@override
String toString() {
  return 'Bounds(minLongitude: $minLongitude, minLatitude: $minLatitude, maxLongitude: $maxLongitude, maxLatitude: $maxLatitude)';
}


}

/// @nodoc
abstract mixin class $BoundsCopyWith<$Res>  {
  factory $BoundsCopyWith(Bounds value, $Res Function(Bounds) _then) = _$BoundsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'min_longitude') num minLongitude,@JsonKey(name: 'min_latitude') num minLatitude,@JsonKey(name: 'max_longitude') num maxLongitude,@JsonKey(name: 'max_latitude') num maxLatitude
});




}
/// @nodoc
class _$BoundsCopyWithImpl<$Res>
    implements $BoundsCopyWith<$Res> {
  _$BoundsCopyWithImpl(this._self, this._then);

  final Bounds _self;
  final $Res Function(Bounds) _then;

/// Create a copy of Bounds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minLongitude = null,Object? minLatitude = null,Object? maxLongitude = null,Object? maxLatitude = null,}) {
  return _then(Bounds(
minLongitude: null == minLongitude ? _self.minLongitude : minLongitude // ignore: cast_nullable_to_non_nullable
as num,minLatitude: null == minLatitude ? _self.minLatitude : minLatitude // ignore: cast_nullable_to_non_nullable
as num,maxLongitude: null == maxLongitude ? _self.maxLongitude : maxLongitude // ignore: cast_nullable_to_non_nullable
as num,maxLatitude: null == maxLatitude ? _self.maxLatitude : maxLatitude // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [Bounds].
extension BoundsPatterns on Bounds {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bounds value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bounds() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bounds value)  $default,){
final _that = this;
switch (_that) {
case _Bounds():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bounds value)?  $default,){
final _that = this;
switch (_that) {
case _Bounds() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'min_longitude')  num minLongitude, @JsonKey(name: 'min_latitude')  num minLatitude, @JsonKey(name: 'max_longitude')  num maxLongitude, @JsonKey(name: 'max_latitude')  num maxLatitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bounds() when $default != null:
return $default(_that.minLongitude,_that.minLatitude,_that.maxLongitude,_that.maxLatitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'min_longitude')  num minLongitude, @JsonKey(name: 'min_latitude')  num minLatitude, @JsonKey(name: 'max_longitude')  num maxLongitude, @JsonKey(name: 'max_latitude')  num maxLatitude)  $default,) {final _that = this;
switch (_that) {
case _Bounds():
return $default(_that.minLongitude,_that.minLatitude,_that.maxLongitude,_that.maxLatitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'min_longitude')  num minLongitude, @JsonKey(name: 'min_latitude')  num minLatitude, @JsonKey(name: 'max_longitude')  num maxLongitude, @JsonKey(name: 'max_latitude')  num maxLatitude)?  $default,) {final _that = this;
switch (_that) {
case _Bounds() when $default != null:
return $default(_that.minLongitude,_that.minLatitude,_that.maxLongitude,_that.maxLatitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Bounds implements Bounds {
  const _Bounds({@JsonKey(name: 'min_longitude') required this.minLongitude, @JsonKey(name: 'min_latitude') required this.minLatitude, @JsonKey(name: 'max_longitude') required this.maxLongitude, @JsonKey(name: 'max_latitude') required this.maxLatitude});
  factory _Bounds.fromJson(Map<String, dynamic> json) => _$BoundsFromJson(json);

@override@JsonKey(name: 'min_longitude') final  num minLongitude;
@override@JsonKey(name: 'min_latitude') final  num minLatitude;
@override@JsonKey(name: 'max_longitude') final  num maxLongitude;
@override@JsonKey(name: 'max_latitude') final  num maxLatitude;

/// Create a copy of Bounds
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoundsCopyWith<_Bounds> get copyWith => __$BoundsCopyWithImpl<_Bounds>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoundsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bounds&&(identical(other.minLongitude, minLongitude) || other.minLongitude == minLongitude)&&(identical(other.minLatitude, minLatitude) || other.minLatitude == minLatitude)&&(identical(other.maxLongitude, maxLongitude) || other.maxLongitude == maxLongitude)&&(identical(other.maxLatitude, maxLatitude) || other.maxLatitude == maxLatitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minLongitude,minLatitude,maxLongitude,maxLatitude);

@override
String toString() {
  return 'Bounds(minLongitude: $minLongitude, minLatitude: $minLatitude, maxLongitude: $maxLongitude, maxLatitude: $maxLatitude)';
}


}

/// @nodoc
abstract mixin class _$BoundsCopyWith<$Res> implements $BoundsCopyWith<$Res> {
  factory _$BoundsCopyWith(_Bounds value, $Res Function(_Bounds) _then) = __$BoundsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'min_longitude') num minLongitude,@JsonKey(name: 'min_latitude') num minLatitude,@JsonKey(name: 'max_longitude') num maxLongitude,@JsonKey(name: 'max_latitude') num maxLatitude
});




}
/// @nodoc
class __$BoundsCopyWithImpl<$Res>
    implements _$BoundsCopyWith<$Res> {
  __$BoundsCopyWithImpl(this._self, this._then);

  final _Bounds _self;
  final $Res Function(_Bounds) _then;

/// Create a copy of Bounds
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minLongitude = null,Object? minLatitude = null,Object? maxLongitude = null,Object? maxLatitude = null,}) {
  return _then(_Bounds(
minLongitude: null == minLongitude ? _self.minLongitude : minLongitude // ignore: cast_nullable_to_non_nullable
as num,minLatitude: null == minLatitude ? _self.minLatitude : minLatitude // ignore: cast_nullable_to_non_nullable
as num,maxLongitude: null == maxLongitude ? _self.maxLongitude : maxLongitude // ignore: cast_nullable_to_non_nullable
as num,maxLatitude: null == maxLatitude ? _self.maxLatitude : maxLatitude // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
