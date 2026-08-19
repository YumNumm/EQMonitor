// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'required_version.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequiredVersion {

@JsonKey(includeIfNull: false) String? get version;@JsonKey(includeIfNull: false, name: 'build_number') int? get buildNumber;@JsonKey(includeIfNull: false) String? get message;
/// Create a copy of RequiredVersion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequiredVersionCopyWith<RequiredVersion> get copyWith => _$RequiredVersionCopyWithImpl<RequiredVersion>(this as RequiredVersion, _$identity);

  /// Serializes this RequiredVersion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequiredVersion&&(identical(other.version, version) || other.version == version)&&(identical(other.buildNumber, buildNumber) || other.buildNumber == buildNumber)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,buildNumber,message);

@override
String toString() {
  return 'RequiredVersion(version: $version, buildNumber: $buildNumber, message: $message)';
}


}

/// @nodoc
abstract mixin class $RequiredVersionCopyWith<$Res>  {
  factory $RequiredVersionCopyWith(RequiredVersion value, $Res Function(RequiredVersion) _then) = _$RequiredVersionCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) String? version,@JsonKey(includeIfNull: false, name: 'build_number') int? buildNumber,@JsonKey(includeIfNull: false) String? message
});




}
/// @nodoc
class _$RequiredVersionCopyWithImpl<$Res>
    implements $RequiredVersionCopyWith<$Res> {
  _$RequiredVersionCopyWithImpl(this._self, this._then);

  final RequiredVersion _self;
  final $Res Function(RequiredVersion) _then;

/// Create a copy of RequiredVersion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = freezed,Object? buildNumber = freezed,Object? message = freezed,}) {
  return _then(RequiredVersion(
version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,buildNumber: freezed == buildNumber ? _self.buildNumber : buildNumber // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RequiredVersion].
extension RequiredVersionPatterns on RequiredVersion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequiredVersion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequiredVersion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequiredVersion value)  $default,){
final _that = this;
switch (_that) {
case _RequiredVersion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequiredVersion value)?  $default,){
final _that = this;
switch (_that) {
case _RequiredVersion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? version, @JsonKey(includeIfNull: false, name: 'build_number')  int? buildNumber, @JsonKey(includeIfNull: false)  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequiredVersion() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? version, @JsonKey(includeIfNull: false, name: 'build_number')  int? buildNumber, @JsonKey(includeIfNull: false)  String? message)  $default,) {final _that = this;
switch (_that) {
case _RequiredVersion():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  String? version, @JsonKey(includeIfNull: false, name: 'build_number')  int? buildNumber, @JsonKey(includeIfNull: false)  String? message)?  $default,) {final _that = this;
switch (_that) {
case _RequiredVersion() when $default != null:
return $default(_that.version,_that.buildNumber,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequiredVersion implements RequiredVersion {
  const _RequiredVersion({@JsonKey(includeIfNull: false) this.version, @JsonKey(includeIfNull: false, name: 'build_number') this.buildNumber, @JsonKey(includeIfNull: false) this.message});
  factory _RequiredVersion.fromJson(Map<String, dynamic> json) => _$RequiredVersionFromJson(json);

@override@JsonKey(includeIfNull: false) final  String? version;
@override@JsonKey(includeIfNull: false, name: 'build_number') final  int? buildNumber;
@override@JsonKey(includeIfNull: false) final  String? message;

/// Create a copy of RequiredVersion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequiredVersionCopyWith<_RequiredVersion> get copyWith => __$RequiredVersionCopyWithImpl<_RequiredVersion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequiredVersionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequiredVersion&&(identical(other.version, version) || other.version == version)&&(identical(other.buildNumber, buildNumber) || other.buildNumber == buildNumber)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,buildNumber,message);

@override
String toString() {
  return 'RequiredVersion(version: $version, buildNumber: $buildNumber, message: $message)';
}


}

/// @nodoc
abstract mixin class _$RequiredVersionCopyWith<$Res> implements $RequiredVersionCopyWith<$Res> {
  factory _$RequiredVersionCopyWith(_RequiredVersion value, $Res Function(_RequiredVersion) _then) = __$RequiredVersionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) String? version,@JsonKey(includeIfNull: false, name: 'build_number') int? buildNumber,@JsonKey(includeIfNull: false) String? message
});




}
/// @nodoc
class __$RequiredVersionCopyWithImpl<$Res>
    implements _$RequiredVersionCopyWith<$Res> {
  __$RequiredVersionCopyWithImpl(this._self, this._then);

  final _RequiredVersion _self;
  final $Res Function(_RequiredVersion) _then;

/// Create a copy of RequiredVersion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = freezed,Object? buildNumber = freezed,Object? message = freezed,}) {
  return _then(_RequiredVersion(
version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,buildNumber: freezed == buildNumber ? _self.buildNumber : buildNumber // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
