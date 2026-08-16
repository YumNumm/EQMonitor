// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_pmtiles_bounds.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeismicityPmTilesBounds {

 double get minLongitude; double get minLatitude; double get maxLongitude; double get maxLatitude;
/// Create a copy of SeismicityPmTilesBounds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityPmTilesBoundsCopyWith<SeismicityPmTilesBounds> get copyWith => _$SeismicityPmTilesBoundsCopyWithImpl<SeismicityPmTilesBounds>(this as SeismicityPmTilesBounds, _$identity);

  /// Serializes this SeismicityPmTilesBounds to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesBounds&&(identical(other.minLongitude, minLongitude) || other.minLongitude == minLongitude)&&(identical(other.minLatitude, minLatitude) || other.minLatitude == minLatitude)&&(identical(other.maxLongitude, maxLongitude) || other.maxLongitude == maxLongitude)&&(identical(other.maxLatitude, maxLatitude) || other.maxLatitude == maxLatitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minLongitude,minLatitude,maxLongitude,maxLatitude);

@override
String toString() {
  return 'SeismicityPmTilesBounds(minLongitude: $minLongitude, minLatitude: $minLatitude, maxLongitude: $maxLongitude, maxLatitude: $maxLatitude)';
}


}

/// @nodoc
abstract mixin class $SeismicityPmTilesBoundsCopyWith<$Res>  {
  factory $SeismicityPmTilesBoundsCopyWith(SeismicityPmTilesBounds value, $Res Function(SeismicityPmTilesBounds) _then) = _$SeismicityPmTilesBoundsCopyWithImpl;
@useResult
$Res call({
 double minLongitude, double minLatitude, double maxLongitude, double maxLatitude
});




}
/// @nodoc
class _$SeismicityPmTilesBoundsCopyWithImpl<$Res>
    implements $SeismicityPmTilesBoundsCopyWith<$Res> {
  _$SeismicityPmTilesBoundsCopyWithImpl(this._self, this._then);

  final SeismicityPmTilesBounds _self;
  final $Res Function(SeismicityPmTilesBounds) _then;

/// Create a copy of SeismicityPmTilesBounds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minLongitude = null,Object? minLatitude = null,Object? maxLongitude = null,Object? maxLatitude = null,}) {
  return _then(SeismicityPmTilesBounds(
minLongitude: null == minLongitude ? _self.minLongitude : minLongitude // ignore: cast_nullable_to_non_nullable
as double,minLatitude: null == minLatitude ? _self.minLatitude : minLatitude // ignore: cast_nullable_to_non_nullable
as double,maxLongitude: null == maxLongitude ? _self.maxLongitude : maxLongitude // ignore: cast_nullable_to_non_nullable
as double,maxLatitude: null == maxLatitude ? _self.maxLatitude : maxLatitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicityPmTilesBounds].
extension SeismicityPmTilesBoundsPatterns on SeismicityPmTilesBounds {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityPmTilesBounds value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityPmTilesBounds() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityPmTilesBounds value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityPmTilesBounds():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityPmTilesBounds value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityPmTilesBounds() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double minLongitude,  double minLatitude,  double maxLongitude,  double maxLatitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicityPmTilesBounds() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double minLongitude,  double minLatitude,  double maxLongitude,  double maxLatitude)  $default,) {final _that = this;
switch (_that) {
case _SeismicityPmTilesBounds():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double minLongitude,  double minLatitude,  double maxLongitude,  double maxLatitude)?  $default,) {final _that = this;
switch (_that) {
case _SeismicityPmTilesBounds() when $default != null:
return $default(_that.minLongitude,_that.minLatitude,_that.maxLongitude,_that.maxLatitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeismicityPmTilesBounds implements SeismicityPmTilesBounds {
  const _SeismicityPmTilesBounds({required this.minLongitude, required this.minLatitude, required this.maxLongitude, required this.maxLatitude});
  factory _SeismicityPmTilesBounds.fromJson(Map<String, dynamic> json) => _$SeismicityPmTilesBoundsFromJson(json);

@override final  double minLongitude;
@override final  double minLatitude;
@override final  double maxLongitude;
@override final  double maxLatitude;

/// Create a copy of SeismicityPmTilesBounds
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityPmTilesBoundsCopyWith<_SeismicityPmTilesBounds> get copyWith => __$SeismicityPmTilesBoundsCopyWithImpl<_SeismicityPmTilesBounds>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeismicityPmTilesBoundsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeismicityPmTilesBounds&&(identical(other.minLongitude, minLongitude) || other.minLongitude == minLongitude)&&(identical(other.minLatitude, minLatitude) || other.minLatitude == minLatitude)&&(identical(other.maxLongitude, maxLongitude) || other.maxLongitude == maxLongitude)&&(identical(other.maxLatitude, maxLatitude) || other.maxLatitude == maxLatitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minLongitude,minLatitude,maxLongitude,maxLatitude);

@override
String toString() {
  return 'SeismicityPmTilesBounds(minLongitude: $minLongitude, minLatitude: $minLatitude, maxLongitude: $maxLongitude, maxLatitude: $maxLatitude)';
}


}

/// @nodoc
abstract mixin class _$SeismicityPmTilesBoundsCopyWith<$Res> implements $SeismicityPmTilesBoundsCopyWith<$Res> {
  factory _$SeismicityPmTilesBoundsCopyWith(_SeismicityPmTilesBounds value, $Res Function(_SeismicityPmTilesBounds) _then) = __$SeismicityPmTilesBoundsCopyWithImpl;
@override @useResult
$Res call({
 double minLongitude, double minLatitude, double maxLongitude, double maxLatitude
});




}
/// @nodoc
class __$SeismicityPmTilesBoundsCopyWithImpl<$Res>
    implements _$SeismicityPmTilesBoundsCopyWith<$Res> {
  __$SeismicityPmTilesBoundsCopyWithImpl(this._self, this._then);

  final _SeismicityPmTilesBounds _self;
  final $Res Function(_SeismicityPmTilesBounds) _then;

/// Create a copy of SeismicityPmTilesBounds
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minLongitude = null,Object? minLatitude = null,Object? maxLongitude = null,Object? maxLatitude = null,}) {
  return _then(_SeismicityPmTilesBounds(
minLongitude: null == minLongitude ? _self.minLongitude : minLongitude // ignore: cast_nullable_to_non_nullable
as double,minLatitude: null == minLatitude ? _self.minLatitude : minLatitude // ignore: cast_nullable_to_non_nullable
as double,maxLongitude: null == maxLongitude ? _self.maxLongitude : maxLongitude // ignore: cast_nullable_to_non_nullable
as double,maxLatitude: null == maxLatitude ? _self.maxLatitude : maxLatitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
