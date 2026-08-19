// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_colors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapColors {

@ColorJsonConverter() Color get background;@ColorJsonConverter() Color get worldLand;@ColorJsonConverter() Color get worldLine;@ColorJsonConverter() Color get japanLand;@ColorJsonConverter() Color get japanLine;
/// Create a copy of MapColors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapColorsCopyWith<MapColors> get copyWith => _$MapColorsCopyWithImpl<MapColors>(this as MapColors, _$identity);

  /// Serializes this MapColors to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapColors&&(identical(other.background, background) || other.background == background)&&(identical(other.worldLand, worldLand) || other.worldLand == worldLand)&&(identical(other.worldLine, worldLine) || other.worldLine == worldLine)&&(identical(other.japanLand, japanLand) || other.japanLand == japanLand)&&(identical(other.japanLine, japanLine) || other.japanLine == japanLine));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,background,worldLand,worldLine,japanLand,japanLine);

@override
String toString() {
  return 'MapColors(background: $background, worldLand: $worldLand, worldLine: $worldLine, japanLand: $japanLand, japanLine: $japanLine)';
}


}

/// @nodoc
abstract mixin class $MapColorsCopyWith<$Res>  {
  factory $MapColorsCopyWith(MapColors value, $Res Function(MapColors) _then) = _$MapColorsCopyWithImpl;
@useResult
$Res call({
@ColorJsonConverter() Color background,@ColorJsonConverter() Color worldLand,@ColorJsonConverter() Color worldLine,@ColorJsonConverter() Color japanLand,@ColorJsonConverter() Color japanLine
});




}
/// @nodoc
class _$MapColorsCopyWithImpl<$Res>
    implements $MapColorsCopyWith<$Res> {
  _$MapColorsCopyWithImpl(this._self, this._then);

  final MapColors _self;
  final $Res Function(MapColors) _then;

/// Create a copy of MapColors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? background = null,Object? worldLand = null,Object? worldLine = null,Object? japanLand = null,Object? japanLine = null,}) {
  return _then(MapColors(
background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as Color,worldLand: null == worldLand ? _self.worldLand : worldLand // ignore: cast_nullable_to_non_nullable
as Color,worldLine: null == worldLine ? _self.worldLine : worldLine // ignore: cast_nullable_to_non_nullable
as Color,japanLand: null == japanLand ? _self.japanLand : japanLand // ignore: cast_nullable_to_non_nullable
as Color,japanLine: null == japanLine ? _self.japanLine : japanLine // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [MapColors].
extension MapColorsPatterns on MapColors {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapColors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapColors() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapColors value)  $default,){
final _that = this;
switch (_that) {
case _MapColors():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapColors value)?  $default,){
final _that = this;
switch (_that) {
case _MapColors() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@ColorJsonConverter()  Color background, @ColorJsonConverter()  Color worldLand, @ColorJsonConverter()  Color worldLine, @ColorJsonConverter()  Color japanLand, @ColorJsonConverter()  Color japanLine)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapColors() when $default != null:
return $default(_that.background,_that.worldLand,_that.worldLine,_that.japanLand,_that.japanLine);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@ColorJsonConverter()  Color background, @ColorJsonConverter()  Color worldLand, @ColorJsonConverter()  Color worldLine, @ColorJsonConverter()  Color japanLand, @ColorJsonConverter()  Color japanLine)  $default,) {final _that = this;
switch (_that) {
case _MapColors():
return $default(_that.background,_that.worldLand,_that.worldLine,_that.japanLand,_that.japanLine);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@ColorJsonConverter()  Color background, @ColorJsonConverter()  Color worldLand, @ColorJsonConverter()  Color worldLine, @ColorJsonConverter()  Color japanLand, @ColorJsonConverter()  Color japanLine)?  $default,) {final _that = this;
switch (_that) {
case _MapColors() when $default != null:
return $default(_that.background,_that.worldLand,_that.worldLine,_that.japanLand,_that.japanLine);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MapColors implements MapColors {
  const _MapColors({@ColorJsonConverter() required this.background, @ColorJsonConverter() required this.worldLand, @ColorJsonConverter() required this.worldLine, @ColorJsonConverter() required this.japanLand, @ColorJsonConverter() required this.japanLine});
  factory _MapColors.fromJson(Map<String, dynamic> json) => _$MapColorsFromJson(json);

@override@ColorJsonConverter() final  Color background;
@override@ColorJsonConverter() final  Color worldLand;
@override@ColorJsonConverter() final  Color worldLine;
@override@ColorJsonConverter() final  Color japanLand;
@override@ColorJsonConverter() final  Color japanLine;

/// Create a copy of MapColors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapColorsCopyWith<_MapColors> get copyWith => __$MapColorsCopyWithImpl<_MapColors>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapColorsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapColors&&(identical(other.background, background) || other.background == background)&&(identical(other.worldLand, worldLand) || other.worldLand == worldLand)&&(identical(other.worldLine, worldLine) || other.worldLine == worldLine)&&(identical(other.japanLand, japanLand) || other.japanLand == japanLand)&&(identical(other.japanLine, japanLine) || other.japanLine == japanLine));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,background,worldLand,worldLine,japanLand,japanLine);

@override
String toString() {
  return 'MapColors(background: $background, worldLand: $worldLand, worldLine: $worldLine, japanLand: $japanLand, japanLine: $japanLine)';
}


}

/// @nodoc
abstract mixin class _$MapColorsCopyWith<$Res> implements $MapColorsCopyWith<$Res> {
  factory _$MapColorsCopyWith(_MapColors value, $Res Function(_MapColors) _then) = __$MapColorsCopyWithImpl;
@override @useResult
$Res call({
@ColorJsonConverter() Color background,@ColorJsonConverter() Color worldLand,@ColorJsonConverter() Color worldLine,@ColorJsonConverter() Color japanLand,@ColorJsonConverter() Color japanLine
});




}
/// @nodoc
class __$MapColorsCopyWithImpl<$Res>
    implements _$MapColorsCopyWith<$Res> {
  __$MapColorsCopyWithImpl(this._self, this._then);

  final _MapColors _self;
  final $Res Function(_MapColors) _then;

/// Create a copy of MapColors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? background = null,Object? worldLand = null,Object? worldLine = null,Object? japanLand = null,Object? japanLine = null,}) {
  return _then(_MapColors(
background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as Color,worldLand: null == worldLand ? _self.worldLand : worldLand // ignore: cast_nullable_to_non_nullable
as Color,worldLine: null == worldLine ? _self.worldLine : worldLine // ignore: cast_nullable_to_non_nullable
as Color,japanLand: null == japanLand ? _self.japanLand : japanLand // ignore: cast_nullable_to_non_nullable
as Color,japanLine: null == japanLine ? _self.japanLine : japanLine // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
