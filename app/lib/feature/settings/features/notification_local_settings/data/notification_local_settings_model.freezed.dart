// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_local_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationLocalSettingsModel {

 EewSettings get eew; EarthquakeSettings get earthquake;
/// Create a copy of NotificationLocalSettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationLocalSettingsModelCopyWith<NotificationLocalSettingsModel> get copyWith => _$NotificationLocalSettingsModelCopyWithImpl<NotificationLocalSettingsModel>(this as NotificationLocalSettingsModel, _$identity);

  /// Serializes this NotificationLocalSettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationLocalSettingsModel&&(identical(other.eew, eew) || other.eew == eew)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eew,earthquake);

@override
String toString() {
  return 'NotificationLocalSettingsModel(eew: $eew, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $NotificationLocalSettingsModelCopyWith<$Res>  {
  factory $NotificationLocalSettingsModelCopyWith(NotificationLocalSettingsModel value, $Res Function(NotificationLocalSettingsModel) _then) = _$NotificationLocalSettingsModelCopyWithImpl;
@useResult
$Res call({
 EewSettings eew, EarthquakeSettings earthquake
});


$EewSettingsCopyWith<$Res> get eew;$EarthquakeSettingsCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$NotificationLocalSettingsModelCopyWithImpl<$Res>
    implements $NotificationLocalSettingsModelCopyWith<$Res> {
  _$NotificationLocalSettingsModelCopyWithImpl(this._self, this._then);

  final NotificationLocalSettingsModel _self;
  final $Res Function(NotificationLocalSettingsModel) _then;

/// Create a copy of NotificationLocalSettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eew = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eew: null == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as EewSettings,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakeSettings,
  ));
}
/// Create a copy of NotificationLocalSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewSettingsCopyWith<$Res> get eew {
  
  return $EewSettingsCopyWith<$Res>(_self.eew, (value) {
    return _then(_self.copyWith(eew: value));
  });
}/// Create a copy of NotificationLocalSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeSettingsCopyWith<$Res> get earthquake {
  
  return $EarthquakeSettingsCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationLocalSettingsModel].
