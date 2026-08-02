// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_map_focus_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EewMapFocusState {

 String? get focusedEventId; bool get isFocused; String? get appliedEventId; ({double latitude, double longitude})? get appliedHypocenter; EewMapFocusGridRect? get appliedShakeRect; Map<String, EewMapFocusGridRect> get shakeBoundsByEventId;
/// Create a copy of EewMapFocusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewMapFocusStateCopyWith<EewMapFocusState> get copyWith => _$EewMapFocusStateCopyWithImpl<EewMapFocusState>(this as EewMapFocusState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewMapFocusState&&(identical(other.focusedEventId, focusedEventId) || other.focusedEventId == focusedEventId)&&(identical(other.isFocused, isFocused) || other.isFocused == isFocused)&&(identical(other.appliedEventId, appliedEventId) || other.appliedEventId == appliedEventId)&&(identical(other.appliedHypocenter, appliedHypocenter) || other.appliedHypocenter == appliedHypocenter)&&(identical(other.appliedShakeRect, appliedShakeRect) || other.appliedShakeRect == appliedShakeRect)&&const DeepCollectionEquality().equals(other.shakeBoundsByEventId, shakeBoundsByEventId));
}


@override
int get hashCode => Object.hash(runtimeType,focusedEventId,isFocused,appliedEventId,appliedHypocenter,appliedShakeRect,const DeepCollectionEquality().hash(shakeBoundsByEventId));

@override
String toString() {
  return 'EewMapFocusState(focusedEventId: $focusedEventId, isFocused: $isFocused, appliedEventId: $appliedEventId, appliedHypocenter: $appliedHypocenter, appliedShakeRect: $appliedShakeRect, shakeBoundsByEventId: $shakeBoundsByEventId)';
}


}

/// @nodoc
abstract mixin class $EewMapFocusStateCopyWith<$Res>  {
  factory $EewMapFocusStateCopyWith(EewMapFocusState value, $Res Function(EewMapFocusState) _then) = _$EewMapFocusStateCopyWithImpl;
@useResult
$Res call({
 String? focusedEventId, bool isFocused, String? appliedEventId, ({double latitude, double longitude})? appliedHypocenter, EewMapFocusGridRect? appliedShakeRect, Map<String, EewMapFocusGridRect> shakeBoundsByEventId
});




}
/// @nodoc
class _$EewMapFocusStateCopyWithImpl<$Res>
    implements $EewMapFocusStateCopyWith<$Res> {
  _$EewMapFocusStateCopyWithImpl(this._self, this._then);

  final EewMapFocusState _self;
  final $Res Function(EewMapFocusState) _then;

/// Create a copy of EewMapFocusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? focusedEventId = freezed,Object? isFocused = null,Object? appliedEventId = freezed,Object? appliedHypocenter = freezed,Object? appliedShakeRect = freezed,Object? shakeBoundsByEventId = null,}) {
  return _then(_self.copyWith(
focusedEventId: freezed == focusedEventId ? _self.focusedEventId : focusedEventId // ignore: cast_nullable_to_non_nullable
as String?,isFocused: null == isFocused ? _self.isFocused : isFocused // ignore: cast_nullable_to_non_nullable
as bool,appliedEventId: freezed == appliedEventId ? _self.appliedEventId : appliedEventId // ignore: cast_nullable_to_non_nullable
as String?,appliedHypocenter: freezed == appliedHypocenter ? _self.appliedHypocenter : appliedHypocenter // ignore: cast_nullable_to_non_nullable
as ({double latitude, double longitude})?,appliedShakeRect: freezed == appliedShakeRect ? _self.appliedShakeRect : appliedShakeRect // ignore: cast_nullable_to_non_nullable
as EewMapFocusGridRect?,shakeBoundsByEventId: null == shakeBoundsByEventId ? _self.shakeBoundsByEventId : shakeBoundsByEventId // ignore: cast_nullable_to_non_nullable
as Map<String, EewMapFocusGridRect>,
  ));
}

}


