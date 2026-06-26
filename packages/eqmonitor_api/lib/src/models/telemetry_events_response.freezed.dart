// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telemetry_events_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelemetryEventsResponse {

 int get accepted;@JsonKey(includeIfNull: false) String? get warning;
/// Create a copy of TelemetryEventsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelemetryEventsResponseCopyWith<TelemetryEventsResponse> get copyWith => _$TelemetryEventsResponseCopyWithImpl<TelemetryEventsResponse>(this as TelemetryEventsResponse, _$identity);

  /// Serializes this TelemetryEventsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelemetryEventsResponse&&(identical(other.accepted, accepted) || other.accepted == accepted)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accepted,warning);

@override
String toString() {
  return 'TelemetryEventsResponse(accepted: $accepted, warning: $warning)';
}


}

/// @nodoc
abstract mixin class $TelemetryEventsResponseCopyWith<$Res>  {
  factory $TelemetryEventsResponseCopyWith(TelemetryEventsResponse value, $Res Function(TelemetryEventsResponse) _then) = _$TelemetryEventsResponseCopyWithImpl;
@useResult
$Res call({
 int accepted,@JsonKey(includeIfNull: false) String? warning
});




}
/// @nodoc
class _$TelemetryEventsResponseCopyWithImpl<$Res>
    implements $TelemetryEventsResponseCopyWith<$Res> {
  _$TelemetryEventsResponseCopyWithImpl(this._self, this._then);

  final TelemetryEventsResponse _self;
  final $Res Function(TelemetryEventsResponse) _then;

/// Create a copy of TelemetryEventsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accepted = null,Object? warning = freezed,}) {
  return _then(_self.copyWith(
accepted: null == accepted ? _self.accepted : accepted // ignore: cast_nullable_to_non_nullable
as int,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TelemetryEventsResponse].
extension TelemetryEventsResponsePatterns on TelemetryEventsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelemetryEventsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelemetryEventsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelemetryEventsResponse value)  $default,){
final _that = this;
switch (_that) {
case _TelemetryEventsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelemetryEventsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TelemetryEventsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int accepted, @JsonKey(includeIfNull: false)  String? warning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelemetryEventsResponse() when $default != null:
return $default(_that.accepted,_that.warning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int accepted, @JsonKey(includeIfNull: false)  String? warning)  $default,) {final _that = this;
switch (_that) {
case _TelemetryEventsResponse():
return $default(_that.accepted,_that.warning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int accepted, @JsonKey(includeIfNull: false)  String? warning)?  $default,) {final _that = this;
switch (_that) {
case _TelemetryEventsResponse() when $default != null:
return $default(_that.accepted,_that.warning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelemetryEventsResponse implements TelemetryEventsResponse {
  const _TelemetryEventsResponse({required this.accepted, @JsonKey(includeIfNull: false) this.warning});
  factory _TelemetryEventsResponse.fromJson(Map<String, dynamic> json) => _$TelemetryEventsResponseFromJson(json);

@override final  int accepted;
@override@JsonKey(includeIfNull: false) final  String? warning;

/// Create a copy of TelemetryEventsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelemetryEventsResponseCopyWith<_TelemetryEventsResponse> get copyWith => __$TelemetryEventsResponseCopyWithImpl<_TelemetryEventsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelemetryEventsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelemetryEventsResponse&&(identical(other.accepted, accepted) || other.accepted == accepted)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accepted,warning);

@override
String toString() {
  return 'TelemetryEventsResponse(accepted: $accepted, warning: $warning)';
}


}

/// @nodoc
abstract mixin class _$TelemetryEventsResponseCopyWith<$Res> implements $TelemetryEventsResponseCopyWith<$Res> {
  factory _$TelemetryEventsResponseCopyWith(_TelemetryEventsResponse value, $Res Function(_TelemetryEventsResponse) _then) = __$TelemetryEventsResponseCopyWithImpl;
@override @useResult
$Res call({
 int accepted,@JsonKey(includeIfNull: false) String? warning
});




}
/// @nodoc
class __$TelemetryEventsResponseCopyWithImpl<$Res>
    implements _$TelemetryEventsResponseCopyWith<$Res> {
  __$TelemetryEventsResponseCopyWithImpl(this._self, this._then);

  final _TelemetryEventsResponse _self;
  final $Res Function(_TelemetryEventsResponse) _then;

/// Create a copy of TelemetryEventsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accepted = null,Object? warning = freezed,}) {
  return _then(_TelemetryEventsResponse(
accepted: null == accepted ? _self.accepted : accepted // ignore: cast_nullable_to_non_nullable
as int,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
