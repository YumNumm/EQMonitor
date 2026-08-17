// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_bounds.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeismicityBounds {

 double get minLatitude; double get maxLatitude; double get minLongitude; double get maxLongitude;
/// Create a copy of SeismicityBounds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityBoundsCopyWith<SeismicityBounds> get copyWith => _$SeismicityBoundsCopyWithImpl<SeismicityBounds>(this as SeismicityBounds, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityBounds&&(identical(other.minLatitude, minLatitude) || other.minLatitude == minLatitude)&&(identical(other.maxLatitude, maxLatitude) || other.maxLatitude == maxLatitude)&&(identical(other.minLongitude, minLongitude) || other.minLongitude == minLongitude)&&(identical(other.maxLongitude, maxLongitude) || other.maxLongitude == maxLongitude));
}


@override
int get hashCode => Object.hash(runtimeType,minLatitude,maxLatitude,minLongitude,maxLongitude);

@override
String toString() {
  return 'SeismicityBounds(minLatitude: $minLatitude, maxLatitude: $maxLatitude, minLongitude: $minLongitude, maxLongitude: $maxLongitude)';
}


}

/// @nodoc
abstract mixin class $SeismicityBoundsCopyWith<$Res>  {
  factory $SeismicityBoundsCopyWith(SeismicityBounds value, $Res Function(SeismicityBounds) _then) = _$SeismicityBoundsCopyWithImpl;
@useResult
$Res call({
 double minLatitude, double maxLatitude, double minLongitude, double maxLongitude
});




}
/// @nodoc
class _$SeismicityBoundsCopyWithImpl<$Res>
    implements $SeismicityBoundsCopyWith<$Res> {
  _$SeismicityBoundsCopyWithImpl(this._self, this._then);

  final SeismicityBounds _self;
  final $Res Function(SeismicityBounds) _then;

/// Create a copy of SeismicityBounds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minLatitude = null,Object? maxLatitude = null,Object? minLongitude = null,Object? maxLongitude = null,}) {
  return _then(SeismicityBounds(
minLatitude: null == minLatitude ? _self.minLatitude : minLatitude // ignore: cast_nullable_to_non_nullable
as double,maxLatitude: null == maxLatitude ? _self.maxLatitude : maxLatitude // ignore: cast_nullable_to_non_nullable
as double,minLongitude: null == minLongitude ? _self.minLongitude : minLongitude // ignore: cast_nullable_to_non_nullable
as double,maxLongitude: null == maxLongitude ? _self.maxLongitude : maxLongitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicityBounds].
extension SeismicityBoundsPatterns on SeismicityBounds {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityBounds value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityBounds() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityBounds value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityBounds():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityBounds value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityBounds() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double minLatitude,  double maxLatitude,  double minLongitude,  double maxLongitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicityBounds() when $default != null:
return $default(_that.minLatitude,_that.maxLatitude,_that.minLongitude,_that.maxLongitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double minLatitude,  double maxLatitude,  double minLongitude,  double maxLongitude)  $default,) {final _that = this;
switch (_that) {
case _SeismicityBounds():
return $default(_that.minLatitude,_that.maxLatitude,_that.minLongitude,_that.maxLongitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double minLatitude,  double maxLatitude,  double minLongitude,  double maxLongitude)?  $default,) {final _that = this;
switch (_that) {
case _SeismicityBounds() when $default != null:
return $default(_that.minLatitude,_that.maxLatitude,_that.minLongitude,_that.maxLongitude);case _:
  return null;

}
}

}

/// @nodoc


class _SeismicityBounds implements SeismicityBounds {
  const _SeismicityBounds({required this.minLatitude, required this.maxLatitude, required this.minLongitude, required this.maxLongitude});
  

@override final  double minLatitude;
@override final  double maxLatitude;
@override final  double minLongitude;
@override final  double maxLongitude;

/// Create a copy of SeismicityBounds
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityBoundsCopyWith<_SeismicityBounds> get copyWith => __$SeismicityBoundsCopyWithImpl<_SeismicityBounds>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeismicityBounds&&(identical(other.minLatitude, minLatitude) || other.minLatitude == minLatitude)&&(identical(other.maxLatitude, maxLatitude) || other.maxLatitude == maxLatitude)&&(identical(other.minLongitude, minLongitude) || other.minLongitude == minLongitude)&&(identical(other.maxLongitude, maxLongitude) || other.maxLongitude == maxLongitude));
}


@override
int get hashCode => Object.hash(runtimeType,minLatitude,maxLatitude,minLongitude,maxLongitude);

@override
String toString() {
  return 'SeismicityBounds(minLatitude: $minLatitude, maxLatitude: $maxLatitude, minLongitude: $minLongitude, maxLongitude: $maxLongitude)';
}


}

/// @nodoc
abstract mixin class _$SeismicityBoundsCopyWith<$Res> implements $SeismicityBoundsCopyWith<$Res> {
  factory _$SeismicityBoundsCopyWith(_SeismicityBounds value, $Res Function(_SeismicityBounds) _then) = __$SeismicityBoundsCopyWithImpl;
@override @useResult
$Res call({
 double minLatitude, double maxLatitude, double minLongitude, double maxLongitude
});




}
/// @nodoc
class __$SeismicityBoundsCopyWithImpl<$Res>
    implements _$SeismicityBoundsCopyWith<$Res> {
  __$SeismicityBoundsCopyWithImpl(this._self, this._then);

  final _SeismicityBounds _self;
  final $Res Function(_SeismicityBounds) _then;

/// Create a copy of SeismicityBounds
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minLatitude = null,Object? maxLatitude = null,Object? minLongitude = null,Object? maxLongitude = null,}) {
  return _then(_SeismicityBounds(
minLatitude: null == minLatitude ? _self.minLatitude : minLatitude // ignore: cast_nullable_to_non_nullable
as double,maxLatitude: null == maxLatitude ? _self.maxLatitude : maxLatitude // ignore: cast_nullable_to_non_nullable
as double,minLongitude: null == minLongitude ? _self.minLongitude : minLongitude // ignore: cast_nullable_to_non_nullable
as double,maxLongitude: null == maxLongitude ? _self.maxLongitude : maxLongitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
