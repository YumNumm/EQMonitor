// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coordinate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Coordinate _$CoordinateFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'LAT_LNG':
          return CoordinateLatLng.fromJson(
            json
          );
                case 'UNKNOWN':
          return CoordinateUnknown.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'Coordinate',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$Coordinate {



  /// Serializes this Coordinate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Coordinate);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Coordinate()';
}


}

/// @nodoc
class $CoordinateCopyWith<$Res>  {
$CoordinateCopyWith(Coordinate _, $Res Function(Coordinate) __);
}


/// Adds pattern-matching-related methods to [Coordinate].
extension CoordinatePatterns on Coordinate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CoordinateLatLng value)?  latLng,TResult Function( CoordinateUnknown value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CoordinateLatLng() when latLng != null:
return latLng(_that);case CoordinateUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CoordinateLatLng value)  latLng,required TResult Function( CoordinateUnknown value)  unknown,}){
final _that = this;
switch (_that) {
case CoordinateLatLng():
return latLng(_that);case CoordinateUnknown():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CoordinateLatLng value)?  latLng,TResult? Function( CoordinateUnknown value)?  unknown,}){
final _that = this;
switch (_that) {
case CoordinateLatLng() when latLng != null:
return latLng(_that);case CoordinateUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( double latitude,  double longitude)?  latLng,TResult Function( String condition)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CoordinateLatLng() when latLng != null:
return latLng(_that.latitude,_that.longitude);case CoordinateUnknown() when unknown != null:
return unknown(_that.condition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( double latitude,  double longitude)  latLng,required TResult Function( String condition)  unknown,}) {final _that = this;
switch (_that) {
case CoordinateLatLng():
return latLng(_that.latitude,_that.longitude);case CoordinateUnknown():
return unknown(_that.condition);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( double latitude,  double longitude)?  latLng,TResult? Function( String condition)?  unknown,}) {final _that = this;
switch (_that) {
case CoordinateLatLng() when latLng != null:
return latLng(_that.latitude,_that.longitude);case CoordinateUnknown() when unknown != null:
return unknown(_that.condition);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class CoordinateLatLng implements Coordinate {
  const CoordinateLatLng({required this.latitude, required this.longitude, final  String? $type}): $type = $type ?? 'LAT_LNG';
  factory CoordinateLatLng.fromJson(Map<String, dynamic> json) => _$CoordinateLatLngFromJson(json);

 final  double latitude;
 final  double longitude;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Coordinate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoordinateLatLngCopyWith<CoordinateLatLng> get copyWith => _$CoordinateLatLngCopyWithImpl<CoordinateLatLng>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoordinateLatLngToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoordinateLatLng&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'Coordinate.latLng(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $CoordinateLatLngCopyWith<$Res> implements $CoordinateCopyWith<$Res> {
  factory $CoordinateLatLngCopyWith(CoordinateLatLng value, $Res Function(CoordinateLatLng) _then) = _$CoordinateLatLngCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class _$CoordinateLatLngCopyWithImpl<$Res>
    implements $CoordinateLatLngCopyWith<$Res> {
  _$CoordinateLatLngCopyWithImpl(this._self, this._then);

  final CoordinateLatLng _self;
  final $Res Function(CoordinateLatLng) _then;

/// Create a copy of Coordinate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(CoordinateLatLng(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CoordinateUnknown implements Coordinate {
  const CoordinateUnknown({required this.condition, final  String? $type}): $type = $type ?? 'UNKNOWN';
  factory CoordinateUnknown.fromJson(Map<String, dynamic> json) => _$CoordinateUnknownFromJson(json);

 final  String condition;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Coordinate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoordinateUnknownCopyWith<CoordinateUnknown> get copyWith => _$CoordinateUnknownCopyWithImpl<CoordinateUnknown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoordinateUnknownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoordinateUnknown&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,condition);

@override
String toString() {
  return 'Coordinate.unknown(condition: $condition)';
}


}

/// @nodoc
abstract mixin class $CoordinateUnknownCopyWith<$Res> implements $CoordinateCopyWith<$Res> {
  factory $CoordinateUnknownCopyWith(CoordinateUnknown value, $Res Function(CoordinateUnknown) _then) = _$CoordinateUnknownCopyWithImpl;
@useResult
$Res call({
 String condition
});




}
/// @nodoc
class _$CoordinateUnknownCopyWithImpl<$Res>
    implements $CoordinateUnknownCopyWith<$Res> {
  _$CoordinateUnknownCopyWithImpl(this._self, this._then);

  final CoordinateUnknown _self;
  final $Res Function(CoordinateUnknown) _then;

/// Create a copy of Coordinate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? condition = null,}) {
  return _then(CoordinateUnknown(
condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
