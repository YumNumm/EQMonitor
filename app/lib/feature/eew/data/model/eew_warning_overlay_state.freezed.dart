// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_warning_overlay_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EewWarningOverlayState {

 EewWarningOverlayMode get mode; EewWarningOverlayDisplayModel? get displayModel; Set<String> get seenEventIds; Set<String> get dismissedEventIds; bool get simulationSessionActive;
/// Create a copy of EewWarningOverlayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewWarningOverlayStateCopyWith<EewWarningOverlayState> get copyWith => _$EewWarningOverlayStateCopyWithImpl<EewWarningOverlayState>(this as EewWarningOverlayState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewWarningOverlayState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.displayModel, displayModel) || other.displayModel == displayModel)&&const DeepCollectionEquality().equals(other.seenEventIds, seenEventIds)&&const DeepCollectionEquality().equals(other.dismissedEventIds, dismissedEventIds)&&(identical(other.simulationSessionActive, simulationSessionActive) || other.simulationSessionActive == simulationSessionActive));
}


@override
int get hashCode => Object.hash(runtimeType,mode,displayModel,const DeepCollectionEquality().hash(seenEventIds),const DeepCollectionEquality().hash(dismissedEventIds),simulationSessionActive);

@override
String toString() {
  return 'EewWarningOverlayState(mode: $mode, displayModel: $displayModel, seenEventIds: $seenEventIds, dismissedEventIds: $dismissedEventIds, simulationSessionActive: $simulationSessionActive)';
}


}

