// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PermissionState {

 bool get isNotificationGranted; bool get isCriticalAlertSupported; bool get isCriticalAlertGranted; bool get isForegroundLocationGranted; bool get isBackgroundLocationGranted;
/// Create a copy of PermissionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PermissionStateCopyWith<PermissionState> get copyWith => _$PermissionStateCopyWithImpl<PermissionState>(this as PermissionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PermissionState&&(identical(other.isNotificationGranted, isNotificationGranted) || other.isNotificationGranted == isNotificationGranted)&&(identical(other.isCriticalAlertSupported, isCriticalAlertSupported) || other.isCriticalAlertSupported == isCriticalAlertSupported)&&(identical(other.isCriticalAlertGranted, isCriticalAlertGranted) || other.isCriticalAlertGranted == isCriticalAlertGranted)&&(identical(other.isForegroundLocationGranted, isForegroundLocationGranted) || other.isForegroundLocationGranted == isForegroundLocationGranted)&&(identical(other.isBackgroundLocationGranted, isBackgroundLocationGranted) || other.isBackgroundLocationGranted == isBackgroundLocationGranted));
}


@override
int get hashCode => Object.hash(runtimeType,isNotificationGranted,isCriticalAlertSupported,isCriticalAlertGranted,isForegroundLocationGranted,isBackgroundLocationGranted);

@override
String toString() {
  return 'PermissionState(isNotificationGranted: $isNotificationGranted, isCriticalAlertSupported: $isCriticalAlertSupported, isCriticalAlertGranted: $isCriticalAlertGranted, isForegroundLocationGranted: $isForegroundLocationGranted, isBackgroundLocationGranted: $isBackgroundLocationGranted)';
}


}

/// @nodoc
abstract mixin class $PermissionStateCopyWith<$Res>  {
  factory $PermissionStateCopyWith(PermissionState value, $Res Function(PermissionState) _then) = _$PermissionStateCopyWithImpl;
@useResult
$Res call({
 bool isNotificationGranted, bool isCriticalAlertSupported, bool isCriticalAlertGranted, bool isForegroundLocationGranted, bool isBackgroundLocationGranted
});




}
/// @nodoc
class _$PermissionStateCopyWithImpl<$Res>
    implements $PermissionStateCopyWith<$Res> {
  _$PermissionStateCopyWithImpl(this._self, this._then);

  final PermissionState _self;
  final $Res Function(PermissionState) _then;

/// Create a copy of PermissionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isNotificationGranted = null,Object? isCriticalAlertSupported = null,Object? isCriticalAlertGranted = null,Object? isForegroundLocationGranted = null,Object? isBackgroundLocationGranted = null,}) {
  return _then(PermissionState(
isNotificationGranted: null == isNotificationGranted ? _self.isNotificationGranted : isNotificationGranted // ignore: cast_nullable_to_non_nullable
as bool,isCriticalAlertSupported: null == isCriticalAlertSupported ? _self.isCriticalAlertSupported : isCriticalAlertSupported // ignore: cast_nullable_to_non_nullable
as bool,isCriticalAlertGranted: null == isCriticalAlertGranted ? _self.isCriticalAlertGranted : isCriticalAlertGranted // ignore: cast_nullable_to_non_nullable
as bool,isForegroundLocationGranted: null == isForegroundLocationGranted ? _self.isForegroundLocationGranted : isForegroundLocationGranted // ignore: cast_nullable_to_non_nullable
as bool,isBackgroundLocationGranted: null == isBackgroundLocationGranted ? _self.isBackgroundLocationGranted : isBackgroundLocationGranted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PermissionState].
extension PermissionStatePatterns on PermissionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PermissionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PermissionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PermissionState value)  $default,){
final _that = this;
switch (_that) {
case _PermissionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PermissionState value)?  $default,){
final _that = this;
switch (_that) {
case _PermissionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isNotificationGranted,  bool isCriticalAlertSupported,  bool isCriticalAlertGranted,  bool isForegroundLocationGranted,  bool isBackgroundLocationGranted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PermissionState() when $default != null:
return $default(_that.isNotificationGranted,_that.isCriticalAlertSupported,_that.isCriticalAlertGranted,_that.isForegroundLocationGranted,_that.isBackgroundLocationGranted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isNotificationGranted,  bool isCriticalAlertSupported,  bool isCriticalAlertGranted,  bool isForegroundLocationGranted,  bool isBackgroundLocationGranted)  $default,) {final _that = this;
switch (_that) {
case _PermissionState():
return $default(_that.isNotificationGranted,_that.isCriticalAlertSupported,_that.isCriticalAlertGranted,_that.isForegroundLocationGranted,_that.isBackgroundLocationGranted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isNotificationGranted,  bool isCriticalAlertSupported,  bool isCriticalAlertGranted,  bool isForegroundLocationGranted,  bool isBackgroundLocationGranted)?  $default,) {final _that = this;
switch (_that) {
case _PermissionState() when $default != null:
return $default(_that.isNotificationGranted,_that.isCriticalAlertSupported,_that.isCriticalAlertGranted,_that.isForegroundLocationGranted,_that.isBackgroundLocationGranted);case _:
  return null;

}
}

}

/// @nodoc


class _PermissionState implements PermissionState {
  const _PermissionState({required this.isNotificationGranted, required this.isCriticalAlertSupported, required this.isCriticalAlertGranted, required this.isForegroundLocationGranted, required this.isBackgroundLocationGranted});
  

@override final  bool isNotificationGranted;
@override final  bool isCriticalAlertSupported;
@override final  bool isCriticalAlertGranted;
@override final  bool isForegroundLocationGranted;
@override final  bool isBackgroundLocationGranted;

/// Create a copy of PermissionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PermissionStateCopyWith<_PermissionState> get copyWith => __$PermissionStateCopyWithImpl<_PermissionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PermissionState&&(identical(other.isNotificationGranted, isNotificationGranted) || other.isNotificationGranted == isNotificationGranted)&&(identical(other.isCriticalAlertSupported, isCriticalAlertSupported) || other.isCriticalAlertSupported == isCriticalAlertSupported)&&(identical(other.isCriticalAlertGranted, isCriticalAlertGranted) || other.isCriticalAlertGranted == isCriticalAlertGranted)&&(identical(other.isForegroundLocationGranted, isForegroundLocationGranted) || other.isForegroundLocationGranted == isForegroundLocationGranted)&&(identical(other.isBackgroundLocationGranted, isBackgroundLocationGranted) || other.isBackgroundLocationGranted == isBackgroundLocationGranted));
}


@override
int get hashCode => Object.hash(runtimeType,isNotificationGranted,isCriticalAlertSupported,isCriticalAlertGranted,isForegroundLocationGranted,isBackgroundLocationGranted);

@override
String toString() {
  return 'PermissionState(isNotificationGranted: $isNotificationGranted, isCriticalAlertSupported: $isCriticalAlertSupported, isCriticalAlertGranted: $isCriticalAlertGranted, isForegroundLocationGranted: $isForegroundLocationGranted, isBackgroundLocationGranted: $isBackgroundLocationGranted)';
}


}

