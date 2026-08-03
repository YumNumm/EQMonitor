// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scene_spike_gate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SceneSpikeCapabilityFinding {

 SceneSpikeRunKey get run; SceneSpikeCapabilityResult get result;
/// Create a copy of SceneSpikeCapabilityFinding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SceneSpikeCapabilityFindingCopyWith<SceneSpikeCapabilityFinding> get copyWith => _$SceneSpikeCapabilityFindingCopyWithImpl<SceneSpikeCapabilityFinding>(this as SceneSpikeCapabilityFinding, _$identity);

  /// Serializes this SceneSpikeCapabilityFinding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SceneSpikeCapabilityFinding&&(identical(other.run, run) || other.run == run)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,run,result);

@override
String toString() {
  return 'SceneSpikeCapabilityFinding(run: $run, result: $result)';
}


}

/// @nodoc
abstract mixin class $SceneSpikeCapabilityFindingCopyWith<$Res>  {
  factory $SceneSpikeCapabilityFindingCopyWith(SceneSpikeCapabilityFinding value, $Res Function(SceneSpikeCapabilityFinding) _then) = _$SceneSpikeCapabilityFindingCopyWithImpl;
@useResult
$Res call({
 SceneSpikeRunKey run, SceneSpikeCapabilityResult result
});


$SceneSpikeRunKeyCopyWith<$Res> get run;$SceneSpikeCapabilityResultCopyWith<$Res> get result;

}
/// @nodoc
class _$SceneSpikeCapabilityFindingCopyWithImpl<$Res>
    implements $SceneSpikeCapabilityFindingCopyWith<$Res> {
  _$SceneSpikeCapabilityFindingCopyWithImpl(this._self, this._then);

  final SceneSpikeCapabilityFinding _self;
  final $Res Function(SceneSpikeCapabilityFinding) _then;

/// Create a copy of SceneSpikeCapabilityFinding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? run = null,Object? result = null,}) {
  return _then(_self.copyWith(
run: null == run ? _self.run : run // ignore: cast_nullable_to_non_nullable
as SceneSpikeRunKey,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as SceneSpikeCapabilityResult,
  ));
}
/// Create a copy of SceneSpikeCapabilityFinding
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SceneSpikeRunKeyCopyWith<$Res> get run {
  
  return $SceneSpikeRunKeyCopyWith<$Res>(_self.run, (value) {
    return _then(_self.copyWith(run: value));
  });
}/// Create a copy of SceneSpikeCapabilityFinding
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SceneSpikeCapabilityResultCopyWith<$Res> get result {
  
  return $SceneSpikeCapabilityResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [SceneSpikeCapabilityFinding].
extension SceneSpikeCapabilityFindingPatterns on SceneSpikeCapabilityFinding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SceneSpikeCapabilityFinding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SceneSpikeCapabilityFinding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SceneSpikeCapabilityFinding value)  $default,){
final _that = this;
switch (_that) {
case _SceneSpikeCapabilityFinding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SceneSpikeCapabilityFinding value)?  $default,){
final _that = this;
switch (_that) {
case _SceneSpikeCapabilityFinding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SceneSpikeRunKey run,  SceneSpikeCapabilityResult result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SceneSpikeCapabilityFinding() when $default != null:
return $default(_that.run,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SceneSpikeRunKey run,  SceneSpikeCapabilityResult result)  $default,) {final _that = this;
switch (_that) {
case _SceneSpikeCapabilityFinding():
return $default(_that.run,_that.result);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SceneSpikeRunKey run,  SceneSpikeCapabilityResult result)?  $default,) {final _that = this;
switch (_that) {
case _SceneSpikeCapabilityFinding() when $default != null:
return $default(_that.run,_that.result);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SceneSpikeCapabilityFinding implements SceneSpikeCapabilityFinding {
  const _SceneSpikeCapabilityFinding({required this.run, required this.result});
  factory _SceneSpikeCapabilityFinding.fromJson(Map<String, dynamic> json) => _$SceneSpikeCapabilityFindingFromJson(json);

@override final  SceneSpikeRunKey run;
@override final  SceneSpikeCapabilityResult result;

/// Create a copy of SceneSpikeCapabilityFinding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SceneSpikeCapabilityFindingCopyWith<_SceneSpikeCapabilityFinding> get copyWith => __$SceneSpikeCapabilityFindingCopyWithImpl<_SceneSpikeCapabilityFinding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SceneSpikeCapabilityFindingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SceneSpikeCapabilityFinding&&(identical(other.run, run) || other.run == run)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,run,result);

@override
String toString() {
  return 'SceneSpikeCapabilityFinding(run: $run, result: $result)';
}


}

/// @nodoc
abstract mixin class _$SceneSpikeCapabilityFindingCopyWith<$Res> implements $SceneSpikeCapabilityFindingCopyWith<$Res> {
  factory _$SceneSpikeCapabilityFindingCopyWith(_SceneSpikeCapabilityFinding value, $Res Function(_SceneSpikeCapabilityFinding) _then) = __$SceneSpikeCapabilityFindingCopyWithImpl;
@override @useResult
$Res call({
 SceneSpikeRunKey run, SceneSpikeCapabilityResult result
});


@override $SceneSpikeRunKeyCopyWith<$Res> get run;@override $SceneSpikeCapabilityResultCopyWith<$Res> get result;

}
/// @nodoc
class __$SceneSpikeCapabilityFindingCopyWithImpl<$Res>
    implements _$SceneSpikeCapabilityFindingCopyWith<$Res> {
  __$SceneSpikeCapabilityFindingCopyWithImpl(this._self, this._then);

  final _SceneSpikeCapabilityFinding _self;
  final $Res Function(_SceneSpikeCapabilityFinding) _then;

/// Create a copy of SceneSpikeCapabilityFinding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? run = null,Object? result = null,}) {
  return _then(_SceneSpikeCapabilityFinding(
run: null == run ? _self.run : run // ignore: cast_nullable_to_non_nullable
as SceneSpikeRunKey,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as SceneSpikeCapabilityResult,
  ));
}

/// Create a copy of SceneSpikeCapabilityFinding
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SceneSpikeRunKeyCopyWith<$Res> get run {
  
  return $SceneSpikeRunKeyCopyWith<$Res>(_self.run, (value) {
    return _then(_self.copyWith(run: value));
  });
}/// Create a copy of SceneSpikeCapabilityFinding
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SceneSpikeCapabilityResultCopyWith<$Res> get result {
  
  return $SceneSpikeCapabilityResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// @nodoc
mixin _$SceneSpikeGateDecision {

 bool get isPass; List<SceneSpikeRunKey> get missingRuns; List<SceneSpikeCapabilityFinding> get failedCapabilities; List<SceneSpikeCapabilityFinding> get unobservedCapabilities; List<String> get validationErrors; List<String> get revisionMismatches;
/// Create a copy of SceneSpikeGateDecision
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SceneSpikeGateDecisionCopyWith<SceneSpikeGateDecision> get copyWith => _$SceneSpikeGateDecisionCopyWithImpl<SceneSpikeGateDecision>(this as SceneSpikeGateDecision, _$identity);

  /// Serializes this SceneSpikeGateDecision to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SceneSpikeGateDecision&&(identical(other.isPass, isPass) || other.isPass == isPass)&&const DeepCollectionEquality().equals(other.missingRuns, missingRuns)&&const DeepCollectionEquality().equals(other.failedCapabilities, failedCapabilities)&&const DeepCollectionEquality().equals(other.unobservedCapabilities, unobservedCapabilities)&&const DeepCollectionEquality().equals(other.validationErrors, validationErrors)&&const DeepCollectionEquality().equals(other.revisionMismatches, revisionMismatches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isPass,const DeepCollectionEquality().hash(missingRuns),const DeepCollectionEquality().hash(failedCapabilities),const DeepCollectionEquality().hash(unobservedCapabilities),const DeepCollectionEquality().hash(validationErrors),const DeepCollectionEquality().hash(revisionMismatches));

@override
String toString() {
  return 'SceneSpikeGateDecision(isPass: $isPass, missingRuns: $missingRuns, failedCapabilities: $failedCapabilities, unobservedCapabilities: $unobservedCapabilities, validationErrors: $validationErrors, revisionMismatches: $revisionMismatches)';
}


}

/// @nodoc
abstract mixin class $SceneSpikeGateDecisionCopyWith<$Res>  {
  factory $SceneSpikeGateDecisionCopyWith(SceneSpikeGateDecision value, $Res Function(SceneSpikeGateDecision) _then) = _$SceneSpikeGateDecisionCopyWithImpl;
@useResult
$Res call({
 bool isPass, List<SceneSpikeRunKey> missingRuns, List<SceneSpikeCapabilityFinding> failedCapabilities, List<SceneSpikeCapabilityFinding> unobservedCapabilities, List<String> validationErrors, List<String> revisionMismatches
});




}
/// @nodoc
class _$SceneSpikeGateDecisionCopyWithImpl<$Res>
    implements $SceneSpikeGateDecisionCopyWith<$Res> {
  _$SceneSpikeGateDecisionCopyWithImpl(this._self, this._then);

  final SceneSpikeGateDecision _self;
  final $Res Function(SceneSpikeGateDecision) _then;

/// Create a copy of SceneSpikeGateDecision
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isPass = null,Object? missingRuns = null,Object? failedCapabilities = null,Object? unobservedCapabilities = null,Object? validationErrors = null,Object? revisionMismatches = null,}) {
  return _then(_self.copyWith(
isPass: null == isPass ? _self.isPass : isPass // ignore: cast_nullable_to_non_nullable
as bool,missingRuns: null == missingRuns ? _self.missingRuns : missingRuns // ignore: cast_nullable_to_non_nullable
as List<SceneSpikeRunKey>,failedCapabilities: null == failedCapabilities ? _self.failedCapabilities : failedCapabilities // ignore: cast_nullable_to_non_nullable
as List<SceneSpikeCapabilityFinding>,unobservedCapabilities: null == unobservedCapabilities ? _self.unobservedCapabilities : unobservedCapabilities // ignore: cast_nullable_to_non_nullable
as List<SceneSpikeCapabilityFinding>,validationErrors: null == validationErrors ? _self.validationErrors : validationErrors // ignore: cast_nullable_to_non_nullable
as List<String>,revisionMismatches: null == revisionMismatches ? _self.revisionMismatches : revisionMismatches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SceneSpikeGateDecision].
extension SceneSpikeGateDecisionPatterns on SceneSpikeGateDecision {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SceneSpikeGateDecision value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SceneSpikeGateDecision() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SceneSpikeGateDecision value)  $default,){
final _that = this;
switch (_that) {
case _SceneSpikeGateDecision():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SceneSpikeGateDecision value)?  $default,){
final _that = this;
switch (_that) {
case _SceneSpikeGateDecision() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isPass,  List<SceneSpikeRunKey> missingRuns,  List<SceneSpikeCapabilityFinding> failedCapabilities,  List<SceneSpikeCapabilityFinding> unobservedCapabilities,  List<String> validationErrors,  List<String> revisionMismatches)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SceneSpikeGateDecision() when $default != null:
return $default(_that.isPass,_that.missingRuns,_that.failedCapabilities,_that.unobservedCapabilities,_that.validationErrors,_that.revisionMismatches);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isPass,  List<SceneSpikeRunKey> missingRuns,  List<SceneSpikeCapabilityFinding> failedCapabilities,  List<SceneSpikeCapabilityFinding> unobservedCapabilities,  List<String> validationErrors,  List<String> revisionMismatches)  $default,) {final _that = this;
switch (_that) {
case _SceneSpikeGateDecision():
return $default(_that.isPass,_that.missingRuns,_that.failedCapabilities,_that.unobservedCapabilities,_that.validationErrors,_that.revisionMismatches);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isPass,  List<SceneSpikeRunKey> missingRuns,  List<SceneSpikeCapabilityFinding> failedCapabilities,  List<SceneSpikeCapabilityFinding> unobservedCapabilities,  List<String> validationErrors,  List<String> revisionMismatches)?  $default,) {final _that = this;
switch (_that) {
case _SceneSpikeGateDecision() when $default != null:
return $default(_that.isPass,_that.missingRuns,_that.failedCapabilities,_that.unobservedCapabilities,_that.validationErrors,_that.revisionMismatches);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SceneSpikeGateDecision implements SceneSpikeGateDecision {
  const _SceneSpikeGateDecision({required this.isPass, required final  List<SceneSpikeRunKey> missingRuns, required final  List<SceneSpikeCapabilityFinding> failedCapabilities, required final  List<SceneSpikeCapabilityFinding> unobservedCapabilities, required final  List<String> validationErrors, required final  List<String> revisionMismatches}): _missingRuns = missingRuns,_failedCapabilities = failedCapabilities,_unobservedCapabilities = unobservedCapabilities,_validationErrors = validationErrors,_revisionMismatches = revisionMismatches;
  factory _SceneSpikeGateDecision.fromJson(Map<String, dynamic> json) => _$SceneSpikeGateDecisionFromJson(json);

@override final  bool isPass;
 final  List<SceneSpikeRunKey> _missingRuns;
@override List<SceneSpikeRunKey> get missingRuns {
  if (_missingRuns is EqualUnmodifiableListView) return _missingRuns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_missingRuns);
}

 final  List<SceneSpikeCapabilityFinding> _failedCapabilities;
@override List<SceneSpikeCapabilityFinding> get failedCapabilities {
  if (_failedCapabilities is EqualUnmodifiableListView) return _failedCapabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_failedCapabilities);
}

 final  List<SceneSpikeCapabilityFinding> _unobservedCapabilities;
@override List<SceneSpikeCapabilityFinding> get unobservedCapabilities {
  if (_unobservedCapabilities is EqualUnmodifiableListView) return _unobservedCapabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unobservedCapabilities);
}

 final  List<String> _validationErrors;
@override List<String> get validationErrors {
  if (_validationErrors is EqualUnmodifiableListView) return _validationErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_validationErrors);
}

 final  List<String> _revisionMismatches;
@override List<String> get revisionMismatches {
  if (_revisionMismatches is EqualUnmodifiableListView) return _revisionMismatches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_revisionMismatches);
}


/// Create a copy of SceneSpikeGateDecision
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SceneSpikeGateDecisionCopyWith<_SceneSpikeGateDecision> get copyWith => __$SceneSpikeGateDecisionCopyWithImpl<_SceneSpikeGateDecision>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SceneSpikeGateDecisionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SceneSpikeGateDecision&&(identical(other.isPass, isPass) || other.isPass == isPass)&&const DeepCollectionEquality().equals(other._missingRuns, _missingRuns)&&const DeepCollectionEquality().equals(other._failedCapabilities, _failedCapabilities)&&const DeepCollectionEquality().equals(other._unobservedCapabilities, _unobservedCapabilities)&&const DeepCollectionEquality().equals(other._validationErrors, _validationErrors)&&const DeepCollectionEquality().equals(other._revisionMismatches, _revisionMismatches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isPass,const DeepCollectionEquality().hash(_missingRuns),const DeepCollectionEquality().hash(_failedCapabilities),const DeepCollectionEquality().hash(_unobservedCapabilities),const DeepCollectionEquality().hash(_validationErrors),const DeepCollectionEquality().hash(_revisionMismatches));

@override
String toString() {
  return 'SceneSpikeGateDecision(isPass: $isPass, missingRuns: $missingRuns, failedCapabilities: $failedCapabilities, unobservedCapabilities: $unobservedCapabilities, validationErrors: $validationErrors, revisionMismatches: $revisionMismatches)';
}


}