/// Adds pattern-matching-related methods to [EewMapFocusState].
extension EewMapFocusStatePatterns on EewMapFocusState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewMapFocusState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewMapFocusState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewMapFocusState value)  $default,){
final _that = this;
switch (_that) {
case _EewMapFocusState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewMapFocusState value)?  $default,){
final _that = this;
switch (_that) {
case _EewMapFocusState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? focusedEventId,  bool isFocused,  String? appliedEventId,  ({double latitude, double longitude})? appliedHypocenter,  EewMapFocusGridRect? appliedShakeRect,  Map<String, EewMapFocusGridRect> shakeBoundsByEventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewMapFocusState() when $default != null:
return $default(_that.focusedEventId,_that.isFocused,_that.appliedEventId,_that.appliedHypocenter,_that.appliedShakeRect,_that.shakeBoundsByEventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? focusedEventId,  bool isFocused,  String? appliedEventId,  ({double latitude, double longitude})? appliedHypocenter,  EewMapFocusGridRect? appliedShakeRect,  Map<String, EewMapFocusGridRect> shakeBoundsByEventId)  $default,) {final _that = this;
switch (_that) {
case _EewMapFocusState():
return $default(_that.focusedEventId,_that.isFocused,_that.appliedEventId,_that.appliedHypocenter,_that.appliedShakeRect,_that.shakeBoundsByEventId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? focusedEventId,  bool isFocused,  String? appliedEventId,  ({double latitude, double longitude})? appliedHypocenter,  EewMapFocusGridRect? appliedShakeRect,  Map<String, EewMapFocusGridRect> shakeBoundsByEventId)?  $default,) {final _that = this;
switch (_that) {
case _EewMapFocusState() when $default != null:
return $default(_that.focusedEventId,_that.isFocused,_that.appliedEventId,_that.appliedHypocenter,_that.appliedShakeRect,_that.shakeBoundsByEventId);case _:
  return null;

}
}

}

/// @nodoc


class _EewMapFocusState extends EewMapFocusState {
  const _EewMapFocusState({this.focusedEventId, this.isFocused = false, this.appliedEventId, this.appliedHypocenter, this.appliedShakeRect, final  Map<String, EewMapFocusGridRect> shakeBoundsByEventId = const {}}): _shakeBoundsByEventId = shakeBoundsByEventId,super._();
  

@override final  String? focusedEventId;
@override@JsonKey() final  bool isFocused;
@override final  String? appliedEventId;
@override final  ({double latitude, double longitude})? appliedHypocenter;
@override final  EewMapFocusGridRect? appliedShakeRect;
 final  Map<String, EewMapFocusGridRect> _shakeBoundsByEventId;
@override@JsonKey() Map<String, EewMapFocusGridRect> get shakeBoundsByEventId {
  if (_shakeBoundsByEventId is EqualUnmodifiableMapView) return _shakeBoundsByEventId;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_shakeBoundsByEventId);
}


/// Create a copy of EewMapFocusState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewMapFocusStateCopyWith<_EewMapFocusState> get copyWith => __$EewMapFocusStateCopyWithImpl<_EewMapFocusState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewMapFocusState&&(identical(other.focusedEventId, focusedEventId) || other.focusedEventId == focusedEventId)&&(identical(other.isFocused, isFocused) || other.isFocused == isFocused)&&(identical(other.appliedEventId, appliedEventId) || other.appliedEventId == appliedEventId)&&(identical(other.appliedHypocenter, appliedHypocenter) || other.appliedHypocenter == appliedHypocenter)&&(identical(other.appliedShakeRect, appliedShakeRect) || other.appliedShakeRect == appliedShakeRect)&&const DeepCollectionEquality().equals(other._shakeBoundsByEventId, _shakeBoundsByEventId));
}


@override
int get hashCode => Object.hash(runtimeType,focusedEventId,isFocused,appliedEventId,appliedHypocenter,appliedShakeRect,const DeepCollectionEquality().hash(_shakeBoundsByEventId));

@override
String toString() {
  return 'EewMapFocusState(focusedEventId: $focusedEventId, isFocused: $isFocused, appliedEventId: $appliedEventId, appliedHypocenter: $appliedHypocenter, appliedShakeRect: $appliedShakeRect, shakeBoundsByEventId: $shakeBoundsByEventId)';
}


}

