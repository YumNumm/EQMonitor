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
mixin _$BuildConfig implements DiagnosticableTreeMixin {

 String get restApiUrl; String get appIdSuffix; String get appName; String get commitInformation; Flavor get flavor; String get wsApiUrl; String get googleIosClientId; String get googleAndroidClientId; String get buildTimestamp; String get buildCommitMessage; String get revenueCatApiKeyIos; String get revenueCatApiKeyAndroid; bool get isBetaTesting; bool get isProFeaturesEnabled;
/// Create a copy of BuildConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuildConfigCopyWith<BuildConfig> get copyWith => _$BuildConfigCopyWithImpl<BuildConfig>(this as BuildConfig, _$identity);

  /// Serializes this BuildConfig to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BuildConfig'))
    ..add(DiagnosticsProperty('restApiUrl', restApiUrl))..add(DiagnosticsProperty('appIdSuffix', appIdSuffix))..add(DiagnosticsProperty('appName', appName))..add(DiagnosticsProperty('commitInformation', commitInformation))..add(DiagnosticsProperty('flavor', flavor))..add(DiagnosticsProperty('wsApiUrl', wsApiUrl))..add(DiagnosticsProperty('googleIosClientId', googleIosClientId))..add(DiagnosticsProperty('googleAndroidClientId', googleAndroidClientId))..add(DiagnosticsProperty('buildTimestamp', buildTimestamp))..add(DiagnosticsProperty('buildCommitMessage', buildCommitMessage))..add(DiagnosticsProperty('revenueCatApiKeyIos', revenueCatApiKeyIos))..add(DiagnosticsProperty('revenueCatApiKeyAndroid', revenueCatApiKeyAndroid))..add(DiagnosticsProperty('isBetaTesting', isBetaTesting))..add(DiagnosticsProperty('isProFeaturesEnabled', isProFeaturesEnabled));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuildConfig&&(identical(other.restApiUrl, restApiUrl) || other.restApiUrl == restApiUrl)&&(identical(other.appIdSuffix, appIdSuffix) || other.appIdSuffix == appIdSuffix)&&(identical(other.appName, appName) || other.appName == appName)&&(identical(other.commitInformation, commitInformation) || other.commitInformation == commitInformation)&&(identical(other.flavor, flavor) || other.flavor == flavor)&&(identical(other.wsApiUrl, wsApiUrl) || other.wsApiUrl == wsApiUrl)&&(identical(other.googleIosClientId, googleIosClientId) || other.googleIosClientId == googleIosClientId)&&(identical(other.googleAndroidClientId, googleAndroidClientId) || other.googleAndroidClientId == googleAndroidClientId)&&(identical(other.buildTimestamp, buildTimestamp) || other.buildTimestamp == buildTimestamp)&&(identical(other.buildCommitMessage, buildCommitMessage) || other.buildCommitMessage == buildCommitMessage)&&(identical(other.revenueCatApiKeyIos, revenueCatApiKeyIos) || other.revenueCatApiKeyIos == revenueCatApiKeyIos)&&(identical(other.revenueCatApiKeyAndroid, revenueCatApiKeyAndroid) || other.revenueCatApiKeyAndroid == revenueCatApiKeyAndroid)&&(identical(other.isBetaTesting, isBetaTesting) || other.isBetaTesting == isBetaTesting)&&(identical(other.isProFeaturesEnabled, isProFeaturesEnabled) || other.isProFeaturesEnabled == isProFeaturesEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restApiUrl,appIdSuffix,appName,commitInformation,flavor,wsApiUrl,googleIosClientId,googleAndroidClientId,buildTimestamp,buildCommitMessage,revenueCatApiKeyIos,revenueCatApiKeyAndroid,isBetaTesting,isProFeaturesEnabled);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BuildConfig(restApiUrl: $restApiUrl, appIdSuffix: $appIdSuffix, appName: $appName, commitInformation: $commitInformation, flavor: $flavor, wsApiUrl: $wsApiUrl, googleIosClientId: $googleIosClientId, googleAndroidClientId: $googleAndroidClientId, buildTimestamp: $buildTimestamp, buildCommitMessage: $buildCommitMessage, revenueCatApiKeyIos: $revenueCatApiKeyIos, revenueCatApiKeyAndroid: $revenueCatApiKeyAndroid, isBetaTesting: $isBetaTesting, isProFeaturesEnabled: $isProFeaturesEnabled)';
}


}

