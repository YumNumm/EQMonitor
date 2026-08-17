// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qzss_serial_port_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QzssSerialPortState {

 bool get isConnected; String? get portName; int get baudRate; String? get error;
/// Create a copy of QzssSerialPortState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssSerialPortStateCopyWith<QzssSerialPortState> get copyWith => _$QzssSerialPortStateCopyWithImpl<QzssSerialPortState>(this as QzssSerialPortState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssSerialPortState&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.portName, portName) || other.portName == portName)&&(identical(other.baudRate, baudRate) || other.baudRate == baudRate)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isConnected,portName,baudRate,error);

@override
String toString() {
  return 'QzssSerialPortState(isConnected: $isConnected, portName: $portName, baudRate: $baudRate, error: $error)';
}


}

/// @nodoc
abstract mixin class $QzssSerialPortStateCopyWith<$Res>  {
  factory $QzssSerialPortStateCopyWith(QzssSerialPortState value, $Res Function(QzssSerialPortState) _then) = _$QzssSerialPortStateCopyWithImpl;
@useResult
$Res call({
 bool isConnected, String? portName, int baudRate, String? error
});




}
/// @nodoc
class _$QzssSerialPortStateCopyWithImpl<$Res>
    implements $QzssSerialPortStateCopyWith<$Res> {
  _$QzssSerialPortStateCopyWithImpl(this._self, this._then);

  final QzssSerialPortState _self;
  final $Res Function(QzssSerialPortState) _then;

/// Create a copy of QzssSerialPortState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isConnected = null,Object? portName = freezed,Object? baudRate = null,Object? error = freezed,}) {
  return _then(QzssSerialPortState(
isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,portName: freezed == portName ? _self.portName : portName // ignore: cast_nullable_to_non_nullable
as String?,baudRate: null == baudRate ? _self.baudRate : baudRate // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QzssSerialPortState].
extension QzssSerialPortStatePatterns on QzssSerialPortState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QzssSerialPortState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QzssSerialPortState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QzssSerialPortState value)  $default,){
final _that = this;
switch (_that) {
case _QzssSerialPortState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QzssSerialPortState value)?  $default,){
final _that = this;
switch (_that) {
case _QzssSerialPortState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isConnected,  String? portName,  int baudRate,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QzssSerialPortState() when $default != null:
return $default(_that.isConnected,_that.portName,_that.baudRate,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isConnected,  String? portName,  int baudRate,  String? error)  $default,) {final _that = this;
switch (_that) {
case _QzssSerialPortState():
return $default(_that.isConnected,_that.portName,_that.baudRate,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isConnected,  String? portName,  int baudRate,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _QzssSerialPortState() when $default != null:
return $default(_that.isConnected,_that.portName,_that.baudRate,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _QzssSerialPortState implements QzssSerialPortState {
  const _QzssSerialPortState({required this.isConnected, required this.portName, required this.baudRate, this.error});
  

@override final  bool isConnected;
@override final  String? portName;
@override final  int baudRate;
@override final  String? error;

/// Create a copy of QzssSerialPortState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QzssSerialPortStateCopyWith<_QzssSerialPortState> get copyWith => __$QzssSerialPortStateCopyWithImpl<_QzssSerialPortState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QzssSerialPortState&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.portName, portName) || other.portName == portName)&&(identical(other.baudRate, baudRate) || other.baudRate == baudRate)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isConnected,portName,baudRate,error);

@override
String toString() {
  return 'QzssSerialPortState(isConnected: $isConnected, portName: $portName, baudRate: $baudRate, error: $error)';
}


}

/// @nodoc
abstract mixin class _$QzssSerialPortStateCopyWith<$Res> implements $QzssSerialPortStateCopyWith<$Res> {
  factory _$QzssSerialPortStateCopyWith(_QzssSerialPortState value, $Res Function(_QzssSerialPortState) _then) = __$QzssSerialPortStateCopyWithImpl;
@override @useResult
$Res call({
 bool isConnected, String? portName, int baudRate, String? error
});




}
/// @nodoc
class __$QzssSerialPortStateCopyWithImpl<$Res>
    implements _$QzssSerialPortStateCopyWith<$Res> {
  __$QzssSerialPortStateCopyWithImpl(this._self, this._then);

  final _QzssSerialPortState _self;
  final $Res Function(_QzssSerialPortState) _then;

/// Create a copy of QzssSerialPortState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isConnected = null,Object? portName = freezed,Object? baudRate = null,Object? error = freezed,}) {
  return _then(_QzssSerialPortState(
isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,portName: freezed == portName ? _self.portName : portName // ignore: cast_nullable_to_non_nullable
as String?,baudRate: null == baudRate ? _self.baudRate : baudRate // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
