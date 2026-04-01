// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prefectures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Prefectures {

 String get code; String get name; String get intensity;
/// Create a copy of Prefectures
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrefecturesCopyWith<Prefectures> get copyWith => _$PrefecturesCopyWithImpl<Prefectures>(this as Prefectures, _$identity);

  /// Serializes this Prefectures to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Prefectures&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity);

@override
String toString() {
  return 'Prefectures(code: $code, name: $name, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $PrefecturesCopyWith<$Res>  {
  factory $PrefecturesCopyWith(Prefectures value, $Res Function(Prefectures) _then) = _$PrefecturesCopyWithImpl;
@useResult
$Res call({
 String code, String name, String intensity
});




}
/// @nodoc
class _$PrefecturesCopyWithImpl<$Res>
    implements $PrefecturesCopyWith<$Res> {
  _$PrefecturesCopyWithImpl(this._self, this._then);

  final Prefectures _self;
  final $Res Function(Prefectures) _then;

/// Create a copy of Prefectures
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


/// Adds pattern-matching-related methods to [Prefectures].
extension PrefecturesPatterns on Prefectures {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Prefectures value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Prefectures() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Prefectures value)  $default,){
final _that = this;
switch (_that) {
case _Prefectures():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Prefectures value)?  $default,){
final _that = this;
switch (_that) {
case _Prefectures() when $default != null:
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
case _Prefectures() when $default != null:
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
case _Prefectures():
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
case _Prefectures() when $default != null:
return $default(_that.code,_that.name,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Prefectures implements Prefectures {
  const _Prefectures({required this.code, required this.name, required this.intensity});
  factory _Prefectures.fromJson(Map<String, dynamic> json) => _$PrefecturesFromJson(json);

@override final  String code;
@override final  String name;
@override final  String intensity;

/// Create a copy of Prefectures
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrefecturesCopyWith<_Prefectures> get copyWith => __$PrefecturesCopyWithImpl<_Prefectures>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrefecturesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Prefectures&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity);

@override
String toString() {
  return 'Prefectures(code: $code, name: $name, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$PrefecturesCopyWith<$Res> implements $PrefecturesCopyWith<$Res> {
  factory _$PrefecturesCopyWith(_Prefectures value, $Res Function(_Prefectures) _then) = __$PrefecturesCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String intensity
});




}
/// @nodoc
class __$PrefecturesCopyWithImpl<$Res>
    implements _$PrefecturesCopyWith<$Res> {
  __$PrefecturesCopyWithImpl(this._self, this._then);

  final _Prefectures _self;
  final $Res Function(_Prefectures) _then;

/// Create a copy of Prefectures
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = null,}) {
  return _then(_Prefectures(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
