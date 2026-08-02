// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter_manifest_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HypocenterManifestResponse {

 Data2 get data; HypocenterMeta get meta;
/// Create a copy of HypocenterManifestResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterManifestResponseCopyWith<HypocenterManifestResponse> get copyWith => _$HypocenterManifestResponseCopyWithImpl<HypocenterManifestResponse>(this as HypocenterManifestResponse, _$identity);

  /// Serializes this HypocenterManifestResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterManifestResponse&&(identical(other.data, data) || other.data == data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data,meta);

@override
String toString() {
  return 'HypocenterManifestResponse(data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class $HypocenterManifestResponseCopyWith<$Res>  {
  factory $HypocenterManifestResponseCopyWith(HypocenterManifestResponse value, $Res Function(HypocenterManifestResponse) _then) = _$HypocenterManifestResponseCopyWithImpl;
@useResult
$Res call({
 Data2 data, HypocenterMeta meta
});


$Data2CopyWith<$Res> get data;$HypocenterMetaCopyWith<$Res> get meta;

}
/// @nodoc
class _$HypocenterManifestResponseCopyWithImpl<$Res>
    implements $HypocenterManifestResponseCopyWith<$Res> {
  _$HypocenterManifestResponseCopyWithImpl(this._self, this._then);

  final HypocenterManifestResponse _self;
  final $Res Function(HypocenterManifestResponse) _then;

/// Create a copy of HypocenterManifestResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? meta = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data2,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as HypocenterMeta,
  ));
}
/// Create a copy of HypocenterManifestResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data2CopyWith<$Res> get data {

  return $Data2CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of HypocenterManifestResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterMetaCopyWith<$Res> get meta {

  return $HypocenterMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [HypocenterManifestResponse].
extension HypocenterManifestResponsePatterns on HypocenterManifestResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterManifestResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterManifestResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterManifestResponse value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterManifestResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterManifestResponse value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterManifestResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Data2 data,  HypocenterMeta meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HypocenterManifestResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Data2 data,  HypocenterMeta meta)  $default,) {final _that = this;
switch (_that) {
case _HypocenterManifestResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Data2 data,  HypocenterMeta meta)?  $default,) {final _that = this;
switch (_that) {
case _HypocenterManifestResponse() when $default != null:
return $default(_that.data,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HypocenterManifestResponse implements HypocenterManifestResponse {
  const _HypocenterManifestResponse({required this.data, required this.meta});
  factory _HypocenterManifestResponse.fromJson(Map<String, dynamic> json) => _$HypocenterManifestResponseFromJson(json);

@override final  Data2 data;
@override final  HypocenterMeta meta;

/// Create a copy of HypocenterManifestResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterManifestResponseCopyWith<_HypocenterManifestResponse> get copyWith => __$HypocenterManifestResponseCopyWithImpl<_HypocenterManifestResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HypocenterManifestResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterManifestResponse&&(identical(other.data, data) || other.data == data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data,meta);

@override
String toString() {
  return 'HypocenterManifestResponse(data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$HypocenterManifestResponseCopyWith<$Res> implements $HypocenterManifestResponseCopyWith<$Res> {
  factory _$HypocenterManifestResponseCopyWith(_HypocenterManifestResponse value, $Res Function(_HypocenterManifestResponse) _then) = __$HypocenterManifestResponseCopyWithImpl;
@override @useResult
$Res call({
 Data2 data, HypocenterMeta meta
});


@override $Data2CopyWith<$Res> get data;@override $HypocenterMetaCopyWith<$Res> get meta;

}
/// @nodoc
class __$HypocenterManifestResponseCopyWithImpl<$Res>
    implements _$HypocenterManifestResponseCopyWith<$Res> {
  __$HypocenterManifestResponseCopyWithImpl(this._self, this._then);

  final _HypocenterManifestResponse _self;
  final $Res Function(_HypocenterManifestResponse) _then;

/// Create a copy of HypocenterManifestResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? meta = null,}) {
  return _then(_HypocenterManifestResponse(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data2,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as HypocenterMeta,
  ));
}

/// Create a copy of HypocenterManifestResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Data2CopyWith<$Res> get data {

  return $Data2CopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of HypocenterManifestResponse
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
