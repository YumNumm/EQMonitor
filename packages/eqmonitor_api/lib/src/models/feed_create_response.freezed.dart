// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_create_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedCreateResponse {

 String get id;
/// Create a copy of FeedCreateResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedCreateResponseCopyWith<FeedCreateResponse> get copyWith => _$FeedCreateResponseCopyWithImpl<FeedCreateResponse>(this as FeedCreateResponse, _$identity);

  /// Serializes this FeedCreateResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedCreateResponse&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'FeedCreateResponse(id: $id)';
}


}

/// @nodoc
abstract mixin class $FeedCreateResponseCopyWith<$Res>  {
  factory $FeedCreateResponseCopyWith(FeedCreateResponse value, $Res Function(FeedCreateResponse) _then) = _$FeedCreateResponseCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$FeedCreateResponseCopyWithImpl<$Res>
    implements $FeedCreateResponseCopyWith<$Res> {
  _$FeedCreateResponseCopyWithImpl(this._self, this._then);

  final FeedCreateResponse _self;
  final $Res Function(FeedCreateResponse) _then;

/// Create a copy of FeedCreateResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedCreateResponse].
extension FeedCreateResponsePatterns on FeedCreateResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedCreateResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedCreateResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedCreateResponse value)  $default,){
final _that = this;
switch (_that) {
case _FeedCreateResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedCreateResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FeedCreateResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedCreateResponse() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id)  $default,) {final _that = this;
switch (_that) {
case _FeedCreateResponse():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id)?  $default,) {final _that = this;
switch (_that) {
case _FeedCreateResponse() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedCreateResponse implements FeedCreateResponse {
  const _FeedCreateResponse({required this.id});
  factory _FeedCreateResponse.fromJson(Map<String, dynamic> json) => _$FeedCreateResponseFromJson(json);

@override final  String id;

/// Create a copy of FeedCreateResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedCreateResponseCopyWith<_FeedCreateResponse> get copyWith => __$FeedCreateResponseCopyWithImpl<_FeedCreateResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedCreateResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedCreateResponse&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'FeedCreateResponse(id: $id)';
}


}

/// @nodoc
abstract mixin class _$FeedCreateResponseCopyWith<$Res> implements $FeedCreateResponseCopyWith<$Res> {
  factory _$FeedCreateResponseCopyWith(_FeedCreateResponse value, $Res Function(_FeedCreateResponse) _then) = __$FeedCreateResponseCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$FeedCreateResponseCopyWithImpl<$Res>
    implements _$FeedCreateResponseCopyWith<$Res> {
  __$FeedCreateResponseCopyWithImpl(this._self, this._then);

  final _FeedCreateResponse _self;
  final $Res Function(_FeedCreateResponse) _then;

/// Create a copy of FeedCreateResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_FeedCreateResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