/// @nodoc
abstract mixin class _$SceneSpikeGateDecisionCopyWith<$Res> implements $SceneSpikeGateDecisionCopyWith<$Res> {
  factory _$SceneSpikeGateDecisionCopyWith(_SceneSpikeGateDecision value, $Res Function(_SceneSpikeGateDecision) _then) = __$SceneSpikeGateDecisionCopyWithImpl;
@override @useResult
$Res call({
 bool isPass, List<SceneSpikeRunKey> missingRuns, List<SceneSpikeCapabilityFinding> failedCapabilities, List<SceneSpikeCapabilityFinding> unobservedCapabilities, List<String> validationErrors, List<String> revisionMismatches
});




}
/// @nodoc
class __$SceneSpikeGateDecisionCopyWithImpl<$Res>
    implements _$SceneSpikeGateDecisionCopyWith<$Res> {
  __$SceneSpikeGateDecisionCopyWithImpl(this._self, this._then);

  final _SceneSpikeGateDecision _self;
  final $Res Function(_SceneSpikeGateDecision) _then;

/// Create a copy of SceneSpikeGateDecision
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPass = null,Object? missingRuns = null,Object? failedCapabilities = null,Object? unobservedCapabilities = null,Object? validationErrors = null,Object? revisionMismatches = null,}) {
  return _then(_SceneSpikeGateDecision(
isPass: null == isPass ? _self.isPass : isPass // ignore: cast_nullable_to_non_nullable
as bool,missingRuns: null == missingRuns ? _self._missingRuns : missingRuns // ignore: cast_nullable_to_non_nullable
as List<SceneSpikeRunKey>,failedCapabilities: null == failedCapabilities ? _self._failedCapabilities : failedCapabilities // ignore: cast_nullable_to_non_nullable
as List<SceneSpikeCapabilityFinding>,unobservedCapabilities: null == unobservedCapabilities ? _self._unobservedCapabilities : unobservedCapabilities // ignore: cast_nullable_to_non_nullable
as List<SceneSpikeCapabilityFinding>,validationErrors: null == validationErrors ? _self._validationErrors : validationErrors // ignore: cast_nullable_to_non_nullable
as List<String>,revisionMismatches: null == revisionMismatches ? _self._revisionMismatches : revisionMismatches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
