// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_location_sync_scope.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceLocationSyncScope {

@JsonKey(name: 'apiEndpoint') String get apiEndpoint;
/// Create a copy of DeviceLocationSyncScope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceLocationSyncScopeCopyWith<DeviceLocationSyncScope> get copyWith => _$DeviceLocationSyncScopeCopyWithImpl<DeviceLocationSyncScope>(this as DeviceLocationSyncScope, _$identity);

  /// Serializes this DeviceLocationSyncScope to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceLocationSyncScope&&(identical(other.apiEndpoint, apiEndpoint) || other.apiEndpoint == apiEndpoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiEndpoint);

@override
String toString() {
  return 'DeviceLocationSyncScope(apiEndpoint: $apiEndpoint)';
}


}

/// @nodoc
abstract mixin class $DeviceLocationSyncScopeCopyWith<$Res>  {
  factory $DeviceLocationSyncScopeCopyWith(DeviceLocationSyncScope value, $Res Function(DeviceLocationSyncScope) _then) = _$DeviceLocationSyncScopeCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'apiEndpoint') String apiEndpoint
});




}
/// @nodoc
class _$DeviceLocationSyncScopeCopyWithImpl<$Res>
    implements $DeviceLocationSyncScopeCopyWith<$Res> {
  _$DeviceLocationSyncScopeCopyWithImpl(this._self, this._then);

  final DeviceLocationSyncScope _self;
  final $Res Function(DeviceLocationSyncScope) _then;

/// Create a copy of DeviceLocationSyncScope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiEndpoint = null,}) {
  return _then(DeviceLocationSyncScope(
apiEndpoint: null == apiEndpoint ? _self.apiEndpoint : apiEndpoint // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceLocationSyncScope].
extension DeviceLocationSyncScopePatterns on DeviceLocationSyncScope {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceLocationSyncScope value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceLocationSyncScope() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceLocationSyncScope value)  $default,){
final _that = this;
switch (_that) {
case _DeviceLocationSyncScope():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceLocationSyncScope value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceLocationSyncScope() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'apiEndpoint')  String apiEndpoint)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceLocationSyncScope() when $default != null:
return $default(_that.apiEndpoint);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'apiEndpoint')  String apiEndpoint)  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationSyncScope():
return $default(_that.apiEndpoint);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'apiEndpoint')  String apiEndpoint)?  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationSyncScope() when $default != null:
return $default(_that.apiEndpoint);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceLocationSyncScope implements DeviceLocationSyncScope {
  const _DeviceLocationSyncScope({@JsonKey(name: 'apiEndpoint') required this.apiEndpoint});
  factory _DeviceLocationSyncScope.fromJson(Map<String, dynamic> json) => _$DeviceLocationSyncScopeFromJson(json);

@override@JsonKey(name: 'apiEndpoint') final  String apiEndpoint;

/// Create a copy of DeviceLocationSyncScope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceLocationSyncScopeCopyWith<_DeviceLocationSyncScope> get copyWith => __$DeviceLocationSyncScopeCopyWithImpl<_DeviceLocationSyncScope>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceLocationSyncScopeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceLocationSyncScope&&(identical(other.apiEndpoint, apiEndpoint) || other.apiEndpoint == apiEndpoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiEndpoint);

@override
String toString() {
  return 'DeviceLocationSyncScope(apiEndpoint: $apiEndpoint)';
}


}

/// @nodoc
abstract mixin class _$DeviceLocationSyncScopeCopyWith<$Res> implements $DeviceLocationSyncScopeCopyWith<$Res> {
  factory _$DeviceLocationSyncScopeCopyWith(_DeviceLocationSyncScope value, $Res Function(_DeviceLocationSyncScope) _then) = __$DeviceLocationSyncScopeCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'apiEndpoint') String apiEndpoint
});




}
/// @nodoc
class __$DeviceLocationSyncScopeCopyWithImpl<$Res>
    implements _$DeviceLocationSyncScopeCopyWith<$Res> {
  __$DeviceLocationSyncScopeCopyWithImpl(this._self, this._then);

  final _DeviceLocationSyncScope _self;
  final $Res Function(_DeviceLocationSyncScope) _then;

/// Create a copy of DeviceLocationSyncScope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiEndpoint = null,}) {
  return _then(_DeviceLocationSyncScope(
apiEndpoint: null == apiEndpoint ? _self.apiEndpoint : apiEndpoint // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
