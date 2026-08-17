// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter_revision_changed_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HypocenterRevisionChangedResponse {

/// const: "DATASET_REVISION_CHANGED"
 String get code; String get message;
/// Create a copy of HypocenterRevisionChangedResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterRevisionChangedResponseCopyWith<HypocenterRevisionChangedResponse> get copyWith => _$HypocenterRevisionChangedResponseCopyWithImpl<HypocenterRevisionChangedResponse>(this as HypocenterRevisionChangedResponse, _$identity);

  /// Serializes this HypocenterRevisionChangedResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterRevisionChangedResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'HypocenterRevisionChangedResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $HypocenterRevisionChangedResponseCopyWith<$Res>  {
  factory $HypocenterRevisionChangedResponseCopyWith(HypocenterRevisionChangedResponse value, $Res Function(HypocenterRevisionChangedResponse) _then) = _$HypocenterRevisionChangedResponseCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$HypocenterRevisionChangedResponseCopyWithImpl<$Res>
    implements $HypocenterRevisionChangedResponseCopyWith<$Res> {
  _$HypocenterRevisionChangedResponseCopyWithImpl(this._self, this._then);

  final HypocenterRevisionChangedResponse _self;
  final $Res Function(HypocenterRevisionChangedResponse) _then;

/// Create a copy of HypocenterRevisionChangedResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(HypocenterRevisionChangedResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HypocenterRevisionChangedResponse].
extension HypocenterRevisionChangedResponsePatterns on HypocenterRevisionChangedResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterRevisionChangedResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterRevisionChangedResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterRevisionChangedResponse value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterRevisionChangedResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterRevisionChangedResponse value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterRevisionChangedResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HypocenterRevisionChangedResponse() when $default != null:
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String message)  $default,) {final _that = this;
switch (_that) {
case _HypocenterRevisionChangedResponse():
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String message)?  $default,) {final _that = this;
switch (_that) {
case _HypocenterRevisionChangedResponse() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HypocenterRevisionChangedResponse implements HypocenterRevisionChangedResponse {
  const _HypocenterRevisionChangedResponse({required this.code, required this.message});
  factory _HypocenterRevisionChangedResponse.fromJson(Map<String, dynamic> json) => _$HypocenterRevisionChangedResponseFromJson(json);

/// const: "DATASET_REVISION_CHANGED"
@override final  String code;
@override final  String message;

/// Create a copy of HypocenterRevisionChangedResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterRevisionChangedResponseCopyWith<_HypocenterRevisionChangedResponse> get copyWith => __$HypocenterRevisionChangedResponseCopyWithImpl<_HypocenterRevisionChangedResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HypocenterRevisionChangedResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterRevisionChangedResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'HypocenterRevisionChangedResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$HypocenterRevisionChangedResponseCopyWith<$Res> implements $HypocenterRevisionChangedResponseCopyWith<$Res> {
  factory _$HypocenterRevisionChangedResponseCopyWith(_HypocenterRevisionChangedResponse value, $Res Function(_HypocenterRevisionChangedResponse) _then) = __$HypocenterRevisionChangedResponseCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$HypocenterRevisionChangedResponseCopyWithImpl<$Res>
    implements _$HypocenterRevisionChangedResponseCopyWith<$Res> {
  __$HypocenterRevisionChangedResponseCopyWithImpl(this._self, this._then);

  final _HypocenterRevisionChangedResponse _self;
  final $Res Function(_HypocenterRevisionChangedResponse) _then;

/// Create a copy of HypocenterRevisionChangedResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_HypocenterRevisionChangedResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