extension NotificationLocalSettingsModelPatterns on NotificationLocalSettingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationLocalSettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationLocalSettingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationLocalSettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _NotificationLocalSettingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationLocalSettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationLocalSettingsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EewSettings eew,  EarthquakeSettings earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationLocalSettingsModel() when $default != null:
return $default(_that.eew,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EewSettings eew,  EarthquakeSettings earthquake)  $default,) {final _that = this;
switch (_that) {
case _NotificationLocalSettingsModel():
return $default(_that.eew,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EewSettings eew,  EarthquakeSettings earthquake)?  $default,) {final _that = this;
switch (_that) {
case _NotificationLocalSettingsModel() when $default != null:
return $default(_that.eew,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationLocalSettingsModel implements NotificationLocalSettingsModel {
  const _NotificationLocalSettingsModel({this.eew = const EewSettings(), this.earthquake = const EarthquakeSettings()});
  factory _NotificationLocalSettingsModel.fromJson(Map<String, dynamic> json) => _$NotificationLocalSettingsModelFromJson(json);

@override@JsonKey() final  EewSettings eew;
@override@JsonKey() final  EarthquakeSettings earthquake;

/// Create a copy of NotificationLocalSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationLocalSettingsModelCopyWith<_NotificationLocalSettingsModel> get copyWith => __$NotificationLocalSettingsModelCopyWithImpl<_NotificationLocalSettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationLocalSettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationLocalSettingsModel&&(identical(other.eew, eew) || other.eew == eew)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eew,earthquake);

@override
String toString() {
  return 'NotificationLocalSettingsModel(eew: $eew, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$NotificationLocalSettingsModelCopyWith<$Res> implements $NotificationLocalSettingsModelCopyWith<$Res> {
  factory _$NotificationLocalSettingsModelCopyWith(_NotificationLocalSettingsModel value, $Res Function(_NotificationLocalSettingsModel) _then) = __$NotificationLocalSettingsModelCopyWithImpl;
@override @useResult
$Res call({
 EewSettings eew, EarthquakeSettings earthquake
});


@override $EewSettingsCopyWith<$Res> get eew;@override $EarthquakeSettingsCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$NotificationLocalSettingsModelCopyWithImpl<$Res>
    implements _$NotificationLocalSettingsModelCopyWith<$Res> {
  __$NotificationLocalSettingsModelCopyWithImpl(this._self, this._then);

  final _NotificationLocalSettingsModel _self;
  final $Res Function(_NotificationLocalSettingsModel) _then;

/// Create a copy of NotificationLocalSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eew = null,Object? earthquake = null,}) {
  return _then(_NotificationLocalSettingsModel(
eew: null == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as EewSettings,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakeSettings,
  ));
}

/// Create a copy of NotificationLocalSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewSettingsCopyWith<$Res> get eew {
  
  return $EewSettingsCopyWith<$Res>(_self.eew, (value) {
    return _then(_self.copyWith(eew: value));
  });
}/// Create a copy of NotificationLocalSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeSettingsCopyWith<$Res> get earthquake {
  
  return $EarthquakeSettingsCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// @nodoc
mixin _$EewSettings {

@JmaIntensityJsonConverter() JmaIntensity? get emergencyIntensity;@JmaIntensityJsonConverter() JmaIntensity? get silentIntensity; List<Region> get regions;
/// Create a copy of EewSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewSettingsCopyWith<EewSettings> get copyWith => _$EewSettingsCopyWithImpl<EewSettings>(this as EewSettings, _$identity);

  /// Serializes this EewSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewSettings&&(identical(other.emergencyIntensity, emergencyIntensity) || other.emergencyIntensity == emergencyIntensity)&&(identical(other.silentIntensity, silentIntensity) || other.silentIntensity == silentIntensity)&&const DeepCollectionEquality().equals(other.regions, regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,emergencyIntensity,silentIntensity,const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'EewSettings(emergencyIntensity: $emergencyIntensity, silentIntensity: $silentIntensity, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $EewSettingsCopyWith<$Res>  {
  factory $EewSettingsCopyWith(EewSettings value, $Res Function(EewSettings) _then) = _$EewSettingsCopyWithImpl;
@useResult
$Res call({
@JmaIntensityJsonConverter() JmaIntensity? emergencyIntensity,@JmaIntensityJsonConverter() JmaIntensity? silentIntensity, List<Region> regions
});




}
/// @nodoc
class _$EewSettingsCopyWithImpl<$Res>
    implements $EewSettingsCopyWith<$Res> {
  _$EewSettingsCopyWithImpl(this._self, this._then);

  final EewSettings _self;
  final $Res Function(EewSettings) _then;

/// Create a copy of EewSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? emergencyIntensity = freezed,Object? silentIntensity = freezed,Object? regions = null,}) {
  return _then(_self.copyWith(
emergencyIntensity: freezed == emergencyIntensity ? _self.emergencyIntensity : emergencyIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,silentIntensity: freezed == silentIntensity ? _self.silentIntensity : silentIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>,
  ));
}

}


/// Adds pattern-matching-related methods to [EewSettings].
extension EewSettingsPatterns on EewSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewSettings value)  $default,){
final _that = this;
switch (_that) {
case _EewSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewSettings value)?  $default,){
final _that = this;
switch (_that) {
case _EewSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JmaIntensityJsonConverter()  JmaIntensity? emergencyIntensity, @JmaIntensityJsonConverter()  JmaIntensity? silentIntensity,  List<Region> regions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewSettings() when $default != null:
return $default(_that.emergencyIntensity,_that.silentIntensity,_that.regions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JmaIntensityJsonConverter()  JmaIntensity? emergencyIntensity, @JmaIntensityJsonConverter()  JmaIntensity? silentIntensity,  List<Region> regions)  $default,) {final _that = this;
switch (_that) {
case _EewSettings():
return $default(_that.emergencyIntensity,_that.silentIntensity,_that.regions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JmaIntensityJsonConverter()  JmaIntensity? emergencyIntensity, @JmaIntensityJsonConverter()  JmaIntensity? silentIntensity,  List<Region> regions)?  $default,) {final _that = this;
switch (_that) {
case _EewSettings() when $default != null:
return $default(_that.emergencyIntensity,_that.silentIntensity,_that.regions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewSettings implements EewSettings {
  const _EewSettings({@JmaIntensityJsonConverter() this.emergencyIntensity = null, @JmaIntensityJsonConverter() this.silentIntensity = null, final  List<Region> regions = const []}): _regions = regions;
  factory _EewSettings.fromJson(Map<String, dynamic> json) => _$EewSettingsFromJson(json);

@override@JsonKey()@JmaIntensityJsonConverter() final  JmaIntensity? emergencyIntensity;
@override@JsonKey()@JmaIntensityJsonConverter() final  JmaIntensity? silentIntensity;
 final  List<Region> _regions;
@override@JsonKey() List<Region> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of EewSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewSettingsCopyWith<_EewSettings> get copyWith => __$EewSettingsCopyWithImpl<_EewSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewSettings&&(identical(other.emergencyIntensity, emergencyIntensity) || other.emergencyIntensity == emergencyIntensity)&&(identical(other.silentIntensity, silentIntensity) || other.silentIntensity == silentIntensity)&&const DeepCollectionEquality().equals(other._regions, _regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,emergencyIntensity,silentIntensity,const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'EewSettings(emergencyIntensity: $emergencyIntensity, silentIntensity: $silentIntensity, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$EewSettingsCopyWith<$Res> implements $EewSettingsCopyWith<$Res> {
  factory _$EewSettingsCopyWith(_EewSettings value, $Res Function(_EewSettings) _then) = __$EewSettingsCopyWithImpl;
@override @useResult
$Res call({
@JmaIntensityJsonConverter() JmaIntensity? emergencyIntensity,@JmaIntensityJsonConverter() JmaIntensity? silentIntensity, List<Region> regions
});




}
/// @nodoc
class __$EewSettingsCopyWithImpl<$Res>
    implements _$EewSettingsCopyWith<$Res> {
  __$EewSettingsCopyWithImpl(this._self, this._then);

  final _EewSettings _self;
  final $Res Function(_EewSettings) _then;

/// Create a copy of EewSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? emergencyIntensity = freezed,Object? silentIntensity = freezed,Object? regions = null,}) {
  return _then(_EewSettings(
emergencyIntensity: freezed == emergencyIntensity ? _self.emergencyIntensity : emergencyIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,silentIntensity: freezed == silentIntensity ? _self.silentIntensity : silentIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>,
  ));
}


}


/// @nodoc
mixin _$EarthquakeSettings {

@JmaIntensityJsonConverter() JmaIntensity? get emergencyIntensity;@JmaIntensityJsonConverter() JmaIntensity? get silentIntensity; List<Region> get regions;
/// Create a copy of EarthquakeSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeSettingsCopyWith<EarthquakeSettings> get copyWith => _$EarthquakeSettingsCopyWithImpl<EarthquakeSettings>(this as EarthquakeSettings, _$identity);

  /// Serializes this EarthquakeSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeSettings&&(identical(other.emergencyIntensity, emergencyIntensity) || other.emergencyIntensity == emergencyIntensity)&&(identical(other.silentIntensity, silentIntensity) || other.silentIntensity == silentIntensity)&&const DeepCollectionEquality().equals(other.regions, regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,emergencyIntensity,silentIntensity,const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'EarthquakeSettings(emergencyIntensity: $emergencyIntensity, silentIntensity: $silentIntensity, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $EarthquakeSettingsCopyWith<$Res>  {
  factory $EarthquakeSettingsCopyWith(EarthquakeSettings value, $Res Function(EarthquakeSettings) _then) = _$EarthquakeSettingsCopyWithImpl;
@useResult
$Res call({
@JmaIntensityJsonConverter() JmaIntensity? emergencyIntensity,@JmaIntensityJsonConverter() JmaIntensity? silentIntensity, List<Region> regions
});




}
/// @nodoc
class _$EarthquakeSettingsCopyWithImpl<$Res>
    implements $EarthquakeSettingsCopyWith<$Res> {
  _$EarthquakeSettingsCopyWithImpl(this._self, this._then);

  final EarthquakeSettings _self;
  final $Res Function(EarthquakeSettings) _then;

/// Create a copy of EarthquakeSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? emergencyIntensity = freezed,Object? silentIntensity = freezed,Object? regions = null,}) {
  return _then(_self.copyWith(
emergencyIntensity: freezed == emergencyIntensity ? _self.emergencyIntensity : emergencyIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,silentIntensity: freezed == silentIntensity ? _self.silentIntensity : silentIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeSettings].
extension EarthquakeSettingsPatterns on EarthquakeSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeSettings value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeSettings value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JmaIntensityJsonConverter()  JmaIntensity? emergencyIntensity, @JmaIntensityJsonConverter()  JmaIntensity? silentIntensity,  List<Region> regions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeSettings() when $default != null:
return $default(_that.emergencyIntensity,_that.silentIntensity,_that.regions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JmaIntensityJsonConverter()  JmaIntensity? emergencyIntensity, @JmaIntensityJsonConverter()  JmaIntensity? silentIntensity,  List<Region> regions)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeSettings():
return $default(_that.emergencyIntensity,_that.silentIntensity,_that.regions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JmaIntensityJsonConverter()  JmaIntensity? emergencyIntensity, @JmaIntensityJsonConverter()  JmaIntensity? silentIntensity,  List<Region> regions)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeSettings() when $default != null:
return $default(_that.emergencyIntensity,_that.silentIntensity,_that.regions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeSettings implements EarthquakeSettings {
  const _EarthquakeSettings({@JmaIntensityJsonConverter() this.emergencyIntensity = null, @JmaIntensityJsonConverter() this.silentIntensity = null, final  List<Region> regions = const []}): _regions = regions;
  factory _EarthquakeSettings.fromJson(Map<String, dynamic> json) => _$EarthquakeSettingsFromJson(json);

@override@JsonKey()@JmaIntensityJsonConverter() final  JmaIntensity? emergencyIntensity;
@override@JsonKey()@JmaIntensityJsonConverter() final  JmaIntensity? silentIntensity;
 final  List<Region> _regions;
@override@JsonKey() List<Region> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of EarthquakeSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeSettingsCopyWith<_EarthquakeSettings> get copyWith => __$EarthquakeSettingsCopyWithImpl<_EarthquakeSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeSettings&&(identical(other.emergencyIntensity, emergencyIntensity) || other.emergencyIntensity == emergencyIntensity)&&(identical(other.silentIntensity, silentIntensity) || other.silentIntensity == silentIntensity)&&const DeepCollectionEquality().equals(other._regions, _regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,emergencyIntensity,silentIntensity,const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'EarthquakeSettings(emergencyIntensity: $emergencyIntensity, silentIntensity: $silentIntensity, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeSettingsCopyWith<$Res> implements $EarthquakeSettingsCopyWith<$Res> {
  factory _$EarthquakeSettingsCopyWith(_EarthquakeSettings value, $Res Function(_EarthquakeSettings) _then) = __$EarthquakeSettingsCopyWithImpl;
@override @useResult
$Res call({
@JmaIntensityJsonConverter() JmaIntensity? emergencyIntensity,@JmaIntensityJsonConverter() JmaIntensity? silentIntensity, List<Region> regions
});




}
/// @nodoc
class __$EarthquakeSettingsCopyWithImpl<$Res>
    implements _$EarthquakeSettingsCopyWith<$Res> {
  __$EarthquakeSettingsCopyWithImpl(this._self, this._then);

  final _EarthquakeSettings _self;
  final $Res Function(_EarthquakeSettings) _then;

/// Create a copy of EarthquakeSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? emergencyIntensity = freezed,Object? silentIntensity = freezed,Object? regions = null,}) {
  return _then(_EarthquakeSettings(
emergencyIntensity: freezed == emergencyIntensity ? _self.emergencyIntensity : emergencyIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,silentIntensity: freezed == silentIntensity ? _self.silentIntensity : silentIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>,
  ));
}


}


/// @nodoc
mixin _$Region {

 String get code; String get name;@JmaIntensityJsonConverter() JmaIntensity get emergencyIntensity;@JmaIntensityJsonConverter() JmaIntensity get silentIntensity; bool get isMain;
/// Create a copy of Region
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionCopyWith<Region> get copyWith => _$RegionCopyWithImpl<Region>(this as Region, _$identity);

  /// Serializes this Region to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Region&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.emergencyIntensity, emergencyIntensity) || other.emergencyIntensity == emergencyIntensity)&&(identical(other.silentIntensity, silentIntensity) || other.silentIntensity == silentIntensity)&&(identical(other.isMain, isMain) || other.isMain == isMain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,emergencyIntensity,silentIntensity,isMain);

@override
String toString() {
  return 'Region(code: $code, name: $name, emergencyIntensity: $emergencyIntensity, silentIntensity: $silentIntensity, isMain: $isMain)';
}


}

/// @nodoc
abstract mixin class $RegionCopyWith<$Res>  {
  factory $RegionCopyWith(Region value, $Res Function(Region) _then) = _$RegionCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JmaIntensityJsonConverter() JmaIntensity emergencyIntensity,@JmaIntensityJsonConverter() JmaIntensity silentIntensity, bool isMain
});




}
/// @nodoc
class _$RegionCopyWithImpl<$Res>
    implements $RegionCopyWith<$Res> {
  _$RegionCopyWithImpl(this._self, this._then);

  final Region _self;
  final $Res Function(Region) _then;

/// Create a copy of Region
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? emergencyIntensity = null,Object? silentIntensity = null,Object? isMain = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emergencyIntensity: null == emergencyIntensity ? _self.emergencyIntensity : emergencyIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,silentIntensity: null == silentIntensity ? _self.silentIntensity : silentIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,isMain: null == isMain ? _self.isMain : isMain // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Region].
extension RegionPatterns on Region {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Region value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Region() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Region value)  $default,){
final _that = this;
switch (_that) {
case _Region():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Region value)?  $default,){
final _that = this;
switch (_that) {
case _Region() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name, @JmaIntensityJsonConverter()  JmaIntensity emergencyIntensity, @JmaIntensityJsonConverter()  JmaIntensity silentIntensity,  bool isMain)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Region() when $default != null:
return $default(_that.code,_that.name,_that.emergencyIntensity,_that.silentIntensity,_that.isMain);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name, @JmaIntensityJsonConverter()  JmaIntensity emergencyIntensity, @JmaIntensityJsonConverter()  JmaIntensity silentIntensity,  bool isMain)  $default,) {final _that = this;
switch (_that) {
case _Region():
return $default(_that.code,_that.name,_that.emergencyIntensity,_that.silentIntensity,_that.isMain);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name, @JmaIntensityJsonConverter()  JmaIntensity emergencyIntensity, @JmaIntensityJsonConverter()  JmaIntensity silentIntensity,  bool isMain)?  $default,) {final _that = this;
switch (_that) {
case _Region() when $default != null:
return $default(_that.code,_that.name,_that.emergencyIntensity,_that.silentIntensity,_that.isMain);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Region implements Region {
  const _Region({required this.code, required this.name, @JmaIntensityJsonConverter() required this.emergencyIntensity, @JmaIntensityJsonConverter() required this.silentIntensity, required this.isMain});
  factory _Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

@override final  String code;
@override final  String name;
@override@JmaIntensityJsonConverter() final  JmaIntensity emergencyIntensity;
@override@JmaIntensityJsonConverter() final  JmaIntensity silentIntensity;
@override final  bool isMain;

/// Create a copy of Region
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionCopyWith<_Region> get copyWith => __$RegionCopyWithImpl<_Region>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Region&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.emergencyIntensity, emergencyIntensity) || other.emergencyIntensity == emergencyIntensity)&&(identical(other.silentIntensity, silentIntensity) || other.silentIntensity == silentIntensity)&&(identical(other.isMain, isMain) || other.isMain == isMain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,emergencyIntensity,silentIntensity,isMain);

@override
String toString() {
  return 'Region(code: $code, name: $name, emergencyIntensity: $emergencyIntensity, silentIntensity: $silentIntensity, isMain: $isMain)';
}


}

/// @nodoc
abstract mixin class _$RegionCopyWith<$Res> implements $RegionCopyWith<$Res> {
  factory _$RegionCopyWith(_Region value, $Res Function(_Region) _then) = __$RegionCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JmaIntensityJsonConverter() JmaIntensity emergencyIntensity,@JmaIntensityJsonConverter() JmaIntensity silentIntensity, bool isMain
});




}
/// @nodoc
class __$RegionCopyWithImpl<$Res>
    implements _$RegionCopyWith<$Res> {
  __$RegionCopyWithImpl(this._self, this._then);

  final _Region _self;
  final $Res Function(_Region) _then;

/// Create a copy of Region
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? emergencyIntensity = null,Object? silentIntensity = null,Object? isMain = null,}) {
  return _then(_Region(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emergencyIntensity: null == emergencyIntensity ? _self.emergencyIntensity : emergencyIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,silentIntensity: null == silentIntensity ? _self.silentIntensity : silentIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,isMain: null == isMain ? _self.isMain : isMain // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
