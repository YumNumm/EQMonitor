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

 PlatformAppInformation get ios; PlatformAppInformation get android;
/// Create a copy of AppInformation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppInformationCopyWith<AppInformation> get copyWith => _$AppInformationCopyWithImpl<AppInformation>(this as AppInformation, _$identity);

  /// Serializes this AppInformation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppInformation&&(identical(other.ios, ios) || other.ios == ios)&&(identical(other.android, android) || other.android == android));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ios,android);

@override
String toString() {
  return 'AppInformation(ios: $ios, android: $android)';
}


}

/// @nodoc
abstract mixin class $AppInformationCopyWith<$Res>  {
  factory $AppInformationCopyWith(AppInformation value, $Res Function(AppInformation) _then) = _$AppInformationCopyWithImpl;
@useResult
$Res call({
 PlatformAppInformation ios, PlatformAppInformation android
});


$PlatformAppInformationCopyWith<$Res> get ios;$PlatformAppInformationCopyWith<$Res> get android;

}
/// @nodoc
class _$AppInformationCopyWithImpl<$Res>
    implements $AppInformationCopyWith<$Res> {
  _$AppInformationCopyWithImpl(this._self, this._then);

  final AppInformation _self;
  final $Res Function(AppInformation) _then;

/// Create a copy of AppInformation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ios = null,Object? android = null,}) {
  return _then(_self.copyWith(
ios: null == ios ? _self.ios : ios // ignore: cast_nullable_to_non_nullable
as PlatformAppInformation,android: null == android ? _self.android : android // ignore: cast_nullable_to_non_nullable
as PlatformAppInformation,
  ));
}
/// Create a copy of AppInformation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlatformAppInformationCopyWith<$Res> get ios {
  
  return $PlatformAppInformationCopyWith<$Res>(_self.ios, (value) {
    return _then(_self.copyWith(ios: value));
  });
}/// Create a copy of AppInformation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlatformAppInformationCopyWith<$Res> get android {
  
  return $PlatformAppInformationCopyWith<$Res>(_self.android, (value) {
    return _then(_self.copyWith(android: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlatformAppInformation ios,  PlatformAppInformation android)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppInformation() when $default != null:
return $default(_that.ios,_that.android);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlatformAppInformation ios,  PlatformAppInformation android)  $default,) {final _that = this;
switch (_that) {
case _AppInformation():
return $default(_that.ios,_that.android);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlatformAppInformation ios,  PlatformAppInformation android)?  $default,) {final _that = this;
switch (_that) {
case _AppInformation() when $default != null:
return $default(_that.ios,_that.android);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppInformation implements AppInformation {
  const _AppInformation({required this.ios, required this.android});
  factory _AppInformation.fromJson(Map<String, dynamic> json) => _$AppInformationFromJson(json);

@override final  PlatformAppInformation ios;
@override final  PlatformAppInformation android;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppInformation&&(identical(other.ios, ios) || other.ios == ios)&&(identical(other.android, android) || other.android == android));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ios,android);

@override
String toString() {
  return 'AppInformation(ios: $ios, android: $android)';
}


}

/// @nodoc
abstract mixin class _$AppInformationCopyWith<$Res> implements $AppInformationCopyWith<$Res> {
  factory _$AppInformationCopyWith(_AppInformation value, $Res Function(_AppInformation) _then) = __$AppInformationCopyWithImpl;
@override @useResult
$Res call({
 PlatformAppInformation ios, PlatformAppInformation android
});


@override $PlatformAppInformationCopyWith<$Res> get ios;@override $PlatformAppInformationCopyWith<$Res> get android;

}
/// @nodoc
class __$AppInformationCopyWithImpl<$Res>
    implements _$AppInformationCopyWith<$Res> {
  __$AppInformationCopyWithImpl(this._self, this._then);

  final _AppInformation _self;
  final $Res Function(_AppInformation) _then;

/// Create a copy of AppInformation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ios = null,Object? android = null,}) {
  return _then(_AppInformation(
ios: null == ios ? _self.ios : ios // ignore: cast_nullable_to_non_nullable
as PlatformAppInformation,android: null == android ? _self.android : android // ignore: cast_nullable_to_non_nullable
as PlatformAppInformation,
  ));
}

/// Create a copy of AppInformation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlatformAppInformationCopyWith<$Res> get ios {
  
  return $PlatformAppInformationCopyWith<$Res>(_self.ios, (value) {
    return _then(_self.copyWith(ios: value));
  });
}/// Create a copy of AppInformation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlatformAppInformationCopyWith<$Res> get android {
  
  return $PlatformAppInformationCopyWith<$Res>(_self.android, (value) {
    return _then(_self.copyWith(android: value));
  });
}
}


