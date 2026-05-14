// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parameters_manifest_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParametersManifestResponse {

 List<ParameterManifestItem> get parameters;
/// Create a copy of ParametersManifestResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParametersManifestResponseCopyWith<ParametersManifestResponse> get copyWith => _$ParametersManifestResponseCopyWithImpl<ParametersManifestResponse>(this as ParametersManifestResponse, _$identity);

  /// Serializes this ParametersManifestResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParametersManifestResponse&&const DeepCollectionEquality().equals(other.parameters, parameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(parameters));

@override
String toString() {
  return 'ParametersManifestResponse(parameters: $parameters)';
}


}

/// @nodoc
abstract mixin class $ParametersManifestResponseCopyWith<$Res>  {
  factory $ParametersManifestResponseCopyWith(ParametersManifestResponse value, $Res Function(ParametersManifestResponse) _then) = _$ParametersManifestResponseCopyWithImpl;
@useResult
$Res call({
 List<ParameterManifestItem> parameters
});




}
/// @nodoc
class _$ParametersManifestResponseCopyWithImpl<$Res>
    implements $ParametersManifestResponseCopyWith<$Res> {
  _$ParametersManifestResponseCopyWithImpl(this._self, this._then);

  final ParametersManifestResponse _self;
  final $Res Function(ParametersManifestResponse) _then;

/// Create a copy of ParametersManifestResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? parameters = null,}) {
  return _then(_self.copyWith(
parameters: null == parameters ? _self.parameters : parameters // ignore: cast_nullable_to_non_nullable
as List<ParameterManifestItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [ParametersManifestResponse].
extension ParametersManifestResponsePatterns on ParametersManifestResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParametersManifestResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParametersManifestResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParametersManifestResponse value)  $default,){
final _that = this;
switch (_that) {
case _ParametersManifestResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParametersManifestResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ParametersManifestResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ParameterManifestItem> parameters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParametersManifestResponse() when $default != null:
return $default(_that.parameters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ParameterManifestItem> parameters)  $default,) {final _that = this;
switch (_that) {
case _ParametersManifestResponse():
return $default(_that.parameters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ParameterManifestItem> parameters)?  $default,) {final _that = this;
switch (_that) {
case _ParametersManifestResponse() when $default != null:
return $default(_that.parameters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParametersManifestResponse implements ParametersManifestResponse {
  const _ParametersManifestResponse({required final  List<ParameterManifestItem> parameters}): _parameters = parameters;
  factory _ParametersManifestResponse.fromJson(Map<String, dynamic> json) => _$ParametersManifestResponseFromJson(json);

 final  List<ParameterManifestItem> _parameters;
@override List<ParameterManifestItem> get parameters {
  if (_parameters is EqualUnmodifiableListView) return _parameters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parameters);
}


/// Create a copy of ParametersManifestResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParametersManifestResponseCopyWith<_ParametersManifestResponse> get copyWith => __$ParametersManifestResponseCopyWithImpl<_ParametersManifestResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParametersManifestResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParametersManifestResponse&&const DeepCollectionEquality().equals(other._parameters, _parameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_parameters));

@override
String toString() {
  return 'ParametersManifestResponse(parameters: $parameters)';
}


}

/// @nodoc
abstract mixin class _$ParametersManifestResponseCopyWith<$Res> implements $ParametersManifestResponseCopyWith<$Res> {
  factory _$ParametersManifestResponseCopyWith(_ParametersManifestResponse value, $Res Function(_ParametersManifestResponse) _then) = __$ParametersManifestResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ParameterManifestItem> parameters
});




}
/// @nodoc
class __$ParametersManifestResponseCopyWithImpl<$Res>
    implements _$ParametersManifestResponseCopyWith<$Res> {
  __$ParametersManifestResponseCopyWithImpl(this._self, this._then);

  final _ParametersManifestResponse _self;
  final $Res Function(_ParametersManifestResponse) _then;

/// Create a copy of ParametersManifestResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? parameters = null,}) {
  return _then(_ParametersManifestResponse(
parameters: null == parameters ? _self._parameters : parameters // ignore: cast_nullable_to_non_nullable
as List<ParameterManifestItem>,
  ));
}


}

// dart format on
