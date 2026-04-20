// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_configuration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeEewSettings {

 HomeEewFillMode get fillMode; HomeEewAnimationRate get animationRate; bool get autoZoom; bool get showPSWaveCircle;
/// Create a copy of HomeEewSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeEewSettingsCopyWith<HomeEewSettings> get copyWith => _$HomeEewSettingsCopyWithImpl<HomeEewSettings>(this as HomeEewSettings, _$identity);

  /// Serializes this HomeEewSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEewSettings&&(identical(other.fillMode, fillMode) || other.fillMode == fillMode)&&(identical(other.animationRate, animationRate) || other.animationRate == animationRate)&&(identical(other.autoZoom, autoZoom) || other.autoZoom == autoZoom)&&(identical(other.showPSWaveCircle, showPSWaveCircle) || other.showPSWaveCircle == showPSWaveCircle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fillMode,animationRate,autoZoom,showPSWaveCircle);

@override
String toString() {
  return 'HomeEewSettings(fillMode: $fillMode, animationRate: $animationRate, autoZoom: $autoZoom, showPSWaveCircle: $showPSWaveCircle)';
}


}

/// @nodoc
abstract mixin class $HomeEewSettingsCopyWith<$Res>  {
  factory $HomeEewSettingsCopyWith(HomeEewSettings value, $Res Function(HomeEewSettings) _then) = _$HomeEewSettingsCopyWithImpl;
@useResult
$Res call({
 HomeEewFillMode fillMode, HomeEewAnimationRate animationRate, bool autoZoom, bool showPSWaveCircle
});




}
/// @nodoc
class _$HomeEewSettingsCopyWithImpl<$Res>
    implements $HomeEewSettingsCopyWith<$Res> {
  _$HomeEewSettingsCopyWithImpl(this._self, this._then);

  final HomeEewSettings _self;
  final $Res Function(HomeEewSettings) _then;

/// Create a copy of HomeEewSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fillMode = null,Object? animationRate = null,Object? autoZoom = null,Object? showPSWaveCircle = null,}) {
  return _then(_self.copyWith(
fillMode: null == fillMode ? _self.fillMode : fillMode // ignore: cast_nullable_to_non_nullable
as HomeEewFillMode,animationRate: null == animationRate ? _self.animationRate : animationRate // ignore: cast_nullable_to_non_nullable
as HomeEewAnimationRate,autoZoom: null == autoZoom ? _self.autoZoom : autoZoom // ignore: cast_nullable_to_non_nullable
as bool,showPSWaveCircle: null == showPSWaveCircle ? _self.showPSWaveCircle : showPSWaveCircle // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeEewSettings].
extension HomeEewSettingsPatterns on HomeEewSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeEewSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeEewSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeEewSettings value)  $default,){
final _that = this;
switch (_that) {
case _HomeEewSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeEewSettings value)?  $default,){
final _that = this;
switch (_that) {
case _HomeEewSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HomeEewFillMode fillMode,  HomeEewAnimationRate animationRate,  bool autoZoom,  bool showPSWaveCircle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeEewSettings() when $default != null:
return $default(_that.fillMode,_that.animationRate,_that.autoZoom,_that.showPSWaveCircle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HomeEewFillMode fillMode,  HomeEewAnimationRate animationRate,  bool autoZoom,  bool showPSWaveCircle)  $default,) {final _that = this;
switch (_that) {
case _HomeEewSettings():
return $default(_that.fillMode,_that.animationRate,_that.autoZoom,_that.showPSWaveCircle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HomeEewFillMode fillMode,  HomeEewAnimationRate animationRate,  bool autoZoom,  bool showPSWaveCircle)?  $default,) {final _that = this;
switch (_that) {
case _HomeEewSettings() when $default != null:
return $default(_that.fillMode,_that.animationRate,_that.autoZoom,_that.showPSWaveCircle);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _HomeEewSettings implements HomeEewSettings {
  const _HomeEewSettings({this.fillMode = HomeEewFillMode.intensity, this.animationRate = HomeEewAnimationRate.unlimited, this.autoZoom = true, this.showPSWaveCircle = true});
  factory _HomeEewSettings.fromJson(Map<String, dynamic> json) => _$HomeEewSettingsFromJson(json);

@override@JsonKey() final  HomeEewFillMode fillMode;
@override@JsonKey() final  HomeEewAnimationRate animationRate;
@override@JsonKey() final  bool autoZoom;
@override@JsonKey() final  bool showPSWaveCircle;

/// Create a copy of HomeEewSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeEewSettingsCopyWith<_HomeEewSettings> get copyWith => __$HomeEewSettingsCopyWithImpl<_HomeEewSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeEewSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeEewSettings&&(identical(other.fillMode, fillMode) || other.fillMode == fillMode)&&(identical(other.animationRate, animationRate) || other.animationRate == animationRate)&&(identical(other.autoZoom, autoZoom) || other.autoZoom == autoZoom)&&(identical(other.showPSWaveCircle, showPSWaveCircle) || other.showPSWaveCircle == showPSWaveCircle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fillMode,animationRate,autoZoom,showPSWaveCircle);

@override
String toString() {
  return 'HomeEewSettings(fillMode: $fillMode, animationRate: $animationRate, autoZoom: $autoZoom, showPSWaveCircle: $showPSWaveCircle)';
}


}

/// @nodoc
abstract mixin class _$HomeEewSettingsCopyWith<$Res> implements $HomeEewSettingsCopyWith<$Res> {
  factory _$HomeEewSettingsCopyWith(_HomeEewSettings value, $Res Function(_HomeEewSettings) _then) = __$HomeEewSettingsCopyWithImpl;
@override @useResult
$Res call({
 HomeEewFillMode fillMode, HomeEewAnimationRate animationRate, bool autoZoom, bool showPSWaveCircle
});




}
/// @nodoc
class __$HomeEewSettingsCopyWithImpl<$Res>
    implements _$HomeEewSettingsCopyWith<$Res> {
  __$HomeEewSettingsCopyWithImpl(this._self, this._then);

  final _HomeEewSettings _self;
  final $Res Function(_HomeEewSettings) _then;

/// Create a copy of HomeEewSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fillMode = null,Object? animationRate = null,Object? autoZoom = null,Object? showPSWaveCircle = null,}) {
  return _then(_HomeEewSettings(
fillMode: null == fillMode ? _self.fillMode : fillMode // ignore: cast_nullable_to_non_nullable
as HomeEewFillMode,animationRate: null == animationRate ? _self.animationRate : animationRate // ignore: cast_nullable_to_non_nullable
as HomeEewAnimationRate,autoZoom: null == autoZoom ? _self.autoZoom : autoZoom // ignore: cast_nullable_to_non_nullable
as bool,showPSWaveCircle: null == showPSWaveCircle ? _self.showPSWaveCircle : showPSWaveCircle // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$HomeKyoshinMonitorSettings {

 double? get minRealtimeShindo; HomeKmoniMarkerSize get markerSize;
/// Create a copy of HomeKyoshinMonitorSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeKyoshinMonitorSettingsCopyWith<HomeKyoshinMonitorSettings> get copyWith => _$HomeKyoshinMonitorSettingsCopyWithImpl<HomeKyoshinMonitorSettings>(this as HomeKyoshinMonitorSettings, _$identity);

  /// Serializes this HomeKyoshinMonitorSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeKyoshinMonitorSettings&&(identical(other.minRealtimeShindo, minRealtimeShindo) || other.minRealtimeShindo == minRealtimeShindo)&&(identical(other.markerSize, markerSize) || other.markerSize == markerSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minRealtimeShindo,markerSize);

@override
String toString() {
  return 'HomeKyoshinMonitorSettings(minRealtimeShindo: $minRealtimeShindo, markerSize: $markerSize)';
}


}

/// @nodoc
abstract mixin class $HomeKyoshinMonitorSettingsCopyWith<$Res>  {
  factory $HomeKyoshinMonitorSettingsCopyWith(HomeKyoshinMonitorSettings value, $Res Function(HomeKyoshinMonitorSettings) _then) = _$HomeKyoshinMonitorSettingsCopyWithImpl;
@useResult
$Res call({
 double? minRealtimeShindo, HomeKmoniMarkerSize markerSize
});




}
/// @nodoc
class _$HomeKyoshinMonitorSettingsCopyWithImpl<$Res>
    implements $HomeKyoshinMonitorSettingsCopyWith<$Res> {
  _$HomeKyoshinMonitorSettingsCopyWithImpl(this._self, this._then);

  final HomeKyoshinMonitorSettings _self;
  final $Res Function(HomeKyoshinMonitorSettings) _then;

/// Create a copy of HomeKyoshinMonitorSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minRealtimeShindo = freezed,Object? markerSize = null,}) {
  return _then(_self.copyWith(
minRealtimeShindo: freezed == minRealtimeShindo ? _self.minRealtimeShindo : minRealtimeShindo // ignore: cast_nullable_to_non_nullable
as double?,markerSize: null == markerSize ? _self.markerSize : markerSize // ignore: cast_nullable_to_non_nullable
as HomeKmoniMarkerSize,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeKyoshinMonitorSettings].
extension HomeKyoshinMonitorSettingsPatterns on HomeKyoshinMonitorSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeKyoshinMonitorSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeKyoshinMonitorSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeKyoshinMonitorSettings value)  $default,){
final _that = this;
switch (_that) {
case _HomeKyoshinMonitorSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeKyoshinMonitorSettings value)?  $default,){
final _that = this;
switch (_that) {
case _HomeKyoshinMonitorSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? minRealtimeShindo,  HomeKmoniMarkerSize markerSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeKyoshinMonitorSettings() when $default != null:
return $default(_that.minRealtimeShindo,_that.markerSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? minRealtimeShindo,  HomeKmoniMarkerSize markerSize)  $default,) {final _that = this;
switch (_that) {
case _HomeKyoshinMonitorSettings():
return $default(_that.minRealtimeShindo,_that.markerSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? minRealtimeShindo,  HomeKmoniMarkerSize markerSize)?  $default,) {final _that = this;
switch (_that) {
case _HomeKyoshinMonitorSettings() when $default != null:
return $default(_that.minRealtimeShindo,_that.markerSize);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _HomeKyoshinMonitorSettings implements HomeKyoshinMonitorSettings {
  const _HomeKyoshinMonitorSettings({this.minRealtimeShindo = null, this.markerSize = HomeKmoniMarkerSize.medium});
  factory _HomeKyoshinMonitorSettings.fromJson(Map<String, dynamic> json) => _$HomeKyoshinMonitorSettingsFromJson(json);

@override@JsonKey() final  double? minRealtimeShindo;
@override@JsonKey() final  HomeKmoniMarkerSize markerSize;

/// Create a copy of HomeKyoshinMonitorSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeKyoshinMonitorSettingsCopyWith<_HomeKyoshinMonitorSettings> get copyWith => __$HomeKyoshinMonitorSettingsCopyWithImpl<_HomeKyoshinMonitorSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeKyoshinMonitorSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeKyoshinMonitorSettings&&(identical(other.minRealtimeShindo, minRealtimeShindo) || other.minRealtimeShindo == minRealtimeShindo)&&(identical(other.markerSize, markerSize) || other.markerSize == markerSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minRealtimeShindo,markerSize);

@override
String toString() {
  return 'HomeKyoshinMonitorSettings(minRealtimeShindo: $minRealtimeShindo, markerSize: $markerSize)';
}


}

/// @nodoc
abstract mixin class _$HomeKyoshinMonitorSettingsCopyWith<$Res> implements $HomeKyoshinMonitorSettingsCopyWith<$Res> {
  factory _$HomeKyoshinMonitorSettingsCopyWith(_HomeKyoshinMonitorSettings value, $Res Function(_HomeKyoshinMonitorSettings) _then) = __$HomeKyoshinMonitorSettingsCopyWithImpl;
@override @useResult
$Res call({
 double? minRealtimeShindo, HomeKmoniMarkerSize markerSize
});




}
/// @nodoc
class __$HomeKyoshinMonitorSettingsCopyWithImpl<$Res>
    implements _$HomeKyoshinMonitorSettingsCopyWith<$Res> {
  __$HomeKyoshinMonitorSettingsCopyWithImpl(this._self, this._then);

  final _HomeKyoshinMonitorSettings _self;
  final $Res Function(_HomeKyoshinMonitorSettings) _then;

/// Create a copy of HomeKyoshinMonitorSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minRealtimeShindo = freezed,Object? markerSize = null,}) {
  return _then(_HomeKyoshinMonitorSettings(
minRealtimeShindo: freezed == minRealtimeShindo ? _self.minRealtimeShindo : minRealtimeShindo // ignore: cast_nullable_to_non_nullable
as double?,markerSize: null == markerSize ? _self.markerSize : markerSize // ignore: cast_nullable_to_non_nullable
as HomeKmoniMarkerSize,
  ));
}


}


/// @nodoc
mixin _$HomeMapSettings {

 double? get maxZoom; HomeMapDefaultBounds get defaultBounds;@LatLngBoundaryJsonConverter() LatLngBoundary? get customBounds; bool get lockBearing;
/// Create a copy of HomeMapSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeMapSettingsCopyWith<HomeMapSettings> get copyWith => _$HomeMapSettingsCopyWithImpl<HomeMapSettings>(this as HomeMapSettings, _$identity);

  /// Serializes this HomeMapSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeMapSettings&&(identical(other.maxZoom, maxZoom) || other.maxZoom == maxZoom)&&(identical(other.defaultBounds, defaultBounds) || other.defaultBounds == defaultBounds)&&(identical(other.customBounds, customBounds) || other.customBounds == customBounds)&&(identical(other.lockBearing, lockBearing) || other.lockBearing == lockBearing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxZoom,defaultBounds,customBounds,lockBearing);

@override
String toString() {
  return 'HomeMapSettings(maxZoom: $maxZoom, defaultBounds: $defaultBounds, customBounds: $customBounds, lockBearing: $lockBearing)';
}


}

/// @nodoc
abstract mixin class $HomeMapSettingsCopyWith<$Res>  {
  factory $HomeMapSettingsCopyWith(HomeMapSettings value, $Res Function(HomeMapSettings) _then) = _$HomeMapSettingsCopyWithImpl;
@useResult
$Res call({
 double? maxZoom, HomeMapDefaultBounds defaultBounds,@LatLngBoundaryJsonConverter() LatLngBoundary? customBounds, bool lockBearing
});




}
/// @nodoc
class _$HomeMapSettingsCopyWithImpl<$Res>
    implements $HomeMapSettingsCopyWith<$Res> {
  _$HomeMapSettingsCopyWithImpl(this._self, this._then);

  final HomeMapSettings _self;
  final $Res Function(HomeMapSettings) _then;

/// Create a copy of HomeMapSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxZoom = freezed,Object? defaultBounds = null,Object? customBounds = freezed,Object? lockBearing = null,}) {
  return _then(_self.copyWith(
maxZoom: freezed == maxZoom ? _self.maxZoom : maxZoom // ignore: cast_nullable_to_non_nullable
as double?,defaultBounds: null == defaultBounds ? _self.defaultBounds : defaultBounds // ignore: cast_nullable_to_non_nullable
as HomeMapDefaultBounds,customBounds: freezed == customBounds ? _self.customBounds : customBounds // ignore: cast_nullable_to_non_nullable
as LatLngBoundary?,lockBearing: null == lockBearing ? _self.lockBearing : lockBearing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeMapSettings].
extension HomeMapSettingsPatterns on HomeMapSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeMapSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeMapSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeMapSettings value)  $default,){
final _that = this;
switch (_that) {
case _HomeMapSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeMapSettings value)?  $default,){
final _that = this;
switch (_that) {
case _HomeMapSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? maxZoom,  HomeMapDefaultBounds defaultBounds, @LatLngBoundaryJsonConverter()  LatLngBoundary? customBounds,  bool lockBearing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeMapSettings() when $default != null:
return $default(_that.maxZoom,_that.defaultBounds,_that.customBounds,_that.lockBearing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? maxZoom,  HomeMapDefaultBounds defaultBounds, @LatLngBoundaryJsonConverter()  LatLngBoundary? customBounds,  bool lockBearing)  $default,) {final _that = this;
switch (_that) {
case _HomeMapSettings():
return $default(_that.maxZoom,_that.defaultBounds,_that.customBounds,_that.lockBearing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? maxZoom,  HomeMapDefaultBounds defaultBounds, @LatLngBoundaryJsonConverter()  LatLngBoundary? customBounds,  bool lockBearing)?  $default,) {final _that = this;
switch (_that) {
case _HomeMapSettings() when $default != null:
return $default(_that.maxZoom,_that.defaultBounds,_that.customBounds,_that.lockBearing);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _HomeMapSettings implements HomeMapSettings {
  const _HomeMapSettings({this.maxZoom = null, this.defaultBounds = HomeMapDefaultBounds.mainIsland, @LatLngBoundaryJsonConverter() this.customBounds, this.lockBearing = false});
  factory _HomeMapSettings.fromJson(Map<String, dynamic> json) => _$HomeMapSettingsFromJson(json);

@override@JsonKey() final  double? maxZoom;
@override@JsonKey() final  HomeMapDefaultBounds defaultBounds;
@override@LatLngBoundaryJsonConverter() final  LatLngBoundary? customBounds;
@override@JsonKey() final  bool lockBearing;

/// Create a copy of HomeMapSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeMapSettingsCopyWith<_HomeMapSettings> get copyWith => __$HomeMapSettingsCopyWithImpl<_HomeMapSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeMapSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeMapSettings&&(identical(other.maxZoom, maxZoom) || other.maxZoom == maxZoom)&&(identical(other.defaultBounds, defaultBounds) || other.defaultBounds == defaultBounds)&&(identical(other.customBounds, customBounds) || other.customBounds == customBounds)&&(identical(other.lockBearing, lockBearing) || other.lockBearing == lockBearing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxZoom,defaultBounds,customBounds,lockBearing);

@override
String toString() {
  return 'HomeMapSettings(maxZoom: $maxZoom, defaultBounds: $defaultBounds, customBounds: $customBounds, lockBearing: $lockBearing)';
}


}

/// @nodoc
abstract mixin class _$HomeMapSettingsCopyWith<$Res> implements $HomeMapSettingsCopyWith<$Res> {
  factory _$HomeMapSettingsCopyWith(_HomeMapSettings value, $Res Function(_HomeMapSettings) _then) = __$HomeMapSettingsCopyWithImpl;
@override @useResult
$Res call({
 double? maxZoom, HomeMapDefaultBounds defaultBounds,@LatLngBoundaryJsonConverter() LatLngBoundary? customBounds, bool lockBearing
});




}
/// @nodoc
class __$HomeMapSettingsCopyWithImpl<$Res>
    implements _$HomeMapSettingsCopyWith<$Res> {
  __$HomeMapSettingsCopyWithImpl(this._self, this._then);

  final _HomeMapSettings _self;
  final $Res Function(_HomeMapSettings) _then;

/// Create a copy of HomeMapSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxZoom = freezed,Object? defaultBounds = null,Object? customBounds = freezed,Object? lockBearing = null,}) {
  return _then(_HomeMapSettings(
maxZoom: freezed == maxZoom ? _self.maxZoom : maxZoom // ignore: cast_nullable_to_non_nullable
as double?,defaultBounds: null == defaultBounds ? _self.defaultBounds : defaultBounds // ignore: cast_nullable_to_non_nullable
as HomeMapDefaultBounds,customBounds: freezed == customBounds ? _self.customBounds : customBounds // ignore: cast_nullable_to_non_nullable
as LatLngBoundary?,lockBearing: null == lockBearing ? _self.lockBearing : lockBearing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$HomeCommonSettings {

 bool get showLocation; HomeEarthquakeHistoryScope get earthquakeHistoryScope; EarthquakeHistoryParameter? get parameter;
/// Create a copy of HomeCommonSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeCommonSettingsCopyWith<HomeCommonSettings> get copyWith => _$HomeCommonSettingsCopyWithImpl<HomeCommonSettings>(this as HomeCommonSettings, _$identity);

  /// Serializes this HomeCommonSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeCommonSettings&&(identical(other.showLocation, showLocation) || other.showLocation == showLocation)&&(identical(other.earthquakeHistoryScope, earthquakeHistoryScope) || other.earthquakeHistoryScope == earthquakeHistoryScope)&&(identical(other.parameter, parameter) || other.parameter == parameter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showLocation,earthquakeHistoryScope,parameter);

@override
String toString() {
  return 'HomeCommonSettings(showLocation: $showLocation, earthquakeHistoryScope: $earthquakeHistoryScope, parameter: $parameter)';
}


}

/// @nodoc
abstract mixin class $HomeCommonSettingsCopyWith<$Res>  {
  factory $HomeCommonSettingsCopyWith(HomeCommonSettings value, $Res Function(HomeCommonSettings) _then) = _$HomeCommonSettingsCopyWithImpl;
@useResult
$Res call({
 bool showLocation, HomeEarthquakeHistoryScope earthquakeHistoryScope, EarthquakeHistoryParameter? parameter
});


$EarthquakeHistoryParameterCopyWith<$Res>? get parameter;

}
/// @nodoc
class _$HomeCommonSettingsCopyWithImpl<$Res>
    implements $HomeCommonSettingsCopyWith<$Res> {
  _$HomeCommonSettingsCopyWithImpl(this._self, this._then);

  final HomeCommonSettings _self;
  final $Res Function(HomeCommonSettings) _then;

/// Create a copy of HomeCommonSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showLocation = null,Object? earthquakeHistoryScope = null,Object? parameter = freezed,}) {
  return _then(_self.copyWith(
showLocation: null == showLocation ? _self.showLocation : showLocation // ignore: cast_nullable_to_non_nullable
as bool,earthquakeHistoryScope: null == earthquakeHistoryScope ? _self.earthquakeHistoryScope : earthquakeHistoryScope // ignore: cast_nullable_to_non_nullable
as HomeEarthquakeHistoryScope,parameter: freezed == parameter ? _self.parameter : parameter // ignore: cast_nullable_to_non_nullable
as EarthquakeHistoryParameter?,
  ));
}
/// Create a copy of HomeCommonSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHistoryParameterCopyWith<$Res>? get parameter {
    if (_self.parameter == null) {
    return null;
  }

  return $EarthquakeHistoryParameterCopyWith<$Res>(_self.parameter!, (value) {
    return _then(_self.copyWith(parameter: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeCommonSettings].
extension HomeCommonSettingsPatterns on HomeCommonSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeCommonSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeCommonSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeCommonSettings value)  $default,){
final _that = this;
switch (_that) {
case _HomeCommonSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeCommonSettings value)?  $default,){
final _that = this;
switch (_that) {
case _HomeCommonSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool showLocation,  HomeEarthquakeHistoryScope earthquakeHistoryScope,  EarthquakeHistoryParameter? parameter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeCommonSettings() when $default != null:
return $default(_that.showLocation,_that.earthquakeHistoryScope,_that.parameter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool showLocation,  HomeEarthquakeHistoryScope earthquakeHistoryScope,  EarthquakeHistoryParameter? parameter)  $default,) {final _that = this;
switch (_that) {
case _HomeCommonSettings():
return $default(_that.showLocation,_that.earthquakeHistoryScope,_that.parameter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool showLocation,  HomeEarthquakeHistoryScope earthquakeHistoryScope,  EarthquakeHistoryParameter? parameter)?  $default,) {final _that = this;
switch (_that) {
case _HomeCommonSettings() when $default != null:
return $default(_that.showLocation,_that.earthquakeHistoryScope,_that.parameter);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _HomeCommonSettings implements HomeCommonSettings {
  const _HomeCommonSettings({this.showLocation = false, this.earthquakeHistoryScope = HomeEarthquakeHistoryScope.nationwide, this.parameter});
  factory _HomeCommonSettings.fromJson(Map<String, dynamic> json) => _$HomeCommonSettingsFromJson(json);

@override@JsonKey() final  bool showLocation;
@override@JsonKey() final  HomeEarthquakeHistoryScope earthquakeHistoryScope;
@override final  EarthquakeHistoryParameter? parameter;

/// Create a copy of HomeCommonSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeCommonSettingsCopyWith<_HomeCommonSettings> get copyWith => __$HomeCommonSettingsCopyWithImpl<_HomeCommonSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeCommonSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeCommonSettings&&(identical(other.showLocation, showLocation) || other.showLocation == showLocation)&&(identical(other.earthquakeHistoryScope, earthquakeHistoryScope) || other.earthquakeHistoryScope == earthquakeHistoryScope)&&(identical(other.parameter, parameter) || other.parameter == parameter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showLocation,earthquakeHistoryScope,parameter);

@override
String toString() {
  return 'HomeCommonSettings(showLocation: $showLocation, earthquakeHistoryScope: $earthquakeHistoryScope, parameter: $parameter)';
}


}

/// @nodoc
abstract mixin class _$HomeCommonSettingsCopyWith<$Res> implements $HomeCommonSettingsCopyWith<$Res> {
  factory _$HomeCommonSettingsCopyWith(_HomeCommonSettings value, $Res Function(_HomeCommonSettings) _then) = __$HomeCommonSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool showLocation, HomeEarthquakeHistoryScope earthquakeHistoryScope, EarthquakeHistoryParameter? parameter
});


@override $EarthquakeHistoryParameterCopyWith<$Res>? get parameter;

}
/// @nodoc
class __$HomeCommonSettingsCopyWithImpl<$Res>
    implements _$HomeCommonSettingsCopyWith<$Res> {
  __$HomeCommonSettingsCopyWithImpl(this._self, this._then);

  final _HomeCommonSettings _self;
  final $Res Function(_HomeCommonSettings) _then;

/// Create a copy of HomeCommonSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showLocation = null,Object? earthquakeHistoryScope = null,Object? parameter = freezed,}) {
  return _then(_HomeCommonSettings(
showLocation: null == showLocation ? _self.showLocation : showLocation // ignore: cast_nullable_to_non_nullable
as bool,earthquakeHistoryScope: null == earthquakeHistoryScope ? _self.earthquakeHistoryScope : earthquakeHistoryScope // ignore: cast_nullable_to_non_nullable
as HomeEarthquakeHistoryScope,parameter: freezed == parameter ? _self.parameter : parameter // ignore: cast_nullable_to_non_nullable
as EarthquakeHistoryParameter?,
  ));
}

/// Create a copy of HomeCommonSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHistoryParameterCopyWith<$Res>? get parameter {
    if (_self.parameter == null) {
    return null;
  }

  return $EarthquakeHistoryParameterCopyWith<$Res>(_self.parameter!, (value) {
    return _then(_self.copyWith(parameter: value));
  });
}
}


/// @nodoc
mixin _$HomeConfigurationModel {

 HomeEewSettings get eew;@JsonKey(name: 'kyoshin_monitor') HomeKyoshinMonitorSettings get kyoshinMonitor; HomeMapSettings get map; HomeCommonSettings get common;
/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeConfigurationModelCopyWith<HomeConfigurationModel> get copyWith => _$HomeConfigurationModelCopyWithImpl<HomeConfigurationModel>(this as HomeConfigurationModel, _$identity);

  /// Serializes this HomeConfigurationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeConfigurationModel&&(identical(other.eew, eew) || other.eew == eew)&&(identical(other.kyoshinMonitor, kyoshinMonitor) || other.kyoshinMonitor == kyoshinMonitor)&&(identical(other.map, map) || other.map == map)&&(identical(other.common, common) || other.common == common));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eew,kyoshinMonitor,map,common);

@override
String toString() {
  return 'HomeConfigurationModel(eew: $eew, kyoshinMonitor: $kyoshinMonitor, map: $map, common: $common)';
}


}

/// @nodoc
abstract mixin class $HomeConfigurationModelCopyWith<$Res>  {
  factory $HomeConfigurationModelCopyWith(HomeConfigurationModel value, $Res Function(HomeConfigurationModel) _then) = _$HomeConfigurationModelCopyWithImpl;
@useResult
$Res call({
 HomeEewSettings eew,@JsonKey(name: 'kyoshin_monitor') HomeKyoshinMonitorSettings kyoshinMonitor, HomeMapSettings map, HomeCommonSettings common
});


$HomeEewSettingsCopyWith<$Res> get eew;$HomeKyoshinMonitorSettingsCopyWith<$Res> get kyoshinMonitor;$HomeMapSettingsCopyWith<$Res> get map;$HomeCommonSettingsCopyWith<$Res> get common;

}
/// @nodoc
class _$HomeConfigurationModelCopyWithImpl<$Res>
    implements $HomeConfigurationModelCopyWith<$Res> {
  _$HomeConfigurationModelCopyWithImpl(this._self, this._then);

  final HomeConfigurationModel _self;
  final $Res Function(HomeConfigurationModel) _then;

/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eew = null,Object? kyoshinMonitor = null,Object? map = null,Object? common = null,}) {
  return _then(_self.copyWith(
eew: null == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as HomeEewSettings,kyoshinMonitor: null == kyoshinMonitor ? _self.kyoshinMonitor : kyoshinMonitor // ignore: cast_nullable_to_non_nullable
as HomeKyoshinMonitorSettings,map: null == map ? _self.map : map // ignore: cast_nullable_to_non_nullable
as HomeMapSettings,common: null == common ? _self.common : common // ignore: cast_nullable_to_non_nullable
as HomeCommonSettings,
  ));
}
/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeEewSettingsCopyWith<$Res> get eew {
  
  return $HomeEewSettingsCopyWith<$Res>(_self.eew, (value) {
    return _then(_self.copyWith(eew: value));
  });
}/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeKyoshinMonitorSettingsCopyWith<$Res> get kyoshinMonitor {
  
  return $HomeKyoshinMonitorSettingsCopyWith<$Res>(_self.kyoshinMonitor, (value) {
    return _then(_self.copyWith(kyoshinMonitor: value));
  });
}/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeMapSettingsCopyWith<$Res> get map {
  
  return $HomeMapSettingsCopyWith<$Res>(_self.map, (value) {
    return _then(_self.copyWith(map: value));
  });
}/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeCommonSettingsCopyWith<$Res> get common {
  
  return $HomeCommonSettingsCopyWith<$Res>(_self.common, (value) {
    return _then(_self.copyWith(common: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeConfigurationModel].
extension HomeConfigurationModelPatterns on HomeConfigurationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeConfigurationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeConfigurationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeConfigurationModel value)  $default,){
final _that = this;
switch (_that) {
case _HomeConfigurationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeConfigurationModel value)?  $default,){
final _that = this;
switch (_that) {
case _HomeConfigurationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HomeEewSettings eew, @JsonKey(name: 'kyoshin_monitor')  HomeKyoshinMonitorSettings kyoshinMonitor,  HomeMapSettings map,  HomeCommonSettings common)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeConfigurationModel() when $default != null:
return $default(_that.eew,_that.kyoshinMonitor,_that.map,_that.common);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HomeEewSettings eew, @JsonKey(name: 'kyoshin_monitor')  HomeKyoshinMonitorSettings kyoshinMonitor,  HomeMapSettings map,  HomeCommonSettings common)  $default,) {final _that = this;
switch (_that) {
case _HomeConfigurationModel():
return $default(_that.eew,_that.kyoshinMonitor,_that.map,_that.common);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HomeEewSettings eew, @JsonKey(name: 'kyoshin_monitor')  HomeKyoshinMonitorSettings kyoshinMonitor,  HomeMapSettings map,  HomeCommonSettings common)?  $default,) {final _that = this;
switch (_that) {
case _HomeConfigurationModel() when $default != null:
return $default(_that.eew,_that.kyoshinMonitor,_that.map,_that.common);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _HomeConfigurationModel implements HomeConfigurationModel {
  const _HomeConfigurationModel({this.eew = const HomeEewSettings(), @JsonKey(name: 'kyoshin_monitor') this.kyoshinMonitor = const HomeKyoshinMonitorSettings(), this.map = const HomeMapSettings(), this.common = const HomeCommonSettings()});
  factory _HomeConfigurationModel.fromJson(Map<String, dynamic> json) => _$HomeConfigurationModelFromJson(json);

@override@JsonKey() final  HomeEewSettings eew;
@override@JsonKey(name: 'kyoshin_monitor') final  HomeKyoshinMonitorSettings kyoshinMonitor;
@override@JsonKey() final  HomeMapSettings map;
@override@JsonKey() final  HomeCommonSettings common;

/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeConfigurationModelCopyWith<_HomeConfigurationModel> get copyWith => __$HomeConfigurationModelCopyWithImpl<_HomeConfigurationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeConfigurationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeConfigurationModel&&(identical(other.eew, eew) || other.eew == eew)&&(identical(other.kyoshinMonitor, kyoshinMonitor) || other.kyoshinMonitor == kyoshinMonitor)&&(identical(other.map, map) || other.map == map)&&(identical(other.common, common) || other.common == common));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eew,kyoshinMonitor,map,common);

@override
String toString() {
  return 'HomeConfigurationModel(eew: $eew, kyoshinMonitor: $kyoshinMonitor, map: $map, common: $common)';
}


}

/// @nodoc
abstract mixin class _$HomeConfigurationModelCopyWith<$Res> implements $HomeConfigurationModelCopyWith<$Res> {
  factory _$HomeConfigurationModelCopyWith(_HomeConfigurationModel value, $Res Function(_HomeConfigurationModel) _then) = __$HomeConfigurationModelCopyWithImpl;
@override @useResult
$Res call({
 HomeEewSettings eew,@JsonKey(name: 'kyoshin_monitor') HomeKyoshinMonitorSettings kyoshinMonitor, HomeMapSettings map, HomeCommonSettings common
});


@override $HomeEewSettingsCopyWith<$Res> get eew;@override $HomeKyoshinMonitorSettingsCopyWith<$Res> get kyoshinMonitor;@override $HomeMapSettingsCopyWith<$Res> get map;@override $HomeCommonSettingsCopyWith<$Res> get common;

}
/// @nodoc
class __$HomeConfigurationModelCopyWithImpl<$Res>
    implements _$HomeConfigurationModelCopyWith<$Res> {
  __$HomeConfigurationModelCopyWithImpl(this._self, this._then);

  final _HomeConfigurationModel _self;
  final $Res Function(_HomeConfigurationModel) _then;

/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eew = null,Object? kyoshinMonitor = null,Object? map = null,Object? common = null,}) {
  return _then(_HomeConfigurationModel(
eew: null == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as HomeEewSettings,kyoshinMonitor: null == kyoshinMonitor ? _self.kyoshinMonitor : kyoshinMonitor // ignore: cast_nullable_to_non_nullable
as HomeKyoshinMonitorSettings,map: null == map ? _self.map : map // ignore: cast_nullable_to_non_nullable
as HomeMapSettings,common: null == common ? _self.common : common // ignore: cast_nullable_to_non_nullable
as HomeCommonSettings,
  ));
}

/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeEewSettingsCopyWith<$Res> get eew {
  
  return $HomeEewSettingsCopyWith<$Res>(_self.eew, (value) {
    return _then(_self.copyWith(eew: value));
  });
}/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeKyoshinMonitorSettingsCopyWith<$Res> get kyoshinMonitor {
  
  return $HomeKyoshinMonitorSettingsCopyWith<$Res>(_self.kyoshinMonitor, (value) {
    return _then(_self.copyWith(kyoshinMonitor: value));
  });
}/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeMapSettingsCopyWith<$Res> get map {
  
  return $HomeMapSettingsCopyWith<$Res>(_self.map, (value) {
    return _then(_self.copyWith(map: value));
  });
}/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeCommonSettingsCopyWith<$Res> get common {
  
  return $HomeCommonSettingsCopyWith<$Res>(_self.common, (value) {
    return _then(_self.copyWith(common: value));
  });
}
}

// dart format on
