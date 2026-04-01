// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_v2_earthquake_event_id_intensity_map_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetV2EarthquakeEventIdIntensityMapResponse {

@JsonKey(includeIfNull: true) String? get url;@JsonKey(includeIfNull: true, name: 'object_key') String? get objectKey;
/// Create a copy of GetV2EarthquakeEventIdIntensityMapResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetV2EarthquakeEventIdIntensityMapResponseCopyWith<GetV2EarthquakeEventIdIntensityMapResponse> get copyWith => _$GetV2EarthquakeEventIdIntensityMapResponseCopyWithImpl<GetV2EarthquakeEventIdIntensityMapResponse>(this as GetV2EarthquakeEventIdIntensityMapResponse, _$identity);

  /// Serializes this GetV2EarthquakeEventIdIntensityMapResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetV2EarthquakeEventIdIntensityMapResponse&&(identical(other.url, url) || other.url == url)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,objectKey);

@override
String toString() {
  return 'GetV2EarthquakeEventIdIntensityMapResponse(url: $url, objectKey: $objectKey)';
}


}

/// @nodoc
abstract mixin class $GetV2EarthquakeEventIdIntensityMapResponseCopyWith<$Res>  {
  factory $GetV2EarthquakeEventIdIntensityMapResponseCopyWith(GetV2EarthquakeEventIdIntensityMapResponse value, $Res Function(GetV2EarthquakeEventIdIntensityMapResponse) _then) = _$GetV2EarthquakeEventIdIntensityMapResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: true) String? url,@JsonKey(includeIfNull: true, name: 'object_key') String? objectKey
});




}
/// @nodoc
class _$GetV2EarthquakeEventIdIntensityMapResponseCopyWithImpl<$Res>
    implements $GetV2EarthquakeEventIdIntensityMapResponseCopyWith<$Res> {
  _$GetV2EarthquakeEventIdIntensityMapResponseCopyWithImpl(this._self, this._then);

  final GetV2EarthquakeEventIdIntensityMapResponse _self;
  final $Res Function(GetV2EarthquakeEventIdIntensityMapResponse) _then;

/// Create a copy of GetV2EarthquakeEventIdIntensityMapResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? objectKey = freezed,}) {
  return _then(_self.copyWith(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,objectKey: freezed == objectKey ? _self.objectKey : objectKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GetV2EarthquakeEventIdIntensityMapResponse].
extension GetV2EarthquakeEventIdIntensityMapResponsePatterns on GetV2EarthquakeEventIdIntensityMapResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetV2EarthquakeEventIdIntensityMapResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetV2EarthquakeEventIdIntensityMapResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetV2EarthquakeEventIdIntensityMapResponse value)  $default,){
final _that = this;
switch (_that) {
case _GetV2EarthquakeEventIdIntensityMapResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetV2EarthquakeEventIdIntensityMapResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GetV2EarthquakeEventIdIntensityMapResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: true)  String? url, @JsonKey(includeIfNull: true, name: 'object_key')  String? objectKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetV2EarthquakeEventIdIntensityMapResponse() when $default != null:
return $default(_that.url,_that.objectKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: true)  String? url, @JsonKey(includeIfNull: true, name: 'object_key')  String? objectKey)  $default,) {final _that = this;
switch (_that) {
case _GetV2EarthquakeEventIdIntensityMapResponse():
return $default(_that.url,_that.objectKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: true)  String? url, @JsonKey(includeIfNull: true, name: 'object_key')  String? objectKey)?  $default,) {final _that = this;
switch (_that) {
case _GetV2EarthquakeEventIdIntensityMapResponse() when $default != null:
return $default(_that.url,_that.objectKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetV2EarthquakeEventIdIntensityMapResponse implements GetV2EarthquakeEventIdIntensityMapResponse {
  const _GetV2EarthquakeEventIdIntensityMapResponse({@JsonKey(includeIfNull: true) required this.url, @JsonKey(includeIfNull: true, name: 'object_key') required this.objectKey});
  factory _GetV2EarthquakeEventIdIntensityMapResponse.fromJson(Map<String, dynamic> json) => _$GetV2EarthquakeEventIdIntensityMapResponseFromJson(json);

@override@JsonKey(includeIfNull: true) final  String? url;
@override@JsonKey(includeIfNull: true, name: 'object_key') final  String? objectKey;

/// Create a copy of GetV2EarthquakeEventIdIntensityMapResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetV2EarthquakeEventIdIntensityMapResponseCopyWith<_GetV2EarthquakeEventIdIntensityMapResponse> get copyWith => __$GetV2EarthquakeEventIdIntensityMapResponseCopyWithImpl<_GetV2EarthquakeEventIdIntensityMapResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetV2EarthquakeEventIdIntensityMapResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetV2EarthquakeEventIdIntensityMapResponse&&(identical(other.url, url) || other.url == url)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,objectKey);

@override
String toString() {
  return 'GetV2EarthquakeEventIdIntensityMapResponse(url: $url, objectKey: $objectKey)';
}


}

/// @nodoc
abstract mixin class _$GetV2EarthquakeEventIdIntensityMapResponseCopyWith<$Res> implements $GetV2EarthquakeEventIdIntensityMapResponseCopyWith<$Res> {
  factory _$GetV2EarthquakeEventIdIntensityMapResponseCopyWith(_GetV2EarthquakeEventIdIntensityMapResponse value, $Res Function(_GetV2EarthquakeEventIdIntensityMapResponse) _then) = __$GetV2EarthquakeEventIdIntensityMapResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: true) String? url,@JsonKey(includeIfNull: true, name: 'object_key') String? objectKey
});




}
/// @nodoc
class __$GetV2EarthquakeEventIdIntensityMapResponseCopyWithImpl<$Res>
    implements _$GetV2EarthquakeEventIdIntensityMapResponseCopyWith<$Res> {
  __$GetV2EarthquakeEventIdIntensityMapResponseCopyWithImpl(this._self, this._then);

  final _GetV2EarthquakeEventIdIntensityMapResponse _self;
  final $Res Function(_GetV2EarthquakeEventIdIntensityMapResponse) _then;

/// Create a copy of GetV2EarthquakeEventIdIntensityMapResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? objectKey = freezed,}) {
  return _then(_GetV2EarthquakeEventIdIntensityMapResponse(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,objectKey: freezed == objectKey ? _self.objectKey : objectKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