/// @nodoc
mixin _$PlatformAppInformation {

 AppVersion? get latest; AppVersion? get minimum; String? get downloadUrl;
/// Create a copy of PlatformAppInformation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformAppInformationCopyWith<PlatformAppInformation> get copyWith => _$PlatformAppInformationCopyWithImpl<PlatformAppInformation>(this as PlatformAppInformation, _$identity);

  /// Serializes this PlatformAppInformation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformAppInformation&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.minimum, minimum) || other.minimum == minimum)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latest,minimum,downloadUrl);

@override
String toString() {
  return 'PlatformAppInformation(latest: $latest, minimum: $minimum, downloadUrl: $downloadUrl)';
}


}

/// @nodoc
abstract mixin class $PlatformAppInformationCopyWith<$Res>  {
  factory $PlatformAppInformationCopyWith(PlatformAppInformation value, $Res Function(PlatformAppInformation) _then) = _$PlatformAppInformationCopyWithImpl;
@useResult
$Res call({
 AppVersion? latest, AppVersion? minimum, String? downloadUrl
});


$AppVersionCopyWith<$Res>? get latest;$AppVersionCopyWith<$Res>? get minimum;

}
/// @nodoc
class _$PlatformAppInformationCopyWithImpl<$Res>
    implements $PlatformAppInformationCopyWith<$Res> {
  _$PlatformAppInformationCopyWithImpl(this._self, this._then);

  final PlatformAppInformation _self;
  final $Res Function(PlatformAppInformation) _then;

/// Create a copy of PlatformAppInformation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latest = freezed,Object? minimum = freezed,Object? downloadUrl = freezed,}) {
  return _then(_self.copyWith(
latest: freezed == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as AppVersion?,minimum: freezed == minimum ? _self.minimum : minimum // ignore: cast_nullable_to_non_nullable
as AppVersion?,downloadUrl: freezed == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PlatformAppInformation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppVersionCopyWith<$Res>? get latest {
    if (_self.latest == null) {
    return null;
  }

  return $AppVersionCopyWith<$Res>(_self.latest!, (value) {
    return _then(_self.copyWith(latest: value));
  });
}/// Create a copy of PlatformAppInformation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppVersionCopyWith<$Res>? get minimum {
    if (_self.minimum == null) {
    return null;
  }

  return $AppVersionCopyWith<$Res>(_self.minimum!, (value) {
    return _then(_self.copyWith(minimum: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlatformAppInformation].
extension PlatformAppInformationPatterns on PlatformAppInformation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformAppInformation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformAppInformation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformAppInformation value)  $default,){
final _that = this;
switch (_that) {
case _PlatformAppInformation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformAppInformation value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformAppInformation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppVersion? latest,  AppVersion? minimum,  String? downloadUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformAppInformation() when $default != null:
return $default(_that.latest,_that.minimum,_that.downloadUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppVersion? latest,  AppVersion? minimum,  String? downloadUrl)  $default,) {final _that = this;
switch (_that) {
case _PlatformAppInformation():
return $default(_that.latest,_that.minimum,_that.downloadUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppVersion? latest,  AppVersion? minimum,  String? downloadUrl)?  $default,) {final _that = this;
switch (_that) {
case _PlatformAppInformation() when $default != null:
return $default(_that.latest,_that.minimum,_that.downloadUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformAppInformation implements PlatformAppInformation {
  const _PlatformAppInformation({required this.latest, required this.minimum, required this.downloadUrl});
  factory _PlatformAppInformation.fromJson(Map<String, dynamic> json) => _$PlatformAppInformationFromJson(json);

@override final  AppVersion? latest;
@override final  AppVersion? minimum;
@override final  String? downloadUrl;

/// Create a copy of PlatformAppInformation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformAppInformationCopyWith<_PlatformAppInformation> get copyWith => __$PlatformAppInformationCopyWithImpl<_PlatformAppInformation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformAppInformationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformAppInformation&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.minimum, minimum) || other.minimum == minimum)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latest,minimum,downloadUrl);

@override
String toString() {
  return 'PlatformAppInformation(latest: $latest, minimum: $minimum, downloadUrl: $downloadUrl)';
}


}

/// @nodoc
abstract mixin class _$PlatformAppInformationCopyWith<$Res> implements $PlatformAppInformationCopyWith<$Res> {
  factory _$PlatformAppInformationCopyWith(_PlatformAppInformation value, $Res Function(_PlatformAppInformation) _then) = __$PlatformAppInformationCopyWithImpl;
@override @useResult
$Res call({
 AppVersion? latest, AppVersion? minimum, String? downloadUrl
});


@override $AppVersionCopyWith<$Res>? get latest;@override $AppVersionCopyWith<$Res>? get minimum;

}
/// @nodoc
class __$PlatformAppInformationCopyWithImpl<$Res>
    implements _$PlatformAppInformationCopyWith<$Res> {
  __$PlatformAppInformationCopyWithImpl(this._self, this._then);

  final _PlatformAppInformation _self;
  final $Res Function(_PlatformAppInformation) _then;

/// Create a copy of PlatformAppInformation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latest = freezed,Object? minimum = freezed,Object? downloadUrl = freezed,}) {
  return _then(_PlatformAppInformation(
latest: freezed == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as AppVersion?,minimum: freezed == minimum ? _self.minimum : minimum // ignore: cast_nullable_to_non_nullable
as AppVersion?,downloadUrl: freezed == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PlatformAppInformation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppVersionCopyWith<$Res>? get latest {
    if (_self.latest == null) {
    return null;
  }

  return $AppVersionCopyWith<$Res>(_self.latest!, (value) {
    return _then(_self.copyWith(latest: value));
  });
}/// Create a copy of PlatformAppInformation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppVersionCopyWith<$Res>? get minimum {
    if (_self.minimum == null) {
    return null;
  }

  return $AppVersionCopyWith<$Res>(_self.minimum!, (value) {
    return _then(_self.copyWith(minimum: value));
  });
}
}


/// @nodoc
mixin _$AppVersion {

 String get version; String? get message;
/// Create a copy of AppVersion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppVersionCopyWith<AppVersion> get copyWith => _$AppVersionCopyWithImpl<AppVersion>(this as AppVersion, _$identity);

  /// Serializes this AppVersion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppVersion&&(identical(other.version, version) || other.version == version)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,message);

@override
String toString() {
  return 'AppVersion(version: $version, message: $message)';
}


}

/// @nodoc
abstract mixin class $AppVersionCopyWith<$Res>  {
  factory $AppVersionCopyWith(AppVersion value, $Res Function(AppVersion) _then) = _$AppVersionCopyWithImpl;
@useResult
$Res call({
 String version, String? message
});




}
/// @nodoc
class _$AppVersionCopyWithImpl<$Res>
    implements $AppVersionCopyWith<$Res> {
  _$AppVersionCopyWithImpl(this._self, this._then);

  final AppVersion _self;
  final $Res Function(AppVersion) _then;

/// Create a copy of AppVersion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppVersion].
extension AppVersionPatterns on AppVersion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppVersion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppVersion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppVersion value)  $default,){
final _that = this;
switch (_that) {
case _AppVersion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppVersion value)?  $default,){
final _that = this;
switch (_that) {
case _AppVersion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppVersion() when $default != null:
return $default(_that.version,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version,  String? message)  $default,) {final _that = this;
switch (_that) {
case _AppVersion():
return $default(_that.version,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AppVersion() when $default != null:
return $default(_that.version,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppVersion implements AppVersion {
  const _AppVersion({required this.version, required this.message});
  factory _AppVersion.fromJson(Map<String, dynamic> json) => _$AppVersionFromJson(json);

@override final  String version;
@override final  String? message;

/// Create a copy of AppVersion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppVersionCopyWith<_AppVersion> get copyWith => __$AppVersionCopyWithImpl<_AppVersion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppVersionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppVersion&&(identical(other.version, version) || other.version == version)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,message);

@override
String toString() {
  return 'AppVersion(version: $version, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AppVersionCopyWith<$Res> implements $AppVersionCopyWith<$Res> {
  factory _$AppVersionCopyWith(_AppVersion value, $Res Function(_AppVersion) _then) = __$AppVersionCopyWithImpl;
@override @useResult
$Res call({
 String version, String? message
});




}
/// @nodoc
class __$AppVersionCopyWithImpl<$Res>
    implements _$AppVersionCopyWith<$Res> {
  __$AppVersionCopyWithImpl(this._self, this._then);

  final _AppVersion _self;
  final $Res Function(_AppVersion) _then;

/// Create a copy of AppVersion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? message = freezed,}) {
  return _then(_AppVersion(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
