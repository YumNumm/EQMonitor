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

 MapTheme get theme; String? get styleString;
/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapConfigurationCopyWith<MapConfiguration> get copyWith => _$MapConfigurationCopyWithImpl<MapConfiguration>(this as MapConfiguration, _$identity);

  /// Serializes this MapConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapConfiguration&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.styleString, styleString) || other.styleString == styleString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,styleString);

@override
String toString() {
  return 'MapConfiguration(theme: $theme, styleString: $styleString)';
}


}

/// @nodoc
abstract mixin class $MapConfigurationCopyWith<$Res>  {
  factory $MapConfigurationCopyWith(MapConfiguration value, $Res Function(MapConfiguration) _then) = _$MapConfigurationCopyWithImpl;
@useResult
$Res call({
 MapTheme theme, String? styleString
});




}
/// @nodoc
class _$MapConfigurationCopyWithImpl<$Res>
    implements $MapConfigurationCopyWith<$Res> {
  _$MapConfigurationCopyWithImpl(this._self, this._then);

  final MapConfiguration _self;
  final $Res Function(MapConfiguration) _then;

/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? styleString = freezed,}) {
  return _then(_self.copyWith(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as MapTheme,styleString: freezed == styleString ? _self.styleString : styleString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MapTheme theme,  String? styleString)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapConfiguration() when $default != null:
return $default(_that.theme,_that.styleString);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MapTheme theme,  String? styleString)  $default,) {final _that = this;
switch (_that) {
case _MapConfiguration():
return $default(_that.theme,_that.styleString);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MapTheme theme,  String? styleString)?  $default,) {final _that = this;
switch (_that) {
case _MapConfiguration() when $default != null:
return $default(_that.theme,_that.styleString);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MapConfiguration implements MapConfiguration {
  const _MapConfiguration({required this.theme, this.styleString});
  factory _MapConfiguration.fromJson(Map<String, dynamic> json) => _$MapConfigurationFromJson(json);

@override final  MapTheme theme;
@override final  String? styleString;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapConfiguration&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.styleString, styleString) || other.styleString == styleString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,styleString);

@override
String toString() {
  return 'MapConfiguration(theme: $theme, styleString: $styleString)';
}


}

/// @nodoc
abstract mixin class _$MapConfigurationCopyWith<$Res> implements $MapConfigurationCopyWith<$Res> {
  factory _$MapConfigurationCopyWith(_MapConfiguration value, $Res Function(_MapConfiguration) _then) = __$MapConfigurationCopyWithImpl;
@override @useResult
$Res call({
 MapTheme theme, String? styleString
});




}
/// @nodoc
class __$MapConfigurationCopyWithImpl<$Res>
    implements _$MapConfigurationCopyWith<$Res> {
  __$MapConfigurationCopyWithImpl(this._self, this._then);

  final _MapConfiguration _self;
  final $Res Function(_MapConfiguration) _then;

/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? styleString = freezed,}) {
  return _then(_MapConfiguration(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as MapTheme,styleString: freezed == styleString ? _self.styleString : styleString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
