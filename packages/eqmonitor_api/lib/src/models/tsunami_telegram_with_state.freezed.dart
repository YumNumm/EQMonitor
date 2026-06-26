// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_telegram_with_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiTelegramWithState {

 LatestTelegram get telegram; TsunamiState get state;
/// Create a copy of TsunamiTelegramWithState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiTelegramWithStateCopyWith<TsunamiTelegramWithState> get copyWith => _$TsunamiTelegramWithStateCopyWithImpl<TsunamiTelegramWithState>(this as TsunamiTelegramWithState, _$identity);

  /// Serializes this TsunamiTelegramWithState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiTelegramWithState&&(identical(other.telegram, telegram) || other.telegram == telegram)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,telegram,state);

@override
String toString() {
  return 'TsunamiTelegramWithState(telegram: $telegram, state: $state)';
}


}

/// @nodoc
abstract mixin class $TsunamiTelegramWithStateCopyWith<$Res>  {
  factory $TsunamiTelegramWithStateCopyWith(TsunamiTelegramWithState value, $Res Function(TsunamiTelegramWithState) _then) = _$TsunamiTelegramWithStateCopyWithImpl;
@useResult
$Res call({
 LatestTelegram telegram, TsunamiState state
});


$LatestTelegramCopyWith<$Res> get telegram;$TsunamiStateCopyWith<$Res> get state;

}
/// @nodoc
class _$TsunamiTelegramWithStateCopyWithImpl<$Res>
    implements $TsunamiTelegramWithStateCopyWith<$Res> {
  _$TsunamiTelegramWithStateCopyWithImpl(this._self, this._then);

  final TsunamiTelegramWithState _self;
  final $Res Function(TsunamiTelegramWithState) _then;

/// Create a copy of TsunamiTelegramWithState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? telegram = null,Object? state = null,}) {
  return _then(_self.copyWith(
telegram: null == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as LatestTelegram,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as TsunamiState,
  ));
}
/// Create a copy of TsunamiTelegramWithState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatestTelegramCopyWith<$Res> get telegram {
  
  return $LatestTelegramCopyWith<$Res>(_self.telegram, (value) {
    return _then(_self.copyWith(telegram: value));
  });
}/// Create a copy of TsunamiTelegramWithState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStateCopyWith<$Res> get state {
  
  return $TsunamiStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiTelegramWithState].
extension TsunamiTelegramWithStatePatterns on TsunamiTelegramWithState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiTelegramWithState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiTelegramWithState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiTelegramWithState value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramWithState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiTelegramWithState value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramWithState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LatestTelegram telegram,  TsunamiState state)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiTelegramWithState() when $default != null:
return $default(_that.telegram,_that.state);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LatestTelegram telegram,  TsunamiState state)  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramWithState():
return $default(_that.telegram,_that.state);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LatestTelegram telegram,  TsunamiState state)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramWithState() when $default != null:
return $default(_that.telegram,_that.state);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiTelegramWithState implements TsunamiTelegramWithState {
  const _TsunamiTelegramWithState({required this.telegram, required this.state});
  factory _TsunamiTelegramWithState.fromJson(Map<String, dynamic> json) => _$TsunamiTelegramWithStateFromJson(json);

@override final  LatestTelegram telegram;
@override final  TsunamiState state;

/// Create a copy of TsunamiTelegramWithState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiTelegramWithStateCopyWith<_TsunamiTelegramWithState> get copyWith => __$TsunamiTelegramWithStateCopyWithImpl<_TsunamiTelegramWithState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiTelegramWithStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiTelegramWithState&&(identical(other.telegram, telegram) || other.telegram == telegram)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,telegram,state);

@override
String toString() {
  return 'TsunamiTelegramWithState(telegram: $telegram, state: $state)';
}


}

/// @nodoc
abstract mixin class _$TsunamiTelegramWithStateCopyWith<$Res> implements $TsunamiTelegramWithStateCopyWith<$Res> {
  factory _$TsunamiTelegramWithStateCopyWith(_TsunamiTelegramWithState value, $Res Function(_TsunamiTelegramWithState) _then) = __$TsunamiTelegramWithStateCopyWithImpl;
@override @useResult
$Res call({
 LatestTelegram telegram, TsunamiState state
});


@override $LatestTelegramCopyWith<$Res> get telegram;@override $TsunamiStateCopyWith<$Res> get state;

}
/// @nodoc
class __$TsunamiTelegramWithStateCopyWithImpl<$Res>
    implements _$TsunamiTelegramWithStateCopyWith<$Res> {
  __$TsunamiTelegramWithStateCopyWithImpl(this._self, this._then);

  final _TsunamiTelegramWithState _self;
  final $Res Function(_TsunamiTelegramWithState) _then;

/// Create a copy of TsunamiTelegramWithState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? telegram = null,Object? state = null,}) {
  return _then(_TsunamiTelegramWithState(
telegram: null == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as LatestTelegram,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as TsunamiState,
  ));
}

/// Create a copy of TsunamiTelegramWithState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatestTelegramCopyWith<$Res> get telegram {
  
  return $LatestTelegramCopyWith<$Res>(_self.telegram, (value) {
    return _then(_self.copyWith(telegram: value));
  });
}/// Create a copy of TsunamiTelegramWithState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStateCopyWith<$Res> get state {
  
  return $TsunamiStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}

// dart format on
