// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_locale_update_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceLocaleUpdateRequest {

 DeviceLocale get locale;
/// Create a copy of DeviceLocaleUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceLocaleUpdateRequestCopyWith<DeviceLocaleUpdateRequest> get copyWith => _$DeviceLocaleUpdateRequestCopyWithImpl<DeviceLocaleUpdateRequest>(this as DeviceLocaleUpdateRequest, _$identity);

  /// Serializes this DeviceLocaleUpdateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceLocaleUpdateRequest&&(identical(other.locale, locale) || other.locale == locale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locale);

@override
String toString() {
  return 'DeviceLocaleUpdateRequest(locale: $locale)';
}


}

/// @nodoc
abstract mixin class $DeviceLocaleUpdateRequestCopyWith<$Res>  {
  factory $DeviceLocaleUpdateRequestCopyWith(DeviceLocaleUpdateRequest value, $Res Function(DeviceLocaleUpdateRequest) _then) = _$DeviceLocaleUpdateRequestCopyWithImpl;
@useResult
$Res call({
 DeviceLocale locale
});




}
/// @nodoc
class _$DeviceLocaleUpdateRequestCopyWithImpl<$Res>
    implements $DeviceLocaleUpdateRequestCopyWith<$Res> {
  _$DeviceLocaleUpdateRequestCopyWithImpl(this._self, this._then);

  final DeviceLocaleUpdateRequest _self;
  final $Res Function(DeviceLocaleUpdateRequest) _then;

/// Create a copy of DeviceLocaleUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,}) {
  return _then(DeviceLocaleUpdateRequest(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as DeviceLocale,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceLocaleUpdateRequest].
extension DeviceLocaleUpdateRequestPatterns on DeviceLocaleUpdateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceLocaleUpdateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceLocaleUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceLocaleUpdateRequest value)  $default,){
final _that = this;
switch (_that) {
case _DeviceLocaleUpdateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceLocaleUpdateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceLocaleUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeviceLocale locale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceLocaleUpdateRequest() when $default != null:
return $default(_that.locale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeviceLocale locale)  $default,) {final _that = this;
switch (_that) {
case _DeviceLocaleUpdateRequest():
return $default(_that.locale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeviceLocale locale)?  $default,) {final _that = this;
switch (_that) {
case _DeviceLocaleUpdateRequest() when $default != null:
return $default(_that.locale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceLocaleUpdateRequest implements DeviceLocaleUpdateRequest {
  const _DeviceLocaleUpdateRequest({required this.locale});
  factory _DeviceLocaleUpdateRequest.fromJson(Map<String, dynamic> json) => _$DeviceLocaleUpdateRequestFromJson(json);

@override final  DeviceLocale locale;

/// Create a copy of DeviceLocaleUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceLocaleUpdateRequestCopyWith<_DeviceLocaleUpdateRequest> get copyWith => __$DeviceLocaleUpdateRequestCopyWithImpl<_DeviceLocaleUpdateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceLocaleUpdateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceLocaleUpdateRequest&&(identical(other.locale, locale) || other.locale == locale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locale);

@override
String toString() {
  return 'DeviceLocaleUpdateRequest(locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$DeviceLocaleUpdateRequestCopyWith<$Res> implements $DeviceLocaleUpdateRequestCopyWith<$Res> {
  factory _$DeviceLocaleUpdateRequestCopyWith(_DeviceLocaleUpdateRequest value, $Res Function(_DeviceLocaleUpdateRequest) _then) = __$DeviceLocaleUpdateRequestCopyWithImpl;
@override @useResult
$Res call({
 DeviceLocale locale
});




}
/// @nodoc
class __$DeviceLocaleUpdateRequestCopyWithImpl<$Res>
    implements _$DeviceLocaleUpdateRequestCopyWith<$Res> {
  __$DeviceLocaleUpdateRequestCopyWithImpl(this._self, this._then);

  final _DeviceLocaleUpdateRequest _self;
  final $Res Function(_DeviceLocaleUpdateRequest) _then;

/// Create a copy of DeviceLocaleUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,}) {
  return _then(_DeviceLocaleUpdateRequest(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as DeviceLocale,
  ));
}


}

// dart format on
