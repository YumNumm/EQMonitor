// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_device_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PendingDeviceLocation {

 String get updateId; double get latitude; double get longitude; double get accuracy; int get timestampMillis;
/// Create a copy of PendingDeviceLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingDeviceLocationCopyWith<PendingDeviceLocation> get copyWith => _$PendingDeviceLocationCopyWithImpl<PendingDeviceLocation>(this as PendingDeviceLocation, _$identity);

  /// Serializes this PendingDeviceLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingDeviceLocation&&(identical(other.updateId, updateId) || other.updateId == updateId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.timestampMillis, timestampMillis) || other.timestampMillis == timestampMillis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updateId,latitude,longitude,accuracy,timestampMillis);

@override
String toString() {
  return 'PendingDeviceLocation(updateId: $updateId, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, timestampMillis: $timestampMillis)';
}


}

/// @nodoc
abstract mixin class $PendingDeviceLocationCopyWith<$Res>  {
  factory $PendingDeviceLocationCopyWith(PendingDeviceLocation value, $Res Function(PendingDeviceLocation) _then) = _$PendingDeviceLocationCopyWithImpl;
@useResult
$Res call({
 String updateId, double latitude, double longitude, double accuracy, int timestampMillis
});




}
/// @nodoc
class _$PendingDeviceLocationCopyWithImpl<$Res>
    implements $PendingDeviceLocationCopyWith<$Res> {
  _$PendingDeviceLocationCopyWithImpl(this._self, this._then);

  final PendingDeviceLocation _self;
  final $Res Function(PendingDeviceLocation) _then;

/// Create a copy of PendingDeviceLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? updateId = null,Object? latitude = null,Object? longitude = null,Object? accuracy = null,Object? timestampMillis = null,}) {
  return _then(PendingDeviceLocation(
updateId: null == updateId ? _self.updateId : updateId // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,timestampMillis: null == timestampMillis ? _self.timestampMillis : timestampMillis // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingDeviceLocation].
extension PendingDeviceLocationPatterns on PendingDeviceLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingDeviceLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingDeviceLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingDeviceLocation value)  $default,){
final _that = this;
switch (_that) {
case _PendingDeviceLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingDeviceLocation value)?  $default,){
final _that = this;
switch (_that) {
case _PendingDeviceLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String updateId,  double latitude,  double longitude,  double accuracy,  int timestampMillis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingDeviceLocation() when $default != null:
return $default(_that.updateId,_that.latitude,_that.longitude,_that.accuracy,_that.timestampMillis);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String updateId,  double latitude,  double longitude,  double accuracy,  int timestampMillis)  $default,) {final _that = this;
switch (_that) {
case _PendingDeviceLocation():
return $default(_that.updateId,_that.latitude,_that.longitude,_that.accuracy,_that.timestampMillis);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String updateId,  double latitude,  double longitude,  double accuracy,  int timestampMillis)?  $default,) {final _that = this;
switch (_that) {
case _PendingDeviceLocation() when $default != null:
return $default(_that.updateId,_that.latitude,_that.longitude,_that.accuracy,_that.timestampMillis);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PendingDeviceLocation implements PendingDeviceLocation {
  const _PendingDeviceLocation({required this.updateId, required this.latitude, required this.longitude, required this.accuracy, required this.timestampMillis});
  factory _PendingDeviceLocation.fromJson(Map<String, dynamic> json) => _$PendingDeviceLocationFromJson(json);

@override final  String updateId;
@override final  double latitude;
@override final  double longitude;
@override final  double accuracy;
@override final  int timestampMillis;

/// Create a copy of PendingDeviceLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingDeviceLocationCopyWith<_PendingDeviceLocation> get copyWith => __$PendingDeviceLocationCopyWithImpl<_PendingDeviceLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PendingDeviceLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingDeviceLocation&&(identical(other.updateId, updateId) || other.updateId == updateId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.timestampMillis, timestampMillis) || other.timestampMillis == timestampMillis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updateId,latitude,longitude,accuracy,timestampMillis);

@override
String toString() {
  return 'PendingDeviceLocation(updateId: $updateId, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, timestampMillis: $timestampMillis)';
}


}

/// @nodoc
abstract mixin class _$PendingDeviceLocationCopyWith<$Res> implements $PendingDeviceLocationCopyWith<$Res> {
  factory _$PendingDeviceLocationCopyWith(_PendingDeviceLocation value, $Res Function(_PendingDeviceLocation) _then) = __$PendingDeviceLocationCopyWithImpl;
@override @useResult
$Res call({
 String updateId, double latitude, double longitude, double accuracy, int timestampMillis
});




}
/// @nodoc
class __$PendingDeviceLocationCopyWithImpl<$Res>
    implements _$PendingDeviceLocationCopyWith<$Res> {
  __$PendingDeviceLocationCopyWithImpl(this._self, this._then);

  final _PendingDeviceLocation _self;
  final $Res Function(_PendingDeviceLocation) _then;

/// Create a copy of PendingDeviceLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? updateId = null,Object? latitude = null,Object? longitude = null,Object? accuracy = null,Object? timestampMillis = null,}) {
  return _then(_PendingDeviceLocation(
updateId: null == updateId ? _self.updateId : updateId // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,timestampMillis: null == timestampMillis ? _self.timestampMillis : timestampMillis // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