/// @nodoc
abstract mixin class $BuildConfigCopyWith<$Res>  {
  factory $BuildConfigCopyWith(BuildConfig value, $Res Function(BuildConfig) _then) = _$BuildConfigCopyWithImpl;
@useResult
$Res call({
 String restApiUrl, String appIdSuffix, String appName, String commitInformation, Flavor flavor, String wsApiUrl, String googleIosClientId, String googleAndroidClientId, String buildTimestamp, String buildCommitMessage, String revenueCatApiKeyIos, String revenueCatApiKeyAndroid, bool isBetaTesting, bool isProFeaturesEnabled
});




}
/// @nodoc
class _$BuildConfigCopyWithImpl<$Res>
    implements $BuildConfigCopyWith<$Res> {
  _$BuildConfigCopyWithImpl(this._self, this._then);

  final BuildConfig _self;
  final $Res Function(BuildConfig) _then;

/// Create a copy of BuildConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? restApiUrl = null,Object? appIdSuffix = null,Object? appName = null,Object? commitInformation = null,Object? flavor = null,Object? wsApiUrl = null,Object? googleIosClientId = null,Object? googleAndroidClientId = null,Object? buildTimestamp = null,Object? buildCommitMessage = null,Object? revenueCatApiKeyIos = null,Object? revenueCatApiKeyAndroid = null,Object? isBetaTesting = null,Object? isProFeaturesEnabled = null,}) {
  return _then(_self.copyWith(
restApiUrl: null == restApiUrl ? _self.restApiUrl : restApiUrl // ignore: cast_nullable_to_non_nullable
as String,appIdSuffix: null == appIdSuffix ? _self.appIdSuffix : appIdSuffix // ignore: cast_nullable_to_non_nullable
as String,appName: null == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String,commitInformation: null == commitInformation ? _self.commitInformation : commitInformation // ignore: cast_nullable_to_non_nullable
as String,flavor: null == flavor ? _self.flavor : flavor // ignore: cast_nullable_to_non_nullable
as Flavor,wsApiUrl: null == wsApiUrl ? _self.wsApiUrl : wsApiUrl // ignore: cast_nullable_to_non_nullable
as String,googleIosClientId: null == googleIosClientId ? _self.googleIosClientId : googleIosClientId // ignore: cast_nullable_to_non_nullable
as String,googleAndroidClientId: null == googleAndroidClientId ? _self.googleAndroidClientId : googleAndroidClientId // ignore: cast_nullable_to_non_nullable
as String,buildTimestamp: null == buildTimestamp ? _self.buildTimestamp : buildTimestamp // ignore: cast_nullable_to_non_nullable
as String,buildCommitMessage: null == buildCommitMessage ? _self.buildCommitMessage : buildCommitMessage // ignore: cast_nullable_to_non_nullable
as String,revenueCatApiKeyIos: null == revenueCatApiKeyIos ? _self.revenueCatApiKeyIos : revenueCatApiKeyIos // ignore: cast_nullable_to_non_nullable
as String,revenueCatApiKeyAndroid: null == revenueCatApiKeyAndroid ? _self.revenueCatApiKeyAndroid : revenueCatApiKeyAndroid // ignore: cast_nullable_to_non_nullable
as String,isBetaTesting: null == isBetaTesting ? _self.isBetaTesting : isBetaTesting // ignore: cast_nullable_to_non_nullable
as bool,isProFeaturesEnabled: null == isProFeaturesEnabled ? _self.isProFeaturesEnabled : isProFeaturesEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BuildConfig].
extension BuildConfigPatterns on BuildConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BuildConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BuildConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BuildConfig value)  $default,){
final _that = this;
switch (_that) {
case _BuildConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BuildConfig value)?  $default,){
final _that = this;
switch (_that) {
case _BuildConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String restApiUrl,  String appIdSuffix,  String appName,  String commitInformation,  Flavor flavor,  String wsApiUrl,  String googleIosClientId,  String googleAndroidClientId,  String buildTimestamp,  String buildCommitMessage,  String revenueCatApiKeyIos,  String revenueCatApiKeyAndroid,  bool isBetaTesting,  bool isProFeaturesEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BuildConfig() when $default != null:
return $default(_that.restApiUrl,_that.appIdSuffix,_that.appName,_that.commitInformation,_that.flavor,_that.wsApiUrl,_that.googleIosClientId,_that.googleAndroidClientId,_that.buildTimestamp,_that.buildCommitMessage,_that.revenueCatApiKeyIos,_that.revenueCatApiKeyAndroid,_that.isBetaTesting,_that.isProFeaturesEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String restApiUrl,  String appIdSuffix,  String appName,  String commitInformation,  Flavor flavor,  String wsApiUrl,  String googleIosClientId,  String googleAndroidClientId,  String buildTimestamp,  String buildCommitMessage,  String revenueCatApiKeyIos,  String revenueCatApiKeyAndroid,  bool isBetaTesting,  bool isProFeaturesEnabled)  $default,) {final _that = this;
switch (_that) {
case _BuildConfig():
return $default(_that.restApiUrl,_that.appIdSuffix,_that.appName,_that.commitInformation,_that.flavor,_that.wsApiUrl,_that.googleIosClientId,_that.googleAndroidClientId,_that.buildTimestamp,_that.buildCommitMessage,_that.revenueCatApiKeyIos,_that.revenueCatApiKeyAndroid,_that.isBetaTesting,_that.isProFeaturesEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String restApiUrl,  String appIdSuffix,  String appName,  String commitInformation,  Flavor flavor,  String wsApiUrl,  String googleIosClientId,  String googleAndroidClientId,  String buildTimestamp,  String buildCommitMessage,  String revenueCatApiKeyIos,  String revenueCatApiKeyAndroid,  bool isBetaTesting,  bool isProFeaturesEnabled)?  $default,) {final _that = this;
switch (_that) {
case _BuildConfig() when $default != null:
return $default(_that.restApiUrl,_that.appIdSuffix,_that.appName,_that.commitInformation,_that.flavor,_that.wsApiUrl,_that.googleIosClientId,_that.googleAndroidClientId,_that.buildTimestamp,_that.buildCommitMessage,_that.revenueCatApiKeyIos,_that.revenueCatApiKeyAndroid,_that.isBetaTesting,_that.isProFeaturesEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BuildConfig extends BuildConfig with DiagnosticableTreeMixin {
  const _BuildConfig({required this.restApiUrl, required this.appIdSuffix, required this.appName, required this.commitInformation, required this.flavor, required this.wsApiUrl, required this.googleIosClientId, required this.googleAndroidClientId, required this.buildTimestamp, required this.buildCommitMessage, required this.revenueCatApiKeyIos, required this.revenueCatApiKeyAndroid, this.isBetaTesting = false, this.isProFeaturesEnabled = false}): super._();
  factory _BuildConfig.fromJson(Map<String, dynamic> json) => _$BuildConfigFromJson(json);

@override final  String restApiUrl;
@override final  String appIdSuffix;
@override final  String appName;
@override final  String commitInformation;
@override final  Flavor flavor;
@override final  String wsApiUrl;
@override final  String googleIosClientId;
@override final  String googleAndroidClientId;
@override final  String buildTimestamp;
@override final  String buildCommitMessage;
@override final  String revenueCatApiKeyIos;
@override final  String revenueCatApiKeyAndroid;
@override@JsonKey() final  bool isBetaTesting;
@override@JsonKey() final  bool isProFeaturesEnabled;

/// Create a copy of BuildConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuildConfigCopyWith<_BuildConfig> get copyWith => __$BuildConfigCopyWithImpl<_BuildConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BuildConfigToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BuildConfig'))
    ..add(DiagnosticsProperty('restApiUrl', restApiUrl))..add(DiagnosticsProperty('appIdSuffix', appIdSuffix))..add(DiagnosticsProperty('appName', appName))..add(DiagnosticsProperty('commitInformation', commitInformation))..add(DiagnosticsProperty('flavor', flavor))..add(DiagnosticsProperty('wsApiUrl', wsApiUrl))..add(DiagnosticsProperty('googleIosClientId', googleIosClientId))..add(DiagnosticsProperty('googleAndroidClientId', googleAndroidClientId))..add(DiagnosticsProperty('buildTimestamp', buildTimestamp))..add(DiagnosticsProperty('buildCommitMessage', buildCommitMessage))..add(DiagnosticsProperty('revenueCatApiKeyIos', revenueCatApiKeyIos))..add(DiagnosticsProperty('revenueCatApiKeyAndroid', revenueCatApiKeyAndroid))..add(DiagnosticsProperty('isBetaTesting', isBetaTesting))..add(DiagnosticsProperty('isProFeaturesEnabled', isProFeaturesEnabled));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuildConfig&&(identical(other.restApiUrl, restApiUrl) || other.restApiUrl == restApiUrl)&&(identical(other.appIdSuffix, appIdSuffix) || other.appIdSuffix == appIdSuffix)&&(identical(other.appName, appName) || other.appName == appName)&&(identical(other.commitInformation, commitInformation) || other.commitInformation == commitInformation)&&(identical(other.flavor, flavor) || other.flavor == flavor)&&(identical(other.wsApiUrl, wsApiUrl) || other.wsApiUrl == wsApiUrl)&&(identical(other.googleIosClientId, googleIosClientId) || other.googleIosClientId == googleIosClientId)&&(identical(other.googleAndroidClientId, googleAndroidClientId) || other.googleAndroidClientId == googleAndroidClientId)&&(identical(other.buildTimestamp, buildTimestamp) || other.buildTimestamp == buildTimestamp)&&(identical(other.buildCommitMessage, buildCommitMessage) || other.buildCommitMessage == buildCommitMessage)&&(identical(other.revenueCatApiKeyIos, revenueCatApiKeyIos) || other.revenueCatApiKeyIos == revenueCatApiKeyIos)&&(identical(other.revenueCatApiKeyAndroid, revenueCatApiKeyAndroid) || other.revenueCatApiKeyAndroid == revenueCatApiKeyAndroid)&&(identical(other.isBetaTesting, isBetaTesting) || other.isBetaTesting == isBetaTesting)&&(identical(other.isProFeaturesEnabled, isProFeaturesEnabled) || other.isProFeaturesEnabled == isProFeaturesEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restApiUrl,appIdSuffix,appName,commitInformation,flavor,wsApiUrl,googleIosClientId,googleAndroidClientId,buildTimestamp,buildCommitMessage,revenueCatApiKeyIos,revenueCatApiKeyAndroid,isBetaTesting,isProFeaturesEnabled);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BuildConfig(restApiUrl: $restApiUrl, appIdSuffix: $appIdSuffix, appName: $appName, commitInformation: $commitInformation, flavor: $flavor, wsApiUrl: $wsApiUrl, googleIosClientId: $googleIosClientId, googleAndroidClientId: $googleAndroidClientId, buildTimestamp: $buildTimestamp, buildCommitMessage: $buildCommitMessage, revenueCatApiKeyIos: $revenueCatApiKeyIos, revenueCatApiKeyAndroid: $revenueCatApiKeyAndroid, isBetaTesting: $isBetaTesting, isProFeaturesEnabled: $isProFeaturesEnabled)';
}


}

/// @nodoc
abstract mixin class _$BuildConfigCopyWith<$Res> implements $BuildConfigCopyWith<$Res> {
  factory _$BuildConfigCopyWith(_BuildConfig value, $Res Function(_BuildConfig) _then) = __$BuildConfigCopyWithImpl;
@override @useResult
$Res call({
 String restApiUrl, String appIdSuffix, String appName, String commitInformation, Flavor flavor, String wsApiUrl, String googleIosClientId, String googleAndroidClientId, String buildTimestamp, String buildCommitMessage, String revenueCatApiKeyIos, String revenueCatApiKeyAndroid, bool isBetaTesting, bool isProFeaturesEnabled
});




}
/// @nodoc
class __$BuildConfigCopyWithImpl<$Res>
    implements _$BuildConfigCopyWith<$Res> {
  __$BuildConfigCopyWithImpl(this._self, this._then);

  final _BuildConfig _self;
  final $Res Function(_BuildConfig) _then;

/// Create a copy of BuildConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? restApiUrl = null,Object? appIdSuffix = null,Object? appName = null,Object? commitInformation = null,Object? flavor = null,Object? wsApiUrl = null,Object? googleIosClientId = null,Object? googleAndroidClientId = null,Object? buildTimestamp = null,Object? buildCommitMessage = null,Object? revenueCatApiKeyIos = null,Object? revenueCatApiKeyAndroid = null,Object? isBetaTesting = null,Object? isProFeaturesEnabled = null,}) {
  return _then(_BuildConfig(
restApiUrl: null == restApiUrl ? _self.restApiUrl : restApiUrl // ignore: cast_nullable_to_non_nullable
as String,appIdSuffix: null == appIdSuffix ? _self.appIdSuffix : appIdSuffix // ignore: cast_nullable_to_non_nullable
as String,appName: null == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String,commitInformation: null == commitInformation ? _self.commitInformation : commitInformation // ignore: cast_nullable_to_non_nullable
as String,flavor: null == flavor ? _self.flavor : flavor // ignore: cast_nullable_to_non_nullable
as Flavor,wsApiUrl: null == wsApiUrl ? _self.wsApiUrl : wsApiUrl // ignore: cast_nullable_to_non_nullable
as String,googleIosClientId: null == googleIosClientId ? _self.googleIosClientId : googleIosClientId // ignore: cast_nullable_to_non_nullable
as String,googleAndroidClientId: null == googleAndroidClientId ? _self.googleAndroidClientId : googleAndroidClientId // ignore: cast_nullable_to_non_nullable
as String,buildTimestamp: null == buildTimestamp ? _self.buildTimestamp : buildTimestamp // ignore: cast_nullable_to_non_nullable
as String,buildCommitMessage: null == buildCommitMessage ? _self.buildCommitMessage : buildCommitMessage // ignore: cast_nullable_to_non_nullable
as String,revenueCatApiKeyIos: null == revenueCatApiKeyIos ? _self.revenueCatApiKeyIos : revenueCatApiKeyIos // ignore: cast_nullable_to_non_nullable
as String,revenueCatApiKeyAndroid: null == revenueCatApiKeyAndroid ? _self.revenueCatApiKeyAndroid : revenueCatApiKeyAndroid // ignore: cast_nullable_to_non_nullable
as String,isBetaTesting: null == isBetaTesting ? _self.isBetaTesting : isBetaTesting // ignore: cast_nullable_to_non_nullable
as bool,isProFeaturesEnabled: null == isProFeaturesEnabled ? _self.isProFeaturesEnabled : isProFeaturesEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
