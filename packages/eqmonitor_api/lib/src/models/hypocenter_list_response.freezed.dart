// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HypocenterListResponse {

 Data3 get data; HypocenterMeta get meta;
/// Create a copy of HypocenterListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterListResponseCopyWith<HypocenterListResponse> get copyWith => _$HypocenterListResponseCopyWithImpl<HypocenterListResponse>(this as HypocenterListResponse, _$identity);

  /// Serializes this HypocenterListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterListResponse&&(identical(other.data, data) || other.data == data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data,meta);

@override
String toString() {
  return 'HypocenterListResponse(data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class $HypocenterListResponseCopyWith<$Res>  {
  factory $HypocenterListResponseCopyWith(HypocenterListResponse value, $Res Function(HypocenterListResponse) _then) = _$HypocenterListResponseCopyWithImpl;
@useResult
$Res call({
 Data3 data, HypocenterMeta meta
});


$Data3CopyWith<$Res> get data;$HypocenterMetaCopyWith<$Res> get meta;

}
/// @nodoc
class _$HypocenterListResponseCopyWithImpl<$Res>
    implements $HypocenterListResponseCopyWith<$Res> {
  _$HypocenterListResponseCopyWithImpl(this._self, this._then);

  final HypocenterListResponse _self;
  final $Res Function(HypocenterListResponse) _then;

/// Create a copy of HypocenterListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? meta = null,}) {
  return _then(HypocenterListResponse(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data3,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as HypocenterMeta,
  ));
}
/// Create a copy of HypocenterListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data3CopyWith<$Res> get data {
  
  return $Data3CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of HypocenterListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterMetaCopyWith<$Res> get meta {
  
  return $HypocenterMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [HypocenterListResponse].
extension HypocenterListResponsePatterns on HypocenterListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterListResponse value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Data3 data,  HypocenterMeta meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HypocenterListResponse() when $default != null:
return $default(_that.data,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Data3 data,  HypocenterMeta meta)  $default,) {final _that = this;
switch (_that) {
case _HypocenterListResponse():
return $default(_that.data,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Data3 data,  HypocenterMeta meta)?  $default,) {final _that = this;
switch (_that) {
case _HypocenterListResponse() when $default != null:
return $default(_that.data,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HypocenterListResponse implements HypocenterListResponse {
  const _HypocenterListResponse({required this.data, required this.meta});
  factory _HypocenterListResponse.fromJson(Map<String, dynamic> json) => _$HypocenterListResponseFromJson(json);

@override final  Data3 data;
@override final  HypocenterMeta meta;

/// Create a copy of HypocenterListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterListResponseCopyWith<_HypocenterListResponse> get copyWith => __$HypocenterListResponseCopyWithImpl<_HypocenterListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HypocenterListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterListResponse&&(identical(other.data, data) || other.data == data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data,meta);

@override
String toString() {
  return 'HypocenterListResponse(data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$HypocenterListResponseCopyWith<$Res> implements $HypocenterListResponseCopyWith<$Res> {
  factory _$HypocenterListResponseCopyWith(_HypocenterListResponse value, $Res Function(_HypocenterListResponse) _then) = __$HypocenterListResponseCopyWithImpl;
@override @useResult
$Res call({
 Data3 data, HypocenterMeta meta
});


@override $Data3CopyWith<$Res> get data;@override $HypocenterMetaCopyWith<$Res> get meta;

}
/// @nodoc
class __$HypocenterListResponseCopyWithImpl<$Res>
    implements _$HypocenterListResponseCopyWith<$Res> {
  __$HypocenterListResponseCopyWithImpl(this._self, this._then);

  final _HypocenterListResponse _self;
  final $Res Function(_HypocenterListResponse) _then;

/// Create a copy of HypocenterListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? meta = null,}) {
  return _then(_HypocenterListResponse(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data3,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as HypocenterMeta,
  ));
}

/// Create a copy of HypocenterListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data3CopyWith<$Res> get data {
  
  return $Data3CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of HypocenterListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterMetaCopyWith<$Res> get meta {
  
  return $HypocenterMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}

// dart format on
