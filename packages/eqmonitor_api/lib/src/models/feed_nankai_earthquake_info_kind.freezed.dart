// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_nankai_earthquake_info_kind.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedNankaiEarthquakeInfoKind {

 String get code; String get name;
/// Create a copy of FeedNankaiEarthquakeInfoKind
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedNankaiEarthquakeInfoKindCopyWith<FeedNankaiEarthquakeInfoKind> get copyWith => _$FeedNankaiEarthquakeInfoKindCopyWithImpl<FeedNankaiEarthquakeInfoKind>(this as FeedNankaiEarthquakeInfoKind, _$identity);

  /// Serializes this FeedNankaiEarthquakeInfoKind to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedNankaiEarthquakeInfoKind&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'FeedNankaiEarthquakeInfoKind(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $FeedNankaiEarthquakeInfoKindCopyWith<$Res>  {
  factory $FeedNankaiEarthquakeInfoKindCopyWith(FeedNankaiEarthquakeInfoKind value, $Res Function(FeedNankaiEarthquakeInfoKind) _then) = _$FeedNankaiEarthquakeInfoKindCopyWithImpl;
@useResult
$Res call({
 String code, String name
});




}
/// @nodoc
class _$FeedNankaiEarthquakeInfoKindCopyWithImpl<$Res>
    implements $FeedNankaiEarthquakeInfoKindCopyWith<$Res> {
  _$FeedNankaiEarthquakeInfoKindCopyWithImpl(this._self, this._then);

  final FeedNankaiEarthquakeInfoKind _self;
  final $Res Function(FeedNankaiEarthquakeInfoKind) _then;

/// Create a copy of FeedNankaiEarthquakeInfoKind
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,}) {
  return _then(FeedNankaiEarthquakeInfoKind(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedNankaiEarthquakeInfoKind].
extension FeedNankaiEarthquakeInfoKindPatterns on FeedNankaiEarthquakeInfoKind {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedNankaiEarthquakeInfoKind value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfoKind() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedNankaiEarthquakeInfoKind value)  $default,){
final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfoKind():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedNankaiEarthquakeInfoKind value)?  $default,){
final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfoKind() when $default != null:
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
case _FeedNankaiEarthquakeInfoKind() when $default != null:
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
case _FeedNankaiEarthquakeInfoKind():
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
case _FeedNankaiEarthquakeInfoKind() when $default != null:
return $default(_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedNankaiEarthquakeInfoKind implements FeedNankaiEarthquakeInfoKind {
  const _FeedNankaiEarthquakeInfoKind({required this.code, required this.name});
  factory _FeedNankaiEarthquakeInfoKind.fromJson(Map<String, dynamic> json) => _$FeedNankaiEarthquakeInfoKindFromJson(json);

@override final  String code;
@override final  String name;

/// Create a copy of FeedNankaiEarthquakeInfoKind
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedNankaiEarthquakeInfoKindCopyWith<_FeedNankaiEarthquakeInfoKind> get copyWith => __$FeedNankaiEarthquakeInfoKindCopyWithImpl<_FeedNankaiEarthquakeInfoKind>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedNankaiEarthquakeInfoKindToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedNankaiEarthquakeInfoKind&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'FeedNankaiEarthquakeInfoKind(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$FeedNankaiEarthquakeInfoKindCopyWith<$Res> implements $FeedNankaiEarthquakeInfoKindCopyWith<$Res> {
  factory _$FeedNankaiEarthquakeInfoKindCopyWith(_FeedNankaiEarthquakeInfoKind value, $Res Function(_FeedNankaiEarthquakeInfoKind) _then) = __$FeedNankaiEarthquakeInfoKindCopyWithImpl;
@override @useResult
$Res call({
 String code, String name
});




}
/// @nodoc
class __$FeedNankaiEarthquakeInfoKindCopyWithImpl<$Res>
    implements _$FeedNankaiEarthquakeInfoKindCopyWith<$Res> {
  __$FeedNankaiEarthquakeInfoKindCopyWithImpl(this._self, this._then);

  final _FeedNankaiEarthquakeInfoKind _self;
  final $Res Function(_FeedNankaiEarthquakeInfoKind) _then;

/// Create a copy of FeedNankaiEarthquakeInfoKind
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,}) {
  return _then(_FeedNankaiEarthquakeInfoKind(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
