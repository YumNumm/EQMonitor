// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'migration_result_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MigrationResultResponse {

@JsonKey(name: 'earthquake_regions') num get earthquakeRegions;@JsonKey(name: 'eew_regions') num get eewRegions;@JsonKey(name: 'notification_settings') bool get notificationSettings;
/// Create a copy of MigrationResultResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MigrationResultResponseCopyWith<MigrationResultResponse> get copyWith => _$MigrationResultResponseCopyWithImpl<MigrationResultResponse>(this as MigrationResultResponse, _$identity);

  /// Serializes this MigrationResultResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MigrationResultResponse&&(identical(other.earthquakeRegions, earthquakeRegions) || other.earthquakeRegions == earthquakeRegions)&&(identical(other.eewRegions, eewRegions) || other.eewRegions == eewRegions)&&(identical(other.notificationSettings, notificationSettings) || other.notificationSettings == notificationSettings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,earthquakeRegions,eewRegions,notificationSettings);

@override
String toString() {
  return 'MigrationResultResponse(earthquakeRegions: $earthquakeRegions, eewRegions: $eewRegions, notificationSettings: $notificationSettings)';
}


}

/// @nodoc
abstract mixin class $MigrationResultResponseCopyWith<$Res>  {
  factory $MigrationResultResponseCopyWith(MigrationResultResponse value, $Res Function(MigrationResultResponse) _then) = _$MigrationResultResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'earthquake_regions') num earthquakeRegions,@JsonKey(name: 'eew_regions') num eewRegions,@JsonKey(name: 'notification_settings') bool notificationSettings
});




}
/// @nodoc
class _$MigrationResultResponseCopyWithImpl<$Res>
    implements $MigrationResultResponseCopyWith<$Res> {
  _$MigrationResultResponseCopyWithImpl(this._self, this._then);

  final MigrationResultResponse _self;
  final $Res Function(MigrationResultResponse) _then;

/// Create a copy of MigrationResultResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? earthquakeRegions = null,Object? eewRegions = null,Object? notificationSettings = null,}) {
  return _then(_self.copyWith(
earthquakeRegions: null == earthquakeRegions ? _self.earthquakeRegions : earthquakeRegions // ignore: cast_nullable_to_non_nullable
as num,eewRegions: null == eewRegions ? _self.eewRegions : eewRegions // ignore: cast_nullable_to_non_nullable
as num,notificationSettings: null == notificationSettings ? _self.notificationSettings : notificationSettings // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MigrationResultResponse].
extension MigrationResultResponsePatterns on MigrationResultResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MigrationResultResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MigrationResultResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MigrationResultResponse value)  $default,){
final _that = this;
switch (_that) {
case _MigrationResultResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MigrationResultResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MigrationResultResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'earthquake_regions')  num earthquakeRegions, @JsonKey(name: 'eew_regions')  num eewRegions, @JsonKey(name: 'notification_settings')  bool notificationSettings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MigrationResultResponse() when $default != null:
return $default(_that.earthquakeRegions,_that.eewRegions,_that.notificationSettings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'earthquake_regions')  num earthquakeRegions, @JsonKey(name: 'eew_regions')  num eewRegions, @JsonKey(name: 'notification_settings')  bool notificationSettings)  $default,) {final _that = this;
switch (_that) {
case _MigrationResultResponse():
return $default(_that.earthquakeRegions,_that.eewRegions,_that.notificationSettings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'earthquake_regions')  num earthquakeRegions, @JsonKey(name: 'eew_regions')  num eewRegions, @JsonKey(name: 'notification_settings')  bool notificationSettings)?  $default,) {final _that = this;
switch (_that) {
case _MigrationResultResponse() when $default != null:
return $default(_that.earthquakeRegions,_that.eewRegions,_that.notificationSettings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MigrationResultResponse implements MigrationResultResponse {
  const _MigrationResultResponse({@JsonKey(name: 'earthquake_regions') required this.earthquakeRegions, @JsonKey(name: 'eew_regions') required this.eewRegions, @JsonKey(name: 'notification_settings') required this.notificationSettings});
  factory _MigrationResultResponse.fromJson(Map<String, dynamic> json) => _$MigrationResultResponseFromJson(json);

@override@JsonKey(name: 'earthquake_regions') final  num earthquakeRegions;
@override@JsonKey(name: 'eew_regions') final  num eewRegions;
@override@JsonKey(name: 'notification_settings') final  bool notificationSettings;

/// Create a copy of MigrationResultResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MigrationResultResponseCopyWith<_MigrationResultResponse> get copyWith => __$MigrationResultResponseCopyWithImpl<_MigrationResultResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MigrationResultResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MigrationResultResponse&&(identical(other.earthquakeRegions, earthquakeRegions) || other.earthquakeRegions == earthquakeRegions)&&(identical(other.eewRegions, eewRegions) || other.eewRegions == eewRegions)&&(identical(other.notificationSettings, notificationSettings) || other.notificationSettings == notificationSettings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,earthquakeRegions,eewRegions,notificationSettings);

@override
String toString() {
  return 'MigrationResultResponse(earthquakeRegions: $earthquakeRegions, eewRegions: $eewRegions, notificationSettings: $notificationSettings)';
}


}

/// @nodoc
abstract mixin class _$MigrationResultResponseCopyWith<$Res> implements $MigrationResultResponseCopyWith<$Res> {
  factory _$MigrationResultResponseCopyWith(_MigrationResultResponse value, $Res Function(_MigrationResultResponse) _then) = __$MigrationResultResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'earthquake_regions') num earthquakeRegions,@JsonKey(name: 'eew_regions') num eewRegions,@JsonKey(name: 'notification_settings') bool notificationSettings
});




}
/// @nodoc
class __$MigrationResultResponseCopyWithImpl<$Res>
    implements _$MigrationResultResponseCopyWith<$Res> {
  __$MigrationResultResponseCopyWithImpl(this._self, this._then);

  final _MigrationResultResponse _self;
  final $Res Function(_MigrationResultResponse) _then;

/// Create a copy of MigrationResultResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? earthquakeRegions = null,Object? eewRegions = null,Object? notificationSettings = null,}) {
  return _then(_MigrationResultResponse(
earthquakeRegions: null == earthquakeRegions ? _self.earthquakeRegions : earthquakeRegions // ignore: cast_nullable_to_non_nullable
as num,eewRegions: null == eewRegions ? _self.eewRegions : eewRegions // ignore: cast_nullable_to_non_nullable
as num,notificationSettings: null == notificationSettings ? _self.notificationSettings : notificationSettings // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
