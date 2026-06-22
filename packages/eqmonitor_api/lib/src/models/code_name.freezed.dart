// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'code_name.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CodeName {

/// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
 String get code; String get name;
/// Create a copy of CodeName
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodeNameCopyWith<CodeName> get copyWith => _$CodeNameCopyWithImpl<CodeName>(this as CodeName, _$identity);

  /// Serializes this CodeName to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodeName&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'CodeName(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $CodeNameCopyWith<$Res>  {
  factory $CodeNameCopyWith(CodeName value, $Res Function(CodeName) _then) = _$CodeNameCopyWithImpl;
@useResult
$Res call({
 String code, String name
});




}
/// @nodoc
class _$CodeNameCopyWithImpl<$Res>
    implements $CodeNameCopyWith<$Res> {
  _$CodeNameCopyWithImpl(this._self, this._then);

  final CodeName _self;
  final $Res Function(CodeName) _then;

/// Create a copy of CodeName
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CodeName].
extension CodeNamePatterns on CodeName {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CodeName value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CodeName() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CodeName value)  $default,){
final _that = this;
switch (_that) {
case _CodeName():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CodeName value)?  $default,){
final _that = this;
switch (_that) {
case _CodeName() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CodeName() when $default != null:
return $default(_that.code,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name)  $default,) {final _that = this;
switch (_that) {
case _CodeName():
return $default(_that.code,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name)?  $default,) {final _that = this;
switch (_that) {
case _CodeName() when $default != null:
return $default(_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CodeName implements CodeName {
  const _CodeName({required this.code, required this.name});
  factory _CodeName.fromJson(Map<String, dynamic> json) => _$CodeNameFromJson(json);

/// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
@override final  String code;
@override final  String name;

/// Create a copy of CodeName
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CodeNameCopyWith<_CodeName> get copyWith => __$CodeNameCopyWithImpl<_CodeName>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CodeNameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodeName&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'CodeName(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$CodeNameCopyWith<$Res> implements $CodeNameCopyWith<$Res> {
  factory _$CodeNameCopyWith(_CodeName value, $Res Function(_CodeName) _then) = __$CodeNameCopyWithImpl;
@override @useResult
$Res call({
 String code, String name
});




}
/// @nodoc
class __$CodeNameCopyWithImpl<$Res>
    implements _$CodeNameCopyWith<$Res> {
  __$CodeNameCopyWithImpl(this._self, this._then);

  final _CodeName _self;
  final $Res Function(_CodeName) _then;

/// Create a copy of CodeName
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,}) {
  return _then(_CodeName(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
