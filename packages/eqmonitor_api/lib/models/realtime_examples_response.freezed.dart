// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_examples_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimeExamplesResponse {

 List<dynamic> get examples;
/// Create a copy of RealtimeExamplesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeExamplesResponseCopyWith<RealtimeExamplesResponse> get copyWith => _$RealtimeExamplesResponseCopyWithImpl<RealtimeExamplesResponse>(this as RealtimeExamplesResponse, _$identity);

  /// Serializes this RealtimeExamplesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeExamplesResponse&&const DeepCollectionEquality().equals(other.examples, examples));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(examples));

@override
String toString() {
  return 'RealtimeExamplesResponse(examples: $examples)';
}


}

/// @nodoc
abstract mixin class $RealtimeExamplesResponseCopyWith<$Res>  {
  factory $RealtimeExamplesResponseCopyWith(RealtimeExamplesResponse value, $Res Function(RealtimeExamplesResponse) _then) = _$RealtimeExamplesResponseCopyWithImpl;
@useResult
$Res call({
 List<dynamic> examples
});




}
/// @nodoc
class _$RealtimeExamplesResponseCopyWithImpl<$Res>
    implements $RealtimeExamplesResponseCopyWith<$Res> {
  _$RealtimeExamplesResponseCopyWithImpl(this._self, this._then);

  final RealtimeExamplesResponse _self;
  final $Res Function(RealtimeExamplesResponse) _then;

/// Create a copy of RealtimeExamplesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? examples = null,}) {
  return _then(_self.copyWith(
examples: null == examples ? _self.examples : examples // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeExamplesResponse].
extension RealtimeExamplesResponsePatterns on RealtimeExamplesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeExamplesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeExamplesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeExamplesResponse value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeExamplesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeExamplesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeExamplesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<dynamic> examples)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeExamplesResponse() when $default != null:
return $default(_that.examples);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<dynamic> examples)  $default,) {final _that = this;
switch (_that) {
case _RealtimeExamplesResponse():
return $default(_that.examples);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<dynamic> examples)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeExamplesResponse() when $default != null:
return $default(_that.examples);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeExamplesResponse implements RealtimeExamplesResponse {
  const _RealtimeExamplesResponse({required final  List<dynamic> examples}): _examples = examples;
  factory _RealtimeExamplesResponse.fromJson(Map<String, dynamic> json) => _$RealtimeExamplesResponseFromJson(json);

 final  List<dynamic> _examples;
@override List<dynamic> get examples {
  if (_examples is EqualUnmodifiableListView) return _examples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_examples);
}


/// Create a copy of RealtimeExamplesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeExamplesResponseCopyWith<_RealtimeExamplesResponse> get copyWith => __$RealtimeExamplesResponseCopyWithImpl<_RealtimeExamplesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeExamplesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeExamplesResponse&&const DeepCollectionEquality().equals(other._examples, _examples));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_examples));

@override
String toString() {
  return 'RealtimeExamplesResponse(examples: $examples)';
}


}

/// @nodoc
abstract mixin class _$RealtimeExamplesResponseCopyWith<$Res> implements $RealtimeExamplesResponseCopyWith<$Res> {
  factory _$RealtimeExamplesResponseCopyWith(_RealtimeExamplesResponse value, $Res Function(_RealtimeExamplesResponse) _then) = __$RealtimeExamplesResponseCopyWithImpl;
@override @useResult
$Res call({
 List<dynamic> examples
});




}
/// @nodoc
class __$RealtimeExamplesResponseCopyWithImpl<$Res>
    implements _$RealtimeExamplesResponseCopyWith<$Res> {
  __$RealtimeExamplesResponseCopyWithImpl(this._self, this._then);

  final _RealtimeExamplesResponse _self;
  final $Res Function(_RealtimeExamplesResponse) _then;

/// Create a copy of RealtimeExamplesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? examples = null,}) {
  return _then(_RealtimeExamplesResponse(
examples: null == examples ? _self._examples : examples // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

// dart format on
