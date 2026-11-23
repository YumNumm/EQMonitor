// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_storage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeviceStorage {

 int get totalBytes; int get availableBytes;
/// Create a copy of DeviceStorage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceStorageCopyWith<DeviceStorage> get copyWith => _$DeviceStorageCopyWithImpl<DeviceStorage>(this as DeviceStorage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceStorage&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes)&&(identical(other.availableBytes, availableBytes) || other.availableBytes == availableBytes));
}


@override
int get hashCode => Object.hash(runtimeType,totalBytes,availableBytes);

@override
String toString() {
  return 'DeviceStorage(totalBytes: $totalBytes, availableBytes: $availableBytes)';
}


}

/// @nodoc
abstract mixin class $DeviceStorageCopyWith<$Res>  {
  factory $DeviceStorageCopyWith(DeviceStorage value, $Res Function(DeviceStorage) _then) = _$DeviceStorageCopyWithImpl;
@useResult
$Res call({
 int totalBytes, int availableBytes
});




}
/// @nodoc
class _$DeviceStorageCopyWithImpl<$Res>
    implements $DeviceStorageCopyWith<$Res> {
  _$DeviceStorageCopyWithImpl(this._self, this._then);

  final DeviceStorage _self;
  final $Res Function(DeviceStorage) _then;

/// Create a copy of DeviceStorage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalBytes = null,Object? availableBytes = null,}) {
  return _then(_self.copyWith(
totalBytes: null == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int,availableBytes: null == availableBytes ? _self.availableBytes : availableBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceStorage].
extension DeviceStoragePatterns on DeviceStorage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AndroidDeviceStorage value)?  android,TResult Function( IosDeviceStorage value)?  ios,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AndroidDeviceStorage() when android != null:
return android(_that);case IosDeviceStorage() when ios != null:
return ios(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AndroidDeviceStorage value)  android,required TResult Function( IosDeviceStorage value)  ios,}){
final _that = this;
switch (_that) {
case AndroidDeviceStorage():
return android(_that);case IosDeviceStorage():
return ios(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AndroidDeviceStorage value)?  android,TResult? Function( IosDeviceStorage value)?  ios,}){
final _that = this;
switch (_that) {
case AndroidDeviceStorage() when android != null:
return android(_that);case IosDeviceStorage() when ios != null:
return ios(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int totalBytes,  int availableBytes,  int freeBytes)?  android,TResult Function( int totalBytes,  int availableBytes,  int? importantUsageAvailableBytes,  int? opportunisticUsageAvailableBytes)?  ios,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AndroidDeviceStorage() when android != null:
return android(_that.totalBytes,_that.availableBytes,_that.freeBytes);case IosDeviceStorage() when ios != null:
return ios(_that.totalBytes,_that.availableBytes,_that.importantUsageAvailableBytes,_that.opportunisticUsageAvailableBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int totalBytes,  int availableBytes,  int freeBytes)  android,required TResult Function( int totalBytes,  int availableBytes,  int? importantUsageAvailableBytes,  int? opportunisticUsageAvailableBytes)  ios,}) {final _that = this;
switch (_that) {
case AndroidDeviceStorage():
return android(_that.totalBytes,_that.availableBytes,_that.freeBytes);case IosDeviceStorage():
return ios(_that.totalBytes,_that.availableBytes,_that.importantUsageAvailableBytes,_that.opportunisticUsageAvailableBytes);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int totalBytes,  int availableBytes,  int freeBytes)?  android,TResult? Function( int totalBytes,  int availableBytes,  int? importantUsageAvailableBytes,  int? opportunisticUsageAvailableBytes)?  ios,}) {final _that = this;
switch (_that) {
case AndroidDeviceStorage() when android != null:
return android(_that.totalBytes,_that.availableBytes,_that.freeBytes);case IosDeviceStorage() when ios != null:
return ios(_that.totalBytes,_that.availableBytes,_that.importantUsageAvailableBytes,_that.opportunisticUsageAvailableBytes);case _:
  return null;

}
}

}

/// @nodoc


class AndroidDeviceStorage extends DeviceStorage {
  const AndroidDeviceStorage({required this.totalBytes, required this.availableBytes, required this.freeBytes}): super._();
  

@override final  int totalBytes;
@override final  int availableBytes;
 final  int freeBytes;

/// Create a copy of DeviceStorage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AndroidDeviceStorageCopyWith<AndroidDeviceStorage> get copyWith => _$AndroidDeviceStorageCopyWithImpl<AndroidDeviceStorage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AndroidDeviceStorage&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes)&&(identical(other.availableBytes, availableBytes) || other.availableBytes == availableBytes)&&(identical(other.freeBytes, freeBytes) || other.freeBytes == freeBytes));
}


