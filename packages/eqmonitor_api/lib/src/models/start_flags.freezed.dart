// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'start_flags.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StartFlags {

@JsonKey(name: 'ads_enabled') bool get adsEnabled; MaintenanceInfo get maintenance;
/// Create a copy of StartFlags
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartFlagsCopyWith<StartFlags> get copyWith => _$StartFlagsCopyWithImpl<StartFlags>(this as StartFlags, _$identity);

  /// Serializes this StartFlags to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartFlags&&(identical(other.adsEnabled, adsEnabled) || other.adsEnabled == adsEnabled)&&(identical(other.maintenance, maintenance) || other.maintenance == maintenance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,adsEnabled,maintenance);

@override
String toString() {
  return 'StartFlags(adsEnabled: $adsEnabled, maintenance: $maintenance)';
}


}

/// @nodoc
abstract mixin class $StartFlagsCopyWith<$Res>  {
  factory $StartFlagsCopyWith(StartFlags value, $Res Function(StartFlags) _then) = _$StartFlagsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'ads_enabled') bool adsEnabled, MaintenanceInfo maintenance
});


$MaintenanceInfoCopyWith<$Res> get maintenance;

}
/// @nodoc
class _$StartFlagsCopyWithImpl<$Res>
    implements $StartFlagsCopyWith<$Res> {
  _$StartFlagsCopyWithImpl(this._self, this._then);

  final StartFlags _self;
  final $Res Function(StartFlags) _then;

/// Create a copy of StartFlags
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? adsEnabled = null,Object? maintenance = null,}) {
  return _then(StartFlags(
adsEnabled: null == adsEnabled ? _self.adsEnabled : adsEnabled // ignore: cast_nullable_to_non_nullable
as bool,maintenance: null == maintenance ? _self.maintenance : maintenance // ignore: cast_nullable_to_non_nullable
as MaintenanceInfo,
  ));
}
/// Create a copy of StartFlags
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MaintenanceInfoCopyWith<$Res> get maintenance {
  
  return $MaintenanceInfoCopyWith<$Res>(_self.maintenance, (value) {
    return _then(_self.copyWith(maintenance: value));
  });
}
}


/// Adds pattern-matching-related methods to [StartFlags].
extension StartFlagsPatterns on StartFlags {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StartFlags value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StartFlags() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StartFlags value)  $default,){
final _that = this;
switch (_that) {
case _StartFlags():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StartFlags value)?  $default,){
final _that = this;
switch (_that) {
case _StartFlags() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'ads_enabled')  bool adsEnabled,  MaintenanceInfo maintenance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StartFlags() when $default != null:
return $default(_that.adsEnabled,_that.maintenance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'ads_enabled')  bool adsEnabled,  MaintenanceInfo maintenance)  $default,) {final _that = this;
switch (_that) {
case _StartFlags():
return $default(_that.adsEnabled,_that.maintenance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'ads_enabled')  bool adsEnabled,  MaintenanceInfo maintenance)?  $default,) {final _that = this;
switch (_that) {
case _StartFlags() when $default != null:
return $default(_that.adsEnabled,_that.maintenance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StartFlags implements StartFlags {
  const _StartFlags({@JsonKey(name: 'ads_enabled') required this.adsEnabled, required this.maintenance});
  factory _StartFlags.fromJson(Map<String, dynamic> json) => _$StartFlagsFromJson(json);

@override@JsonKey(name: 'ads_enabled') final  bool adsEnabled;
@override final  MaintenanceInfo maintenance;

/// Create a copy of StartFlags
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartFlagsCopyWith<_StartFlags> get copyWith => __$StartFlagsCopyWithImpl<_StartFlags>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StartFlagsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartFlags&&(identical(other.adsEnabled, adsEnabled) || other.adsEnabled == adsEnabled)&&(identical(other.maintenance, maintenance) || other.maintenance == maintenance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,adsEnabled,maintenance);

@override
String toString() {
  return 'StartFlags(adsEnabled: $adsEnabled, maintenance: $maintenance)';
}


}

/// @nodoc
abstract mixin class _$StartFlagsCopyWith<$Res> implements $StartFlagsCopyWith<$Res> {
  factory _$StartFlagsCopyWith(_StartFlags value, $Res Function(_StartFlags) _then) = __$StartFlagsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'ads_enabled') bool adsEnabled, MaintenanceInfo maintenance
});


@override $MaintenanceInfoCopyWith<$Res> get maintenance;

}
/// @nodoc
class __$StartFlagsCopyWithImpl<$Res>
    implements _$StartFlagsCopyWith<$Res> {
  __$StartFlagsCopyWithImpl(this._self, this._then);

  final _StartFlags _self;
  final $Res Function(_StartFlags) _then;

/// Create a copy of StartFlags
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? adsEnabled = null,Object? maintenance = null,}) {
  return _then(_StartFlags(
adsEnabled: null == adsEnabled ? _self.adsEnabled : adsEnabled // ignore: cast_nullable_to_non_nullable
as bool,maintenance: null == maintenance ? _self.maintenance : maintenance // ignore: cast_nullable_to_non_nullable
as MaintenanceInfo,
  ));
}

/// Create a copy of StartFlags
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MaintenanceInfoCopyWith<$Res> get maintenance {
  
  return $MaintenanceInfoCopyWith<$Res>(_self.maintenance, (value) {
    return _then(_self.copyWith(maintenance: value));
  });
}
}

// dart format on
