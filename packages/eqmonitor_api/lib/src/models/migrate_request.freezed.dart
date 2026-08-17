// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'migrate_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MigrateRequest {

@JsonKey(name: 'old_device_id') String get oldDeviceId;
/// Create a copy of MigrateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MigrateRequestCopyWith<MigrateRequest> get copyWith => _$MigrateRequestCopyWithImpl<MigrateRequest>(this as MigrateRequest, _$identity);

  /// Serializes this MigrateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MigrateRequest&&(identical(other.oldDeviceId, oldDeviceId) || other.oldDeviceId == oldDeviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oldDeviceId);

@override
String toString() {
  return 'MigrateRequest(oldDeviceId: $oldDeviceId)';
}


}

/// @nodoc
abstract mixin class $MigrateRequestCopyWith<$Res>  {
  factory $MigrateRequestCopyWith(MigrateRequest value, $Res Function(MigrateRequest) _then) = _$MigrateRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'old_device_id') String oldDeviceId
});




}
/// @nodoc
class _$MigrateRequestCopyWithImpl<$Res>
    implements $MigrateRequestCopyWith<$Res> {
  _$MigrateRequestCopyWithImpl(this._self, this._then);

  final MigrateRequest _self;
  final $Res Function(MigrateRequest) _then;

/// Create a copy of MigrateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? oldDeviceId = null,}) {
  return _then(MigrateRequest(
oldDeviceId: null == oldDeviceId ? _self.oldDeviceId : oldDeviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MigrateRequest].
extension MigrateRequestPatterns on MigrateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MigrateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MigrateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MigrateRequest value)  $default,){
final _that = this;
switch (_that) {
case _MigrateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MigrateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _MigrateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'old_device_id')  String oldDeviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MigrateRequest() when $default != null:
return $default(_that.oldDeviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'old_device_id')  String oldDeviceId)  $default,) {final _that = this;
switch (_that) {
case _MigrateRequest():
return $default(_that.oldDeviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'old_device_id')  String oldDeviceId)?  $default,) {final _that = this;
switch (_that) {
case _MigrateRequest() when $default != null:
return $default(_that.oldDeviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MigrateRequest implements MigrateRequest {
  const _MigrateRequest({@JsonKey(name: 'old_device_id') required this.oldDeviceId});
  factory _MigrateRequest.fromJson(Map<String, dynamic> json) => _$MigrateRequestFromJson(json);

@override@JsonKey(name: 'old_device_id') final  String oldDeviceId;

/// Create a copy of MigrateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MigrateRequestCopyWith<_MigrateRequest> get copyWith => __$MigrateRequestCopyWithImpl<_MigrateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MigrateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MigrateRequest&&(identical(other.oldDeviceId, oldDeviceId) || other.oldDeviceId == oldDeviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oldDeviceId);

@override
String toString() {
  return 'MigrateRequest(oldDeviceId: $oldDeviceId)';
}


}

/// @nodoc
abstract mixin class _$MigrateRequestCopyWith<$Res> implements $MigrateRequestCopyWith<$Res> {
  factory _$MigrateRequestCopyWith(_MigrateRequest value, $Res Function(_MigrateRequest) _then) = __$MigrateRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'old_device_id') String oldDeviceId
});




}
/// @nodoc
class __$MigrateRequestCopyWithImpl<$Res>
    implements _$MigrateRequestCopyWith<$Res> {
  __$MigrateRequestCopyWithImpl(this._self, this._then);

  final _MigrateRequest _self;
  final $Res Function(_MigrateRequest) _then;

/// Create a copy of MigrateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? oldDeviceId = null,}) {
  return _then(_MigrateRequest(
oldDeviceId: null == oldDeviceId ? _self.oldDeviceId : oldDeviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
