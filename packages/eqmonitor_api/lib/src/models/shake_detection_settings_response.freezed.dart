// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShakeDetectionSettingsResponse {

 List<ShakeDetectionSettingResponse> get settings;@JsonKey(name: 'requires_reconfiguration') bool get requiresReconfiguration;
/// Create a copy of ShakeDetectionSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionSettingsResponseCopyWith<ShakeDetectionSettingsResponse> get copyWith => _$ShakeDetectionSettingsResponseCopyWithImpl<ShakeDetectionSettingsResponse>(this as ShakeDetectionSettingsResponse, _$identity);

  /// Serializes this ShakeDetectionSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionSettingsResponse&&const DeepCollectionEquality().equals(other.settings, settings)&&(identical(other.requiresReconfiguration, requiresReconfiguration) || other.requiresReconfiguration == requiresReconfiguration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(settings),requiresReconfiguration);

@override
String toString() {
  return 'ShakeDetectionSettingsResponse(settings: $settings, requiresReconfiguration: $requiresReconfiguration)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionSettingsResponseCopyWith<$Res>  {
  factory $ShakeDetectionSettingsResponseCopyWith(ShakeDetectionSettingsResponse value, $Res Function(ShakeDetectionSettingsResponse) _then) = _$ShakeDetectionSettingsResponseCopyWithImpl;
@useResult
$Res call({
 List<ShakeDetectionSettingResponse> settings,@JsonKey(name: 'requires_reconfiguration') bool requiresReconfiguration
});




}
/// @nodoc
class _$ShakeDetectionSettingsResponseCopyWithImpl<$Res>
    implements $ShakeDetectionSettingsResponseCopyWith<$Res> {
  _$ShakeDetectionSettingsResponseCopyWithImpl(this._self, this._then);

  final ShakeDetectionSettingsResponse _self;
  final $Res Function(ShakeDetectionSettingsResponse) _then;

/// Create a copy of ShakeDetectionSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? requiresReconfiguration = null,}) {
  return _then(ShakeDetectionSettingsResponse(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionSettingResponse>,requiresReconfiguration: null == requiresReconfiguration ? _self.requiresReconfiguration : requiresReconfiguration // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ShakeDetectionSettingsResponse].
extension ShakeDetectionSettingsResponsePatterns on ShakeDetectionSettingsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionSettingsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionSettingsResponse value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSettingsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionSettingsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ShakeDetectionSettingResponse> settings, @JsonKey(name: 'requires_reconfiguration')  bool requiresReconfiguration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingsResponse() when $default != null:
return $default(_that.settings,_that.requiresReconfiguration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ShakeDetectionSettingResponse> settings, @JsonKey(name: 'requires_reconfiguration')  bool requiresReconfiguration)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingsResponse():
return $default(_that.settings,_that.requiresReconfiguration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ShakeDetectionSettingResponse> settings, @JsonKey(name: 'requires_reconfiguration')  bool requiresReconfiguration)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingsResponse() when $default != null:
return $default(_that.settings,_that.requiresReconfiguration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShakeDetectionSettingsResponse implements ShakeDetectionSettingsResponse {
  const _ShakeDetectionSettingsResponse({required  List<ShakeDetectionSettingResponse> settings, @JsonKey(name: 'requires_reconfiguration') required this.requiresReconfiguration}): _settings = settings;
  factory _ShakeDetectionSettingsResponse.fromJson(Map<String, dynamic> json) => _$ShakeDetectionSettingsResponseFromJson(json);

 final  List<ShakeDetectionSettingResponse> _settings;
@override List<ShakeDetectionSettingResponse> get settings {
  if (_settings is EqualUnmodifiableListView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_settings);
}

@override@JsonKey(name: 'requires_reconfiguration') final  bool requiresReconfiguration;

/// Create a copy of ShakeDetectionSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionSettingsResponseCopyWith<_ShakeDetectionSettingsResponse> get copyWith => __$ShakeDetectionSettingsResponseCopyWithImpl<_ShakeDetectionSettingsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionSettingsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionSettingsResponse&&const DeepCollectionEquality().equals(other._settings, _settings)&&(identical(other.requiresReconfiguration, requiresReconfiguration) || other.requiresReconfiguration == requiresReconfiguration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_settings),requiresReconfiguration);

@override
String toString() {
  return 'ShakeDetectionSettingsResponse(settings: $settings, requiresReconfiguration: $requiresReconfiguration)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionSettingsResponseCopyWith<$Res> implements $ShakeDetectionSettingsResponseCopyWith<$Res> {
  factory _$ShakeDetectionSettingsResponseCopyWith(_ShakeDetectionSettingsResponse value, $Res Function(_ShakeDetectionSettingsResponse) _then) = __$ShakeDetectionSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ShakeDetectionSettingResponse> settings,@JsonKey(name: 'requires_reconfiguration') bool requiresReconfiguration
});




}
/// @nodoc
class __$ShakeDetectionSettingsResponseCopyWithImpl<$Res>
    implements _$ShakeDetectionSettingsResponseCopyWith<$Res> {
  __$ShakeDetectionSettingsResponseCopyWithImpl(this._self, this._then);

  final _ShakeDetectionSettingsResponse _self;
  final $Res Function(_ShakeDetectionSettingsResponse) _then;

/// Create a copy of ShakeDetectionSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? requiresReconfiguration = null,}) {
  return _then(_ShakeDetectionSettingsResponse(
settings: null == settings ? _self._settings : settings // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionSettingResponse>,requiresReconfiguration: null == requiresReconfiguration ? _self.requiresReconfiguration : requiresReconfiguration // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
