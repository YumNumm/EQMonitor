// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiDetailResponse {

 TsunamiDetail get tsunami;
/// Create a copy of TsunamiDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiDetailResponseCopyWith<TsunamiDetailResponse> get copyWith => _$TsunamiDetailResponseCopyWithImpl<TsunamiDetailResponse>(this as TsunamiDetailResponse, _$identity);

  /// Serializes this TsunamiDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiDetailResponse&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunami);

@override
String toString() {
  return 'TsunamiDetailResponse(tsunami: $tsunami)';
}


}

/// @nodoc
abstract mixin class $TsunamiDetailResponseCopyWith<$Res>  {
  factory $TsunamiDetailResponseCopyWith(TsunamiDetailResponse value, $Res Function(TsunamiDetailResponse) _then) = _$TsunamiDetailResponseCopyWithImpl;
@useResult
$Res call({
 TsunamiDetail tsunami
});


$TsunamiDetailCopyWith<$Res> get tsunami;

}
/// @nodoc
class _$TsunamiDetailResponseCopyWithImpl<$Res>
    implements $TsunamiDetailResponseCopyWith<$Res> {
  _$TsunamiDetailResponseCopyWithImpl(this._self, this._then);

  final TsunamiDetailResponse _self;
  final $Res Function(TsunamiDetailResponse) _then;

/// Create a copy of TsunamiDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tsunami = null,}) {
  return _then(_self.copyWith(
tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as TsunamiDetail,
  ));
}
/// Create a copy of TsunamiDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiDetailCopyWith<$Res> get tsunami {
  
  return $TsunamiDetailCopyWith<$Res>(_self.tsunami, (value) {
    return _then(_self.copyWith(tsunami: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiDetailResponse].
extension TsunamiDetailResponsePatterns on TsunamiDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiDetailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TsunamiDetail tsunami)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiDetailResponse() when $default != null:
return $default(_that.tsunami);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TsunamiDetail tsunami)  $default,) {final _that = this;
switch (_that) {
case _TsunamiDetailResponse():
return $default(_that.tsunami);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TsunamiDetail tsunami)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiDetailResponse() when $default != null:
return $default(_that.tsunami);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiDetailResponse implements TsunamiDetailResponse {
  const _TsunamiDetailResponse({required this.tsunami});
  factory _TsunamiDetailResponse.fromJson(Map<String, dynamic> json) => _$TsunamiDetailResponseFromJson(json);

@override final  TsunamiDetail tsunami;

/// Create a copy of TsunamiDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiDetailResponseCopyWith<_TsunamiDetailResponse> get copyWith => __$TsunamiDetailResponseCopyWithImpl<_TsunamiDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiDetailResponse&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunami);

@override
String toString() {
  return 'TsunamiDetailResponse(tsunami: $tsunami)';
}


}

/// @nodoc
abstract mixin class _$TsunamiDetailResponseCopyWith<$Res> implements $TsunamiDetailResponseCopyWith<$Res> {
  factory _$TsunamiDetailResponseCopyWith(_TsunamiDetailResponse value, $Res Function(_TsunamiDetailResponse) _then) = __$TsunamiDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 TsunamiDetail tsunami
});


@override $TsunamiDetailCopyWith<$Res> get tsunami;

}
/// @nodoc
class __$TsunamiDetailResponseCopyWithImpl<$Res>
    implements _$TsunamiDetailResponseCopyWith<$Res> {
  __$TsunamiDetailResponseCopyWithImpl(this._self, this._then);

  final _TsunamiDetailResponse _self;
  final $Res Function(_TsunamiDetailResponse) _then;

/// Create a copy of TsunamiDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tsunami = null,}) {
  return _then(_TsunamiDetailResponse(
tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as TsunamiDetail,
  ));
}

/// Create a copy of TsunamiDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiDetailCopyWith<$Res> get tsunami {
  
  return $TsunamiDetailCopyWith<$Res>(_self.tsunami, (value) {
    return _then(_self.copyWith(tsunami: value));
  });
}
}

// dart format on
