// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_v2_admin_simulation_eew_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostV2AdminSimulationEewResponse {

/// const: true
 bool get ok; String get eventId; num get totalReports; String get scenario; String get targetDeviceId; num get intervalMs; num get durationMs;
/// Create a copy of PostV2AdminSimulationEewResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostV2AdminSimulationEewResponseCopyWith<PostV2AdminSimulationEewResponse> get copyWith => _$PostV2AdminSimulationEewResponseCopyWithImpl<PostV2AdminSimulationEewResponse>(this as PostV2AdminSimulationEewResponse, _$identity);

  /// Serializes this PostV2AdminSimulationEewResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostV2AdminSimulationEewResponse&&(identical(other.ok, ok) || other.ok == ok)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.totalReports, totalReports) || other.totalReports == totalReports)&&(identical(other.scenario, scenario) || other.scenario == scenario)&&(identical(other.targetDeviceId, targetDeviceId) || other.targetDeviceId == targetDeviceId)&&(identical(other.intervalMs, intervalMs) || other.intervalMs == intervalMs)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ok,eventId,totalReports,scenario,targetDeviceId,intervalMs,durationMs);

@override
String toString() {
  return 'PostV2AdminSimulationEewResponse(ok: $ok, eventId: $eventId, totalReports: $totalReports, scenario: $scenario, targetDeviceId: $targetDeviceId, intervalMs: $intervalMs, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class $PostV2AdminSimulationEewResponseCopyWith<$Res>  {
  factory $PostV2AdminSimulationEewResponseCopyWith(PostV2AdminSimulationEewResponse value, $Res Function(PostV2AdminSimulationEewResponse) _then) = _$PostV2AdminSimulationEewResponseCopyWithImpl;
@useResult
$Res call({
 bool ok, String eventId, num totalReports, String scenario, String targetDeviceId, num intervalMs, num durationMs
});




}
/// @nodoc
class _$PostV2AdminSimulationEewResponseCopyWithImpl<$Res>
    implements $PostV2AdminSimulationEewResponseCopyWith<$Res> {
  _$PostV2AdminSimulationEewResponseCopyWithImpl(this._self, this._then);

  final PostV2AdminSimulationEewResponse _self;
  final $Res Function(PostV2AdminSimulationEewResponse) _then;

/// Create a copy of PostV2AdminSimulationEewResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ok = null,Object? eventId = null,Object? totalReports = null,Object? scenario = null,Object? targetDeviceId = null,Object? intervalMs = null,Object? durationMs = null,}) {
  return _then(PostV2AdminSimulationEewResponse(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,totalReports: null == totalReports ? _self.totalReports : totalReports // ignore: cast_nullable_to_non_nullable
as num,scenario: null == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as String,targetDeviceId: null == targetDeviceId ? _self.targetDeviceId : targetDeviceId // ignore: cast_nullable_to_non_nullable
as String,intervalMs: null == intervalMs ? _self.intervalMs : intervalMs // ignore: cast_nullable_to_non_nullable
as num,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [PostV2AdminSimulationEewResponse].
extension PostV2AdminSimulationEewResponsePatterns on PostV2AdminSimulationEewResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostV2AdminSimulationEewResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostV2AdminSimulationEewResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostV2AdminSimulationEewResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostV2AdminSimulationEewResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostV2AdminSimulationEewResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostV2AdminSimulationEewResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool ok,  String eventId,  num totalReports,  String scenario,  String targetDeviceId,  num intervalMs,  num durationMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostV2AdminSimulationEewResponse() when $default != null:
return $default(_that.ok,_that.eventId,_that.totalReports,_that.scenario,_that.targetDeviceId,_that.intervalMs,_that.durationMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool ok,  String eventId,  num totalReports,  String scenario,  String targetDeviceId,  num intervalMs,  num durationMs)  $default,) {final _that = this;
switch (_that) {
case _PostV2AdminSimulationEewResponse():
return $default(_that.ok,_that.eventId,_that.totalReports,_that.scenario,_that.targetDeviceId,_that.intervalMs,_that.durationMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool ok,  String eventId,  num totalReports,  String scenario,  String targetDeviceId,  num intervalMs,  num durationMs)?  $default,) {final _that = this;
switch (_that) {
case _PostV2AdminSimulationEewResponse() when $default != null:
return $default(_that.ok,_that.eventId,_that.totalReports,_that.scenario,_that.targetDeviceId,_that.intervalMs,_that.durationMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostV2AdminSimulationEewResponse implements PostV2AdminSimulationEewResponse {
  const _PostV2AdminSimulationEewResponse({required this.ok, required this.eventId, required this.totalReports, required this.scenario, required this.targetDeviceId, required this.intervalMs, required this.durationMs});
  factory _PostV2AdminSimulationEewResponse.fromJson(Map<String, dynamic> json) => _$PostV2AdminSimulationEewResponseFromJson(json);

/// const: true
@override final  bool ok;
@override final  String eventId;
@override final  num totalReports;
@override final  String scenario;
@override final  String targetDeviceId;
@override final  num intervalMs;
@override final  num durationMs;

/// Create a copy of PostV2AdminSimulationEewResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostV2AdminSimulationEewResponseCopyWith<_PostV2AdminSimulationEewResponse> get copyWith => __$PostV2AdminSimulationEewResponseCopyWithImpl<_PostV2AdminSimulationEewResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostV2AdminSimulationEewResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostV2AdminSimulationEewResponse&&(identical(other.ok, ok) || other.ok == ok)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.totalReports, totalReports) || other.totalReports == totalReports)&&(identical(other.scenario, scenario) || other.scenario == scenario)&&(identical(other.targetDeviceId, targetDeviceId) || other.targetDeviceId == targetDeviceId)&&(identical(other.intervalMs, intervalMs) || other.intervalMs == intervalMs)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ok,eventId,totalReports,scenario,targetDeviceId,intervalMs,durationMs);

@override
String toString() {
  return 'PostV2AdminSimulationEewResponse(ok: $ok, eventId: $eventId, totalReports: $totalReports, scenario: $scenario, targetDeviceId: $targetDeviceId, intervalMs: $intervalMs, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class _$PostV2AdminSimulationEewResponseCopyWith<$Res> implements $PostV2AdminSimulationEewResponseCopyWith<$Res> {
  factory _$PostV2AdminSimulationEewResponseCopyWith(_PostV2AdminSimulationEewResponse value, $Res Function(_PostV2AdminSimulationEewResponse) _then) = __$PostV2AdminSimulationEewResponseCopyWithImpl;
@override @useResult
$Res call({
 bool ok, String eventId, num totalReports, String scenario, String targetDeviceId, num intervalMs, num durationMs
});




}
/// @nodoc
class __$PostV2AdminSimulationEewResponseCopyWithImpl<$Res>
    implements _$PostV2AdminSimulationEewResponseCopyWith<$Res> {
  __$PostV2AdminSimulationEewResponseCopyWithImpl(this._self, this._then);

  final _PostV2AdminSimulationEewResponse _self;
  final $Res Function(_PostV2AdminSimulationEewResponse) _then;

/// Create a copy of PostV2AdminSimulationEewResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ok = null,Object? eventId = null,Object? totalReports = null,Object? scenario = null,Object? targetDeviceId = null,Object? intervalMs = null,Object? durationMs = null,}) {
  return _then(_PostV2AdminSimulationEewResponse(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,totalReports: null == totalReports ? _self.totalReports : totalReports // ignore: cast_nullable_to_non_nullable
as num,scenario: null == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as String,targetDeviceId: null == targetDeviceId ? _self.targetDeviceId : targetDeviceId // ignore: cast_nullable_to_non_nullable
as String,intervalMs: null == intervalMs ? _self.intervalMs : intervalMs // ignore: cast_nullable_to_non_nullable
as num,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
