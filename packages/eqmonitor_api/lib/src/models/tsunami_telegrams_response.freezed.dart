// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_telegrams_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiTelegramsResponse {

 List<TsunamiTelegramWithState> get telegrams;
/// Create a copy of TsunamiTelegramsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiTelegramsResponseCopyWith<TsunamiTelegramsResponse> get copyWith => _$TsunamiTelegramsResponseCopyWithImpl<TsunamiTelegramsResponse>(this as TsunamiTelegramsResponse, _$identity);

  /// Serializes this TsunamiTelegramsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiTelegramsResponse&&const DeepCollectionEquality().equals(other.telegrams, telegrams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(telegrams));

@override
String toString() {
  return 'TsunamiTelegramsResponse(telegrams: $telegrams)';
}


}

/// @nodoc
abstract mixin class $TsunamiTelegramsResponseCopyWith<$Res>  {
  factory $TsunamiTelegramsResponseCopyWith(TsunamiTelegramsResponse value, $Res Function(TsunamiTelegramsResponse) _then) = _$TsunamiTelegramsResponseCopyWithImpl;
@useResult
$Res call({
 List<TsunamiTelegramWithState> telegrams
});




}
/// @nodoc
class _$TsunamiTelegramsResponseCopyWithImpl<$Res>
    implements $TsunamiTelegramsResponseCopyWith<$Res> {
  _$TsunamiTelegramsResponseCopyWithImpl(this._self, this._then);

  final TsunamiTelegramsResponse _self;
  final $Res Function(TsunamiTelegramsResponse) _then;

/// Create a copy of TsunamiTelegramsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? telegrams = null,}) {
  return _then(TsunamiTelegramsResponse(
telegrams: null == telegrams ? _self.telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<TsunamiTelegramWithState>,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiTelegramsResponse].
extension TsunamiTelegramsResponsePatterns on TsunamiTelegramsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiTelegramsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiTelegramsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiTelegramsResponse value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiTelegramsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TsunamiTelegramWithState> telegrams)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiTelegramsResponse() when $default != null:
return $default(_that.telegrams);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TsunamiTelegramWithState> telegrams)  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramsResponse():
return $default(_that.telegrams);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TsunamiTelegramWithState> telegrams)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramsResponse() when $default != null:
return $default(_that.telegrams);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiTelegramsResponse implements TsunamiTelegramsResponse {
  const _TsunamiTelegramsResponse({required  List<TsunamiTelegramWithState> telegrams}): _telegrams = telegrams;
  factory _TsunamiTelegramsResponse.fromJson(Map<String, dynamic> json) => _$TsunamiTelegramsResponseFromJson(json);

 final  List<TsunamiTelegramWithState> _telegrams;
@override List<TsunamiTelegramWithState> get telegrams {
  if (_telegrams is EqualUnmodifiableListView) return _telegrams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegrams);
}


/// Create a copy of TsunamiTelegramsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiTelegramsResponseCopyWith<_TsunamiTelegramsResponse> get copyWith => __$TsunamiTelegramsResponseCopyWithImpl<_TsunamiTelegramsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiTelegramsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiTelegramsResponse&&const DeepCollectionEquality().equals(other._telegrams, _telegrams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_telegrams));

@override
String toString() {
  return 'TsunamiTelegramsResponse(telegrams: $telegrams)';
}


}

/// @nodoc
abstract mixin class _$TsunamiTelegramsResponseCopyWith<$Res> implements $TsunamiTelegramsResponseCopyWith<$Res> {
  factory _$TsunamiTelegramsResponseCopyWith(_TsunamiTelegramsResponse value, $Res Function(_TsunamiTelegramsResponse) _then) = __$TsunamiTelegramsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<TsunamiTelegramWithState> telegrams
});




}
/// @nodoc
class __$TsunamiTelegramsResponseCopyWithImpl<$Res>
    implements _$TsunamiTelegramsResponseCopyWith<$Res> {
  __$TsunamiTelegramsResponseCopyWithImpl(this._self, this._then);

  final _TsunamiTelegramsResponse _self;
  final $Res Function(_TsunamiTelegramsResponse) _then;

/// Create a copy of TsunamiTelegramsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? telegrams = null,}) {
  return _then(_TsunamiTelegramsResponse(
telegrams: null == telegrams ? _self._telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<TsunamiTelegramWithState>,
  ));
}


}

// dart format on
