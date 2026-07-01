// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'latest_version.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LatestVersion {

 String get version; DateTime get date;@JsonKey(name: 'show_whats_new') bool get showWhatsNew;@JsonKey(includeIfNull: false, name: 'build_number') int? get buildNumber;@JsonKey(includeIfNull: false, name: 'whats_new') WhatsNew? get whatsNew;
/// Create a copy of LatestVersion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatestVersionCopyWith<LatestVersion> get copyWith => _$LatestVersionCopyWithImpl<LatestVersion>(this as LatestVersion, _$identity);

  /// Serializes this LatestVersion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatestVersion&&(identical(other.version, version) || other.version == version)&&(identical(other.date, date) || other.date == date)&&(identical(other.showWhatsNew, showWhatsNew) || other.showWhatsNew == showWhatsNew)&&(identical(other.buildNumber, buildNumber) || other.buildNumber == buildNumber)&&(identical(other.whatsNew, whatsNew) || other.whatsNew == whatsNew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,date,showWhatsNew,buildNumber,whatsNew);

@override
String toString() {
  return 'LatestVersion(version: $version, date: $date, showWhatsNew: $showWhatsNew, buildNumber: $buildNumber, whatsNew: $whatsNew)';
}


}

/// @nodoc
abstract mixin class $LatestVersionCopyWith<$Res>  {
  factory $LatestVersionCopyWith(LatestVersion value, $Res Function(LatestVersion) _then) = _$LatestVersionCopyWithImpl;
@useResult
$Res call({
 String version, DateTime date,@JsonKey(name: 'show_whats_new') bool showWhatsNew,@JsonKey(includeIfNull: false, name: 'build_number') int? buildNumber,@JsonKey(includeIfNull: false, name: 'whats_new') WhatsNew? whatsNew
});


$WhatsNewCopyWith<$Res>? get whatsNew;

}
/// @nodoc
class _$LatestVersionCopyWithImpl<$Res>
    implements $LatestVersionCopyWith<$Res> {
  _$LatestVersionCopyWithImpl(this._self, this._then);

  final LatestVersion _self;
  final $Res Function(LatestVersion) _then;

/// Create a copy of LatestVersion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? date = null,Object? showWhatsNew = null,Object? buildNumber = freezed,Object? whatsNew = freezed,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,showWhatsNew: null == showWhatsNew ? _self.showWhatsNew : showWhatsNew // ignore: cast_nullable_to_non_nullable
as bool,buildNumber: freezed == buildNumber ? _self.buildNumber : buildNumber // ignore: cast_nullable_to_non_nullable
as int?,whatsNew: freezed == whatsNew ? _self.whatsNew : whatsNew // ignore: cast_nullable_to_non_nullable
as WhatsNew?,
  ));
}
/// Create a copy of LatestVersion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WhatsNewCopyWith<$Res>? get whatsNew {
    if (_self.whatsNew == null) {
    return null;
  }

  return $WhatsNewCopyWith<$Res>(_self.whatsNew!, (value) {
    return _then(_self.copyWith(whatsNew: value));
  });
}
}