/// @nodoc
abstract mixin class $EewWarningOverlayStateCopyWith<$Res>  {
  factory $EewWarningOverlayStateCopyWith(EewWarningOverlayState value, $Res Function(EewWarningOverlayState) _then) = _$EewWarningOverlayStateCopyWithImpl;
@useResult
$Res call({
 EewWarningOverlayMode mode, EewWarningOverlayDisplayModel? displayModel, Set<String> seenEventIds, Set<String> dismissedEventIds, bool simulationSessionActive
});


$EewWarningOverlayDisplayModelCopyWith<$Res>? get displayModel;

}
/// @nodoc
class _$EewWarningOverlayStateCopyWithImpl<$Res>
    implements $EewWarningOverlayStateCopyWith<$Res> {
  _$EewWarningOverlayStateCopyWithImpl(this._self, this._then);

  final EewWarningOverlayState _self;
  final $Res Function(EewWarningOverlayState) _then;

/// Create a copy of EewWarningOverlayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? displayModel = freezed,Object? seenEventIds = null,Object? dismissedEventIds = null,Object? simulationSessionActive = null,}) {
  return _then(EewWarningOverlayState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as EewWarningOverlayMode,displayModel: freezed == displayModel ? _self.displayModel : displayModel // ignore: cast_nullable_to_non_nullable
as EewWarningOverlayDisplayModel?,seenEventIds: null == seenEventIds ? _self.seenEventIds : seenEventIds // ignore: cast_nullable_to_non_nullable
as Set<String>,dismissedEventIds: null == dismissedEventIds ? _self.dismissedEventIds : dismissedEventIds // ignore: cast_nullable_to_non_nullable
as Set<String>,simulationSessionActive: null == simulationSessionActive ? _self.simulationSessionActive : simulationSessionActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of EewWarningOverlayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewWarningOverlayDisplayModelCopyWith<$Res>? get displayModel {
    if (_self.displayModel == null) {
    return null;
  }

  return $EewWarningOverlayDisplayModelCopyWith<$Res>(_self.displayModel!, (value) {
    return _then(_self.copyWith(displayModel: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewWarningOverlayState].
extension EewWarningOverlayStatePatterns on EewWarningOverlayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewWarningOverlayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewWarningOverlayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewWarningOverlayState value)  $default,){
final _that = this;
switch (_that) {
case _EewWarningOverlayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewWarningOverlayState value)?  $default,){
final _that = this;
switch (_that) {
case _EewWarningOverlayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EewWarningOverlayMode mode,  EewWarningOverlayDisplayModel? displayModel,  Set<String> seenEventIds,  Set<String> dismissedEventIds,  bool simulationSessionActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewWarningOverlayState() when $default != null:
return $default(_that.mode,_that.displayModel,_that.seenEventIds,_that.dismissedEventIds,_that.simulationSessionActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EewWarningOverlayMode mode,  EewWarningOverlayDisplayModel? displayModel,  Set<String> seenEventIds,  Set<String> dismissedEventIds,  bool simulationSessionActive)  $default,) {final _that = this;
switch (_that) {
case _EewWarningOverlayState():
return $default(_that.mode,_that.displayModel,_that.seenEventIds,_that.dismissedEventIds,_that.simulationSessionActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EewWarningOverlayMode mode,  EewWarningOverlayDisplayModel? displayModel,  Set<String> seenEventIds,  Set<String> dismissedEventIds,  bool simulationSessionActive)?  $default,) {final _that = this;
switch (_that) {
case _EewWarningOverlayState() when $default != null:
return $default(_that.mode,_that.displayModel,_that.seenEventIds,_that.dismissedEventIds,_that.simulationSessionActive);case _:
  return null;

}
}

}

/// @nodoc


class _EewWarningOverlayState implements EewWarningOverlayState {
  const _EewWarningOverlayState({this.mode = EewWarningOverlayMode.hidden, this.displayModel,  Set<String> seenEventIds = const <String>{},  Set<String> dismissedEventIds = const <String>{}, this.simulationSessionActive = false}): _seenEventIds = seenEventIds,_dismissedEventIds = dismissedEventIds;
  

@override@JsonKey() final  EewWarningOverlayMode mode;
@override final  EewWarningOverlayDisplayModel? displayModel;
 final  Set<String> _seenEventIds;
@override@JsonKey() Set<String> get seenEventIds {
  if (_seenEventIds is EqualUnmodifiableSetView) return _seenEventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_seenEventIds);
}

 final  Set<String> _dismissedEventIds;
@override@JsonKey() Set<String> get dismissedEventIds {
  if (_dismissedEventIds is EqualUnmodifiableSetView) return _dismissedEventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_dismissedEventIds);
}

@override@JsonKey() final  bool simulationSessionActive;

/// Create a copy of EewWarningOverlayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewWarningOverlayStateCopyWith<_EewWarningOverlayState> get copyWith => __$EewWarningOverlayStateCopyWithImpl<_EewWarningOverlayState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewWarningOverlayState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.displayModel, displayModel) || other.displayModel == displayModel)&&const DeepCollectionEquality().equals(other._seenEventIds, _seenEventIds)&&const DeepCollectionEquality().equals(other._dismissedEventIds, _dismissedEventIds)&&(identical(other.simulationSessionActive, simulationSessionActive) || other.simulationSessionActive == simulationSessionActive));
}


@override
int get hashCode => Object.hash(runtimeType,mode,displayModel,const DeepCollectionEquality().hash(_seenEventIds),const DeepCollectionEquality().hash(_dismissedEventIds),simulationSessionActive);

@override
String toString() {
  return 'EewWarningOverlayState(mode: $mode, displayModel: $displayModel, seenEventIds: $seenEventIds, dismissedEventIds: $dismissedEventIds, simulationSessionActive: $simulationSessionActive)';
}


}

/// @nodoc
abstract mixin class _$EewWarningOverlayStateCopyWith<$Res> implements $EewWarningOverlayStateCopyWith<$Res> {
  factory _$EewWarningOverlayStateCopyWith(_EewWarningOverlayState value, $Res Function(_EewWarningOverlayState) _then) = __$EewWarningOverlayStateCopyWithImpl;
@override @useResult
$Res call({
 EewWarningOverlayMode mode, EewWarningOverlayDisplayModel? displayModel, Set<String> seenEventIds, Set<String> dismissedEventIds, bool simulationSessionActive
});


@override $EewWarningOverlayDisplayModelCopyWith<$Res>? get displayModel;

}
/// @nodoc
class __$EewWarningOverlayStateCopyWithImpl<$Res>
    implements _$EewWarningOverlayStateCopyWith<$Res> {
  __$EewWarningOverlayStateCopyWithImpl(this._self, this._then);

  final _EewWarningOverlayState _self;
  final $Res Function(_EewWarningOverlayState) _then;

/// Create a copy of EewWarningOverlayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? displayModel = freezed,Object? seenEventIds = null,Object? dismissedEventIds = null,Object? simulationSessionActive = null,}) {
  return _then(_EewWarningOverlayState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as EewWarningOverlayMode,displayModel: freezed == displayModel ? _self.displayModel : displayModel // ignore: cast_nullable_to_non_nullable
as EewWarningOverlayDisplayModel?,seenEventIds: null == seenEventIds ? _self._seenEventIds : seenEventIds // ignore: cast_nullable_to_non_nullable
as Set<String>,dismissedEventIds: null == dismissedEventIds ? _self._dismissedEventIds : dismissedEventIds // ignore: cast_nullable_to_non_nullable
as Set<String>,simulationSessionActive: null == simulationSessionActive ? _self.simulationSessionActive : simulationSessionActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of EewWarningOverlayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewWarningOverlayDisplayModelCopyWith<$Res>? get displayModel {
    if (_self.displayModel == null) {
    return null;
  }

  return $EewWarningOverlayDisplayModelCopyWith<$Res>(_self.displayModel!, (value) {
    return _then(_self.copyWith(displayModel: value));
  });
}
}

// dart format on
