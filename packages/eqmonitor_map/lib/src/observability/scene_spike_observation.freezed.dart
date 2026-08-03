// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scene_spike_observation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SceneSpikeRunKey {

 SceneSpikePlatform get platform; SceneSpikeBuildMode get buildMode;
/// Create a copy of SceneSpikeRunKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SceneSpikeRunKeyCopyWith<SceneSpikeRunKey> get copyWith => _$SceneSpikeRunKeyCopyWithImpl<SceneSpikeRunKey>(this as SceneSpikeRunKey, _$identity);

  /// Serializes this SceneSpikeRunKey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SceneSpikeRunKey&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.buildMode, buildMode) || other.buildMode == buildMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platform,buildMode);

@override
String toString() {
  return 'SceneSpikeRunKey(platform: $platform, buildMode: $buildMode)';
}


}

/// @nodoc
abstract mixin class $SceneSpikeRunKeyCopyWith<$Res>  {
  factory $SceneSpikeRunKeyCopyWith(SceneSpikeRunKey value, $Res Function(SceneSpikeRunKey) _then) = _$SceneSpikeRunKeyCopyWithImpl;
@useResult
$Res call({
 SceneSpikePlatform platform, SceneSpikeBuildMode buildMode
});




}
/// @nodoc
class _$SceneSpikeRunKeyCopyWithImpl<$Res>
    implements $SceneSpikeRunKeyCopyWith<$Res> {
  _$SceneSpikeRunKeyCopyWithImpl(this._self, this._then);

  final SceneSpikeRunKey _self;
  final $Res Function(SceneSpikeRunKey) _then;

/// Create a copy of SceneSpikeRunKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? platform = null,Object? buildMode = null,}) {
  return _then(_self.copyWith(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as SceneSpikePlatform,buildMode: null == buildMode ? _self.buildMode : buildMode // ignore: cast_nullable_to_non_nullable
as SceneSpikeBuildMode,
  ));
}

}