/// @nodoc
abstract mixin class _$EewMapFocusStateCopyWith<$Res> implements $EewMapFocusStateCopyWith<$Res> {
  factory _$EewMapFocusStateCopyWith(_EewMapFocusState value, $Res Function(_EewMapFocusState) _then) = __$EewMapFocusStateCopyWithImpl;
@override @useResult
$Res call({
 String? focusedEventId, bool isFocused, String? appliedEventId, ({double latitude, double longitude})? appliedHypocenter, EewMapFocusGridRect? appliedShakeRect, Map<String, EewMapFocusGridRect> shakeBoundsByEventId
});




}
/// @nodoc
class __$EewMapFocusStateCopyWithImpl<$Res>
    implements _$EewMapFocusStateCopyWith<$Res> {
  __$EewMapFocusStateCopyWithImpl(this._self, this._then);

  final _EewMapFocusState _self;
  final $Res Function(_EewMapFocusState) _then;

/// Create a copy of EewMapFocusState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? focusedEventId = freezed,Object? isFocused = null,Object? appliedEventId = freezed,Object? appliedHypocenter = freezed,Object? appliedShakeRect = freezed,Object? shakeBoundsByEventId = null,}) {
  return _then(_EewMapFocusState(
focusedEventId: freezed == focusedEventId ? _self.focusedEventId : focusedEventId // ignore: cast_nullable_to_non_nullable
as String?,isFocused: null == isFocused ? _self.isFocused : isFocused // ignore: cast_nullable_to_non_nullable
as bool,appliedEventId: freezed == appliedEventId ? _self.appliedEventId : appliedEventId // ignore: cast_nullable_to_non_nullable
as String?,appliedHypocenter: freezed == appliedHypocenter ? _self.appliedHypocenter : appliedHypocenter // ignore: cast_nullable_to_non_nullable
as ({double latitude, double longitude})?,appliedShakeRect: freezed == appliedShakeRect ? _self.appliedShakeRect : appliedShakeRect // ignore: cast_nullable_to_non_nullable
as EewMapFocusGridRect?,shakeBoundsByEventId: null == shakeBoundsByEventId ? _self._shakeBoundsByEventId : shakeBoundsByEventId // ignore: cast_nullable_to_non_nullable
as Map<String, EewMapFocusGridRect>,
  ));
}


}

/// @nodoc
mixin _$EewMapFocusDecision {

 EewMapFocusState get state; bool get shouldFit; ({double latitude, double longitude})? get targetHypocenter; EewMapFocusGridRect? get targetShakeRect;
/// Create a copy of EewMapFocusDecision
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewMapFocusDecisionCopyWith<EewMapFocusDecision> get copyWith => _$EewMapFocusDecisionCopyWithImpl<EewMapFocusDecision>(this as EewMapFocusDecision, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewMapFocusDecision&&(identical(other.state, state) || other.state == state)&&(identical(other.shouldFit, shouldFit) || other.shouldFit == shouldFit)&&(identical(other.targetHypocenter, targetHypocenter) || other.targetHypocenter == targetHypocenter)&&(identical(other.targetShakeRect, targetShakeRect) || other.targetShakeRect == targetShakeRect));
}


@override
int get hashCode => Object.hash(runtimeType,state,shouldFit,targetHypocenter,targetShakeRect);

@override
String toString() {
  return 'EewMapFocusDecision(state: $state, shouldFit: $shouldFit, targetHypocenter: $targetHypocenter, targetShakeRect: $targetShakeRect)';
}


}

/// @nodoc
abstract mixin class $EewMapFocusDecisionCopyWith<$Res>  {
  factory $EewMapFocusDecisionCopyWith(EewMapFocusDecision value, $Res Function(EewMapFocusDecision) _then) = _$EewMapFocusDecisionCopyWithImpl;
@useResult
$Res call({
 EewMapFocusState state, bool shouldFit, ({double latitude, double longitude})? targetHypocenter, EewMapFocusGridRect? targetShakeRect
});


$EewMapFocusStateCopyWith<$Res> get state;

}
/// @nodoc
class _$EewMapFocusDecisionCopyWithImpl<$Res>
    implements $EewMapFocusDecisionCopyWith<$Res> {
  _$EewMapFocusDecisionCopyWithImpl(this._self, this._then);

  final EewMapFocusDecision _self;
  final $Res Function(EewMapFocusDecision) _then;

/// Create a copy of EewMapFocusDecision
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? shouldFit = null,Object? targetHypocenter = freezed,Object? targetShakeRect = freezed,}) {
  return _then(_self.copyWith(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as EewMapFocusState,shouldFit: null == shouldFit ? _self.shouldFit : shouldFit // ignore: cast_nullable_to_non_nullable
as bool,targetHypocenter: freezed == targetHypocenter ? _self.targetHypocenter : targetHypocenter // ignore: cast_nullable_to_non_nullable
as ({double latitude, double longitude})?,targetShakeRect: freezed == targetShakeRect ? _self.targetShakeRect : targetShakeRect // ignore: cast_nullable_to_non_nullable
as EewMapFocusGridRect?,
  ));
}
/// Create a copy of EewMapFocusDecision
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewMapFocusStateCopyWith<$Res> get state {
  
  return $EewMapFocusStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewMapFocusDecision].
