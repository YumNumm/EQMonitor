// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSettingsResponse {

@JsonKey(name: 'tsunami_enabled') bool get tsunamiEnabled;@JsonKey(name: 'training_enabled') bool get trainingEnabled;
/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsResponseCopyWith<NotificationSettingsResponse> get copyWith => _$NotificationSettingsResponseCopyWithImpl<NotificationSettingsResponse>(this as NotificationSettingsResponse, _$identity);

  /// Serializes this NotificationSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsResponse&&(identical(other.tsunamiEnabled, tsunamiEnabled) || other.tsunamiEnabled == tsunamiEnabled)&&(identical(other.trainingEnabled, trainingEnabled) || other.trainingEnabled == trainingEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunamiEnabled,trainingEnabled);

@override
String toString() {
  return 'NotificationSettingsResponse(tsunamiEnabled: $tsunamiEnabled, trainingEnabled: $trainingEnabled)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsResponseCopyWith<$Res>  {
  factory $NotificationSettingsResponseCopyWith(NotificationSettingsResponse value, $Res Function(NotificationSettingsResponse) _then) = _$NotificationSettingsResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'tsunami_enabled') bool tsunamiEnabled,@JsonKey(name: 'training_enabled') bool trainingEnabled
});




}
/// @nodoc
class _$NotificationSettingsResponseCopyWithImpl<$Res>
    implements $NotificationSettingsResponseCopyWith<$Res> {
  _$NotificationSettingsResponseCopyWithImpl(this._self, this._then);

  final NotificationSettingsResponse _self;
  final $Res Function(NotificationSettingsResponse) _then;

/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tsunamiEnabled = null,Object? trainingEnabled = null,}) {
  return _then(_self.copyWith(
tsunamiEnabled: null == tsunamiEnabled ? _self.tsunamiEnabled : tsunamiEnabled // ignore: cast_nullable_to_non_nullable
as bool,trainingEnabled: null == trainingEnabled ? _self.trainingEnabled : trainingEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSettingsResponse].
extension NotificationSettingsResponsePatterns on NotificationSettingsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSettingsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSettingsResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSettingsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'tsunami_enabled')  bool tsunamiEnabled, @JsonKey(name: 'training_enabled')  bool trainingEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSettingsResponse() when $default != null:
return $default(_that.tsunamiEnabled,_that.trainingEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'tsunami_enabled')  bool tsunamiEnabled, @JsonKey(name: 'training_enabled')  bool trainingEnabled)  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsResponse():
return $default(_that.tsunamiEnabled,_that.trainingEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'tsunami_enabled')  bool tsunamiEnabled, @JsonKey(name: 'training_enabled')  bool trainingEnabled)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsResponse() when $default != null:
return $default(_that.tsunamiEnabled,_that.trainingEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationSettingsResponse implements NotificationSettingsResponse {
  const _NotificationSettingsResponse({@JsonKey(name: 'tsunami_enabled') required this.tsunamiEnabled, @JsonKey(name: 'training_enabled') required this.trainingEnabled});
  factory _NotificationSettingsResponse.fromJson(Map<String, dynamic> json) => _$NotificationSettingsResponseFromJson(json);

@override@JsonKey(name: 'tsunami_enabled') final  bool tsunamiEnabled;
@override@JsonKey(name: 'training_enabled') final  bool trainingEnabled;

/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsResponseCopyWith<_NotificationSettingsResponse> get copyWith => __$NotificationSettingsResponseCopyWithImpl<_NotificationSettingsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsResponse&&(identical(other.tsunamiEnabled, tsunamiEnabled) || other.tsunamiEnabled == tsunamiEnabled)&&(identical(other.trainingEnabled, trainingEnabled) || other.trainingEnabled == trainingEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunamiEnabled,trainingEnabled);

@override
String toString() {
  return 'NotificationSettingsResponse(tsunamiEnabled: $tsunamiEnabled, trainingEnabled: $trainingEnabled)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsResponseCopyWith<$Res> implements $NotificationSettingsResponseCopyWith<$Res> {
  factory _$NotificationSettingsResponseCopyWith(_NotificationSettingsResponse value, $Res Function(_NotificationSettingsResponse) _then) = __$NotificationSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'tsunami_enabled') bool tsunamiEnabled,@JsonKey(name: 'training_enabled') bool trainingEnabled
});




}
/// @nodoc
class __$NotificationSettingsResponseCopyWithImpl<$Res>
    implements _$NotificationSettingsResponseCopyWith<$Res> {
  __$NotificationSettingsResponseCopyWithImpl(this._self, this._then);

  final _NotificationSettingsResponse _self;
  final $Res Function(_NotificationSettingsResponse) _then;

/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tsunamiEnabled = null,Object? trainingEnabled = null,}) {
  return _then(_NotificationSettingsResponse(
tsunamiEnabled: null == tsunamiEnabled ? _self.tsunamiEnabled : tsunamiEnabled // ignore: cast_nullable_to_non_nullable
as bool,trainingEnabled: null == trainingEnabled ? _self.trainingEnabled : trainingEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
