// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'v2_admin_simulation_eew_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$V2AdminSimulationEewRequestBody {

 Scenario get scenario; String get targetDeviceId;@JsonKey(includeIfNull: true) int? get totalReports;@JsonKey(includeIfNull: true) int? get intervalMs;
/// Create a copy of V2AdminSimulationEewRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$V2AdminSimulationEewRequestBodyCopyWith<V2AdminSimulationEewRequestBody> get copyWith => _$V2AdminSimulationEewRequestBodyCopyWithImpl<V2AdminSimulationEewRequestBody>(this as V2AdminSimulationEewRequestBody, _$identity);

  /// Serializes this V2AdminSimulationEewRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is V2AdminSimulationEewRequestBody&&(identical(other.scenario, scenario) || other.scenario == scenario)&&(identical(other.targetDeviceId, targetDeviceId) || other.targetDeviceId == targetDeviceId)&&(identical(other.totalReports, totalReports) || other.totalReports == totalReports)&&(identical(other.intervalMs, intervalMs) || other.intervalMs == intervalMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scenario,targetDeviceId,totalReports,intervalMs);

@override
String toString() {
  return 'V2AdminSimulationEewRequestBody(scenario: $scenario, targetDeviceId: $targetDeviceId, totalReports: $totalReports, intervalMs: $intervalMs)';
}


}

/// @nodoc
abstract mixin class $V2AdminSimulationEewRequestBodyCopyWith<$Res>  {
  factory $V2AdminSimulationEewRequestBodyCopyWith(V2AdminSimulationEewRequestBody value, $Res Function(V2AdminSimulationEewRequestBody) _then) = _$V2AdminSimulationEewRequestBodyCopyWithImpl;
@useResult
$Res call({
 Scenario scenario, String targetDeviceId,@JsonKey(includeIfNull: true) int? totalReports,@JsonKey(includeIfNull: true) int? intervalMs
});




}
/// @nodoc
class _$V2AdminSimulationEewRequestBodyCopyWithImpl<$Res>
    implements $V2AdminSimulationEewRequestBodyCopyWith<$Res> {
  _$V2AdminSimulationEewRequestBodyCopyWithImpl(this._self, this._then);

  final V2AdminSimulationEewRequestBody _self;
  final $Res Function(V2AdminSimulationEewRequestBody) _then;

/// Create a copy of V2AdminSimulationEewRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scenario = null,Object? targetDeviceId = null,Object? totalReports = freezed,Object? intervalMs = freezed,}) {
  return _then(V2AdminSimulationEewRequestBody(
scenario: null == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as Scenario,targetDeviceId: null == targetDeviceId ? _self.targetDeviceId : targetDeviceId // ignore: cast_nullable_to_non_nullable
as String,totalReports: freezed == totalReports ? _self.totalReports : totalReports // ignore: cast_nullable_to_non_nullable
as int?,intervalMs: freezed == intervalMs ? _self.intervalMs : intervalMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [V2AdminSimulationEewRequestBody].
extension V2AdminSimulationEewRequestBodyPatterns on V2AdminSimulationEewRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _V2AdminSimulationEewRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _V2AdminSimulationEewRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _V2AdminSimulationEewRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _V2AdminSimulationEewRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _V2AdminSimulationEewRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _V2AdminSimulationEewRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Scenario scenario,  String targetDeviceId, @JsonKey(includeIfNull: true)  int? totalReports, @JsonKey(includeIfNull: true)  int? intervalMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _V2AdminSimulationEewRequestBody() when $default != null:
return $default(_that.scenario,_that.targetDeviceId,_that.totalReports,_that.intervalMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Scenario scenario,  String targetDeviceId, @JsonKey(includeIfNull: true)  int? totalReports, @JsonKey(includeIfNull: true)  int? intervalMs)  $default,) {final _that = this;
switch (_that) {
case _V2AdminSimulationEewRequestBody():
return $default(_that.scenario,_that.targetDeviceId,_that.totalReports,_that.intervalMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Scenario scenario,  String targetDeviceId, @JsonKey(includeIfNull: true)  int? totalReports, @JsonKey(includeIfNull: true)  int? intervalMs)?  $default,) {final _that = this;
switch (_that) {
case _V2AdminSimulationEewRequestBody() when $default != null:
return $default(_that.scenario,_that.targetDeviceId,_that.totalReports,_that.intervalMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _V2AdminSimulationEewRequestBody implements V2AdminSimulationEewRequestBody {
  const _V2AdminSimulationEewRequestBody({required this.scenario, required this.targetDeviceId, @JsonKey(includeIfNull: true) this.totalReports = 60, @JsonKey(includeIfNull: true) this.intervalMs = 100});
  factory _V2AdminSimulationEewRequestBody.fromJson(Map<String, dynamic> json) => _$V2AdminSimulationEewRequestBodyFromJson(json);

@override final  Scenario scenario;
@override final  String targetDeviceId;
@override@JsonKey(includeIfNull: true) final  int? totalReports;
@override@JsonKey(includeIfNull: true) final  int? intervalMs;

/// Create a copy of V2AdminSimulationEewRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$V2AdminSimulationEewRequestBodyCopyWith<_V2AdminSimulationEewRequestBody> get copyWith => __$V2AdminSimulationEewRequestBodyCopyWithImpl<_V2AdminSimulationEewRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$V2AdminSimulationEewRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _V2AdminSimulationEewRequestBody&&(identical(other.scenario, scenario) || other.scenario == scenario)&&(identical(other.targetDeviceId, targetDeviceId) || other.targetDeviceId == targetDeviceId)&&(identical(other.totalReports, totalReports) || other.totalReports == totalReports)&&(identical(other.intervalMs, intervalMs) || other.intervalMs == intervalMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scenario,targetDeviceId,totalReports,intervalMs);

@override
String toString() {
  return 'V2AdminSimulationEewRequestBody(scenario: $scenario, targetDeviceId: $targetDeviceId, totalReports: $totalReports, intervalMs: $intervalMs)';
}


}

/// @nodoc
abstract mixin class _$V2AdminSimulationEewRequestBodyCopyWith<$Res> implements $V2AdminSimulationEewRequestBodyCopyWith<$Res> {
  factory _$V2AdminSimulationEewRequestBodyCopyWith(_V2AdminSimulationEewRequestBody value, $Res Function(_V2AdminSimulationEewRequestBody) _then) = __$V2AdminSimulationEewRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 Scenario scenario, String targetDeviceId,@JsonKey(includeIfNull: true) int? totalReports,@JsonKey(includeIfNull: true) int? intervalMs
});




}
/// @nodoc
class __$V2AdminSimulationEewRequestBodyCopyWithImpl<$Res>
    implements _$V2AdminSimulationEewRequestBodyCopyWith<$Res> {
  __$V2AdminSimulationEewRequestBodyCopyWithImpl(this._self, this._then);

  final _V2AdminSimulationEewRequestBody _self;
  final $Res Function(_V2AdminSimulationEewRequestBody) _then;

/// Create a copy of V2AdminSimulationEewRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scenario = null,Object? targetDeviceId = null,Object? totalReports = freezed,Object? intervalMs = freezed,}) {
  return _then(_V2AdminSimulationEewRequestBody(
scenario: null == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as Scenario,targetDeviceId: null == targetDeviceId ? _self.targetDeviceId : targetDeviceId // ignore: cast_nullable_to_non_nullable
as String,totalReports: freezed == totalReports ? _self.totalReports : totalReports // ignore: cast_nullable_to_non_nullable
as int?,intervalMs: freezed == intervalMs ? _self.intervalMs : intervalMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
