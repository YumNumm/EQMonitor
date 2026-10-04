// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_event_id_serial_no_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewEventIdSerialNoParam {

 String get eventId; num get serialNo;
/// Create a copy of EewEventIdSerialNoParam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewEventIdSerialNoParamCopyWith<EewEventIdSerialNoParam> get copyWith => _$EewEventIdSerialNoParamCopyWithImpl<EewEventIdSerialNoParam>(this as EewEventIdSerialNoParam, _$identity);

  /// Serializes this EewEventIdSerialNoParam to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewEventIdSerialNoParam&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo);

@override
String toString() {
  return 'EewEventIdSerialNoParam(eventId: $eventId, serialNo: $serialNo)';
}


}

/// @nodoc
abstract mixin class $EewEventIdSerialNoParamCopyWith<$Res>  {
  factory $EewEventIdSerialNoParamCopyWith(EewEventIdSerialNoParam value, $Res Function(EewEventIdSerialNoParam) _then) = _$EewEventIdSerialNoParamCopyWithImpl;
@useResult
$Res call({
 String eventId, num serialNo
});




}
/// @nodoc
class _$EewEventIdSerialNoParamCopyWithImpl<$Res>
    implements $EewEventIdSerialNoParamCopyWith<$Res> {
  _$EewEventIdSerialNoParamCopyWithImpl(this._self, this._then);

  final EewEventIdSerialNoParam _self;
  final $Res Function(EewEventIdSerialNoParam) _then;

/// Create a copy of EewEventIdSerialNoParam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? serialNo = null,}) {
  return _then(EewEventIdSerialNoParam(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [EewEventIdSerialNoParam].
extension EewEventIdSerialNoParamPatterns on EewEventIdSerialNoParam {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewEventIdSerialNoParam value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewEventIdSerialNoParam() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewEventIdSerialNoParam value)  $default,){
final _that = this;
switch (_that) {
case _EewEventIdSerialNoParam():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewEventIdSerialNoParam value)?  $default,){
final _that = this;
switch (_that) {
case _EewEventIdSerialNoParam() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  num serialNo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewEventIdSerialNoParam() when $default != null:
return $default(_that.eventId,_that.serialNo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  num serialNo)  $default,) {final _that = this;
switch (_that) {
case _EewEventIdSerialNoParam():
return $default(_that.eventId,_that.serialNo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  num serialNo)?  $default,) {final _that = this;
switch (_that) {
case _EewEventIdSerialNoParam() when $default != null:
return $default(_that.eventId,_that.serialNo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewEventIdSerialNoParam implements EewEventIdSerialNoParam {
  const _EewEventIdSerialNoParam({required this.eventId, required this.serialNo});
  factory _EewEventIdSerialNoParam.fromJson(Map<String, dynamic> json) => _$EewEventIdSerialNoParamFromJson(json);

@override final  String eventId;
@override final  num serialNo;

/// Create a copy of EewEventIdSerialNoParam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewEventIdSerialNoParamCopyWith<_EewEventIdSerialNoParam> get copyWith => __$EewEventIdSerialNoParamCopyWithImpl<_EewEventIdSerialNoParam>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewEventIdSerialNoParamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewEventIdSerialNoParam&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo);

@override
String toString() {
  return 'EewEventIdSerialNoParam(eventId: $eventId, serialNo: $serialNo)';
}


}

/// @nodoc
abstract mixin class _$EewEventIdSerialNoParamCopyWith<$Res> implements $EewEventIdSerialNoParamCopyWith<$Res> {
  factory _$EewEventIdSerialNoParamCopyWith(_EewEventIdSerialNoParam value, $Res Function(_EewEventIdSerialNoParam) _then) = __$EewEventIdSerialNoParamCopyWithImpl;
@override @useResult
$Res call({
 String eventId, num serialNo
});




}
/// @nodoc
class __$EewEventIdSerialNoParamCopyWithImpl<$Res>
    implements _$EewEventIdSerialNoParamCopyWith<$Res> {
  __$EewEventIdSerialNoParamCopyWithImpl(this._self, this._then);

  final _EewEventIdSerialNoParam _self;
  final $Res Function(_EewEventIdSerialNoParam) _then;

/// Create a copy of EewEventIdSerialNoParam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? serialNo = null,}) {
  return _then(_EewEventIdSerialNoParam(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