extension EewMapFocusDecisionPatterns on EewMapFocusDecision {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewMapFocusDecision value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewMapFocusDecision() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewMapFocusDecision value)  $default,){
final _that = this;
switch (_that) {
case _EewMapFocusDecision():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewMapFocusDecision value)?  $default,){
final _that = this;
switch (_that) {
case _EewMapFocusDecision() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EewMapFocusState state,  bool shouldFit,  ({double latitude, double longitude})? targetHypocenter,  EewMapFocusGridRect? targetShakeRect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewMapFocusDecision() when $default != null:
return $default(_that.state,_that.shouldFit,_that.targetHypocenter,_that.targetShakeRect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EewMapFocusState state,  bool shouldFit,  ({double latitude, double longitude})? targetHypocenter,  EewMapFocusGridRect? targetShakeRect)  $default,) {final _that = this;
switch (_that) {
case _EewMapFocusDecision():
return $default(_that.state,_that.shouldFit,_that.targetHypocenter,_that.targetShakeRect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EewMapFocusState state,  bool shouldFit,  ({double latitude, double longitude})? targetHypocenter,  EewMapFocusGridRect? targetShakeRect)?  $default,) {final _that = this;
switch (_that) {
case _EewMapFocusDecision() when $default != null:
return $default(_that.state,_that.shouldFit,_that.targetHypocenter,_that.targetShakeRect);case _:
  return null;

}
}

}

/// @nodoc


class _EewMapFocusDecision implements EewMapFocusDecision {
  const _EewMapFocusDecision({required this.state, required this.shouldFit, this.targetHypocenter, this.targetShakeRect});
  

@override final  EewMapFocusState state;
@override final  bool shouldFit;
@override final  ({double latitude, double longitude})? targetHypocenter;
@override final  EewMapFocusGridRect? targetShakeRect;

/// Create a copy of EewMapFocusDecision
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewMapFocusDecisionCopyWith<_EewMapFocusDecision> get copyWith => __$EewMapFocusDecisionCopyWithImpl<_EewMapFocusDecision>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewMapFocusDecision&&(identical(other.state, state) || other.state == state)&&(identical(other.shouldFit, shouldFit) || other.shouldFit == shouldFit)&&(identical(other.targetHypocenter, targetHypocenter) || other.targetHypocenter == targetHypocenter)&&(identical(other.targetShakeRect, targetShakeRect) || other.targetShakeRect == targetShakeRect));
}


@override
int get hashCode => Object.hash(runtimeType,state,shouldFit,targetHypocenter,targetShakeRect);

@override
String toString() {
  return 'EewMapFocusDecision(state: $state, shouldFit: $shouldFit, targetHypocenter: $targetHypocenter, targetShakeRect: $targetShakeRect)';
}


}

/// @nodoc
abstract mixin class _$EewMapFocusDecisionCopyWith<$Res> implements $EewMapFocusDecisionCopyWith<$Res> {
  factory _$EewMapFocusDecisionCopyWith(_EewMapFocusDecision value, $Res Function(_EewMapFocusDecision) _then) = __$EewMapFocusDecisionCopyWithImpl;
@override @useResult
$Res call({
 EewMapFocusState state, bool shouldFit, ({double latitude, double longitude})? targetHypocenter, EewMapFocusGridRect? targetShakeRect
});


@override $EewMapFocusStateCopyWith<$Res> get state;

}
/// @nodoc
class __$EewMapFocusDecisionCopyWithImpl<$Res>
    implements _$EewMapFocusDecisionCopyWith<$Res> {
  __$EewMapFocusDecisionCopyWithImpl(this._self, this._then);

  final _EewMapFocusDecision _self;
  final $Res Function(_EewMapFocusDecision) _then;

/// Create a copy of EewMapFocusDecision
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? shouldFit = null,Object? targetHypocenter = freezed,Object? targetShakeRect = freezed,}) {
  return _then(_EewMapFocusDecision(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as EewMapFocusState,shouldFit: null == shouldFit ? _self.shouldFit : shouldFit // ignore: cast_nullable_to_non_nullable
as bool,targetHypocenter: freezed == targetHypocenter ? _self.targetHypocenter : targetHypocenter // ignore: cast_nullable_to_non_nullable
as ({double latitude, double longitude})?,targetShakeRect: freezed == targetShakeRect ? _self.targetShakeRect : targetShakeRect // ignore: cast_nullable_to_non_nullable
as EewMapFocusGridRect?,
  ));
}

/// Create a copy of EewMapFocusDecision
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewMapFocusStateCopyWith<$Res> get state {
  
  return $EewMapFocusStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}

// dart format on
