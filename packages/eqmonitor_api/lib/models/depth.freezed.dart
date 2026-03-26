// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'depth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Depth {

 DepthType get type;/// typeがNORMALのときのみ出現する
@JsonKey(includeIfNull: false) num? get value;
/// Create a copy of Depth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepthCopyWith<Depth> get copyWith => _$DepthCopyWithImpl<Depth>(this as Depth, _$identity);

  /// Serializes this Depth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Depth&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,value);

@override
String toString() {
  return 'Depth(type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class $DepthCopyWith<$Res>  {
  factory $DepthCopyWith(Depth value, $Res Function(Depth) _then) = _$DepthCopyWithImpl;
@useResult
$Res call({
 DepthType type,@JsonKey(includeIfNull: false) num? value
});




}
/// @nodoc
class _$DepthCopyWithImpl<$Res>
    implements $DepthCopyWith<$Res> {
  _$DepthCopyWithImpl(this._self, this._then);

  final Depth _self;
  final $Res Function(Depth) _then;

/// Create a copy of Depth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? value = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DepthType,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [Depth].
extension DepthPatterns on Depth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Depth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Depth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Depth value)  $default,){
final _that = this;
switch (_that) {
case _Depth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Depth value)?  $default,){
final _that = this;
switch (_that) {
case _Depth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DepthType type, @JsonKey(includeIfNull: false)  num? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Depth() when $default != null:
return $default(_that.type,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DepthType type, @JsonKey(includeIfNull: false)  num? value)  $default,) {final _that = this;
switch (_that) {
case _Depth():
return $default(_that.type,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DepthType type, @JsonKey(includeIfNull: false)  num? value)?  $default,) {final _that = this;
switch (_that) {
case _Depth() when $default != null:
return $default(_that.type,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Depth implements Depth {
  const _Depth({required this.type, @JsonKey(includeIfNull: false) this.value});
  factory _Depth.fromJson(Map<String, dynamic> json) => _$DepthFromJson(json);

@override final  DepthType type;
/// typeがNORMALのときのみ出現する
@override@JsonKey(includeIfNull: false) final  num? value;

/// Create a copy of Depth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepthCopyWith<_Depth> get copyWith => __$DepthCopyWithImpl<_Depth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DepthToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Depth&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,value);

@override
String toString() {
  return 'Depth(type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class _$DepthCopyWith<$Res> implements $DepthCopyWith<$Res> {
  factory _$DepthCopyWith(_Depth value, $Res Function(_Depth) _then) = __$DepthCopyWithImpl;
@override @useResult
$Res call({
 DepthType type,@JsonKey(includeIfNull: false) num? value
});




}
/// @nodoc
class __$DepthCopyWithImpl<$Res>
    implements _$DepthCopyWith<$Res> {
  __$DepthCopyWithImpl(this._self, this._then);

  final _Depth _self;
  final $Res Function(_Depth) _then;

/// Create a copy of Depth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? value = freezed,}) {
  return _then(_Depth(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DepthType,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
