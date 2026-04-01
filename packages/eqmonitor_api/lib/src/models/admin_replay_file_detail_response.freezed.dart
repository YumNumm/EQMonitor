// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_replay_file_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminReplayFileDetailResponse {

 AdminReplayFileDetailResponseItem get item;
/// Create a copy of AdminReplayFileDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminReplayFileDetailResponseCopyWith<AdminReplayFileDetailResponse> get copyWith => _$AdminReplayFileDetailResponseCopyWithImpl<AdminReplayFileDetailResponse>(this as AdminReplayFileDetailResponse, _$identity);

  /// Serializes this AdminReplayFileDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminReplayFileDetailResponse&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'AdminReplayFileDetailResponse(item: $item)';
}


}

/// @nodoc
abstract mixin class $AdminReplayFileDetailResponseCopyWith<$Res>  {
  factory $AdminReplayFileDetailResponseCopyWith(AdminReplayFileDetailResponse value, $Res Function(AdminReplayFileDetailResponse) _then) = _$AdminReplayFileDetailResponseCopyWithImpl;
@useResult
$Res call({
 AdminReplayFileDetailResponseItem item
});


$AdminReplayFileDetailResponseItemCopyWith<$Res> get item;

}
/// @nodoc
class _$AdminReplayFileDetailResponseCopyWithImpl<$Res>
    implements $AdminReplayFileDetailResponseCopyWith<$Res> {
  _$AdminReplayFileDetailResponseCopyWithImpl(this._self, this._then);

  final AdminReplayFileDetailResponse _self;
  final $Res Function(AdminReplayFileDetailResponse) _then;

/// Create a copy of AdminReplayFileDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item = null,}) {
  return _then(_self.copyWith(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as AdminReplayFileDetailResponseItem,
  ));
}
/// Create a copy of AdminReplayFileDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminReplayFileDetailResponseItemCopyWith<$Res> get item {
  
  return $AdminReplayFileDetailResponseItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminReplayFileDetailResponse].
extension AdminReplayFileDetailResponsePatterns on AdminReplayFileDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminReplayFileDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminReplayFileDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminReplayFileDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _AdminReplayFileDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminReplayFileDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AdminReplayFileDetailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AdminReplayFileDetailResponseItem item)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminReplayFileDetailResponse() when $default != null:
return $default(_that.item);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AdminReplayFileDetailResponseItem item)  $default,) {final _that = this;
switch (_that) {
case _AdminReplayFileDetailResponse():
return $default(_that.item);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AdminReplayFileDetailResponseItem item)?  $default,) {final _that = this;
switch (_that) {
case _AdminReplayFileDetailResponse() when $default != null:
return $default(_that.item);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminReplayFileDetailResponse implements AdminReplayFileDetailResponse {
  const _AdminReplayFileDetailResponse({required this.item});
  factory _AdminReplayFileDetailResponse.fromJson(Map<String, dynamic> json) => _$AdminReplayFileDetailResponseFromJson(json);

@override final  AdminReplayFileDetailResponseItem item;

/// Create a copy of AdminReplayFileDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminReplayFileDetailResponseCopyWith<_AdminReplayFileDetailResponse> get copyWith => __$AdminReplayFileDetailResponseCopyWithImpl<_AdminReplayFileDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminReplayFileDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminReplayFileDetailResponse&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'AdminReplayFileDetailResponse(item: $item)';
}


}

/// @nodoc
abstract mixin class _$AdminReplayFileDetailResponseCopyWith<$Res> implements $AdminReplayFileDetailResponseCopyWith<$Res> {
  factory _$AdminReplayFileDetailResponseCopyWith(_AdminReplayFileDetailResponse value, $Res Function(_AdminReplayFileDetailResponse) _then) = __$AdminReplayFileDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 AdminReplayFileDetailResponseItem item
});


@override $AdminReplayFileDetailResponseItemCopyWith<$Res> get item;

}
/// @nodoc
class __$AdminReplayFileDetailResponseCopyWithImpl<$Res>
    implements _$AdminReplayFileDetailResponseCopyWith<$Res> {
  __$AdminReplayFileDetailResponseCopyWithImpl(this._self, this._then);

  final _AdminReplayFileDetailResponse _self;
  final $Res Function(_AdminReplayFileDetailResponse) _then;

/// Create a copy of AdminReplayFileDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(_AdminReplayFileDetailResponse(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as AdminReplayFileDetailResponseItem,
  ));
}

/// Create a copy of AdminReplayFileDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminReplayFileDetailResponseItemCopyWith<$Res> get item {
  
  return $AdminReplayFileDetailResponseItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

// dart format on
