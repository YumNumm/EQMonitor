// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_location_intensity_display.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrentLocationIntensityDisplay {

 JmaIntensity get intensity;/// 市区町村ポリゴン（areaInformationCity）に一致するデータか。
/// false のときは細分区域（areaForecastLocalE）フォールバック。
 bool get usedCityLevelData;
/// Create a copy of CurrentLocationIntensityDisplay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentLocationIntensityDisplayCopyWith<CurrentLocationIntensityDisplay> get copyWith => _$CurrentLocationIntensityDisplayCopyWithImpl<CurrentLocationIntensityDisplay>(this as CurrentLocationIntensityDisplay, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentLocationIntensityDisplay&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.usedCityLevelData, usedCityLevelData) || other.usedCityLevelData == usedCityLevelData));
}


@override
int get hashCode => Object.hash(runtimeType,intensity,usedCityLevelData);

@override
String toString() {
  return 'CurrentLocationIntensityDisplay(intensity: $intensity, usedCityLevelData: $usedCityLevelData)';
}


}

/// @nodoc
abstract mixin class $CurrentLocationIntensityDisplayCopyWith<$Res>  {
  factory $CurrentLocationIntensityDisplayCopyWith(CurrentLocationIntensityDisplay value, $Res Function(CurrentLocationIntensityDisplay) _then) = _$CurrentLocationIntensityDisplayCopyWithImpl;
@useResult
$Res call({
 JmaIntensity intensity, bool usedCityLevelData
});




}
/// @nodoc
class _$CurrentLocationIntensityDisplayCopyWithImpl<$Res>
    implements $CurrentLocationIntensityDisplayCopyWith<$Res> {
  _$CurrentLocationIntensityDisplayCopyWithImpl(this._self, this._then);

  final CurrentLocationIntensityDisplay _self;
  final $Res Function(CurrentLocationIntensityDisplay) _then;

/// Create a copy of CurrentLocationIntensityDisplay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intensity = null,Object? usedCityLevelData = null,}) {
  return _then(_self.copyWith(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,usedCityLevelData: null == usedCityLevelData ? _self.usedCityLevelData : usedCityLevelData // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentLocationIntensityDisplay].
extension CurrentLocationIntensityDisplayPatterns on CurrentLocationIntensityDisplay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentLocationIntensityDisplay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentLocationIntensityDisplay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentLocationIntensityDisplay value)  $default,){
final _that = this;
switch (_that) {
case _CurrentLocationIntensityDisplay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentLocationIntensityDisplay value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentLocationIntensityDisplay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JmaIntensity intensity,  bool usedCityLevelData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentLocationIntensityDisplay() when $default != null:
return $default(_that.intensity,_that.usedCityLevelData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JmaIntensity intensity,  bool usedCityLevelData)  $default,) {final _that = this;
switch (_that) {
case _CurrentLocationIntensityDisplay():
return $default(_that.intensity,_that.usedCityLevelData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JmaIntensity intensity,  bool usedCityLevelData)?  $default,) {final _that = this;
switch (_that) {
case _CurrentLocationIntensityDisplay() when $default != null:
return $default(_that.intensity,_that.usedCityLevelData);case _:
  return null;

}
}

}

/// @nodoc


class _CurrentLocationIntensityDisplay implements CurrentLocationIntensityDisplay {
  const _CurrentLocationIntensityDisplay({required this.intensity, required this.usedCityLevelData});
  

@override final  JmaIntensity intensity;
/// 市区町村ポリゴン（areaInformationCity）に一致するデータか。
/// false のときは細分区域（areaForecastLocalE）フォールバック。
@override final  bool usedCityLevelData;

/// Create a copy of CurrentLocationIntensityDisplay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentLocationIntensityDisplayCopyWith<_CurrentLocationIntensityDisplay> get copyWith => __$CurrentLocationIntensityDisplayCopyWithImpl<_CurrentLocationIntensityDisplay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentLocationIntensityDisplay&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.usedCityLevelData, usedCityLevelData) || other.usedCityLevelData == usedCityLevelData));
}


@override
int get hashCode => Object.hash(runtimeType,intensity,usedCityLevelData);

@override
String toString() {
  return 'CurrentLocationIntensityDisplay(intensity: $intensity, usedCityLevelData: $usedCityLevelData)';
}


}

/// @nodoc
abstract mixin class _$CurrentLocationIntensityDisplayCopyWith<$Res> implements $CurrentLocationIntensityDisplayCopyWith<$Res> {
  factory _$CurrentLocationIntensityDisplayCopyWith(_CurrentLocationIntensityDisplay value, $Res Function(_CurrentLocationIntensityDisplay) _then) = __$CurrentLocationIntensityDisplayCopyWithImpl;
@override @useResult
$Res call({
 JmaIntensity intensity, bool usedCityLevelData
});




}
/// @nodoc
class __$CurrentLocationIntensityDisplayCopyWithImpl<$Res>
    implements _$CurrentLocationIntensityDisplayCopyWith<$Res> {
  __$CurrentLocationIntensityDisplayCopyWithImpl(this._self, this._then);

  final _CurrentLocationIntensityDisplay _self;
  final $Res Function(_CurrentLocationIntensityDisplay) _then;

/// Create a copy of CurrentLocationIntensityDisplay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intensity = null,Object? usedCityLevelData = null,}) {
  return _then(_CurrentLocationIntensityDisplay(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,usedCityLevelData: null == usedCityLevelData ? _self.usedCityLevelData : usedCityLevelData // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
