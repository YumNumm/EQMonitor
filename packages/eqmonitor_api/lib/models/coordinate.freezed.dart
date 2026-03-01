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

/// @nodoc
mixin _$Coordinate {

 CoordinateType get type;/// 緯度(typeがLAT_LNGのときのみ出現する)
@JsonKey(includeIfNull: false) num? get latitude;/// 経度(typeがLAT_LNGのときのみ出現する)
@JsonKey(includeIfNull: false) num? get longitude;/// 不明の場合のみ出現する
@JsonKey(includeIfNull: false) String? get condition;
/// Create a copy of Coordinate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoordinateCopyWith<Coordinate> get copyWith => _$CoordinateCopyWithImpl<Coordinate>(this as Coordinate, _$identity);

  /// Serializes this Coordinate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Coordinate&&(identical(other.type, type) || other.type == type)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,latitude,longitude,condition);

@override
String toString() {
  return 'Coordinate(type: $type, latitude: $latitude, longitude: $longitude, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $CoordinateCopyWith<$Res>  {
  factory $CoordinateCopyWith(Coordinate value, $Res Function(Coordinate) _then) = _$CoordinateCopyWithImpl;
@useResult
$Res call({
 CoordinateType type,@JsonKey(includeIfNull: false) num? latitude,@JsonKey(includeIfNull: false) num? longitude,@JsonKey(includeIfNull: false) String? condition
});




}
/// @nodoc
class _$CoordinateCopyWithImpl<$Res>
    implements $CoordinateCopyWith<$Res> {
  _$CoordinateCopyWithImpl(this._self, this._then);

  final Coordinate _self;
  final $Res Function(Coordinate) _then;

/// Create a copy of Coordinate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? latitude = freezed,Object? longitude = freezed,Object? condition = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CoordinateType,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Coordinate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Coordinate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Coordinate value)  $default,){
final _that = this;
switch (_that) {
case _Coordinate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Coordinate value)?  $default,){
final _that = this;
switch (_that) {
case _Coordinate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CoordinateType type, @JsonKey(includeIfNull: false)  num? latitude, @JsonKey(includeIfNull: false)  num? longitude, @JsonKey(includeIfNull: false)  String? condition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Coordinate() when $default != null:
return $default(_that.type,_that.latitude,_that.longitude,_that.condition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CoordinateType type, @JsonKey(includeIfNull: false)  num? latitude, @JsonKey(includeIfNull: false)  num? longitude, @JsonKey(includeIfNull: false)  String? condition)  $default,) {final _that = this;
switch (_that) {
case _Coordinate():
return $default(_that.type,_that.latitude,_that.longitude,_that.condition);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CoordinateType type, @JsonKey(includeIfNull: false)  num? latitude, @JsonKey(includeIfNull: false)  num? longitude, @JsonKey(includeIfNull: false)  String? condition)?  $default,) {final _that = this;
switch (_that) {
case _Coordinate() when $default != null:
return $default(_that.type,_that.latitude,_that.longitude,_that.condition);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Coordinate implements Coordinate {
  const _Coordinate({required this.type, @JsonKey(includeIfNull: false) this.latitude, @JsonKey(includeIfNull: false) this.longitude, @JsonKey(includeIfNull: false) this.condition});
  factory _Coordinate.fromJson(Map<String, dynamic> json) => _$CoordinateFromJson(json);

@override final  CoordinateType type;
/// 緯度(typeがLAT_LNGのときのみ出現する)
@override@JsonKey(includeIfNull: false) final  num? latitude;
/// 経度(typeがLAT_LNGのときのみ出現する)
@override@JsonKey(includeIfNull: false) final  num? longitude;
/// 不明の場合のみ出現する
@override@JsonKey(includeIfNull: false) final  String? condition;

/// Create a copy of Coordinate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoordinateCopyWith<_Coordinate> get copyWith => __$CoordinateCopyWithImpl<_Coordinate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoordinateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Coordinate&&(identical(other.type, type) || other.type == type)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,latitude,longitude,condition);

@override
String toString() {
  return 'Coordinate(type: $type, latitude: $latitude, longitude: $longitude, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$CoordinateCopyWith<$Res> implements $CoordinateCopyWith<$Res> {
  factory _$CoordinateCopyWith(_Coordinate value, $Res Function(_Coordinate) _then) = __$CoordinateCopyWithImpl;
@override @useResult
$Res call({
 CoordinateType type,@JsonKey(includeIfNull: false) num? latitude,@JsonKey(includeIfNull: false) num? longitude,@JsonKey(includeIfNull: false) String? condition
});




}
/// @nodoc
class __$CoordinateCopyWithImpl<$Res>
    implements _$CoordinateCopyWith<$Res> {
  __$CoordinateCopyWithImpl(this._self, this._then);

  final _Coordinate _self;
  final $Res Function(_Coordinate) _then;

/// Create a copy of Coordinate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? latitude = freezed,Object? longitude = freezed,Object? condition = freezed,}) {
  return _then(_Coordinate(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CoordinateType,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
