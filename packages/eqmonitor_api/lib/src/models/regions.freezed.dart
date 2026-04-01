// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Regions {

 String get code; String get name; String get intensity;
/// Create a copy of Regions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionsCopyWith<Regions> get copyWith => _$RegionsCopyWithImpl<Regions>(this as Regions, _$identity);

  /// Serializes this Regions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Regions&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity);

@override
String toString() {
  return 'Regions(code: $code, name: $name, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $RegionsCopyWith<$Res>  {
  factory $RegionsCopyWith(Regions value, $Res Function(Regions) _then) = _$RegionsCopyWithImpl;
@useResult
$Res call({
 String code, String name, String intensity
});




}
/// @nodoc
class _$RegionsCopyWithImpl<$Res>
    implements $RegionsCopyWith<$Res> {
  _$RegionsCopyWithImpl(this._self, this._then);

  final Regions _self;
  final $Res Function(Regions) _then;

/// Create a copy of Regions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Regions].
extension RegionsPatterns on Regions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Regions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Regions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Regions value)  $default,){
final _that = this;
switch (_that) {
case _Regions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Regions value)?  $default,){
final _that = this;
switch (_that) {
case _Regions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  String intensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Regions() when $default != null:
return $default(_that.code,_that.name,_that.intensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  String intensity)  $default,) {final _that = this;
switch (_that) {
case _Regions():
return $default(_that.code,_that.name,_that.intensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  String intensity)?  $default,) {final _that = this;
switch (_that) {
case _Regions() when $default != null:
return $default(_that.code,_that.name,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Regions implements Regions {
  const _Regions({required this.code, required this.name, required this.intensity});
  factory _Regions.fromJson(Map<String, dynamic> json) => _$RegionsFromJson(json);

@override final  String code;
@override final  String name;
@override final  String intensity;

/// Create a copy of Regions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionsCopyWith<_Regions> get copyWith => __$RegionsCopyWithImpl<_Regions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Regions&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity);

@override
String toString() {
  return 'Regions(code: $code, name: $name, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$RegionsCopyWith<$Res> implements $RegionsCopyWith<$Res> {
  factory _$RegionsCopyWith(_Regions value, $Res Function(_Regions) _then) = __$RegionsCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String intensity
});




}
/// @nodoc
class __$RegionsCopyWithImpl<$Res>
    implements _$RegionsCopyWith<$Res> {
  __$RegionsCopyWithImpl(this._self, this._then);

  final _Regions _self;
  final $Res Function(_Regions) _then;

/// Create a copy of Regions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = null,}) {
  return _then(_Regions(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
