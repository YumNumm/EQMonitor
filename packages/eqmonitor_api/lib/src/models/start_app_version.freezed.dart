// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'start_app_version.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StartAppVersion {

@JsonKey(name: 'required_versions') List<RequiredVersion> get requiredVersions;@JsonKey(includeIfNull: false) LatestVersion? get latest;
/// Create a copy of StartAppVersion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartAppVersionCopyWith<StartAppVersion> get copyWith => _$StartAppVersionCopyWithImpl<StartAppVersion>(this as StartAppVersion, _$identity);

  /// Serializes this StartAppVersion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartAppVersion&&const DeepCollectionEquality().equals(other.requiredVersions, requiredVersions)&&(identical(other.latest, latest) || other.latest == latest));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(requiredVersions),latest);

@override
String toString() {
  return 'StartAppVersion(requiredVersions: $requiredVersions, latest: $latest)';
}


}

/// @nodoc
abstract mixin class $StartAppVersionCopyWith<$Res>  {
  factory $StartAppVersionCopyWith(StartAppVersion value, $Res Function(StartAppVersion) _then) = _$StartAppVersionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'required_versions') List<RequiredVersion> requiredVersions,@JsonKey(includeIfNull: false) LatestVersion? latest
});


$LatestVersionCopyWith<$Res>? get latest;

}
/// @nodoc
class _$StartAppVersionCopyWithImpl<$Res>
    implements $StartAppVersionCopyWith<$Res> {
  _$StartAppVersionCopyWithImpl(this._self, this._then);

  final StartAppVersion _self;
  final $Res Function(StartAppVersion) _then;

/// Create a copy of StartAppVersion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requiredVersions = null,Object? latest = freezed,}) {
  return _then(_self.copyWith(
requiredVersions: null == requiredVersions ? _self.requiredVersions : requiredVersions // ignore: cast_nullable_to_non_nullable
as List<RequiredVersion>,latest: freezed == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as LatestVersion?,
  ));
}
/// Create a copy of StartAppVersion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatestVersionCopyWith<$Res>? get latest {
    if (_self.latest == null) {
    return null;
  }

  return $LatestVersionCopyWith<$Res>(_self.latest!, (value) {
    return _then(_self.copyWith(latest: value));
  });
}
}


/// Adds pattern-matching-related methods to [StartAppVersion].
extension StartAppVersionPatterns on StartAppVersion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StartAppVersion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StartAppVersion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StartAppVersion value)  $default,){
final _that = this;
switch (_that) {
case _StartAppVersion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StartAppVersion value)?  $default,){
final _that = this;
switch (_that) {
case _StartAppVersion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'required_versions')  List<RequiredVersion> requiredVersions, @JsonKey(includeIfNull: false)  LatestVersion? latest)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StartAppVersion() when $default != null:
return $default(_that.requiredVersions,_that.latest);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'required_versions')  List<RequiredVersion> requiredVersions, @JsonKey(includeIfNull: false)  LatestVersion? latest)  $default,) {final _that = this;
switch (_that) {
case _StartAppVersion():
return $default(_that.requiredVersions,_that.latest);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'required_versions')  List<RequiredVersion> requiredVersions, @JsonKey(includeIfNull: false)  LatestVersion? latest)?  $default,) {final _that = this;
switch (_that) {
case _StartAppVersion() when $default != null:
return $default(_that.requiredVersions,_that.latest);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StartAppVersion implements StartAppVersion {
  const _StartAppVersion({@JsonKey(name: 'required_versions') required final  List<RequiredVersion> requiredVersions, @JsonKey(includeIfNull: false) this.latest}): _requiredVersions = requiredVersions;
  factory _StartAppVersion.fromJson(Map<String, dynamic> json) => _$StartAppVersionFromJson(json);

 final  List<RequiredVersion> _requiredVersions;
@override@JsonKey(name: 'required_versions') List<RequiredVersion> get requiredVersions {
  if (_requiredVersions is EqualUnmodifiableListView) return _requiredVersions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requiredVersions);
}

@override@JsonKey(includeIfNull: false) final  LatestVersion? latest;

/// Create a copy of StartAppVersion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartAppVersionCopyWith<_StartAppVersion> get copyWith => __$StartAppVersionCopyWithImpl<_StartAppVersion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StartAppVersionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartAppVersion&&const DeepCollectionEquality().equals(other._requiredVersions, _requiredVersions)&&(identical(other.latest, latest) || other.latest == latest));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_requiredVersions),latest);

@override
String toString() {
  return 'StartAppVersion(requiredVersions: $requiredVersions, latest: $latest)';
}


}

/// @nodoc
abstract mixin class _$StartAppVersionCopyWith<$Res> implements $StartAppVersionCopyWith<$Res> {
  factory _$StartAppVersionCopyWith(_StartAppVersion value, $Res Function(_StartAppVersion) _then) = __$StartAppVersionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'required_versions') List<RequiredVersion> requiredVersions,@JsonKey(includeIfNull: false) LatestVersion? latest
});


@override $LatestVersionCopyWith<$Res>? get latest;

}
/// @nodoc
class __$StartAppVersionCopyWithImpl<$Res>
    implements _$StartAppVersionCopyWith<$Res> {
  __$StartAppVersionCopyWithImpl(this._self, this._then);

  final _StartAppVersion _self;
  final $Res Function(_StartAppVersion) _then;

/// Create a copy of StartAppVersion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requiredVersions = null,Object? latest = freezed,}) {
  return _then(_StartAppVersion(
requiredVersions: null == requiredVersions ? _self._requiredVersions : requiredVersions // ignore: cast_nullable_to_non_nullable
as List<RequiredVersion>,latest: freezed == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as LatestVersion?,
  ));
}

/// Create a copy of StartAppVersion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatestVersionCopyWith<$Res>? get latest {
    if (_self.latest == null) {
    return null;
  }

  return $LatestVersionCopyWith<$Res>(_self.latest!, (value) {
    return _then(_self.copyWith(latest: value));
  });
}
}

// dart format on
