// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_storage_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeviceStorageException {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceStorageException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeviceStorageException()';
}


}

/// @nodoc
class $DeviceStorageExceptionCopyWith<$Res>  {
$DeviceStorageExceptionCopyWith(DeviceStorageException _, $Res Function(DeviceStorageException) __);
}


/// Adds pattern-matching-related methods to [DeviceStorageException].
extension DeviceStorageExceptionPatterns on DeviceStorageException {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DeviceStorageUnsupportedPlatformException value)?  unsupportedPlatform,TResult Function( DeviceStorageNativeCallFailedException value)?  nativeCallFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DeviceStorageUnsupportedPlatformException() when unsupportedPlatform != null:
return unsupportedPlatform(_that);case DeviceStorageNativeCallFailedException() when nativeCallFailed != null:
return nativeCallFailed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DeviceStorageUnsupportedPlatformException value)  unsupportedPlatform,required TResult Function( DeviceStorageNativeCallFailedException value)  nativeCallFailed,}){
final _that = this;
switch (_that) {
case DeviceStorageUnsupportedPlatformException():
return unsupportedPlatform(_that);case DeviceStorageNativeCallFailedException():
return nativeCallFailed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DeviceStorageUnsupportedPlatformException value)?  unsupportedPlatform,TResult? Function( DeviceStorageNativeCallFailedException value)?  nativeCallFailed,}){
final _that = this;
switch (_that) {
case DeviceStorageUnsupportedPlatformException() when unsupportedPlatform != null:
return unsupportedPlatform(_that);case DeviceStorageNativeCallFailedException() when nativeCallFailed != null:
return nativeCallFailed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String operatingSystem)?  unsupportedPlatform,TResult Function( String message)?  nativeCallFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DeviceStorageUnsupportedPlatformException() when unsupportedPlatform != null:
return unsupportedPlatform(_that.operatingSystem);case DeviceStorageNativeCallFailedException() when nativeCallFailed != null:
return nativeCallFailed(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String operatingSystem)  unsupportedPlatform,required TResult Function( String message)  nativeCallFailed,}) {final _that = this;
switch (_that) {
case DeviceStorageUnsupportedPlatformException():
return unsupportedPlatform(_that.operatingSystem);case DeviceStorageNativeCallFailedException():
return nativeCallFailed(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String operatingSystem)?  unsupportedPlatform,TResult? Function( String message)?  nativeCallFailed,}) {final _that = this;
switch (_that) {
case DeviceStorageUnsupportedPlatformException() when unsupportedPlatform != null:
return unsupportedPlatform(_that.operatingSystem);case DeviceStorageNativeCallFailedException() when nativeCallFailed != null:
return nativeCallFailed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class DeviceStorageUnsupportedPlatformException implements DeviceStorageException {
  const DeviceStorageUnsupportedPlatformException({required this.operatingSystem});
  

 final  String operatingSystem;

/// Create a copy of DeviceStorageException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceStorageUnsupportedPlatformExceptionCopyWith<DeviceStorageUnsupportedPlatformException> get copyWith => _$DeviceStorageUnsupportedPlatformExceptionCopyWithImpl<DeviceStorageUnsupportedPlatformException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceStorageUnsupportedPlatformException&&(identical(other.operatingSystem, operatingSystem) || other.operatingSystem == operatingSystem));
}


@override
int get hashCode => Object.hash(runtimeType,operatingSystem);

@override
String toString() {
  return 'DeviceStorageException.unsupportedPlatform(operatingSystem: $operatingSystem)';
}


}

/// @nodoc
abstract mixin class $DeviceStorageUnsupportedPlatformExceptionCopyWith<$Res> implements $DeviceStorageExceptionCopyWith<$Res> {
  factory $DeviceStorageUnsupportedPlatformExceptionCopyWith(DeviceStorageUnsupportedPlatformException value, $Res Function(DeviceStorageUnsupportedPlatformException) _then) = _$DeviceStorageUnsupportedPlatformExceptionCopyWithImpl;
@useResult
$Res call({
 String operatingSystem
});




}
/// @nodoc
class _$DeviceStorageUnsupportedPlatformExceptionCopyWithImpl<$Res>
    implements $DeviceStorageUnsupportedPlatformExceptionCopyWith<$Res> {
  _$DeviceStorageUnsupportedPlatformExceptionCopyWithImpl(this._self, this._then);

  final DeviceStorageUnsupportedPlatformException _self;
  final $Res Function(DeviceStorageUnsupportedPlatformException) _then;

/// Create a copy of DeviceStorageException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? operatingSystem = null,}) {
  return _then(DeviceStorageUnsupportedPlatformException(
operatingSystem: null == operatingSystem ? _self.operatingSystem : operatingSystem // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DeviceStorageNativeCallFailedException implements DeviceStorageException {
  const DeviceStorageNativeCallFailedException({required this.message});
  

 final  String message;

/// Create a copy of DeviceStorageException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceStorageNativeCallFailedExceptionCopyWith<DeviceStorageNativeCallFailedException> get copyWith => _$DeviceStorageNativeCallFailedExceptionCopyWithImpl<DeviceStorageNativeCallFailedException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceStorageNativeCallFailedException&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DeviceStorageException.nativeCallFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $DeviceStorageNativeCallFailedExceptionCopyWith<$Res> implements $DeviceStorageExceptionCopyWith<$Res> {
  factory $DeviceStorageNativeCallFailedExceptionCopyWith(DeviceStorageNativeCallFailedException value, $Res Function(DeviceStorageNativeCallFailedException) _then) = _$DeviceStorageNativeCallFailedExceptionCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DeviceStorageNativeCallFailedExceptionCopyWithImpl<$Res>
    implements $DeviceStorageNativeCallFailedExceptionCopyWith<$Res> {
  _$DeviceStorageNativeCallFailedExceptionCopyWithImpl(this._self, this._then);

  final DeviceStorageNativeCallFailedException _self;
  final $Res Function(DeviceStorageNativeCallFailedException) _then;

/// Create a copy of DeviceStorageException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DeviceStorageNativeCallFailedException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
