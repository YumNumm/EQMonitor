// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegionPayload {

 LocationPayload get topLeft; LocationPayload get bottomRight;
/// Create a copy of RegionPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionPayloadCopyWith<RegionPayload> get copyWith => _$RegionPayloadCopyWithImpl<RegionPayload>(this as RegionPayload, _$identity);

  /// Serializes this RegionPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionPayload&&(identical(other.topLeft, topLeft) || other.topLeft == topLeft)&&(identical(other.bottomRight, bottomRight) || other.bottomRight == bottomRight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topLeft,bottomRight);

@override
String toString() {
  return 'RegionPayload(topLeft: $topLeft, bottomRight: $bottomRight)';
}


}

/// @nodoc
abstract mixin class $RegionPayloadCopyWith<$Res>  {
  factory $RegionPayloadCopyWith(RegionPayload value, $Res Function(RegionPayload) _then) = _$RegionPayloadCopyWithImpl;
@useResult
$Res call({
 LocationPayload topLeft, LocationPayload bottomRight
});


$LocationPayloadCopyWith<$Res> get topLeft;$LocationPayloadCopyWith<$Res> get bottomRight;

}
/// @nodoc
class _$RegionPayloadCopyWithImpl<$Res>
    implements $RegionPayloadCopyWith<$Res> {
  _$RegionPayloadCopyWithImpl(this._self, this._then);

  final RegionPayload _self;
  final $Res Function(RegionPayload) _then;

/// Create a copy of RegionPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topLeft = null,Object? bottomRight = null,}) {
  return _then(_self.copyWith(
topLeft: null == topLeft ? _self.topLeft : topLeft // ignore: cast_nullable_to_non_nullable
as LocationPayload,bottomRight: null == bottomRight ? _self.bottomRight : bottomRight // ignore: cast_nullable_to_non_nullable
as LocationPayload,
  ));
}
/// Create a copy of RegionPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationPayloadCopyWith<$Res> get topLeft {
  
  return $LocationPayloadCopyWith<$Res>(_self.topLeft, (value) {
    return _then(_self.copyWith(topLeft: value));
  });
}/// Create a copy of RegionPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationPayloadCopyWith<$Res> get bottomRight {
  
  return $LocationPayloadCopyWith<$Res>(_self.bottomRight, (value) {
    return _then(_self.copyWith(bottomRight: value));
  });
}
}


/// Adds pattern-matching-related methods to [RegionPayload].
extension RegionPayloadPatterns on RegionPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionPayload value)  $default,){
final _that = this;
switch (_that) {
case _RegionPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionPayload value)?  $default,){
final _that = this;
switch (_that) {
case _RegionPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocationPayload topLeft,  LocationPayload bottomRight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionPayload() when $default != null:
return $default(_that.topLeft,_that.bottomRight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocationPayload topLeft,  LocationPayload bottomRight)  $default,) {final _that = this;
switch (_that) {
case _RegionPayload():
return $default(_that.topLeft,_that.bottomRight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocationPayload topLeft,  LocationPayload bottomRight)?  $default,) {final _that = this;
switch (_that) {
case _RegionPayload() when $default != null:
return $default(_that.topLeft,_that.bottomRight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionPayload implements RegionPayload {
  const _RegionPayload({required this.topLeft, required this.bottomRight});
  factory _RegionPayload.fromJson(Map<String, dynamic> json) => _$RegionPayloadFromJson(json);

@override final  LocationPayload topLeft;
@override final  LocationPayload bottomRight;

/// Create a copy of RegionPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionPayloadCopyWith<_RegionPayload> get copyWith => __$RegionPayloadCopyWithImpl<_RegionPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionPayload&&(identical(other.topLeft, topLeft) || other.topLeft == topLeft)&&(identical(other.bottomRight, bottomRight) || other.bottomRight == bottomRight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topLeft,bottomRight);

@override
String toString() {
  return 'RegionPayload(topLeft: $topLeft, bottomRight: $bottomRight)';
}


}

/// @nodoc
abstract mixin class _$RegionPayloadCopyWith<$Res> implements $RegionPayloadCopyWith<$Res> {
  factory _$RegionPayloadCopyWith(_RegionPayload value, $Res Function(_RegionPayload) _then) = __$RegionPayloadCopyWithImpl;
@override @useResult
$Res call({
 LocationPayload topLeft, LocationPayload bottomRight
});


@override $LocationPayloadCopyWith<$Res> get topLeft;@override $LocationPayloadCopyWith<$Res> get bottomRight;

}
/// @nodoc
class __$RegionPayloadCopyWithImpl<$Res>
    implements _$RegionPayloadCopyWith<$Res> {
  __$RegionPayloadCopyWithImpl(this._self, this._then);

  final _RegionPayload _self;
  final $Res Function(_RegionPayload) _then;

/// Create a copy of RegionPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topLeft = null,Object? bottomRight = null,}) {
  return _then(_RegionPayload(
topLeft: null == topLeft ? _self.topLeft : topLeft // ignore: cast_nullable_to_non_nullable
as LocationPayload,bottomRight: null == bottomRight ? _self.bottomRight : bottomRight // ignore: cast_nullable_to_non_nullable
as LocationPayload,
  ));
}

/// Create a copy of RegionPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationPayloadCopyWith<$Res> get topLeft {
  
  return $LocationPayloadCopyWith<$Res>(_self.topLeft, (value) {
    return _then(_self.copyWith(topLeft: value));
  });
}/// Create a copy of RegionPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationPayloadCopyWith<$Res> get bottomRight {
  
  return $LocationPayloadCopyWith<$Res>(_self.bottomRight, (value) {
    return _then(_self.copyWith(bottomRight: value));
  });
}
}

// dart format on