/// Adds pattern-matching-related methods to [LatestVersion].
extension LatestVersionPatterns on LatestVersion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatestVersion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatestVersion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatestVersion value)  $default,){
final _that = this;
switch (_that) {
case _LatestVersion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatestVersion value)?  $default,){
final _that = this;
switch (_that) {
case _LatestVersion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version,  DateTime date, @JsonKey(name: 'show_whats_new')  bool showWhatsNew, @JsonKey(includeIfNull: false, name: 'build_number')  int? buildNumber, @JsonKey(includeIfNull: false, name: 'whats_new')  WhatsNew? whatsNew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatestVersion() when $default != null:
return $default(_that.version,_that.date,_that.showWhatsNew,_that.buildNumber,_that.whatsNew);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version,  DateTime date, @JsonKey(name: 'show_whats_new')  bool showWhatsNew, @JsonKey(includeIfNull: false, name: 'build_number')  int? buildNumber, @JsonKey(includeIfNull: false, name: 'whats_new')  WhatsNew? whatsNew)  $default,) {final _that = this;
switch (_that) {
case _LatestVersion():
return $default(_that.version,_that.date,_that.showWhatsNew,_that.buildNumber,_that.whatsNew);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version,  DateTime date, @JsonKey(name: 'show_whats_new')  bool showWhatsNew, @JsonKey(includeIfNull: false, name: 'build_number')  int? buildNumber, @JsonKey(includeIfNull: false, name: 'whats_new')  WhatsNew? whatsNew)?  $default,) {final _that = this;
switch (_that) {
case _LatestVersion() when $default != null:
return $default(_that.version,_that.date,_that.showWhatsNew,_that.buildNumber,_that.whatsNew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatestVersion implements LatestVersion {
  const _LatestVersion({required this.version, required this.date, @JsonKey(name: 'show_whats_new') required this.showWhatsNew, @JsonKey(includeIfNull: false, name: 'build_number') this.buildNumber, @JsonKey(includeIfNull: false, name: 'whats_new') this.whatsNew});
  factory _LatestVersion.fromJson(Map<String, dynamic> json) => _$LatestVersionFromJson(json);

@override final  String version;
@override final  DateTime date;
@override@JsonKey(name: 'show_whats_new') final  bool showWhatsNew;
@override@JsonKey(includeIfNull: false, name: 'build_number') final  int? buildNumber;
@override@JsonKey(includeIfNull: false, name: 'whats_new') final  WhatsNew? whatsNew;

/// Create a copy of LatestVersion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatestVersionCopyWith<_LatestVersion> get copyWith => __$LatestVersionCopyWithImpl<_LatestVersion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatestVersionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatestVersion&&(identical(other.version, version) || other.version == version)&&(identical(other.date, date) || other.date == date)&&(identical(other.showWhatsNew, showWhatsNew) || other.showWhatsNew == showWhatsNew)&&(identical(other.buildNumber, buildNumber) || other.buildNumber == buildNumber)&&(identical(other.whatsNew, whatsNew) || other.whatsNew == whatsNew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,date,showWhatsNew,buildNumber,whatsNew);

@override
String toString() {
  return 'LatestVersion(version: $version, date: $date, showWhatsNew: $showWhatsNew, buildNumber: $buildNumber, whatsNew: $whatsNew)';
}


}

/// @nodoc
abstract mixin class _$LatestVersionCopyWith<$Res> implements $LatestVersionCopyWith<$Res> {
  factory _$LatestVersionCopyWith(_LatestVersion value, $Res Function(_LatestVersion) _then) = __$LatestVersionCopyWithImpl;
@override @useResult
$Res call({
 String version, DateTime date,@JsonKey(name: 'show_whats_new') bool showWhatsNew,@JsonKey(includeIfNull: false, name: 'build_number') int? buildNumber,@JsonKey(includeIfNull: false, name: 'whats_new') WhatsNew? whatsNew
});


@override $WhatsNewCopyWith<$Res>? get whatsNew;

}
/// @nodoc
class __$LatestVersionCopyWithImpl<$Res>
    implements _$LatestVersionCopyWith<$Res> {
  __$LatestVersionCopyWithImpl(this._self, this._then);

  final _LatestVersion _self;
  final $Res Function(_LatestVersion) _then;

/// Create a copy of LatestVersion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? date = null,Object? showWhatsNew = null,Object? buildNumber = freezed,Object? whatsNew = freezed,}) {
  return _then(_LatestVersion(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,showWhatsNew: null == showWhatsNew ? _self.showWhatsNew : showWhatsNew // ignore: cast_nullable_to_non_nullable
as bool,buildNumber: freezed == buildNumber ? _self.buildNumber : buildNumber // ignore: cast_nullable_to_non_nullable
as int?,whatsNew: freezed == whatsNew ? _self.whatsNew : whatsNew // ignore: cast_nullable_to_non_nullable
as WhatsNew?,
  ));
}

/// Create a copy of LatestVersion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WhatsNewCopyWith<$Res>? get whatsNew {
    if (_self.whatsNew == null) {
    return null;
  }

  return $WhatsNewCopyWith<$Res>(_self.whatsNew!, (value) {
    return _then(_self.copyWith(whatsNew: value));
  });
}
}

// dart format on
