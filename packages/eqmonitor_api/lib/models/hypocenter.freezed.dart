// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Hypocenter {

 num get latitude; num get longitude; num get depth;@JsonKey(includeIfNull: false) String? get name;
/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterCopyWith<Hypocenter> get copyWith => _$HypocenterCopyWithImpl<Hypocenter>(this as Hypocenter, _$identity);

  /// Serializes this Hypocenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Hypocenter&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,depth,name);

@override
String toString() {
  return 'Hypocenter(latitude: $latitude, longitude: $longitude, depth: $depth, name: $name)';
}


}

/// @nodoc
abstract mixin class $HypocenterCopyWith<$Res>  {
  factory $HypocenterCopyWith(Hypocenter value, $Res Function(Hypocenter) _then) = _$HypocenterCopyWithImpl;
@useResult
$Res call({
 num latitude, num longitude, num depth,@JsonKey(includeIfNull: false) String? name
});




}
/// @nodoc
class _$HypocenterCopyWithImpl<$Res>
    implements $HypocenterCopyWith<$Res> {
  _$HypocenterCopyWithImpl(this._self, this._then);

  final Hypocenter _self;
  final $Res Function(Hypocenter) _then;

/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? depth = null,Object? name = freezed,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as num,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Hypocenter].
extension HypocenterPatterns on Hypocenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Hypocenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hypocenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Hypocenter value)  $default,){
final _that = this;
switch (_that) {
case _Hypocenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Hypocenter value)?  $default,){
final _that = this;
switch (_that) {
case _Hypocenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num latitude,  num longitude,  num depth, @JsonKey(includeIfNull: false)  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hypocenter() when $default != null:
return $default(_that.latitude,_that.longitude,_that.depth,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num latitude,  num longitude,  num depth, @JsonKey(includeIfNull: false)  String? name)  $default,) {final _that = this;
switch (_that) {
case _Hypocenter():
return $default(_that.latitude,_that.longitude,_that.depth,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num latitude,  num longitude,  num depth, @JsonKey(includeIfNull: false)  String? name)?  $default,) {final _that = this;
switch (_that) {
case _Hypocenter() when $default != null:
return $default(_that.latitude,_that.longitude,_that.depth,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Hypocenter implements Hypocenter {
  const _Hypocenter({required this.latitude, required this.longitude, required this.depth, @JsonKey(includeIfNull: false) this.name});
  factory _Hypocenter.fromJson(Map<String, dynamic> json) => _$HypocenterFromJson(json);

@override final  num latitude;
@override final  num longitude;
@override final  num depth;
@override@JsonKey(includeIfNull: false) final  String? name;

/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterCopyWith<_Hypocenter> get copyWith => __$HypocenterCopyWithImpl<_Hypocenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HypocenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hypocenter&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,depth,name);

@override
String toString() {
  return 'Hypocenter(latitude: $latitude, longitude: $longitude, depth: $depth, name: $name)';
}


}

/// @nodoc
abstract mixin class _$HypocenterCopyWith<$Res> implements $HypocenterCopyWith<$Res> {
  factory _$HypocenterCopyWith(_Hypocenter value, $Res Function(_Hypocenter) _then) = __$HypocenterCopyWithImpl;
@override @useResult
$Res call({
 num latitude, num longitude, num depth,@JsonKey(includeIfNull: false) String? name
});




}
/// @nodoc
class __$HypocenterCopyWithImpl<$Res>
    implements _$HypocenterCopyWith<$Res> {
  __$HypocenterCopyWithImpl(this._self, this._then);

  final _Hypocenter _self;
  final $Res Function(_Hypocenter) _then;

/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? depth = null,Object? name = freezed,}) {
  return _then(_Hypocenter(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as num,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