/// @nodoc
abstract mixin class _$PermissionStateCopyWith<$Res> implements $PermissionStateCopyWith<$Res> {
  factory _$PermissionStateCopyWith(_PermissionState value, $Res Function(_PermissionState) _then) = __$PermissionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isNotificationGranted, bool isCriticalAlertSupported, bool isCriticalAlertGranted, bool isForegroundLocationGranted, bool isBackgroundLocationGranted
});




}
/// @nodoc
class __$PermissionStateCopyWithImpl<$Res>
    implements _$PermissionStateCopyWith<$Res> {
  __$PermissionStateCopyWithImpl(this._self, this._then);

  final _PermissionState _self;
  final $Res Function(_PermissionState) _then;

/// Create a copy of PermissionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isNotificationGranted = null,Object? isCriticalAlertSupported = null,Object? isCriticalAlertGranted = null,Object? isForegroundLocationGranted = null,Object? isBackgroundLocationGranted = null,}) {
  return _then(_PermissionState(
isNotificationGranted: null == isNotificationGranted ? _self.isNotificationGranted : isNotificationGranted // ignore: cast_nullable_to_non_nullable
as bool,isCriticalAlertSupported: null == isCriticalAlertSupported ? _self.isCriticalAlertSupported : isCriticalAlertSupported // ignore: cast_nullable_to_non_nullable
as bool,isCriticalAlertGranted: null == isCriticalAlertGranted ? _self.isCriticalAlertGranted : isCriticalAlertGranted // ignore: cast_nullable_to_non_nullable
as bool,isForegroundLocationGranted: null == isForegroundLocationGranted ? _self.isForegroundLocationGranted : isForegroundLocationGranted // ignore: cast_nullable_to_non_nullable
as bool,isBackgroundLocationGranted: null == isBackgroundLocationGranted ? _self.isBackgroundLocationGranted : isBackgroundLocationGranted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
