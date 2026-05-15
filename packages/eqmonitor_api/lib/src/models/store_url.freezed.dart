// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_url.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoreUrl {

 String get ios; String get android;
/// Create a copy of StoreUrl
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreUrlCopyWith<StoreUrl> get copyWith => _$StoreUrlCopyWithImpl<StoreUrl>(this as StoreUrl, _$identity);

  /// Serializes this StoreUrl to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreUrl&&(identical(other.ios, ios) || other.ios == ios)&&(identical(other.android, android) || other.android == android));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ios,android);

@override
String toString() {
  return 'StoreUrl(ios: $ios, android: $android)';
}


}

/// @nodoc
abstract mixin class $StoreUrlCopyWith<$Res>  {
  factory $StoreUrlCopyWith(StoreUrl value, $Res Function(StoreUrl) _then) = _$StoreUrlCopyWithImpl;
@useResult
$Res call({
 String ios, String android
});




}
/// @nodoc
class _$StoreUrlCopyWithImpl<$Res>
    implements $StoreUrlCopyWith<$Res> {
  _$StoreUrlCopyWithImpl(this._self, this._then);

  final StoreUrl _self;
  final $Res Function(StoreUrl) _then;

/// Create a copy of StoreUrl
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ios = null,Object? android = null,}) {
  return _then(_self.copyWith(
ios: null == ios ? _self.ios : ios // ignore: cast_nullable_to_non_nullable
as String,android: null == android ? _self.android : android // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreUrl].
extension StoreUrlPatterns on StoreUrl {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreUrl value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreUrl() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreUrl value)  $default,){
final _that = this;
switch (_that) {
case _StoreUrl():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreUrl value)?  $default,){
final _that = this;
switch (_that) {
case _StoreUrl() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ios,  String android)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreUrl() when $default != null:
return $default(_that.ios,_that.android);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ios,  String android)  $default,) {final _that = this;
switch (_that) {
case _StoreUrl():
return $default(_that.ios,_that.android);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ios,  String android)?  $default,) {final _that = this;
switch (_that) {
case _StoreUrl() when $default != null:
return $default(_that.ios,_that.android);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoreUrl implements StoreUrl {
  const _StoreUrl({required this.ios, required this.android});
  factory _StoreUrl.fromJson(Map<String, dynamic> json) => _$StoreUrlFromJson(json);

@override final  String ios;
@override final  String android;

/// Create a copy of StoreUrl
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreUrlCopyWith<_StoreUrl> get copyWith => __$StoreUrlCopyWithImpl<_StoreUrl>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoreUrlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreUrl&&(identical(other.ios, ios) || other.ios == ios)&&(identical(other.android, android) || other.android == android));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ios,android);

@override
String toString() {
  return 'StoreUrl(ios: $ios, android: $android)';
}


}

/// @nodoc
abstract mixin class _$StoreUrlCopyWith<$Res> implements $StoreUrlCopyWith<$Res> {
  factory _$StoreUrlCopyWith(_StoreUrl value, $Res Function(_StoreUrl) _then) = __$StoreUrlCopyWithImpl;
@override @useResult
$Res call({
 String ios, String android
});




}
/// @nodoc
class __$StoreUrlCopyWithImpl<$Res>
    implements _$StoreUrlCopyWith<$Res> {
  __$StoreUrlCopyWithImpl(this._self, this._then);

  final _StoreUrl _self;
  final $Res Function(_StoreUrl) _then;

/// Create a copy of StoreUrl
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ios = null,Object? android = null,}) {
  return _then(_StoreUrl(
ios: null == ios ? _self.ios : ios // ignore: cast_nullable_to_non_nullable
as String,android: null == android ? _self.android : android // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