@override
int get hashCode => Object.hash(runtimeType,totalBytes,availableBytes,freeBytes);

@override
String toString() {
  return 'DeviceStorage.android(totalBytes: $totalBytes, availableBytes: $availableBytes, freeBytes: $freeBytes)';
}


}

/// @nodoc
abstract mixin class $AndroidDeviceStorageCopyWith<$Res> implements $DeviceStorageCopyWith<$Res> {
  factory $AndroidDeviceStorageCopyWith(AndroidDeviceStorage value, $Res Function(AndroidDeviceStorage) _then) = _$AndroidDeviceStorageCopyWithImpl;
@override @useResult
$Res call({
 int totalBytes, int availableBytes, int freeBytes
});




}
/// @nodoc
class _$AndroidDeviceStorageCopyWithImpl<$Res>
    implements $AndroidDeviceStorageCopyWith<$Res> {
  _$AndroidDeviceStorageCopyWithImpl(this._self, this._then);

  final AndroidDeviceStorage _self;
  final $Res Function(AndroidDeviceStorage) _then;

/// Create a copy of DeviceStorage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalBytes = null,Object? availableBytes = null,Object? freeBytes = null,}) {
  return _then(AndroidDeviceStorage(
totalBytes: null == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int,availableBytes: null == availableBytes ? _self.availableBytes : availableBytes // ignore: cast_nullable_to_non_nullable
as int,freeBytes: null == freeBytes ? _self.freeBytes : freeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class IosDeviceStorage extends DeviceStorage {
  const IosDeviceStorage({required this.totalBytes, required this.availableBytes, required this.importantUsageAvailableBytes, required this.opportunisticUsageAvailableBytes}): super._();
  

@override final  int totalBytes;
@override final  int availableBytes;
 final  int? importantUsageAvailableBytes;
 final  int? opportunisticUsageAvailableBytes;

/// Create a copy of DeviceStorage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IosDeviceStorageCopyWith<IosDeviceStorage> get copyWith => _$IosDeviceStorageCopyWithImpl<IosDeviceStorage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IosDeviceStorage&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes)&&(identical(other.availableBytes, availableBytes) || other.availableBytes == availableBytes)&&(identical(other.importantUsageAvailableBytes, importantUsageAvailableBytes) || other.importantUsageAvailableBytes == importantUsageAvailableBytes)&&(identical(other.opportunisticUsageAvailableBytes, opportunisticUsageAvailableBytes) || other.opportunisticUsageAvailableBytes == opportunisticUsageAvailableBytes));
}


@override
int get hashCode => Object.hash(runtimeType,totalBytes,availableBytes,importantUsageAvailableBytes,opportunisticUsageAvailableBytes);

@override
String toString() {
  return 'DeviceStorage.ios(totalBytes: $totalBytes, availableBytes: $availableBytes, importantUsageAvailableBytes: $importantUsageAvailableBytes, opportunisticUsageAvailableBytes: $opportunisticUsageAvailableBytes)';
}


}

/// @nodoc
abstract mixin class $IosDeviceStorageCopyWith<$Res> implements $DeviceStorageCopyWith<$Res> {
  factory $IosDeviceStorageCopyWith(IosDeviceStorage value, $Res Function(IosDeviceStorage) _then) = _$IosDeviceStorageCopyWithImpl;
@override @useResult
$Res call({
 int totalBytes, int availableBytes, int? importantUsageAvailableBytes, int? opportunisticUsageAvailableBytes
});




}
/// @nodoc
class _$IosDeviceStorageCopyWithImpl<$Res>
    implements $IosDeviceStorageCopyWith<$Res> {
  _$IosDeviceStorageCopyWithImpl(this._self, this._then);

  final IosDeviceStorage _self;
  final $Res Function(IosDeviceStorage) _then;

/// Create a copy of DeviceStorage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalBytes = null,Object? availableBytes = null,Object? importantUsageAvailableBytes = freezed,Object? opportunisticUsageAvailableBytes = freezed,}) {
  return _then(IosDeviceStorage(
totalBytes: null == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int,availableBytes: null == availableBytes ? _self.availableBytes : availableBytes // ignore: cast_nullable_to_non_nullable
as int,importantUsageAvailableBytes: freezed == importantUsageAvailableBytes ? _self.importantUsageAvailableBytes : importantUsageAvailableBytes // ignore: cast_nullable_to_non_nullable
as int?,opportunisticUsageAvailableBytes: freezed == opportunisticUsageAvailableBytes ? _self.opportunisticUsageAvailableBytes : opportunisticUsageAvailableBytes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
