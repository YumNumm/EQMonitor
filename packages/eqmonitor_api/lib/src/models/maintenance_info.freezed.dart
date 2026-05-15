// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'maintenance_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MaintenanceInfo {

 bool get enabled;@JsonKey(includeIfNull: false) String? get message;@JsonKey(includeIfNull: false) String? get url;
/// Create a copy of MaintenanceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaintenanceInfoCopyWith<MaintenanceInfo> get copyWith => _$MaintenanceInfoCopyWithImpl<MaintenanceInfo>(this as MaintenanceInfo, _$identity);

  /// Serializes this MaintenanceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaintenanceInfo&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.message, message) || other.message == message)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,message,url);

@override
String toString() {
  return 'MaintenanceInfo(enabled: $enabled, message: $message, url: $url)';
}


}

/// @nodoc
abstract mixin class $MaintenanceInfoCopyWith<$Res>  {
  factory $MaintenanceInfoCopyWith(MaintenanceInfo value, $Res Function(MaintenanceInfo) _then) = _$MaintenanceInfoCopyWithImpl;
@useResult
$Res call({
 bool enabled,@JsonKey(includeIfNull: false) String? message,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class _$MaintenanceInfoCopyWithImpl<$Res>
    implements $MaintenanceInfoCopyWith<$Res> {
  _$MaintenanceInfoCopyWithImpl(this._self, this._then);

  final MaintenanceInfo _self;
  final $Res Function(MaintenanceInfo) _then;

/// Create a copy of MaintenanceInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? message = freezed,Object? url = freezed,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MaintenanceInfo].
extension MaintenanceInfoPatterns on MaintenanceInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaintenanceInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaintenanceInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaintenanceInfo value)  $default,){
final _that = this;
switch (_that) {
case _MaintenanceInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaintenanceInfo value)?  $default,){
final _that = this;
switch (_that) {
case _MaintenanceInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(includeIfNull: false)  String? message, @JsonKey(includeIfNull: false)  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaintenanceInfo() when $default != null:
return $default(_that.enabled,_that.message,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(includeIfNull: false)  String? message, @JsonKey(includeIfNull: false)  String? url)  $default,) {final _that = this;
switch (_that) {
case _MaintenanceInfo():
return $default(_that.enabled,_that.message,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled, @JsonKey(includeIfNull: false)  String? message, @JsonKey(includeIfNull: false)  String? url)?  $default,) {final _that = this;
switch (_that) {
case _MaintenanceInfo() when $default != null:
return $default(_that.enabled,_that.message,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaintenanceInfo implements MaintenanceInfo {
  const _MaintenanceInfo({required this.enabled, @JsonKey(includeIfNull: false) this.message, @JsonKey(includeIfNull: false) this.url});
  factory _MaintenanceInfo.fromJson(Map<String, dynamic> json) => _$MaintenanceInfoFromJson(json);

@override final  bool enabled;
@override@JsonKey(includeIfNull: false) final  String? message;
@override@JsonKey(includeIfNull: false) final  String? url;

/// Create a copy of MaintenanceInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaintenanceInfoCopyWith<_MaintenanceInfo> get copyWith => __$MaintenanceInfoCopyWithImpl<_MaintenanceInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaintenanceInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaintenanceInfo&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.message, message) || other.message == message)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,message,url);

@override
String toString() {
  return 'MaintenanceInfo(enabled: $enabled, message: $message, url: $url)';
}


}

/// @nodoc
abstract mixin class _$MaintenanceInfoCopyWith<$Res> implements $MaintenanceInfoCopyWith<$Res> {
  factory _$MaintenanceInfoCopyWith(_MaintenanceInfo value, $Res Function(_MaintenanceInfo) _then) = __$MaintenanceInfoCopyWithImpl;
@override @useResult
$Res call({
 bool enabled,@JsonKey(includeIfNull: false) String? message,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class __$MaintenanceInfoCopyWithImpl<$Res>
    implements _$MaintenanceInfoCopyWith<$Res> {
  __$MaintenanceInfoCopyWithImpl(this._self, this._then);

  final _MaintenanceInfo _self;
  final $Res Function(_MaintenanceInfo) _then;

/// Create a copy of MaintenanceInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? message = freezed,Object? url = freezed,}) {
  return _then(_MaintenanceInfo(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
