// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapConfiguration {

 MapTheme get theme;@JsonKey(includeToJson: false, includeFromJson: false) MapColorScheme? get colorScheme;@JsonKey(includeToJson: false, includeFromJson: false) String? get styleString;
/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapConfigurationCopyWith<MapConfiguration> get copyWith => _$MapConfigurationCopyWithImpl<MapConfiguration>(this as MapConfiguration, _$identity);

  /// Serializes this MapConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapConfiguration&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.colorScheme, colorScheme) || other.colorScheme == colorScheme)&&(identical(other.styleString, styleString) || other.styleString == styleString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,colorScheme,styleString);

@override
String toString() {
  return 'MapConfiguration(theme: $theme, colorScheme: $colorScheme, styleString: $styleString)';
}


}

/// @nodoc
abstract mixin class $MapConfigurationCopyWith<$Res>  {
  factory $MapConfigurationCopyWith(MapConfiguration value, $Res Function(MapConfiguration) _then) = _$MapConfigurationCopyWithImpl;
@useResult
$Res call({
 MapTheme theme,@JsonKey(includeToJson: false, includeFromJson: false) MapColorScheme? colorScheme,@JsonKey(includeToJson: false, includeFromJson: false) String? styleString
});


$MapColorSchemeCopyWith<$Res>? get colorScheme;

}
/// @nodoc
class _$MapConfigurationCopyWithImpl<$Res>
    implements $MapConfigurationCopyWith<$Res> {
  _$MapConfigurationCopyWithImpl(this._self, this._then);

  final MapConfiguration _self;
  final $Res Function(MapConfiguration) _then;

/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? colorScheme = freezed,Object? styleString = freezed,}) {
  return _then(_self.copyWith(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as MapTheme,colorScheme: freezed == colorScheme ? _self.colorScheme : colorScheme // ignore: cast_nullable_to_non_nullable
as MapColorScheme?,styleString: freezed == styleString ? _self.styleString : styleString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapColorSchemeCopyWith<$Res>? get colorScheme {
    if (_self.colorScheme == null) {
    return null;
  }

  return $MapColorSchemeCopyWith<$Res>(_self.colorScheme!, (value) {
    return _then(_self.copyWith(colorScheme: value));
  });
}
}


/// Adds pattern-matching-related methods to [MapConfiguration].
extension MapConfigurationPatterns on MapConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _MapConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _MapConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MapTheme theme, @JsonKey(includeToJson: false, includeFromJson: false)  MapColorScheme? colorScheme, @JsonKey(includeToJson: false, includeFromJson: false)  String? styleString)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapConfiguration() when $default != null:
return $default(_that.theme,_that.colorScheme,_that.styleString);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MapTheme theme, @JsonKey(includeToJson: false, includeFromJson: false)  MapColorScheme? colorScheme, @JsonKey(includeToJson: false, includeFromJson: false)  String? styleString)  $default,) {final _that = this;
switch (_that) {
case _MapConfiguration():
return $default(_that.theme,_that.colorScheme,_that.styleString);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MapTheme theme, @JsonKey(includeToJson: false, includeFromJson: false)  MapColorScheme? colorScheme, @JsonKey(includeToJson: false, includeFromJson: false)  String? styleString)?  $default,) {final _that = this;
switch (_that) {
case _MapConfiguration() when $default != null:
return $default(_that.theme,_that.colorScheme,_that.styleString);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MapConfiguration implements MapConfiguration {
  const _MapConfiguration({required this.theme, @JsonKey(includeToJson: false, includeFromJson: false) this.colorScheme, @JsonKey(includeToJson: false, includeFromJson: false) this.styleString});
  factory _MapConfiguration.fromJson(Map<String, dynamic> json) => _$MapConfigurationFromJson(json);

@override final  MapTheme theme;
@override@JsonKey(includeToJson: false, includeFromJson: false) final  MapColorScheme? colorScheme;
@override@JsonKey(includeToJson: false, includeFromJson: false) final  String? styleString;

/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapConfigurationCopyWith<_MapConfiguration> get copyWith => __$MapConfigurationCopyWithImpl<_MapConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapConfiguration&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.colorScheme, colorScheme) || other.colorScheme == colorScheme)&&(identical(other.styleString, styleString) || other.styleString == styleString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,colorScheme,styleString);

@override
String toString() {
  return 'MapConfiguration(theme: $theme, colorScheme: $colorScheme, styleString: $styleString)';
}


}

