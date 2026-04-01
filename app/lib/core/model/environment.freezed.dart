// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'environment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Environment {

 String get restApiUrl; dynamic get appIdSuffix; String get appName; String get commitInformation;
/// Create a copy of Environment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnvironmentCopyWith<Environment> get copyWith => _$EnvironmentCopyWithImpl<Environment>(this as Environment, _$identity);

  /// Serializes this Environment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Environment&&(identical(other.restApiUrl, restApiUrl) || other.restApiUrl == restApiUrl)&&const DeepCollectionEquality().equals(other.appIdSuffix, appIdSuffix)&&(identical(other.appName, appName) || other.appName == appName)&&(identical(other.commitInformation, commitInformation) || other.commitInformation == commitInformation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restApiUrl,const DeepCollectionEquality().hash(appIdSuffix),appName,commitInformation);

@override
String toString() {
  return 'Environment(restApiUrl: $restApiUrl, appIdSuffix: $appIdSuffix, appName: $appName, commitInformation: $commitInformation)';
}


}

/// @nodoc
abstract mixin class $EnvironmentCopyWith<$Res>  {
  factory $EnvironmentCopyWith(Environment value, $Res Function(Environment) _then) = _$EnvironmentCopyWithImpl;
@useResult
$Res call({
 String restApiUrl, dynamic appIdSuffix, String appName, String commitInformation
});




}
/// @nodoc
class _$EnvironmentCopyWithImpl<$Res>
    implements $EnvironmentCopyWith<$Res> {
  _$EnvironmentCopyWithImpl(this._self, this._then);

  final Environment _self;
  final $Res Function(Environment) _then;

/// Create a copy of Environment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? restApiUrl = null,Object? appIdSuffix = freezed,Object? appName = null,Object? commitInformation = null,}) {
  return _then(_self.copyWith(
restApiUrl: null == restApiUrl ? _self.restApiUrl : restApiUrl // ignore: cast_nullable_to_non_nullable
as String,appIdSuffix: freezed == appIdSuffix ? _self.appIdSuffix : appIdSuffix // ignore: cast_nullable_to_non_nullable
as dynamic,appName: null == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String,commitInformation: null == commitInformation ? _self.commitInformation : commitInformation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Environment].
extension EnvironmentPatterns on Environment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Environment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Environment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Environment value)  $default,){
final _that = this;
switch (_that) {
case _Environment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Environment value)?  $default,){
final _that = this;
switch (_that) {
case _Environment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String restApiUrl,  dynamic appIdSuffix,  String appName,  String commitInformation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Environment() when $default != null:
return $default(_that.restApiUrl,_that.appIdSuffix,_that.appName,_that.commitInformation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String restApiUrl,  dynamic appIdSuffix,  String appName,  String commitInformation)  $default,) {final _that = this;
switch (_that) {
case _Environment():
return $default(_that.restApiUrl,_that.appIdSuffix,_that.appName,_that.commitInformation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String restApiUrl,  dynamic appIdSuffix,  String appName,  String commitInformation)?  $default,) {final _that = this;
switch (_that) {
case _Environment() when $default != null:
return $default(_that.restApiUrl,_that.appIdSuffix,_that.appName,_that.commitInformation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Environment extends Environment {
  const _Environment({required this.restApiUrl, required this.appIdSuffix, required this.appName, required this.commitInformation}): super._();
  factory _Environment.fromJson(Map<String, dynamic> json) => _$EnvironmentFromJson(json);

@override final  String restApiUrl;
@override final  dynamic appIdSuffix;
@override final  String appName;
@override final  String commitInformation;

/// Create a copy of Environment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnvironmentCopyWith<_Environment> get copyWith => __$EnvironmentCopyWithImpl<_Environment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EnvironmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Environment&&(identical(other.restApiUrl, restApiUrl) || other.restApiUrl == restApiUrl)&&const DeepCollectionEquality().equals(other.appIdSuffix, appIdSuffix)&&(identical(other.appName, appName) || other.appName == appName)&&(identical(other.commitInformation, commitInformation) || other.commitInformation == commitInformation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restApiUrl,const DeepCollectionEquality().hash(appIdSuffix),appName,commitInformation);

@override
String toString() {
  return 'Environment(restApiUrl: $restApiUrl, appIdSuffix: $appIdSuffix, appName: $appName, commitInformation: $commitInformation)';
}


}

/// @nodoc
abstract mixin class _$EnvironmentCopyWith<$Res> implements $EnvironmentCopyWith<$Res> {
  factory _$EnvironmentCopyWith(_Environment value, $Res Function(_Environment) _then) = __$EnvironmentCopyWithImpl;
@override @useResult
$Res call({
 String restApiUrl, dynamic appIdSuffix, String appName, String commitInformation
});




}
/// @nodoc
class __$EnvironmentCopyWithImpl<$Res>
    implements _$EnvironmentCopyWith<$Res> {
  __$EnvironmentCopyWithImpl(this._self, this._then);

  final _Environment _self;
  final $Res Function(_Environment) _then;

/// Create a copy of Environment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? restApiUrl = null,Object? appIdSuffix = freezed,Object? appName = null,Object? commitInformation = null,}) {
  return _then(_Environment(
restApiUrl: null == restApiUrl ? _self.restApiUrl : restApiUrl // ignore: cast_nullable_to_non_nullable
as String,appIdSuffix: freezed == appIdSuffix ? _self.appIdSuffix : appIdSuffix // ignore: cast_nullable_to_non_nullable
as dynamic,appName: null == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String,commitInformation: null == commitInformation ? _self.commitInformation : commitInformation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
