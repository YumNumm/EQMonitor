// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_station_search_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityStationSearchItem {

 JmaIntensity get intensity; EarthquakePartial get earthquake;
/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityStationSearchItemCopyWith<IntensityStationSearchItem> get copyWith => _$IntensityStationSearchItemCopyWithImpl<IntensityStationSearchItem>(this as IntensityStationSearchItem, _$identity);

  /// Serializes this IntensityStationSearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityStationSearchItem&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensity,earthquake);

@override
String toString() {
  return 'IntensityStationSearchItem(intensity: $intensity, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $IntensityStationSearchItemCopyWith<$Res>  {
  factory $IntensityStationSearchItemCopyWith(IntensityStationSearchItem value, $Res Function(IntensityStationSearchItem) _then) = _$IntensityStationSearchItemCopyWithImpl;
@useResult
$Res call({
 JmaIntensity intensity, EarthquakePartial earthquake
});


$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$IntensityStationSearchItemCopyWithImpl<$Res>
    implements $IntensityStationSearchItemCopyWith<$Res> {
  _$IntensityStationSearchItemCopyWithImpl(this._self, this._then);

  final IntensityStationSearchItem _self;
  final $Res Function(IntensityStationSearchItem) _then;

/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intensity = null,Object? earthquake = null,}) {
  return _then(IntensityStationSearchItem(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityStationSearchItem].
extension IntensityStationSearchItemPatterns on IntensityStationSearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityStationSearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityStationSearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityStationSearchItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityStationSearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityStationSearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityStationSearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JmaIntensity intensity,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityStationSearchItem() when $default != null:
return $default(_that.intensity,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JmaIntensity intensity,  EarthquakePartial earthquake)  $default,) {final _that = this;
switch (_that) {
case _IntensityStationSearchItem():
return $default(_that.intensity,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JmaIntensity intensity,  EarthquakePartial earthquake)?  $default,) {final _that = this;
switch (_that) {
case _IntensityStationSearchItem() when $default != null:
return $default(_that.intensity,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityStationSearchItem implements IntensityStationSearchItem {
  const _IntensityStationSearchItem({required this.intensity, required this.earthquake});
  factory _IntensityStationSearchItem.fromJson(Map<String, dynamic> json) => _$IntensityStationSearchItemFromJson(json);

@override final  JmaIntensity intensity;
@override final  EarthquakePartial earthquake;

/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityStationSearchItemCopyWith<_IntensityStationSearchItem> get copyWith => __$IntensityStationSearchItemCopyWithImpl<_IntensityStationSearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityStationSearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityStationSearchItem&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensity,earthquake);

@override
String toString() {
  return 'IntensityStationSearchItem(intensity: $intensity, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$IntensityStationSearchItemCopyWith<$Res> implements $IntensityStationSearchItemCopyWith<$Res> {
  factory _$IntensityStationSearchItemCopyWith(_IntensityStationSearchItem value, $Res Function(_IntensityStationSearchItem) _then) = __$IntensityStationSearchItemCopyWithImpl;
@override @useResult
$Res call({
 JmaIntensity intensity, EarthquakePartial earthquake
});


@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$IntensityStationSearchItemCopyWithImpl<$Res>
    implements _$IntensityStationSearchItemCopyWith<$Res> {
  __$IntensityStationSearchItemCopyWithImpl(this._self, this._then);

  final _IntensityStationSearchItem _self;
  final $Res Function(_IntensityStationSearchItem) _then;

/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intensity = null,Object? earthquake = null,}) {
  return _then(_IntensityStationSearchItem(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

// dart format on