/// @nodoc
abstract mixin class _$MapConfigurationCopyWith<$Res> implements $MapConfigurationCopyWith<$Res> {
  factory _$MapConfigurationCopyWith(_MapConfiguration value, $Res Function(_MapConfiguration) _then) = __$MapConfigurationCopyWithImpl;
@override @useResult
$Res call({
 MapTheme theme,@JsonKey(includeToJson: false, includeFromJson: false) MapColorScheme? colorScheme,@JsonKey(includeToJson: false, includeFromJson: false) String? styleString
});


@override $MapColorSchemeCopyWith<$Res>? get colorScheme;

}
/// @nodoc
class __$MapConfigurationCopyWithImpl<$Res>
    implements _$MapConfigurationCopyWith<$Res> {
  __$MapConfigurationCopyWithImpl(this._self, this._then);

  final _MapConfiguration _self;
  final $Res Function(_MapConfiguration) _then;

/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? colorScheme = freezed,Object? styleString = freezed,}) {
  return _then(_MapConfiguration(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as MapTheme,colorScheme: freezed == colorScheme ? _self.colorScheme : colorScheme // ignore: cast_nullable_to_non_nullable
as MapColorScheme?,styleString: freezed == styleString ? _self.styleString : styleString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapColorSchemeCopyWith<$Res>? get colorScheme {
    if (_self.colorScheme == null) {
    return null;
  }

  return $MapColorSchemeCopyWith<$Res>(_self.colorScheme!, (value) {
    return _then(_self.copyWith(colorScheme: value));
  });
}
}


/// @nodoc
mixin _$MapColorScheme {

@ColorJsonConverter() Color get backgroundColor;@ColorJsonConverter() Color get worldLandColor;@ColorJsonConverter() Color get worldLineColor;@ColorJsonConverter() Color get japanLandColor;@ColorJsonConverter() Color get japanLineColor;
/// Create a copy of MapColorScheme
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapColorSchemeCopyWith<MapColorScheme> get copyWith => _$MapColorSchemeCopyWithImpl<MapColorScheme>(this as MapColorScheme, _$identity);

  /// Serializes this MapColorScheme to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapColorScheme&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.worldLandColor, worldLandColor) || other.worldLandColor == worldLandColor)&&(identical(other.worldLineColor, worldLineColor) || other.worldLineColor == worldLineColor)&&(identical(other.japanLandColor, japanLandColor) || other.japanLandColor == japanLandColor)&&(identical(other.japanLineColor, japanLineColor) || other.japanLineColor == japanLineColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,worldLandColor,worldLineColor,japanLandColor,japanLineColor);

@override
String toString() {
  return 'MapColorScheme(backgroundColor: $backgroundColor, worldLandColor: $worldLandColor, worldLineColor: $worldLineColor, japanLandColor: $japanLandColor, japanLineColor: $japanLineColor)';
}


}

/// @nodoc
abstract mixin class $MapColorSchemeCopyWith<$Res>  {
  factory $MapColorSchemeCopyWith(MapColorScheme value, $Res Function(MapColorScheme) _then) = _$MapColorSchemeCopyWithImpl;
@useResult
$Res call({
@ColorJsonConverter() Color backgroundColor,@ColorJsonConverter() Color worldLandColor,@ColorJsonConverter() Color worldLineColor,@ColorJsonConverter() Color japanLandColor,@ColorJsonConverter() Color japanLineColor
});




}
/// @nodoc
class _$MapColorSchemeCopyWithImpl<$Res>
    implements $MapColorSchemeCopyWith<$Res> {
  _$MapColorSchemeCopyWithImpl(this._self, this._then);

  final MapColorScheme _self;
  final $Res Function(MapColorScheme) _then;

/// Create a copy of MapColorScheme
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgroundColor = null,Object? worldLandColor = null,Object? worldLineColor = null,Object? japanLandColor = null,Object? japanLineColor = null,}) {
  return _then(_self.copyWith(
backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as Color,worldLandColor: null == worldLandColor ? _self.worldLandColor : worldLandColor // ignore: cast_nullable_to_non_nullable
as Color,worldLineColor: null == worldLineColor ? _self.worldLineColor : worldLineColor // ignore: cast_nullable_to_non_nullable
as Color,japanLandColor: null == japanLandColor ? _self.japanLandColor : japanLandColor // ignore: cast_nullable_to_non_nullable
as Color,japanLineColor: null == japanLineColor ? _self.japanLineColor : japanLineColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [MapColorScheme].
extension MapColorSchemePatterns on MapColorScheme {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapColorScheme value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapColorScheme() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapColorScheme value)  $default,){
final _that = this;
switch (_that) {
case _MapColorScheme():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapColorScheme value)?  $default,){
final _that = this;
switch (_that) {
case _MapColorScheme() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@ColorJsonConverter()  Color backgroundColor, @ColorJsonConverter()  Color worldLandColor, @ColorJsonConverter()  Color worldLineColor, @ColorJsonConverter()  Color japanLandColor, @ColorJsonConverter()  Color japanLineColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapColorScheme() when $default != null:
return $default(_that.backgroundColor,_that.worldLandColor,_that.worldLineColor,_that.japanLandColor,_that.japanLineColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@ColorJsonConverter()  Color backgroundColor, @ColorJsonConverter()  Color worldLandColor, @ColorJsonConverter()  Color worldLineColor, @ColorJsonConverter()  Color japanLandColor, @ColorJsonConverter()  Color japanLineColor)  $default,) {final _that = this;
switch (_that) {
case _MapColorScheme():
return $default(_that.backgroundColor,_that.worldLandColor,_that.worldLineColor,_that.japanLandColor,_that.japanLineColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@ColorJsonConverter()  Color backgroundColor, @ColorJsonConverter()  Color worldLandColor, @ColorJsonConverter()  Color worldLineColor, @ColorJsonConverter()  Color japanLandColor, @ColorJsonConverter()  Color japanLineColor)?  $default,) {final _that = this;
switch (_that) {
case _MapColorScheme() when $default != null:
return $default(_that.backgroundColor,_that.worldLandColor,_that.worldLineColor,_that.japanLandColor,_that.japanLineColor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MapColorScheme implements MapColorScheme {
  const _MapColorScheme({@ColorJsonConverter() required this.backgroundColor, @ColorJsonConverter() required this.worldLandColor, @ColorJsonConverter() required this.worldLineColor, @ColorJsonConverter() required this.japanLandColor, @ColorJsonConverter() required this.japanLineColor});
  factory _MapColorScheme.fromJson(Map<String, dynamic> json) => _$MapColorSchemeFromJson(json);

@override@ColorJsonConverter() final  Color backgroundColor;
@override@ColorJsonConverter() final  Color worldLandColor;
@override@ColorJsonConverter() final  Color worldLineColor;
@override@ColorJsonConverter() final  Color japanLandColor;
@override@ColorJsonConverter() final  Color japanLineColor;

/// Create a copy of MapColorScheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapColorSchemeCopyWith<_MapColorScheme> get copyWith => __$MapColorSchemeCopyWithImpl<_MapColorScheme>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapColorSchemeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapColorScheme&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.worldLandColor, worldLandColor) || other.worldLandColor == worldLandColor)&&(identical(other.worldLineColor, worldLineColor) || other.worldLineColor == worldLineColor)&&(identical(other.japanLandColor, japanLandColor) || other.japanLandColor == japanLandColor)&&(identical(other.japanLineColor, japanLineColor) || other.japanLineColor == japanLineColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,worldLandColor,worldLineColor,japanLandColor,japanLineColor);

@override
String toString() {
  return 'MapColorScheme(backgroundColor: $backgroundColor, worldLandColor: $worldLandColor, worldLineColor: $worldLineColor, japanLandColor: $japanLandColor, japanLineColor: $japanLineColor)';
}


}

/// @nodoc
abstract mixin class _$MapColorSchemeCopyWith<$Res> implements $MapColorSchemeCopyWith<$Res> {
  factory _$MapColorSchemeCopyWith(_MapColorScheme value, $Res Function(_MapColorScheme) _then) = __$MapColorSchemeCopyWithImpl;
@override @useResult
$Res call({
@ColorJsonConverter() Color backgroundColor,@ColorJsonConverter() Color worldLandColor,@ColorJsonConverter() Color worldLineColor,@ColorJsonConverter() Color japanLandColor,@ColorJsonConverter() Color japanLineColor
});




}
/// @nodoc
class __$MapColorSchemeCopyWithImpl<$Res>
    implements _$MapColorSchemeCopyWith<$Res> {
  __$MapColorSchemeCopyWithImpl(this._self, this._then);

  final _MapColorScheme _self;
  final $Res Function(_MapColorScheme) _then;

/// Create a copy of MapColorScheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? backgroundColor = null,Object? worldLandColor = null,Object? worldLineColor = null,Object? japanLandColor = null,Object? japanLineColor = null,}) {
  return _then(_MapColorScheme(
backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as Color,worldLandColor: null == worldLandColor ? _self.worldLandColor : worldLandColor // ignore: cast_nullable_to_non_nullable
as Color,worldLineColor: null == worldLineColor ? _self.worldLineColor : worldLineColor // ignore: cast_nullable_to_non_nullable
as Color,japanLandColor: null == japanLandColor ? _self.japanLandColor : japanLandColor // ignore: cast_nullable_to_non_nullable
as Color,japanLineColor: null == japanLineColor ? _self.japanLineColor : japanLineColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
