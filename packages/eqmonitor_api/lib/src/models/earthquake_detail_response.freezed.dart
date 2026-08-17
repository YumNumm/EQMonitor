// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeDetailResponse {

 Earthquake get earthquake;
/// Create a copy of EarthquakeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeDetailResponseCopyWith<EarthquakeDetailResponse> get copyWith => _$EarthquakeDetailResponseCopyWithImpl<EarthquakeDetailResponse>(this as EarthquakeDetailResponse, _$identity);

  /// Serializes this EarthquakeDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeDetailResponse&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,earthquake);

@override
String toString() {
  return 'EarthquakeDetailResponse(earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EarthquakeDetailResponseCopyWith<$Res>  {
  factory $EarthquakeDetailResponseCopyWith(EarthquakeDetailResponse value, $Res Function(EarthquakeDetailResponse) _then) = _$EarthquakeDetailResponseCopyWithImpl;
@useResult
$Res call({
 Earthquake earthquake
});


$EarthquakeCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$EarthquakeDetailResponseCopyWithImpl<$Res>
    implements $EarthquakeDetailResponseCopyWith<$Res> {
  _$EarthquakeDetailResponseCopyWithImpl(this._self, this._then);

  final EarthquakeDetailResponse _self;
  final $Res Function(EarthquakeDetailResponse) _then;

/// Create a copy of EarthquakeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? earthquake = null,}) {
  return _then(EarthquakeDetailResponse(
earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as Earthquake,
  ));
}
/// Create a copy of EarthquakeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<$Res> get earthquake {
  
  return $EarthquakeCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeDetailResponse].
extension EarthquakeDetailResponsePatterns on EarthquakeDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeDetailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Earthquake earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeDetailResponse() when $default != null:
return $default(_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Earthquake earthquake)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeDetailResponse():
return $default(_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Earthquake earthquake)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeDetailResponse() when $default != null:
return $default(_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeDetailResponse implements EarthquakeDetailResponse {
  const _EarthquakeDetailResponse({required this.earthquake});
  factory _EarthquakeDetailResponse.fromJson(Map<String, dynamic> json) => _$EarthquakeDetailResponseFromJson(json);

@override final  Earthquake earthquake;

/// Create a copy of EarthquakeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeDetailResponseCopyWith<_EarthquakeDetailResponse> get copyWith => __$EarthquakeDetailResponseCopyWithImpl<_EarthquakeDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeDetailResponse&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,earthquake);

@override
String toString() {
  return 'EarthquakeDetailResponse(earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeDetailResponseCopyWith<$Res> implements $EarthquakeDetailResponseCopyWith<$Res> {
  factory _$EarthquakeDetailResponseCopyWith(_EarthquakeDetailResponse value, $Res Function(_EarthquakeDetailResponse) _then) = __$EarthquakeDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 Earthquake earthquake
});


@override $EarthquakeCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$EarthquakeDetailResponseCopyWithImpl<$Res>
    implements _$EarthquakeDetailResponseCopyWith<$Res> {
  __$EarthquakeDetailResponseCopyWithImpl(this._self, this._then);

  final _EarthquakeDetailResponse _self;
  final $Res Function(_EarthquakeDetailResponse) _then;

/// Create a copy of EarthquakeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? earthquake = null,}) {
  return _then(_EarthquakeDetailResponse(
earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as Earthquake,
  ));
}

/// Create a copy of EarthquakeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<$Res> get earthquake {
  
  return $EarthquakeCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

// dart format on
