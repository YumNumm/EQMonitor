// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_playback_selection_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiPlaybackSelectionState {

 int? get selectedIndex; bool get isExpanded;
/// Create a copy of TsunamiPlaybackSelectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiPlaybackSelectionStateCopyWith<TsunamiPlaybackSelectionState> get copyWith => _$TsunamiPlaybackSelectionStateCopyWithImpl<TsunamiPlaybackSelectionState>(this as TsunamiPlaybackSelectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiPlaybackSelectionState&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.isExpanded, isExpanded) || other.isExpanded == isExpanded));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex,isExpanded);

@override
String toString() {
  return 'TsunamiPlaybackSelectionState(selectedIndex: $selectedIndex, isExpanded: $isExpanded)';
}


}

/// @nodoc
abstract mixin class $TsunamiPlaybackSelectionStateCopyWith<$Res>  {
  factory $TsunamiPlaybackSelectionStateCopyWith(TsunamiPlaybackSelectionState value, $Res Function(TsunamiPlaybackSelectionState) _then) = _$TsunamiPlaybackSelectionStateCopyWithImpl;
@useResult
$Res call({
 int? selectedIndex, bool isExpanded
});




}
/// @nodoc
class _$TsunamiPlaybackSelectionStateCopyWithImpl<$Res>
    implements $TsunamiPlaybackSelectionStateCopyWith<$Res> {
  _$TsunamiPlaybackSelectionStateCopyWithImpl(this._self, this._then);

  final TsunamiPlaybackSelectionState _self;
  final $Res Function(TsunamiPlaybackSelectionState) _then;

/// Create a copy of TsunamiPlaybackSelectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedIndex = freezed,Object? isExpanded = null,}) {
  return _then(TsunamiPlaybackSelectionState(
selectedIndex: freezed == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int?,isExpanded: null == isExpanded ? _self.isExpanded : isExpanded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiPlaybackSelectionState].
extension TsunamiPlaybackSelectionStatePatterns on TsunamiPlaybackSelectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiPlaybackSelectionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiPlaybackSelectionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiPlaybackSelectionState value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiPlaybackSelectionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiPlaybackSelectionState value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiPlaybackSelectionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? selectedIndex,  bool isExpanded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiPlaybackSelectionState() when $default != null:
return $default(_that.selectedIndex,_that.isExpanded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? selectedIndex,  bool isExpanded)  $default,) {final _that = this;
switch (_that) {
case _TsunamiPlaybackSelectionState():
return $default(_that.selectedIndex,_that.isExpanded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? selectedIndex,  bool isExpanded)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiPlaybackSelectionState() when $default != null:
return $default(_that.selectedIndex,_that.isExpanded);case _:
  return null;

}
}

}

/// @nodoc


class _TsunamiPlaybackSelectionState implements TsunamiPlaybackSelectionState {
  const _TsunamiPlaybackSelectionState({this.selectedIndex = null, this.isExpanded = true});
  

@override@JsonKey() final  int? selectedIndex;
@override@JsonKey() final  bool isExpanded;

/// Create a copy of TsunamiPlaybackSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiPlaybackSelectionStateCopyWith<_TsunamiPlaybackSelectionState> get copyWith => __$TsunamiPlaybackSelectionStateCopyWithImpl<_TsunamiPlaybackSelectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiPlaybackSelectionState&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.isExpanded, isExpanded) || other.isExpanded == isExpanded));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex,isExpanded);

@override
String toString() {
  return 'TsunamiPlaybackSelectionState(selectedIndex: $selectedIndex, isExpanded: $isExpanded)';
}


}

/// @nodoc
abstract mixin class _$TsunamiPlaybackSelectionStateCopyWith<$Res> implements $TsunamiPlaybackSelectionStateCopyWith<$Res> {
  factory _$TsunamiPlaybackSelectionStateCopyWith(_TsunamiPlaybackSelectionState value, $Res Function(_TsunamiPlaybackSelectionState) _then) = __$TsunamiPlaybackSelectionStateCopyWithImpl;
@override @useResult
$Res call({
 int? selectedIndex, bool isExpanded
});




}
/// @nodoc
class __$TsunamiPlaybackSelectionStateCopyWithImpl<$Res>
    implements _$TsunamiPlaybackSelectionStateCopyWith<$Res> {
  __$TsunamiPlaybackSelectionStateCopyWithImpl(this._self, this._then);

  final _TsunamiPlaybackSelectionState _self;
  final $Res Function(_TsunamiPlaybackSelectionState) _then;

/// Create a copy of TsunamiPlaybackSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedIndex = freezed,Object? isExpanded = null,}) {
  return _then(_TsunamiPlaybackSelectionState(
selectedIndex: freezed == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int?,isExpanded: null == isExpanded ? _self.isExpanded : isExpanded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
