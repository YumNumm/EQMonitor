// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_configuration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeShakeDetectionSettings {

 bool get show; HomeShakeDetectionAnimationMode get animationMode;
/// Create a copy of HomeShakeDetectionSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeShakeDetectionSettingsCopyWith<HomeShakeDetectionSettings> get copyWith => _$HomeShakeDetectionSettingsCopyWithImpl<HomeShakeDetectionSettings>(this as HomeShakeDetectionSettings, _$identity);

  /// Serializes this HomeShakeDetectionSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeShakeDetectionSettings&&(identical(other.show, show) || other.show == show)&&(identical(other.animationMode, animationMode) || other.animationMode == animationMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,show,animationMode);

@override
String toString() {
  return 'HomeShakeDetectionSettings(show: $show, animationMode: $animationMode)';
}


}

/// @nodoc
abstract mixin class $HomeShakeDetectionSettingsCopyWith<$Res>  {
  factory $HomeShakeDetectionSettingsCopyWith(HomeShakeDetectionSettings value, $Res Function(HomeShakeDetectionSettings) _then) = _$HomeShakeDetectionSettingsCopyWithImpl;
@useResult
$Res call({
 bool show, HomeShakeDetectionAnimationMode animationMode
});




}
/// @nodoc
class _$HomeShakeDetectionSettingsCopyWithImpl<$Res>
    implements $HomeShakeDetectionSettingsCopyWith<$Res> {
  _$HomeShakeDetectionSettingsCopyWithImpl(this._self, this._then);

  final HomeShakeDetectionSettings _self;
  final $Res Function(HomeShakeDetectionSettings) _then;

/// Create a copy of HomeShakeDetectionSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? show = null,Object? animationMode = null,}) {
  return _then(HomeShakeDetectionSettings(
show: null == show ? _self.show : show // ignore: cast_nullable_to_non_nullable
as bool,animationMode: null == animationMode ? _self.animationMode : animationMode // ignore: cast_nullable_to_non_nullable
as HomeShakeDetectionAnimationMode,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeShakeDetectionSettings].
extension HomeShakeDetectionSettingsPatterns on HomeShakeDetectionSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeShakeDetectionSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeShakeDetectionSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeShakeDetectionSettings value)  $default,){
final _that = this;
switch (_that) {
case _HomeShakeDetectionSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeShakeDetectionSettings value)?  $default,){
final _that = this;
switch (_that) {
case _HomeShakeDetectionSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool show,  HomeShakeDetectionAnimationMode animationMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeShakeDetectionSettings() when $default != null:
return $default(_that.show,_that.animationMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool show,  HomeShakeDetectionAnimationMode animationMode)  $default,) {final _that = this;
switch (_that) {
case _HomeShakeDetectionSettings():
return $default(_that.show,_that.animationMode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool show,  HomeShakeDetectionAnimationMode animationMode)?  $default,) {final _that = this;
switch (_that) {
case _HomeShakeDetectionSettings() when $default != null:
return $default(_that.show,_that.animationMode);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _HomeShakeDetectionSettings implements HomeShakeDetectionSettings {
  const _HomeShakeDetectionSettings({this.show = true, this.animationMode = HomeShakeDetectionAnimationMode.blink});
  factory _HomeShakeDetectionSettings.fromJson(Map<String, dynamic> json) => _$HomeShakeDetectionSettingsFromJson(json);

@override@JsonKey() final  bool show;
@override@JsonKey() final  HomeShakeDetectionAnimationMode animationMode;

/// Create a copy of HomeShakeDetectionSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeShakeDetectionSettingsCopyWith<_HomeShakeDetectionSettings> get copyWith => __$HomeShakeDetectionSettingsCopyWithImpl<_HomeShakeDetectionSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeShakeDetectionSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeShakeDetectionSettings&&(identical(other.show, show) || other.show == show)&&(identical(other.animationMode, animationMode) || other.animationMode == animationMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,show,animationMode);

@override
String toString() {
  return 'HomeShakeDetectionSettings(show: $show, animationMode: $animationMode)';
}


}

/// @nodoc
abstract mixin class _$HomeShakeDetectionSettingsCopyWith<$Res> implements $HomeShakeDetectionSettingsCopyWith<$Res> {
  factory _$HomeShakeDetectionSettingsCopyWith(_HomeShakeDetectionSettings value, $Res Function(_HomeShakeDetectionSettings) _then) = __$HomeShakeDetectionSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool show, HomeShakeDetectionAnimationMode animationMode
});




}
/// @nodoc
class __$HomeShakeDetectionSettingsCopyWithImpl<$Res>
    implements _$HomeShakeDetectionSettingsCopyWith<$Res> {
  __$HomeShakeDetectionSettingsCopyWithImpl(this._self, this._then);

  final _HomeShakeDetectionSettings _self;
  final $Res Function(_HomeShakeDetectionSettings) _then;

/// Create a copy of HomeShakeDetectionSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? show = null,Object? animationMode = null,}) {
  return _then(_HomeShakeDetectionSettings(
show: null == show ? _self.show : show // ignore: cast_nullable_to_non_nullable
as bool,animationMode: null == animationMode ? _self.animationMode : animationMode // ignore: cast_nullable_to_non_nullable
as HomeShakeDetectionAnimationMode,
  ));
}


}


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
  return _then(HomeEewSettings(
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
  return _then(HomeKyoshinMonitorSettings(
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
mixin _$HomeMapGridSettings {

 bool get enabled;
/// Create a copy of HomeMapGridSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeMapGridSettingsCopyWith<HomeMapGridSettings> get copyWith => _$HomeMapGridSettingsCopyWithImpl<HomeMapGridSettings>(this as HomeMapGridSettings, _$identity);

  /// Serializes this HomeMapGridSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeMapGridSettings&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'HomeMapGridSettings(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $HomeMapGridSettingsCopyWith<$Res>  {
  factory $HomeMapGridSettingsCopyWith(HomeMapGridSettings value, $Res Function(HomeMapGridSettings) _then) = _$HomeMapGridSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class _$HomeMapGridSettingsCopyWithImpl<$Res>
    implements $HomeMapGridSettingsCopyWith<$Res> {
  _$HomeMapGridSettingsCopyWithImpl(this._self, this._then);

  final HomeMapGridSettings _self;
  final $Res Function(HomeMapGridSettings) _then;

/// Create a copy of HomeMapGridSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,}) {
  return _then(HomeMapGridSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeMapGridSettings].
extension HomeMapGridSettingsPatterns on HomeMapGridSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeMapGridSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeMapGridSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeMapGridSettings value)  $default,){
final _that = this;
switch (_that) {
case _HomeMapGridSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeMapGridSettings value)?  $default,){
final _that = this;
switch (_that) {
case _HomeMapGridSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeMapGridSettings() when $default != null:
return $default(_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled)  $default,) {final _that = this;
switch (_that) {
case _HomeMapGridSettings():
return $default(_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _HomeMapGridSettings() when $default != null:
return $default(_that.enabled);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _HomeMapGridSettings implements HomeMapGridSettings {
  const _HomeMapGridSettings({this.enabled = false});
  factory _HomeMapGridSettings.fromJson(Map<String, dynamic> json) => _$HomeMapGridSettingsFromJson(json);

@override@JsonKey() final  bool enabled;

/// Create a copy of HomeMapGridSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeMapGridSettingsCopyWith<_HomeMapGridSettings> get copyWith => __$HomeMapGridSettingsCopyWithImpl<_HomeMapGridSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeMapGridSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeMapGridSettings&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'HomeMapGridSettings(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$HomeMapGridSettingsCopyWith<$Res> implements $HomeMapGridSettingsCopyWith<$Res> {
  factory _$HomeMapGridSettingsCopyWith(_HomeMapGridSettings value, $Res Function(_HomeMapGridSettings) _then) = __$HomeMapGridSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$HomeMapGridSettingsCopyWithImpl<$Res>
    implements _$HomeMapGridSettingsCopyWith<$Res> {
  __$HomeMapGridSettingsCopyWithImpl(this._self, this._then);

  final _HomeMapGridSettings _self;
  final $Res Function(_HomeMapGridSettings) _then;

/// Create a copy of HomeMapGridSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_HomeMapGridSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
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
  return _then(HomeMapSettings(
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
  return _then(HomeCommonSettings(
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

 HomeEewSettings get eew; HomeKyoshinMonitorSettings get kyoshinMonitor; HomeMapSettings get map; HomeCommonSettings get common; HomeShakeDetectionSettings get shakeDetection; HomeMapGridSettings get mapGrid;
/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeConfigurationModelCopyWith<HomeConfigurationModel> get copyWith => _$HomeConfigurationModelCopyWithImpl<HomeConfigurationModel>(this as HomeConfigurationModel, _$identity);

  /// Serializes this HomeConfigurationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeConfigurationModel&&(identical(other.eew, eew) || other.eew == eew)&&(identical(other.kyoshinMonitor, kyoshinMonitor) || other.kyoshinMonitor == kyoshinMonitor)&&(identical(other.map, map) || other.map == map)&&(identical(other.common, common) || other.common == common)&&(identical(other.shakeDetection, shakeDetection) || other.shakeDetection == shakeDetection)&&(identical(other.mapGrid, mapGrid) || other.mapGrid == mapGrid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eew,kyoshinMonitor,map,common,shakeDetection,mapGrid);

@override
String toString() {
  return 'HomeConfigurationModel(eew: $eew, kyoshinMonitor: $kyoshinMonitor, map: $map, common: $common, shakeDetection: $shakeDetection, mapGrid: $mapGrid)';
}


}

/// @nodoc
abstract mixin class $HomeConfigurationModelCopyWith<$Res>  {
  factory $HomeConfigurationModelCopyWith(HomeConfigurationModel value, $Res Function(HomeConfigurationModel) _then) = _$HomeConfigurationModelCopyWithImpl;
@useResult
$Res call({
 HomeEewSettings eew, HomeKyoshinMonitorSettings kyoshinMonitor, HomeMapSettings map, HomeCommonSettings common, HomeShakeDetectionSettings shakeDetection, HomeMapGridSettings mapGrid
});


$HomeEewSettingsCopyWith<$Res> get eew;$HomeKyoshinMonitorSettingsCopyWith<$Res> get kyoshinMonitor;$HomeMapSettingsCopyWith<$Res> get map;$HomeCommonSettingsCopyWith<$Res> get common;$HomeShakeDetectionSettingsCopyWith<$Res> get shakeDetection;$HomeMapGridSettingsCopyWith<$Res> get mapGrid;

}
/// @nodoc
class _$HomeConfigurationModelCopyWithImpl<$Res>
    implements $HomeConfigurationModelCopyWith<$Res> {
  _$HomeConfigurationModelCopyWithImpl(this._self, this._then);

  final HomeConfigurationModel _self;
  final $Res Function(HomeConfigurationModel) _then;

/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eew = null,Object? kyoshinMonitor = null,Object? map = null,Object? common = null,Object? shakeDetection = null,Object? mapGrid = null,}) {
  return _then(HomeConfigurationModel(
eew: null == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as HomeEewSettings,kyoshinMonitor: null == kyoshinMonitor ? _self.kyoshinMonitor : kyoshinMonitor // ignore: cast_nullable_to_non_nullable
as HomeKyoshinMonitorSettings,map: null == map ? _self.map : map // ignore: cast_nullable_to_non_nullable
as HomeMapSettings,common: null == common ? _self.common : common // ignore: cast_nullable_to_non_nullable
as HomeCommonSettings,shakeDetection: null == shakeDetection ? _self.shakeDetection : shakeDetection // ignore: cast_nullable_to_non_nullable
as HomeShakeDetectionSettings,mapGrid: null == mapGrid ? _self.mapGrid : mapGrid // ignore: cast_nullable_to_non_nullable
as HomeMapGridSettings,
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
}/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeShakeDetectionSettingsCopyWith<$Res> get shakeDetection {
  
  return $HomeShakeDetectionSettingsCopyWith<$Res>(_self.shakeDetection, (value) {
    return _then(_self.copyWith(shakeDetection: value));
  });
}/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeMapGridSettingsCopyWith<$Res> get mapGrid {
  
  return $HomeMapGridSettingsCopyWith<$Res>(_self.mapGrid, (value) {
    return _then(_self.copyWith(mapGrid: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HomeEewSettings eew,  HomeKyoshinMonitorSettings kyoshinMonitor,  HomeMapSettings map,  HomeCommonSettings common,  HomeShakeDetectionSettings shakeDetection,  HomeMapGridSettings mapGrid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeConfigurationModel() when $default != null:
return $default(_that.eew,_that.kyoshinMonitor,_that.map,_that.common,_that.shakeDetection,_that.mapGrid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HomeEewSettings eew,  HomeKyoshinMonitorSettings kyoshinMonitor,  HomeMapSettings map,  HomeCommonSettings common,  HomeShakeDetectionSettings shakeDetection,  HomeMapGridSettings mapGrid)  $default,) {final _that = this;
switch (_that) {
case _HomeConfigurationModel():
return $default(_that.eew,_that.kyoshinMonitor,_that.map,_that.common,_that.shakeDetection,_that.mapGrid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HomeEewSettings eew,  HomeKyoshinMonitorSettings kyoshinMonitor,  HomeMapSettings map,  HomeCommonSettings common,  HomeShakeDetectionSettings shakeDetection,  HomeMapGridSettings mapGrid)?  $default,) {final _that = this;
switch (_that) {
case _HomeConfigurationModel() when $default != null:
return $default(_that.eew,_that.kyoshinMonitor,_that.map,_that.common,_that.shakeDetection,_that.mapGrid);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _HomeConfigurationModel implements HomeConfigurationModel {
  const _HomeConfigurationModel({this.eew = const HomeEewSettings(), this.kyoshinMonitor = const HomeKyoshinMonitorSettings(), this.map = const HomeMapSettings(), this.common = const HomeCommonSettings(), this.shakeDetection = const HomeShakeDetectionSettings(), this.mapGrid = const HomeMapGridSettings()});
  factory _HomeConfigurationModel.fromJson(Map<String, dynamic> json) => _$HomeConfigurationModelFromJson(json);

@override@JsonKey() final  HomeEewSettings eew;
@override@JsonKey() final  HomeKyoshinMonitorSettings kyoshinMonitor;
@override@JsonKey() final  HomeMapSettings map;
@override@JsonKey() final  HomeCommonSettings common;
@override@JsonKey() final  HomeShakeDetectionSettings shakeDetection;
@override@JsonKey() final  HomeMapGridSettings mapGrid;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeConfigurationModel&&(identical(other.eew, eew) || other.eew == eew)&&(identical(other.kyoshinMonitor, kyoshinMonitor) || other.kyoshinMonitor == kyoshinMonitor)&&(identical(other.map, map) || other.map == map)&&(identical(other.common, common) || other.common == common)&&(identical(other.shakeDetection, shakeDetection) || other.shakeDetection == shakeDetection)&&(identical(other.mapGrid, mapGrid) || other.mapGrid == mapGrid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eew,kyoshinMonitor,map,common,shakeDetection,mapGrid);

@override
String toString() {
  return 'HomeConfigurationModel(eew: $eew, kyoshinMonitor: $kyoshinMonitor, map: $map, common: $common, shakeDetection: $shakeDetection, mapGrid: $mapGrid)';
}


}

/// @nodoc
abstract mixin class _$HomeConfigurationModelCopyWith<$Res> implements $HomeConfigurationModelCopyWith<$Res> {
  factory _$HomeConfigurationModelCopyWith(_HomeConfigurationModel value, $Res Function(_HomeConfigurationModel) _then) = __$HomeConfigurationModelCopyWithImpl;
@override @useResult
$Res call({
 HomeEewSettings eew, HomeKyoshinMonitorSettings kyoshinMonitor, HomeMapSettings map, HomeCommonSettings common, HomeShakeDetectionSettings shakeDetection, HomeMapGridSettings mapGrid
});


@override $HomeEewSettingsCopyWith<$Res> get eew;@override $HomeKyoshinMonitorSettingsCopyWith<$Res> get kyoshinMonitor;@override $HomeMapSettingsCopyWith<$Res> get map;@override $HomeCommonSettingsCopyWith<$Res> get common;@override $HomeShakeDetectionSettingsCopyWith<$Res> get shakeDetection;@override $HomeMapGridSettingsCopyWith<$Res> get mapGrid;

}
/// @nodoc
class __$HomeConfigurationModelCopyWithImpl<$Res>
    implements _$HomeConfigurationModelCopyWith<$Res> {
  __$HomeConfigurationModelCopyWithImpl(this._self, this._then);

  final _HomeConfigurationModel _self;
  final $Res Function(_HomeConfigurationModel) _then;

/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eew = null,Object? kyoshinMonitor = null,Object? map = null,Object? common = null,Object? shakeDetection = null,Object? mapGrid = null,}) {
  return _then(_HomeConfigurationModel(
eew: null == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as HomeEewSettings,kyoshinMonitor: null == kyoshinMonitor ? _self.kyoshinMonitor : kyoshinMonitor // ignore: cast_nullable_to_non_nullable
as HomeKyoshinMonitorSettings,map: null == map ? _self.map : map // ignore: cast_nullable_to_non_nullable
as HomeMapSettings,common: null == common ? _self.common : common // ignore: cast_nullable_to_non_nullable
as HomeCommonSettings,shakeDetection: null == shakeDetection ? _self.shakeDetection : shakeDetection // ignore: cast_nullable_to_non_nullable
as HomeShakeDetectionSettings,mapGrid: null == mapGrid ? _self.mapGrid : mapGrid // ignore: cast_nullable_to_non_nullable
as HomeMapGridSettings,
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
}/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeShakeDetectionSettingsCopyWith<$Res> get shakeDetection {
  
  return $HomeShakeDetectionSettingsCopyWith<$Res>(_self.shakeDetection, (value) {
    return _then(_self.copyWith(shakeDetection: value));
  });
}/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeMapGridSettingsCopyWith<$Res> get mapGrid {
  
  return $HomeMapGridSettingsCopyWith<$Res>(_self.mapGrid, (value) {
    return _then(_self.copyWith(mapGrid: value));
  });
}
}

// dart format on
