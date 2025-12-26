// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppInformation {

 String get version; String get buildNumber; String? get message;
/// Create a copy of AppInformation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppInformationCopyWith<AppInformation> get copyWith => _$AppInformationCopyWithImpl<AppInformation>(this as AppInformation, _$identity);

  /// Serializes this AppInformation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppInformation&&(identical(other.version, version) || other.version == version)&&(identical(other.buildNumber, buildNumber) || other.buildNumber == buildNumber)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,buildNumber,message);

@override
String toString() {
  return 'AppInformation(version: $version, buildNumber: $buildNumber, message: $message)';
}


}

/// @nodoc
abstract mixin class $AppInformationCopyWith<$Res>  {
  factory $AppInformationCopyWith(AppInformation value, $Res Function(AppInformation) _then) = _$AppInformationCopyWithImpl;
@useResult
$Res call({
 String version, String buildNumber, String? message
});




}
/// @nodoc
class _$AppInformationCopyWithImpl<$Res>
    implements $AppInformationCopyWith<$Res> {
  _$AppInformationCopyWithImpl(this._self, this._then);

  final AppInformation _self;
  final $Res Function(AppInformation) _then;

/// Create a copy of AppInformation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? buildNumber = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,buildNumber: null == buildNumber ? _self.buildNumber : buildNumber // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppInformation].
extension AppInformationPatterns on AppInformation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppInformation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppInformation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppInformation value)  $default,){
final _that = this;
switch (_that) {
case _AppInformation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppInformation value)?  $default,){
final _that = this;
switch (_that) {
case _AppInformation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version,  String buildNumber,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppInformation() when $default != null:
return $default(_that.version,_that.buildNumber,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version,  String buildNumber,  String? message)  $default,) {final _that = this;
switch (_that) {
case _AppInformation():
return $default(_that.version,_that.buildNumber,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version,  String buildNumber,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AppInformation() when $default != null:
return $default(_that.version,_that.buildNumber,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppInformation implements AppInformation {
  const _AppInformation({required this.version, required this.buildNumber, this.message});
  factory _AppInformation.fromJson(Map<String, dynamic> json) => _$AppInformationFromJson(json);

@override final  String version;
@override final  String buildNumber;
@override final  String? message;

/// Create a copy of AppInformation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppInformationCopyWith<_AppInformation> get copyWith => __$AppInformationCopyWithImpl<_AppInformation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppInformationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppInformation&&(identical(other.version, version) || other.version == version)&&(identical(other.buildNumber, buildNumber) || other.buildNumber == buildNumber)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,buildNumber,message);

@override
String toString() {
  return 'AppInformation(version: $version, buildNumber: $buildNumber, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AppInformationCopyWith<$Res> implements $AppInformationCopyWith<$Res> {
  factory _$AppInformationCopyWith(_AppInformation value, $Res Function(_AppInformation) _then) = __$AppInformationCopyWithImpl;
@override @useResult
$Res call({
 String version, String buildNumber, String? message
});




}
/// @nodoc
class __$AppInformationCopyWithImpl<$Res>
    implements _$AppInformationCopyWith<$Res> {
  __$AppInformationCopyWithImpl(this._self, this._then);

  final _AppInformation _self;
  final $Res Function(_AppInformation) _then;

/// Create a copy of AppInformation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? buildNumber = null,Object? message = freezed,}) {
  return _then(_AppInformation(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,buildNumber: null == buildNumber ? _self.buildNumber : buildNumber // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