/// Adds pattern-matching-related methods to [SceneSpikeRunKey].
extension SceneSpikeRunKeyPatterns on SceneSpikeRunKey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SceneSpikeRunKey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SceneSpikeRunKey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SceneSpikeRunKey value)  $default,){
final _that = this;
switch (_that) {
case _SceneSpikeRunKey():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SceneSpikeRunKey value)?  $default,){
final _that = this;
switch (_that) {
case _SceneSpikeRunKey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SceneSpikePlatform platform,  SceneSpikeBuildMode buildMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SceneSpikeRunKey() when $default != null:
return $default(_that.platform,_that.buildMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SceneSpikePlatform platform,  SceneSpikeBuildMode buildMode)  $default,) {final _that = this;
switch (_that) {
case _SceneSpikeRunKey():
return $default(_that.platform,_that.buildMode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SceneSpikePlatform platform,  SceneSpikeBuildMode buildMode)?  $default,) {final _that = this;
switch (_that) {
case _SceneSpikeRunKey() when $default != null:
return $default(_that.platform,_that.buildMode);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SceneSpikeRunKey implements SceneSpikeRunKey {
  const _SceneSpikeRunKey({required this.platform, required this.buildMode});
  factory _SceneSpikeRunKey.fromJson(Map<String, dynamic> json) => _$SceneSpikeRunKeyFromJson(json);

@override final  SceneSpikePlatform platform;
@override final  SceneSpikeBuildMode buildMode;

/// Create a copy of SceneSpikeRunKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SceneSpikeRunKeyCopyWith<_SceneSpikeRunKey> get copyWith => __$SceneSpikeRunKeyCopyWithImpl<_SceneSpikeRunKey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SceneSpikeRunKeyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SceneSpikeRunKey&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.buildMode, buildMode) || other.buildMode == buildMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platform,buildMode);

@override
String toString() {
  return 'SceneSpikeRunKey(platform: $platform, buildMode: $buildMode)';
}


}

/// @nodoc
abstract mixin class _$SceneSpikeRunKeyCopyWith<$Res> implements $SceneSpikeRunKeyCopyWith<$Res> {
  factory _$SceneSpikeRunKeyCopyWith(_SceneSpikeRunKey value, $Res Function(_SceneSpikeRunKey) _then) = __$SceneSpikeRunKeyCopyWithImpl;
@override @useResult
$Res call({
 SceneSpikePlatform platform, SceneSpikeBuildMode buildMode
});




}
/// @nodoc
class __$SceneSpikeRunKeyCopyWithImpl<$Res>
    implements _$SceneSpikeRunKeyCopyWith<$Res> {
  __$SceneSpikeRunKeyCopyWithImpl(this._self, this._then);

  final _SceneSpikeRunKey _self;
  final $Res Function(_SceneSpikeRunKey) _then;

/// Create a copy of SceneSpikeRunKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? platform = null,Object? buildMode = null,}) {
  return _then(_SceneSpikeRunKey(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as SceneSpikePlatform,buildMode: null == buildMode ? _self.buildMode : buildMode // ignore: cast_nullable_to_non_nullable
as SceneSpikeBuildMode,
  ));
}


}


/// @nodoc
mixin _$SceneSpikeCapabilityResult {

 SceneSpikeCapability get capability; SceneSpikeCapabilityStatus get status; SceneSpikeObservationProvenance get provenance; String get detail; DateTime get observedAtUtc;
/// Create a copy of SceneSpikeCapabilityResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SceneSpikeCapabilityResultCopyWith<SceneSpikeCapabilityResult> get copyWith => _$SceneSpikeCapabilityResultCopyWithImpl<SceneSpikeCapabilityResult>(this as SceneSpikeCapabilityResult, _$identity);

  /// Serializes this SceneSpikeCapabilityResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SceneSpikeCapabilityResult&&(identical(other.capability, capability) || other.capability == capability)&&(identical(other.status, status) || other.status == status)&&(identical(other.provenance, provenance) || other.provenance == provenance)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.observedAtUtc, observedAtUtc) || other.observedAtUtc == observedAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,capability,status,provenance,detail,observedAtUtc);

@override
String toString() {
  return 'SceneSpikeCapabilityResult(capability: $capability, status: $status, provenance: $provenance, detail: $detail, observedAtUtc: $observedAtUtc)';
}


}

/// @nodoc
abstract mixin class $SceneSpikeCapabilityResultCopyWith<$Res>  {
  factory $SceneSpikeCapabilityResultCopyWith(SceneSpikeCapabilityResult value, $Res Function(SceneSpikeCapabilityResult) _then) = _$SceneSpikeCapabilityResultCopyWithImpl;
@useResult
$Res call({
 SceneSpikeCapability capability, SceneSpikeCapabilityStatus status, SceneSpikeObservationProvenance provenance, String detail, DateTime observedAtUtc
});




}
/// @nodoc
class _$SceneSpikeCapabilityResultCopyWithImpl<$Res>
    implements $SceneSpikeCapabilityResultCopyWith<$Res> {
  _$SceneSpikeCapabilityResultCopyWithImpl(this._self, this._then);

  final SceneSpikeCapabilityResult _self;
  final $Res Function(SceneSpikeCapabilityResult) _then;

/// Create a copy of SceneSpikeCapabilityResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? capability = null,Object? status = null,Object? provenance = null,Object? detail = null,Object? observedAtUtc = null,}) {
  return _then(_self.copyWith(
capability: null == capability ? _self.capability : capability // ignore: cast_nullable_to_non_nullable
as SceneSpikeCapability,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SceneSpikeCapabilityStatus,provenance: null == provenance ? _self.provenance : provenance // ignore: cast_nullable_to_non_nullable
as SceneSpikeObservationProvenance,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,observedAtUtc: null == observedAtUtc ? _self.observedAtUtc : observedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SceneSpikeCapabilityResult].
extension SceneSpikeCapabilityResultPatterns on SceneSpikeCapabilityResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SceneSpikeCapabilityResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SceneSpikeCapabilityResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SceneSpikeCapabilityResult value)  $default,){
final _that = this;
switch (_that) {
case _SceneSpikeCapabilityResult():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SceneSpikeCapabilityResult value)?  $default,){
final _that = this;
switch (_that) {
case _SceneSpikeCapabilityResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SceneSpikeCapability capability,  SceneSpikeCapabilityStatus status,  SceneSpikeObservationProvenance provenance,  String detail,  DateTime observedAtUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SceneSpikeCapabilityResult() when $default != null:
return $default(_that.capability,_that.status,_that.provenance,_that.detail,_that.observedAtUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SceneSpikeCapability capability,  SceneSpikeCapabilityStatus status,  SceneSpikeObservationProvenance provenance,  String detail,  DateTime observedAtUtc)  $default,) {final _that = this;
switch (_that) {
case _SceneSpikeCapabilityResult():
return $default(_that.capability,_that.status,_that.provenance,_that.detail,_that.observedAtUtc);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SceneSpikeCapability capability,  SceneSpikeCapabilityStatus status,  SceneSpikeObservationProvenance provenance,  String detail,  DateTime observedAtUtc)?  $default,) {final _that = this;
switch (_that) {
case _SceneSpikeCapabilityResult() when $default != null:
return $default(_that.capability,_that.status,_that.provenance,_that.detail,_that.observedAtUtc);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SceneSpikeCapabilityResult implements SceneSpikeCapabilityResult {
  const _SceneSpikeCapabilityResult({required this.capability, required this.status, required this.provenance, required this.detail, required this.observedAtUtc});
  factory _SceneSpikeCapabilityResult.fromJson(Map<String, dynamic> json) => _$SceneSpikeCapabilityResultFromJson(json);

@override final  SceneSpikeCapability capability;
@override final  SceneSpikeCapabilityStatus status;
@override final  SceneSpikeObservationProvenance provenance;
@override final  String detail;
@override final  DateTime observedAtUtc;

/// Create a copy of SceneSpikeCapabilityResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SceneSpikeCapabilityResultCopyWith<_SceneSpikeCapabilityResult> get copyWith => __$SceneSpikeCapabilityResultCopyWithImpl<_SceneSpikeCapabilityResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SceneSpikeCapabilityResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SceneSpikeCapabilityResult&&(identical(other.capability, capability) || other.capability == capability)&&(identical(other.status, status) || other.status == status)&&(identical(other.provenance, provenance) || other.provenance == provenance)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.observedAtUtc, observedAtUtc) || other.observedAtUtc == observedAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,capability,status,provenance,detail,observedAtUtc);

@override
String toString() {
  return 'SceneSpikeCapabilityResult(capability: $capability, status: $status, provenance: $provenance, detail: $detail, observedAtUtc: $observedAtUtc)';
}


}

/// @nodoc
abstract mixin class _$SceneSpikeCapabilityResultCopyWith<$Res> implements $SceneSpikeCapabilityResultCopyWith<$Res> {
  factory _$SceneSpikeCapabilityResultCopyWith(_SceneSpikeCapabilityResult value, $Res Function(_SceneSpikeCapabilityResult) _then) = __$SceneSpikeCapabilityResultCopyWithImpl;
@override @useResult
$Res call({
 SceneSpikeCapability capability, SceneSpikeCapabilityStatus status, SceneSpikeObservationProvenance provenance, String detail, DateTime observedAtUtc
});




}
/// @nodoc
class __$SceneSpikeCapabilityResultCopyWithImpl<$Res>
    implements _$SceneSpikeCapabilityResultCopyWith<$Res> {
  __$SceneSpikeCapabilityResultCopyWithImpl(this._self, this._then);

  final _SceneSpikeCapabilityResult _self;
  final $Res Function(_SceneSpikeCapabilityResult) _then;

/// Create a copy of SceneSpikeCapabilityResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? capability = null,Object? status = null,Object? provenance = null,Object? detail = null,Object? observedAtUtc = null,}) {
  return _then(_SceneSpikeCapabilityResult(
capability: null == capability ? _self.capability : capability // ignore: cast_nullable_to_non_nullable
as SceneSpikeCapability,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SceneSpikeCapabilityStatus,provenance: null == provenance ? _self.provenance : provenance // ignore: cast_nullable_to_non_nullable
as SceneSpikeObservationProvenance,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,observedAtUtc: null == observedAtUtc ? _self.observedAtUtc : observedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$SceneSpikeCustomMaterialRuntimeSuccess {

@SceneSpikeStrictIntConverter() int get controllerGeneration;@SceneSpikeStrictIntConverter() int get appResourceGeneration; DateTime get observedAtUtc;
/// Create a copy of SceneSpikeCustomMaterialRuntimeSuccess
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SceneSpikeCustomMaterialRuntimeSuccessCopyWith<SceneSpikeCustomMaterialRuntimeSuccess> get copyWith => _$SceneSpikeCustomMaterialRuntimeSuccessCopyWithImpl<SceneSpikeCustomMaterialRuntimeSuccess>(this as SceneSpikeCustomMaterialRuntimeSuccess, _$identity);

  /// Serializes this SceneSpikeCustomMaterialRuntimeSuccess to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SceneSpikeCustomMaterialRuntimeSuccess&&(identical(other.controllerGeneration, controllerGeneration) || other.controllerGeneration == controllerGeneration)&&(identical(other.appResourceGeneration, appResourceGeneration) || other.appResourceGeneration == appResourceGeneration)&&(identical(other.observedAtUtc, observedAtUtc) || other.observedAtUtc == observedAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,controllerGeneration,appResourceGeneration,observedAtUtc);

@override
String toString() {
  return 'SceneSpikeCustomMaterialRuntimeSuccess(controllerGeneration: $controllerGeneration, appResourceGeneration: $appResourceGeneration, observedAtUtc: $observedAtUtc)';
}


}

/// @nodoc
abstract mixin class $SceneSpikeCustomMaterialRuntimeSuccessCopyWith<$Res>  {
  factory $SceneSpikeCustomMaterialRuntimeSuccessCopyWith(SceneSpikeCustomMaterialRuntimeSuccess value, $Res Function(SceneSpikeCustomMaterialRuntimeSuccess) _then) = _$SceneSpikeCustomMaterialRuntimeSuccessCopyWithImpl;
@useResult
$Res call({
@SceneSpikeStrictIntConverter() int controllerGeneration,@SceneSpikeStrictIntConverter() int appResourceGeneration, DateTime observedAtUtc
});




}
/// @nodoc
class _$SceneSpikeCustomMaterialRuntimeSuccessCopyWithImpl<$Res>
    implements $SceneSpikeCustomMaterialRuntimeSuccessCopyWith<$Res> {
  _$SceneSpikeCustomMaterialRuntimeSuccessCopyWithImpl(this._self, this._then);

  final SceneSpikeCustomMaterialRuntimeSuccess _self;
  final $Res Function(SceneSpikeCustomMaterialRuntimeSuccess) _then;

/// Create a copy of SceneSpikeCustomMaterialRuntimeSuccess
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? controllerGeneration = null,Object? appResourceGeneration = null,Object? observedAtUtc = null,}) {
  return _then(_self.copyWith(
controllerGeneration: null == controllerGeneration ? _self.controllerGeneration : controllerGeneration // ignore: cast_nullable_to_non_nullable
as int,appResourceGeneration: null == appResourceGeneration ? _self.appResourceGeneration : appResourceGeneration // ignore: cast_nullable_to_non_nullable
as int,observedAtUtc: null == observedAtUtc ? _self.observedAtUtc : observedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SceneSpikeCustomMaterialRuntimeSuccess].
extension SceneSpikeCustomMaterialRuntimeSuccessPatterns on SceneSpikeCustomMaterialRuntimeSuccess {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SceneSpikeCustomMaterialRuntimeSuccess value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SceneSpikeCustomMaterialRuntimeSuccess() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SceneSpikeCustomMaterialRuntimeSuccess value)  $default,){
final _that = this;
switch (_that) {
case _SceneSpikeCustomMaterialRuntimeSuccess():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SceneSpikeCustomMaterialRuntimeSuccess value)?  $default,){
final _that = this;
switch (_that) {
case _SceneSpikeCustomMaterialRuntimeSuccess() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@SceneSpikeStrictIntConverter()  int controllerGeneration, @SceneSpikeStrictIntConverter()  int appResourceGeneration,  DateTime observedAtUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SceneSpikeCustomMaterialRuntimeSuccess() when $default != null:
return $default(_that.controllerGeneration,_that.appResourceGeneration,_that.observedAtUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@SceneSpikeStrictIntConverter()  int controllerGeneration, @SceneSpikeStrictIntConverter()  int appResourceGeneration,  DateTime observedAtUtc)  $default,) {final _that = this;
switch (_that) {
case _SceneSpikeCustomMaterialRuntimeSuccess():
return $default(_that.controllerGeneration,_that.appResourceGeneration,_that.observedAtUtc);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@SceneSpikeStrictIntConverter()  int controllerGeneration, @SceneSpikeStrictIntConverter()  int appResourceGeneration,  DateTime observedAtUtc)?  $default,) {final _that = this;
switch (_that) {
case _SceneSpikeCustomMaterialRuntimeSuccess() when $default != null:
return $default(_that.controllerGeneration,_that.appResourceGeneration,_that.observedAtUtc);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SceneSpikeCustomMaterialRuntimeSuccess implements SceneSpikeCustomMaterialRuntimeSuccess {
  const _SceneSpikeCustomMaterialRuntimeSuccess({@SceneSpikeStrictIntConverter() required this.controllerGeneration, @SceneSpikeStrictIntConverter() required this.appResourceGeneration, required this.observedAtUtc});
  factory _SceneSpikeCustomMaterialRuntimeSuccess.fromJson(Map<String, dynamic> json) => _$SceneSpikeCustomMaterialRuntimeSuccessFromJson(json);

@override@SceneSpikeStrictIntConverter() final  int controllerGeneration;
@override@SceneSpikeStrictIntConverter() final  int appResourceGeneration;
@override final  DateTime observedAtUtc;

/// Create a copy of SceneSpikeCustomMaterialRuntimeSuccess
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SceneSpikeCustomMaterialRuntimeSuccessCopyWith<_SceneSpikeCustomMaterialRuntimeSuccess> get copyWith => __$SceneSpikeCustomMaterialRuntimeSuccessCopyWithImpl<_SceneSpikeCustomMaterialRuntimeSuccess>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SceneSpikeCustomMaterialRuntimeSuccessToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SceneSpikeCustomMaterialRuntimeSuccess&&(identical(other.controllerGeneration, controllerGeneration) || other.controllerGeneration == controllerGeneration)&&(identical(other.appResourceGeneration, appResourceGeneration) || other.appResourceGeneration == appResourceGeneration)&&(identical(other.observedAtUtc, observedAtUtc) || other.observedAtUtc == observedAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,controllerGeneration,appResourceGeneration,observedAtUtc);

@override
String toString() {
  return 'SceneSpikeCustomMaterialRuntimeSuccess(controllerGeneration: $controllerGeneration, appResourceGeneration: $appResourceGeneration, observedAtUtc: $observedAtUtc)';
}


}

/// @nodoc
abstract mixin class _$SceneSpikeCustomMaterialRuntimeSuccessCopyWith<$Res> implements $SceneSpikeCustomMaterialRuntimeSuccessCopyWith<$Res> {
  factory _$SceneSpikeCustomMaterialRuntimeSuccessCopyWith(_SceneSpikeCustomMaterialRuntimeSuccess value, $Res Function(_SceneSpikeCustomMaterialRuntimeSuccess) _then) = __$SceneSpikeCustomMaterialRuntimeSuccessCopyWithImpl;
@override @useResult
$Res call({
@SceneSpikeStrictIntConverter() int controllerGeneration,@SceneSpikeStrictIntConverter() int appResourceGeneration, DateTime observedAtUtc
});




}
/// @nodoc
class __$SceneSpikeCustomMaterialRuntimeSuccessCopyWithImpl<$Res>
    implements _$SceneSpikeCustomMaterialRuntimeSuccessCopyWith<$Res> {
  __$SceneSpikeCustomMaterialRuntimeSuccessCopyWithImpl(this._self, this._then);

  final _SceneSpikeCustomMaterialRuntimeSuccess _self;
  final $Res Function(_SceneSpikeCustomMaterialRuntimeSuccess) _then;

/// Create a copy of SceneSpikeCustomMaterialRuntimeSuccess
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? controllerGeneration = null,Object? appResourceGeneration = null,Object? observedAtUtc = null,}) {
  return _then(_SceneSpikeCustomMaterialRuntimeSuccess(
controllerGeneration: null == controllerGeneration ? _self.controllerGeneration : controllerGeneration // ignore: cast_nullable_to_non_nullable
as int,appResourceGeneration: null == appResourceGeneration ? _self.appResourceGeneration : appResourceGeneration // ignore: cast_nullable_to_non_nullable
as int,observedAtUtc: null == observedAtUtc ? _self.observedAtUtc : observedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$SceneSpikePerformanceSnapshot {

@SceneSpikeStrictIntConverter() int get buildDurationCount;@SceneSpikeStrictIntConverter() int get buildDurationMaxMicroseconds;@SceneSpikeStrictIntConverter() int get buildDurationP50Microseconds;@SceneSpikeStrictIntConverter() int get buildDurationP95Microseconds;@SceneSpikeStrictIntConverter() int get rasterDurationCount;@SceneSpikeStrictIntConverter() int get rasterDurationMaxMicroseconds;@SceneSpikeStrictIntConverter() int get rasterDurationP50Microseconds;@SceneSpikeStrictIntConverter() int get rasterDurationP95Microseconds;@SceneSpikeStrictIntConverter() int get droppedFrameCount;@SceneSpikeStrictIntConverter() int get partialUpdateCount;@SceneSpikeStrictIntConverter() int get resourceRebuildCount;@SceneSpikeStrictIntConverter() int get exceptionCount;
/// Create a copy of SceneSpikePerformanceSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SceneSpikePerformanceSnapshotCopyWith<SceneSpikePerformanceSnapshot> get copyWith => _$SceneSpikePerformanceSnapshotCopyWithImpl<SceneSpikePerformanceSnapshot>(this as SceneSpikePerformanceSnapshot, _$identity);

  /// Serializes this SceneSpikePerformanceSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SceneSpikePerformanceSnapshot&&(identical(other.buildDurationCount, buildDurationCount) || other.buildDurationCount == buildDurationCount)&&(identical(other.buildDurationMaxMicroseconds, buildDurationMaxMicroseconds) || other.buildDurationMaxMicroseconds == buildDurationMaxMicroseconds)&&(identical(other.buildDurationP50Microseconds, buildDurationP50Microseconds) || other.buildDurationP50Microseconds == buildDurationP50Microseconds)&&(identical(other.buildDurationP95Microseconds, buildDurationP95Microseconds) || other.buildDurationP95Microseconds == buildDurationP95Microseconds)&&(identical(other.rasterDurationCount, rasterDurationCount) || other.rasterDurationCount == rasterDurationCount)&&(identical(other.rasterDurationMaxMicroseconds, rasterDurationMaxMicroseconds) || other.rasterDurationMaxMicroseconds == rasterDurationMaxMicroseconds)&&(identical(other.rasterDurationP50Microseconds, rasterDurationP50Microseconds) || other.rasterDurationP50Microseconds == rasterDurationP50Microseconds)&&(identical(other.rasterDurationP95Microseconds, rasterDurationP95Microseconds) || other.rasterDurationP95Microseconds == rasterDurationP95Microseconds)&&(identical(other.droppedFrameCount, droppedFrameCount) || other.droppedFrameCount == droppedFrameCount)&&(identical(other.partialUpdateCount, partialUpdateCount) || other.partialUpdateCount == partialUpdateCount)&&(identical(other.resourceRebuildCount, resourceRebuildCount) || other.resourceRebuildCount == resourceRebuildCount)&&(identical(other.exceptionCount, exceptionCount) || other.exceptionCount == exceptionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,buildDurationCount,buildDurationMaxMicroseconds,buildDurationP50Microseconds,buildDurationP95Microseconds,rasterDurationCount,rasterDurationMaxMicroseconds,rasterDurationP50Microseconds,rasterDurationP95Microseconds,droppedFrameCount,partialUpdateCount,resourceRebuildCount,exceptionCount);

@override
String toString() {
  return 'SceneSpikePerformanceSnapshot(buildDurationCount: $buildDurationCount, buildDurationMaxMicroseconds: $buildDurationMaxMicroseconds, buildDurationP50Microseconds: $buildDurationP50Microseconds, buildDurationP95Microseconds: $buildDurationP95Microseconds, rasterDurationCount: $rasterDurationCount, rasterDurationMaxMicroseconds: $rasterDurationMaxMicroseconds, rasterDurationP50Microseconds: $rasterDurationP50Microseconds, rasterDurationP95Microseconds: $rasterDurationP95Microseconds, droppedFrameCount: $droppedFrameCount, partialUpdateCount: $partialUpdateCount, resourceRebuildCount: $resourceRebuildCount, exceptionCount: $exceptionCount)';
}


}

/// @nodoc
abstract mixin class $SceneSpikePerformanceSnapshotCopyWith<$Res>  {
  factory $SceneSpikePerformanceSnapshotCopyWith(SceneSpikePerformanceSnapshot value, $Res Function(SceneSpikePerformanceSnapshot) _then) = _$SceneSpikePerformanceSnapshotCopyWithImpl;
@useResult
$Res call({
@SceneSpikeStrictIntConverter() int buildDurationCount,@SceneSpikeStrictIntConverter() int buildDurationMaxMicroseconds,@SceneSpikeStrictIntConverter() int buildDurationP50Microseconds,@SceneSpikeStrictIntConverter() int buildDurationP95Microseconds,@SceneSpikeStrictIntConverter() int rasterDurationCount,@SceneSpikeStrictIntConverter() int rasterDurationMaxMicroseconds,@SceneSpikeStrictIntConverter() int rasterDurationP50Microseconds,@SceneSpikeStrictIntConverter() int rasterDurationP95Microseconds,@SceneSpikeStrictIntConverter() int droppedFrameCount,@SceneSpikeStrictIntConverter() int partialUpdateCount,@SceneSpikeStrictIntConverter() int resourceRebuildCount,@SceneSpikeStrictIntConverter() int exceptionCount
});




}
/// @nodoc
class _$SceneSpikePerformanceSnapshotCopyWithImpl<$Res>
    implements $SceneSpikePerformanceSnapshotCopyWith<$Res> {
  _$SceneSpikePerformanceSnapshotCopyWithImpl(this._self, this._then);

  final SceneSpikePerformanceSnapshot _self;
  final $Res Function(SceneSpikePerformanceSnapshot) _then;

/// Create a copy of SceneSpikePerformanceSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buildDurationCount = null,Object? buildDurationMaxMicroseconds = null,Object? buildDurationP50Microseconds = null,Object? buildDurationP95Microseconds = null,Object? rasterDurationCount = null,Object? rasterDurationMaxMicroseconds = null,Object? rasterDurationP50Microseconds = null,Object? rasterDurationP95Microseconds = null,Object? droppedFrameCount = null,Object? partialUpdateCount = null,Object? resourceRebuildCount = null,Object? exceptionCount = null,}) {
  return _then(_self.copyWith(
buildDurationCount: null == buildDurationCount ? _self.buildDurationCount : buildDurationCount // ignore: cast_nullable_to_non_nullable
as int,buildDurationMaxMicroseconds: null == buildDurationMaxMicroseconds ? _self.buildDurationMaxMicroseconds : buildDurationMaxMicroseconds // ignore: cast_nullable_to_non_nullable
as int,buildDurationP50Microseconds: null == buildDurationP50Microseconds ? _self.buildDurationP50Microseconds : buildDurationP50Microseconds // ignore: cast_nullable_to_non_nullable
as int,buildDurationP95Microseconds: null == buildDurationP95Microseconds ? _self.buildDurationP95Microseconds : buildDurationP95Microseconds // ignore: cast_nullable_to_non_nullable
as int,rasterDurationCount: null == rasterDurationCount ? _self.rasterDurationCount : rasterDurationCount // ignore: cast_nullable_to_non_nullable
as int,rasterDurationMaxMicroseconds: null == rasterDurationMaxMicroseconds ? _self.rasterDurationMaxMicroseconds : rasterDurationMaxMicroseconds // ignore: cast_nullable_to_non_nullable
as int,rasterDurationP50Microseconds: null == rasterDurationP50Microseconds ? _self.rasterDurationP50Microseconds : rasterDurationP50Microseconds // ignore: cast_nullable_to_non_nullable
as int,rasterDurationP95Microseconds: null == rasterDurationP95Microseconds ? _self.rasterDurationP95Microseconds : rasterDurationP95Microseconds // ignore: cast_nullable_to_non_nullable
as int,droppedFrameCount: null == droppedFrameCount ? _self.droppedFrameCount : droppedFrameCount // ignore: cast_nullable_to_non_nullable
as int,partialUpdateCount: null == partialUpdateCount ? _self.partialUpdateCount : partialUpdateCount // ignore: cast_nullable_to_non_nullable
as int,resourceRebuildCount: null == resourceRebuildCount ? _self.resourceRebuildCount : resourceRebuildCount // ignore: cast_nullable_to_non_nullable
as int,exceptionCount: null == exceptionCount ? _self.exceptionCount : exceptionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SceneSpikePerformanceSnapshot].
extension SceneSpikePerformanceSnapshotPatterns on SceneSpikePerformanceSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SceneSpikePerformanceSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SceneSpikePerformanceSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SceneSpikePerformanceSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _SceneSpikePerformanceSnapshot():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SceneSpikePerformanceSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _SceneSpikePerformanceSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@SceneSpikeStrictIntConverter()  int buildDurationCount, @SceneSpikeStrictIntConverter()  int buildDurationMaxMicroseconds, @SceneSpikeStrictIntConverter()  int buildDurationP50Microseconds, @SceneSpikeStrictIntConverter()  int buildDurationP95Microseconds, @SceneSpikeStrictIntConverter()  int rasterDurationCount, @SceneSpikeStrictIntConverter()  int rasterDurationMaxMicroseconds, @SceneSpikeStrictIntConverter()  int rasterDurationP50Microseconds, @SceneSpikeStrictIntConverter()  int rasterDurationP95Microseconds, @SceneSpikeStrictIntConverter()  int droppedFrameCount, @SceneSpikeStrictIntConverter()  int partialUpdateCount, @SceneSpikeStrictIntConverter()  int resourceRebuildCount, @SceneSpikeStrictIntConverter()  int exceptionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SceneSpikePerformanceSnapshot() when $default != null:
return $default(_that.buildDurationCount,_that.buildDurationMaxMicroseconds,_that.buildDurationP50Microseconds,_that.buildDurationP95Microseconds,_that.rasterDurationCount,_that.rasterDurationMaxMicroseconds,_that.rasterDurationP50Microseconds,_that.rasterDurationP95Microseconds,_that.droppedFrameCount,_that.partialUpdateCount,_that.resourceRebuildCount,_that.exceptionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@SceneSpikeStrictIntConverter()  int buildDurationCount, @SceneSpikeStrictIntConverter()  int buildDurationMaxMicroseconds, @SceneSpikeStrictIntConverter()  int buildDurationP50Microseconds, @SceneSpikeStrictIntConverter()  int buildDurationP95Microseconds, @SceneSpikeStrictIntConverter()  int rasterDurationCount, @SceneSpikeStrictIntConverter()  int rasterDurationMaxMicroseconds, @SceneSpikeStrictIntConverter()  int rasterDurationP50Microseconds, @SceneSpikeStrictIntConverter()  int rasterDurationP95Microseconds, @SceneSpikeStrictIntConverter()  int droppedFrameCount, @SceneSpikeStrictIntConverter()  int partialUpdateCount, @SceneSpikeStrictIntConverter()  int resourceRebuildCount, @SceneSpikeStrictIntConverter()  int exceptionCount)  $default,) {final _that = this;
switch (_that) {
case _SceneSpikePerformanceSnapshot():
return $default(_that.buildDurationCount,_that.buildDurationMaxMicroseconds,_that.buildDurationP50Microseconds,_that.buildDurationP95Microseconds,_that.rasterDurationCount,_that.rasterDurationMaxMicroseconds,_that.rasterDurationP50Microseconds,_that.rasterDurationP95Microseconds,_that.droppedFrameCount,_that.partialUpdateCount,_that.resourceRebuildCount,_that.exceptionCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@SceneSpikeStrictIntConverter()  int buildDurationCount, @SceneSpikeStrictIntConverter()  int buildDurationMaxMicroseconds, @SceneSpikeStrictIntConverter()  int buildDurationP50Microseconds, @SceneSpikeStrictIntConverter()  int buildDurationP95Microseconds, @SceneSpikeStrictIntConverter()  int rasterDurationCount, @SceneSpikeStrictIntConverter()  int rasterDurationMaxMicroseconds, @SceneSpikeStrictIntConverter()  int rasterDurationP50Microseconds, @SceneSpikeStrictIntConverter()  int rasterDurationP95Microseconds, @SceneSpikeStrictIntConverter()  int droppedFrameCount, @SceneSpikeStrictIntConverter()  int partialUpdateCount, @SceneSpikeStrictIntConverter()  int resourceRebuildCount, @SceneSpikeStrictIntConverter()  int exceptionCount)?  $default,) {final _that = this;
switch (_that) {
case _SceneSpikePerformanceSnapshot() when $default != null:
return $default(_that.buildDurationCount,_that.buildDurationMaxMicroseconds,_that.buildDurationP50Microseconds,_that.buildDurationP95Microseconds,_that.rasterDurationCount,_that.rasterDurationMaxMicroseconds,_that.rasterDurationP50Microseconds,_that.rasterDurationP95Microseconds,_that.droppedFrameCount,_that.partialUpdateCount,_that.resourceRebuildCount,_that.exceptionCount);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SceneSpikePerformanceSnapshot implements SceneSpikePerformanceSnapshot {
  const _SceneSpikePerformanceSnapshot({@SceneSpikeStrictIntConverter() required this.buildDurationCount, @SceneSpikeStrictIntConverter() required this.buildDurationMaxMicroseconds, @SceneSpikeStrictIntConverter() required this.buildDurationP50Microseconds, @SceneSpikeStrictIntConverter() required this.buildDurationP95Microseconds, @SceneSpikeStrictIntConverter() required this.rasterDurationCount, @SceneSpikeStrictIntConverter() required this.rasterDurationMaxMicroseconds, @SceneSpikeStrictIntConverter() required this.rasterDurationP50Microseconds, @SceneSpikeStrictIntConverter() required this.rasterDurationP95Microseconds, @SceneSpikeStrictIntConverter() required this.droppedFrameCount, @SceneSpikeStrictIntConverter() required this.partialUpdateCount, @SceneSpikeStrictIntConverter() required this.resourceRebuildCount, @SceneSpikeStrictIntConverter() required this.exceptionCount});
  factory _SceneSpikePerformanceSnapshot.fromJson(Map<String, dynamic> json) => _$SceneSpikePerformanceSnapshotFromJson(json);

@override@SceneSpikeStrictIntConverter() final  int buildDurationCount;
@override@SceneSpikeStrictIntConverter() final  int buildDurationMaxMicroseconds;
@override@SceneSpikeStrictIntConverter() final  int buildDurationP50Microseconds;
@override@SceneSpikeStrictIntConverter() final  int buildDurationP95Microseconds;
@override@SceneSpikeStrictIntConverter() final  int rasterDurationCount;
@override@SceneSpikeStrictIntConverter() final  int rasterDurationMaxMicroseconds;
@override@SceneSpikeStrictIntConverter() final  int rasterDurationP50Microseconds;
@override@SceneSpikeStrictIntConverter() final  int rasterDurationP95Microseconds;
@override@SceneSpikeStrictIntConverter() final  int droppedFrameCount;
@override@SceneSpikeStrictIntConverter() final  int partialUpdateCount;
@override@SceneSpikeStrictIntConverter() final  int resourceRebuildCount;
@override@SceneSpikeStrictIntConverter() final  int exceptionCount;

/// Create a copy of SceneSpikePerformanceSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SceneSpikePerformanceSnapshotCopyWith<_SceneSpikePerformanceSnapshot> get copyWith => __$SceneSpikePerformanceSnapshotCopyWithImpl<_SceneSpikePerformanceSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SceneSpikePerformanceSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SceneSpikePerformanceSnapshot&&(identical(other.buildDurationCount, buildDurationCount) || other.buildDurationCount == buildDurationCount)&&(identical(other.buildDurationMaxMicroseconds, buildDurationMaxMicroseconds) || other.buildDurationMaxMicroseconds == buildDurationMaxMicroseconds)&&(identical(other.buildDurationP50Microseconds, buildDurationP50Microseconds) || other.buildDurationP50Microseconds == buildDurationP50Microseconds)&&(identical(other.buildDurationP95Microseconds, buildDurationP95Microseconds) || other.buildDurationP95Microseconds == buildDurationP95Microseconds)&&(identical(other.rasterDurationCount, rasterDurationCount) || other.rasterDurationCount == rasterDurationCount)&&(identical(other.rasterDurationMaxMicroseconds, rasterDurationMaxMicroseconds) || other.rasterDurationMaxMicroseconds == rasterDurationMaxMicroseconds)&&(identical(other.rasterDurationP50Microseconds, rasterDurationP50Microseconds) || other.rasterDurationP50Microseconds == rasterDurationP50Microseconds)&&(identical(other.rasterDurationP95Microseconds, rasterDurationP95Microseconds) || other.rasterDurationP95Microseconds == rasterDurationP95Microseconds)&&(identical(other.droppedFrameCount, droppedFrameCount) || other.droppedFrameCount == droppedFrameCount)&&(identical(other.partialUpdateCount, partialUpdateCount) || other.partialUpdateCount == partialUpdateCount)&&(identical(other.resourceRebuildCount, resourceRebuildCount) || other.resourceRebuildCount == resourceRebuildCount)&&(identical(other.exceptionCount, exceptionCount) || other.exceptionCount == exceptionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,buildDurationCount,buildDurationMaxMicroseconds,buildDurationP50Microseconds,buildDurationP95Microseconds,rasterDurationCount,rasterDurationMaxMicroseconds,rasterDurationP50Microseconds,rasterDurationP95Microseconds,droppedFrameCount,partialUpdateCount,resourceRebuildCount,exceptionCount);

@override
String toString() {
  return 'SceneSpikePerformanceSnapshot(buildDurationCount: $buildDurationCount, buildDurationMaxMicroseconds: $buildDurationMaxMicroseconds, buildDurationP50Microseconds: $buildDurationP50Microseconds, buildDurationP95Microseconds: $buildDurationP95Microseconds, rasterDurationCount: $rasterDurationCount, rasterDurationMaxMicroseconds: $rasterDurationMaxMicroseconds, rasterDurationP50Microseconds: $rasterDurationP50Microseconds, rasterDurationP95Microseconds: $rasterDurationP95Microseconds, droppedFrameCount: $droppedFrameCount, partialUpdateCount: $partialUpdateCount, resourceRebuildCount: $resourceRebuildCount, exceptionCount: $exceptionCount)';
}


}

/// @nodoc
abstract mixin class _$SceneSpikePerformanceSnapshotCopyWith<$Res> implements $SceneSpikePerformanceSnapshotCopyWith<$Res> {
  factory _$SceneSpikePerformanceSnapshotCopyWith(_SceneSpikePerformanceSnapshot value, $Res Function(_SceneSpikePerformanceSnapshot) _then) = __$SceneSpikePerformanceSnapshotCopyWithImpl;
@override @useResult
$Res call({
@SceneSpikeStrictIntConverter() int buildDurationCount,@SceneSpikeStrictIntConverter() int buildDurationMaxMicroseconds,@SceneSpikeStrictIntConverter() int buildDurationP50Microseconds,@SceneSpikeStrictIntConverter() int buildDurationP95Microseconds,@SceneSpikeStrictIntConverter() int rasterDurationCount,@SceneSpikeStrictIntConverter() int rasterDurationMaxMicroseconds,@SceneSpikeStrictIntConverter() int rasterDurationP50Microseconds,@SceneSpikeStrictIntConverter() int rasterDurationP95Microseconds,@SceneSpikeStrictIntConverter() int droppedFrameCount,@SceneSpikeStrictIntConverter() int partialUpdateCount,@SceneSpikeStrictIntConverter() int resourceRebuildCount,@SceneSpikeStrictIntConverter() int exceptionCount
});




}
/// @nodoc
class __$SceneSpikePerformanceSnapshotCopyWithImpl<$Res>
    implements _$SceneSpikePerformanceSnapshotCopyWith<$Res> {
  __$SceneSpikePerformanceSnapshotCopyWithImpl(this._self, this._then);

  final _SceneSpikePerformanceSnapshot _self;
  final $Res Function(_SceneSpikePerformanceSnapshot) _then;

/// Create a copy of SceneSpikePerformanceSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? buildDurationCount = null,Object? buildDurationMaxMicroseconds = null,Object? buildDurationP50Microseconds = null,Object? buildDurationP95Microseconds = null,Object? rasterDurationCount = null,Object? rasterDurationMaxMicroseconds = null,Object? rasterDurationP50Microseconds = null,Object? rasterDurationP95Microseconds = null,Object? droppedFrameCount = null,Object? partialUpdateCount = null,Object? resourceRebuildCount = null,Object? exceptionCount = null,}) {
  return _then(_SceneSpikePerformanceSnapshot(
buildDurationCount: null == buildDurationCount ? _self.buildDurationCount : buildDurationCount // ignore: cast_nullable_to_non_nullable
as int,buildDurationMaxMicroseconds: null == buildDurationMaxMicroseconds ? _self.buildDurationMaxMicroseconds : buildDurationMaxMicroseconds // ignore: cast_nullable_to_non_nullable
as int,buildDurationP50Microseconds: null == buildDurationP50Microseconds ? _self.buildDurationP50Microseconds : buildDurationP50Microseconds // ignore: cast_nullable_to_non_nullable
as int,buildDurationP95Microseconds: null == buildDurationP95Microseconds ? _self.buildDurationP95Microseconds : buildDurationP95Microseconds // ignore: cast_nullable_to_non_nullable
as int,rasterDurationCount: null == rasterDurationCount ? _self.rasterDurationCount : rasterDurationCount // ignore: cast_nullable_to_non_nullable
as int,rasterDurationMaxMicroseconds: null == rasterDurationMaxMicroseconds ? _self.rasterDurationMaxMicroseconds : rasterDurationMaxMicroseconds // ignore: cast_nullable_to_non_nullable
as int,rasterDurationP50Microseconds: null == rasterDurationP50Microseconds ? _self.rasterDurationP50Microseconds : rasterDurationP50Microseconds // ignore: cast_nullable_to_non_nullable
as int,rasterDurationP95Microseconds: null == rasterDurationP95Microseconds ? _self.rasterDurationP95Microseconds : rasterDurationP95Microseconds // ignore: cast_nullable_to_non_nullable
as int,droppedFrameCount: null == droppedFrameCount ? _self.droppedFrameCount : droppedFrameCount // ignore: cast_nullable_to_non_nullable
as int,partialUpdateCount: null == partialUpdateCount ? _self.partialUpdateCount : partialUpdateCount // ignore: cast_nullable_to_non_nullable
as int,resourceRebuildCount: null == resourceRebuildCount ? _self.resourceRebuildCount : resourceRebuildCount // ignore: cast_nullable_to_non_nullable
as int,exceptionCount: null == exceptionCount ? _self.exceptionCount : exceptionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SceneSpikeEvidence {

 int get schemaVersion; SceneSpikeRunKey get run; String get deviceModel; String get operatingSystemVersion; String get flutterFrameworkRevision; String get flutterEngineRevision; String get dartVersion; String get dartSourceRevision; String get flutterSceneRevision; String get eqmonitorMapRendererRevision; bool get eqmonitorMapRendererCheckoutDirty; SceneSpikeObservationProvenance get revisionProvenance; String get renderingBackend; SceneSpikeObservationProvenance get renderingBackendProvenance; DateTime get startedAtUtc; int get elapsedMicroseconds; int get frameCount; int get partialUpdateCount; int get lifecycleResumeCount; int get disposeAndRemountCount; int get controllerGeneration; int get appResourceGeneration; SceneSpikeCustomMaterialRuntimeSuccess? get customMaterialRuntimeSuccess; List<SceneSpikeCapabilityResult> get capabilities; SceneSpikePerformanceSnapshot get performance;
/// Create a copy of SceneSpikeEvidence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SceneSpikeEvidenceCopyWith<SceneSpikeEvidence> get copyWith => _$SceneSpikeEvidenceCopyWithImpl<SceneSpikeEvidence>(this as SceneSpikeEvidence, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SceneSpikeEvidence&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.run, run) || other.run == run)&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.operatingSystemVersion, operatingSystemVersion) || other.operatingSystemVersion == operatingSystemVersion)&&(identical(other.flutterFrameworkRevision, flutterFrameworkRevision) || other.flutterFrameworkRevision == flutterFrameworkRevision)&&(identical(other.flutterEngineRevision, flutterEngineRevision) || other.flutterEngineRevision == flutterEngineRevision)&&(identical(other.dartVersion, dartVersion) || other.dartVersion == dartVersion)&&(identical(other.dartSourceRevision, dartSourceRevision) || other.dartSourceRevision == dartSourceRevision)&&(identical(other.flutterSceneRevision, flutterSceneRevision) || other.flutterSceneRevision == flutterSceneRevision)&&(identical(other.eqmonitorMapRendererRevision, eqmonitorMapRendererRevision) || other.eqmonitorMapRendererRevision == eqmonitorMapRendererRevision)&&(identical(other.eqmonitorMapRendererCheckoutDirty, eqmonitorMapRendererCheckoutDirty) || other.eqmonitorMapRendererCheckoutDirty == eqmonitorMapRendererCheckoutDirty)&&(identical(other.revisionProvenance, revisionProvenance) || other.revisionProvenance == revisionProvenance)&&(identical(other.renderingBackend, renderingBackend) || other.renderingBackend == renderingBackend)&&(identical(other.renderingBackendProvenance, renderingBackendProvenance) || other.renderingBackendProvenance == renderingBackendProvenance)&&(identical(other.startedAtUtc, startedAtUtc) || other.startedAtUtc == startedAtUtc)&&(identical(other.elapsedMicroseconds, elapsedMicroseconds) || other.elapsedMicroseconds == elapsedMicroseconds)&&(identical(other.frameCount, frameCount) || other.frameCount == frameCount)&&(identical(other.partialUpdateCount, partialUpdateCount) || other.partialUpdateCount == partialUpdateCount)&&(identical(other.lifecycleResumeCount, lifecycleResumeCount) || other.lifecycleResumeCount == lifecycleResumeCount)&&(identical(other.disposeAndRemountCount, disposeAndRemountCount) || other.disposeAndRemountCount == disposeAndRemountCount)&&(identical(other.controllerGeneration, controllerGeneration) || other.controllerGeneration == controllerGeneration)&&(identical(other.appResourceGeneration, appResourceGeneration) || other.appResourceGeneration == appResourceGeneration)&&(identical(other.customMaterialRuntimeSuccess, customMaterialRuntimeSuccess) || other.customMaterialRuntimeSuccess == customMaterialRuntimeSuccess)&&const DeepCollectionEquality().equals(other.capabilities, capabilities)&&(identical(other.performance, performance) || other.performance == performance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,schemaVersion,run,deviceModel,operatingSystemVersion,flutterFrameworkRevision,flutterEngineRevision,dartVersion,dartSourceRevision,flutterSceneRevision,eqmonitorMapRendererRevision,eqmonitorMapRendererCheckoutDirty,revisionProvenance,renderingBackend,renderingBackendProvenance,startedAtUtc,elapsedMicroseconds,frameCount,partialUpdateCount,lifecycleResumeCount,disposeAndRemountCount,controllerGeneration,appResourceGeneration,customMaterialRuntimeSuccess,const DeepCollectionEquality().hash(capabilities),performance]);

@override
String toString() {
  return 'SceneSpikeEvidence(schemaVersion: $schemaVersion, run: $run, deviceModel: $deviceModel, operatingSystemVersion: $operatingSystemVersion, flutterFrameworkRevision: $flutterFrameworkRevision, flutterEngineRevision: $flutterEngineRevision, dartVersion: $dartVersion, dartSourceRevision: $dartSourceRevision, flutterSceneRevision: $flutterSceneRevision, eqmonitorMapRendererRevision: $eqmonitorMapRendererRevision, eqmonitorMapRendererCheckoutDirty: $eqmonitorMapRendererCheckoutDirty, revisionProvenance: $revisionProvenance, renderingBackend: $renderingBackend, renderingBackendProvenance: $renderingBackendProvenance, startedAtUtc: $startedAtUtc, elapsedMicroseconds: $elapsedMicroseconds, frameCount: $frameCount, partialUpdateCount: $partialUpdateCount, lifecycleResumeCount: $lifecycleResumeCount, disposeAndRemountCount: $disposeAndRemountCount, controllerGeneration: $controllerGeneration, appResourceGeneration: $appResourceGeneration, customMaterialRuntimeSuccess: $customMaterialRuntimeSuccess, capabilities: $capabilities, performance: $performance)';
}


}

/// @nodoc
abstract mixin class $SceneSpikeEvidenceCopyWith<$Res>  {
  factory $SceneSpikeEvidenceCopyWith(SceneSpikeEvidence value, $Res Function(SceneSpikeEvidence) _then) = _$SceneSpikeEvidenceCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, SceneSpikeRunKey run, String deviceModel, String operatingSystemVersion, String flutterFrameworkRevision, String flutterEngineRevision, String dartVersion, String dartSourceRevision, String flutterSceneRevision, String eqmonitorMapRendererRevision, bool eqmonitorMapRendererCheckoutDirty, SceneSpikeObservationProvenance revisionProvenance, String renderingBackend, SceneSpikeObservationProvenance renderingBackendProvenance, DateTime startedAtUtc, int elapsedMicroseconds, int frameCount, int partialUpdateCount, int lifecycleResumeCount, int disposeAndRemountCount, int controllerGeneration, int appResourceGeneration, SceneSpikeCustomMaterialRuntimeSuccess? customMaterialRuntimeSuccess, List<SceneSpikeCapabilityResult> capabilities, SceneSpikePerformanceSnapshot performance
});




}
/// @nodoc
class _$SceneSpikeEvidenceCopyWithImpl<$Res>
    implements $SceneSpikeEvidenceCopyWith<$Res> {
  _$SceneSpikeEvidenceCopyWithImpl(this._self, this._then);

  final SceneSpikeEvidence _self;
  final $Res Function(SceneSpikeEvidence) _then;

/// Create a copy of SceneSpikeEvidence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? run = null,Object? deviceModel = null,Object? operatingSystemVersion = null,Object? flutterFrameworkRevision = null,Object? flutterEngineRevision = null,Object? dartVersion = null,Object? dartSourceRevision = null,Object? flutterSceneRevision = null,Object? eqmonitorMapRendererRevision = null,Object? eqmonitorMapRendererCheckoutDirty = null,Object? revisionProvenance = null,Object? renderingBackend = null,Object? renderingBackendProvenance = null,Object? startedAtUtc = null,Object? elapsedMicroseconds = null,Object? frameCount = null,Object? partialUpdateCount = null,Object? lifecycleResumeCount = null,Object? disposeAndRemountCount = null,Object? controllerGeneration = null,Object? appResourceGeneration = null,Object? customMaterialRuntimeSuccess = freezed,Object? capabilities = null,Object? performance = null,}) {
  return _then(SceneSpikeEvidence(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,run: null == run ? _self.run : run // ignore: cast_nullable_to_non_nullable
as SceneSpikeRunKey,deviceModel: null == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String,operatingSystemVersion: null == operatingSystemVersion ? _self.operatingSystemVersion : operatingSystemVersion // ignore: cast_nullable_to_non_nullable
as String,flutterFrameworkRevision: null == flutterFrameworkRevision ? _self.flutterFrameworkRevision : flutterFrameworkRevision // ignore: cast_nullable_to_non_nullable
as String,flutterEngineRevision: null == flutterEngineRevision ? _self.flutterEngineRevision : flutterEngineRevision // ignore: cast_nullable_to_non_nullable
as String,dartVersion: null == dartVersion ? _self.dartVersion : dartVersion // ignore: cast_nullable_to_non_nullable
as String,dartSourceRevision: null == dartSourceRevision ? _self.dartSourceRevision : dartSourceRevision // ignore: cast_nullable_to_non_nullable
as String,flutterSceneRevision: null == flutterSceneRevision ? _self.flutterSceneRevision : flutterSceneRevision // ignore: cast_nullable_to_non_nullable
as String,eqmonitorMapRendererRevision: null == eqmonitorMapRendererRevision ? _self.eqmonitorMapRendererRevision : eqmonitorMapRendererRevision // ignore: cast_nullable_to_non_nullable
as String,eqmonitorMapRendererCheckoutDirty: null == eqmonitorMapRendererCheckoutDirty ? _self.eqmonitorMapRendererCheckoutDirty : eqmonitorMapRendererCheckoutDirty // ignore: cast_nullable_to_non_nullable
as bool,revisionProvenance: null == revisionProvenance ? _self.revisionProvenance : revisionProvenance // ignore: cast_nullable_to_non_nullable
as SceneSpikeObservationProvenance,renderingBackend: null == renderingBackend ? _self.renderingBackend : renderingBackend // ignore: cast_nullable_to_non_nullable
as String,renderingBackendProvenance: null == renderingBackendProvenance ? _self.renderingBackendProvenance : renderingBackendProvenance // ignore: cast_nullable_to_non_nullable
as SceneSpikeObservationProvenance,startedAtUtc: null == startedAtUtc ? _self.startedAtUtc : startedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,elapsedMicroseconds: null == elapsedMicroseconds ? _self.elapsedMicroseconds : elapsedMicroseconds // ignore: cast_nullable_to_non_nullable
as int,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as int,partialUpdateCount: null == partialUpdateCount ? _self.partialUpdateCount : partialUpdateCount // ignore: cast_nullable_to_non_nullable
as int,lifecycleResumeCount: null == lifecycleResumeCount ? _self.lifecycleResumeCount : lifecycleResumeCount // ignore: cast_nullable_to_non_nullable
as int,disposeAndRemountCount: null == disposeAndRemountCount ? _self.disposeAndRemountCount : disposeAndRemountCount // ignore: cast_nullable_to_non_nullable
as int,controllerGeneration: null == controllerGeneration ? _self.controllerGeneration : controllerGeneration // ignore: cast_nullable_to_non_nullable
as int,appResourceGeneration: null == appResourceGeneration ? _self.appResourceGeneration : appResourceGeneration // ignore: cast_nullable_to_non_nullable
as int,customMaterialRuntimeSuccess: freezed == customMaterialRuntimeSuccess ? _self.customMaterialRuntimeSuccess : customMaterialRuntimeSuccess // ignore: cast_nullable_to_non_nullable
as SceneSpikeCustomMaterialRuntimeSuccess?,capabilities: null == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as List<SceneSpikeCapabilityResult>,performance: null == performance ? _self.performance : performance // ignore: cast_nullable_to_non_nullable
as SceneSpikePerformanceSnapshot,
  ));
}

}


/// Adds pattern-matching-related methods to [SceneSpikeEvidence].
extension SceneSpikeEvidencePatterns on SceneSpikeEvidence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
