// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'epicenter_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EpicenterInfo {

 num get code; String get name;
/// Create a copy of EpicenterInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpicenterInfoCopyWith<EpicenterInfo> get copyWith => _$EpicenterInfoCopyWithImpl<EpicenterInfo>(this as EpicenterInfo, _$identity);

  /// Serializes this EpicenterInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EpicenterInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'EpicenterInfo(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $EpicenterInfoCopyWith<$Res>  {
  factory $EpicenterInfoCopyWith(EpicenterInfo value, $Res Function(EpicenterInfo) _then) = _$EpicenterInfoCopyWithImpl;
@useResult
$Res call({
 num code, String name
});




}
/// @nodoc
class _$EpicenterInfoCopyWithImpl<$Res>
    implements $EpicenterInfoCopyWith<$Res> {
  _$EpicenterInfoCopyWithImpl(this._self, this._then);

  final EpicenterInfo _self;
  final $Res Function(EpicenterInfo) _then;

/// Create a copy of EpicenterInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as num,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EpicenterInfo].
extension EpicenterInfoPatterns on EpicenterInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EpicenterInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EpicenterInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EpicenterInfo value)  $default,){
final _that = this;
switch (_that) {
case _EpicenterInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EpicenterInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EpicenterInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num code,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EpicenterInfo() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num code,  String name)  $default,) {final _that = this;
switch (_that) {
case _EpicenterInfo():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num code,  String name)?  $default,) {final _that = this;
switch (_that) {
case _EpicenterInfo() when $default != null:
return $default(_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EpicenterInfo implements EpicenterInfo {
  const _EpicenterInfo({required this.code, required this.name});
  factory _EpicenterInfo.fromJson(Map<String, dynamic> json) => _$EpicenterInfoFromJson(json);

@override final  num code;
@override final  String name;

/// Create a copy of EpicenterInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpicenterInfoCopyWith<_EpicenterInfo> get copyWith => __$EpicenterInfoCopyWithImpl<_EpicenterInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EpicenterInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EpicenterInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'EpicenterInfo(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$EpicenterInfoCopyWith<$Res> implements $EpicenterInfoCopyWith<$Res> {
  factory _$EpicenterInfoCopyWith(_EpicenterInfo value, $Res Function(_EpicenterInfo) _then) = __$EpicenterInfoCopyWithImpl;
@override @useResult
$Res call({
 num code, String name
});




}
/// @nodoc
class __$EpicenterInfoCopyWithImpl<$Res>
    implements _$EpicenterInfoCopyWith<$Res> {
  __$EpicenterInfoCopyWithImpl(this._self, this._then);

  final _EpicenterInfo _self;
  final $Res Function(_EpicenterInfo) _then;

/// Create a copy of EpicenterInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,}) {
  return _then(_EpicenterInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as num,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
