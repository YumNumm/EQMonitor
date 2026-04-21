// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_upsert_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceUpsertRequest {

 DeviceType get type;@JsonKey(includeIfNull: false) DeviceLocale? get locale;
/// Create a copy of DeviceUpsertRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceUpsertRequestCopyWith<DeviceUpsertRequest> get copyWith => _$DeviceUpsertRequestCopyWithImpl<DeviceUpsertRequest>(this as DeviceUpsertRequest, _$identity);

  /// Serializes this DeviceUpsertRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceUpsertRequest&&(identical(other.type, type) || other.type == type)&&(identical(other.locale, locale) || other.locale == locale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,locale);

@override
String toString() {
  return 'DeviceUpsertRequest(type: $type, locale: $locale)';
}


}

/// @nodoc
abstract mixin class $DeviceUpsertRequestCopyWith<$Res>  {
  factory $DeviceUpsertRequestCopyWith(DeviceUpsertRequest value, $Res Function(DeviceUpsertRequest) _then) = _$DeviceUpsertRequestCopyWithImpl;
@useResult
$Res call({
 DeviceType type,@JsonKey(includeIfNull: false) DeviceLocale? locale
});




}
/// @nodoc
class _$DeviceUpsertRequestCopyWithImpl<$Res>
    implements $DeviceUpsertRequestCopyWith<$Res> {
  _$DeviceUpsertRequestCopyWithImpl(this._self, this._then);

  final DeviceUpsertRequest _self;
  final $Res Function(DeviceUpsertRequest) _then;

/// Create a copy of DeviceUpsertRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? locale = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DeviceType,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as DeviceLocale?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceUpsertRequest].
extension DeviceUpsertRequestPatterns on DeviceUpsertRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceUpsertRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceUpsertRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceUpsertRequest value)  $default,){
final _that = this;
switch (_that) {
case _DeviceUpsertRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceUpsertRequest value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceUpsertRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeviceType type, @JsonKey(includeIfNull: false)  DeviceLocale? locale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceUpsertRequest() when $default != null:
return $default(_that.type,_that.locale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeviceType type, @JsonKey(includeIfNull: false)  DeviceLocale? locale)  $default,) {final _that = this;
switch (_that) {
case _DeviceUpsertRequest():
return $default(_that.type,_that.locale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeviceType type, @JsonKey(includeIfNull: false)  DeviceLocale? locale)?  $default,) {final _that = this;
switch (_that) {
case _DeviceUpsertRequest() when $default != null:
return $default(_that.type,_that.locale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceUpsertRequest implements DeviceUpsertRequest {
  const _DeviceUpsertRequest({required this.type, @JsonKey(includeIfNull: false) this.locale});
  factory _DeviceUpsertRequest.fromJson(Map<String, dynamic> json) => _$DeviceUpsertRequestFromJson(json);

@override final  DeviceType type;
@override@JsonKey(includeIfNull: false) final  DeviceLocale? locale;

/// Create a copy of DeviceUpsertRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceUpsertRequestCopyWith<_DeviceUpsertRequest> get copyWith => __$DeviceUpsertRequestCopyWithImpl<_DeviceUpsertRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceUpsertRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceUpsertRequest&&(identical(other.type, type) || other.type == type)&&(identical(other.locale, locale) || other.locale == locale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,locale);

@override
String toString() {
  return 'DeviceUpsertRequest(type: $type, locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$DeviceUpsertRequestCopyWith<$Res> implements $DeviceUpsertRequestCopyWith<$Res> {
  factory _$DeviceUpsertRequestCopyWith(_DeviceUpsertRequest value, $Res Function(_DeviceUpsertRequest) _then) = __$DeviceUpsertRequestCopyWithImpl;
@override @useResult
$Res call({
 DeviceType type,@JsonKey(includeIfNull: false) DeviceLocale? locale
});




}
/// @nodoc
class __$DeviceUpsertRequestCopyWithImpl<$Res>
    implements _$DeviceUpsertRequestCopyWith<$Res> {
  __$DeviceUpsertRequestCopyWithImpl(this._self, this._then);

  final _DeviceUpsertRequest _self;
  final $Res Function(_DeviceUpsertRequest) _then;

/// Create a copy of DeviceUpsertRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? locale = freezed,}) {
  return _then(_DeviceUpsertRequest(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DeviceType,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as DeviceLocale?,
  ));
}


}

// dart format on
