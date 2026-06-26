// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_city_search_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityCitySearchItem {

 JmaIntensity get intensity; EarthquakePartial get earthquake;
/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityCitySearchItemCopyWith<IntensityCitySearchItem> get copyWith => _$IntensityCitySearchItemCopyWithImpl<IntensityCitySearchItem>(this as IntensityCitySearchItem, _$identity);

  /// Serializes this IntensityCitySearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityCitySearchItem&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensity,earthquake);

@override
String toString() {
  return 'IntensityCitySearchItem(intensity: $intensity, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $IntensityCitySearchItemCopyWith<$Res>  {
  factory $IntensityCitySearchItemCopyWith(IntensityCitySearchItem value, $Res Function(IntensityCitySearchItem) _then) = _$IntensityCitySearchItemCopyWithImpl;
@useResult
$Res call({
 JmaIntensity intensity, EarthquakePartial earthquake
});


$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$IntensityCitySearchItemCopyWithImpl<$Res>
    implements $IntensityCitySearchItemCopyWith<$Res> {
  _$IntensityCitySearchItemCopyWithImpl(this._self, this._then);

  final IntensityCitySearchItem _self;
  final $Res Function(IntensityCitySearchItem) _then;

/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intensity = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityCitySearchItem].
extension IntensityCitySearchItemPatterns on IntensityCitySearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityCitySearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityCitySearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityCitySearchItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityCitySearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityCitySearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityCitySearchItem() when $default != null:
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
case _IntensityCitySearchItem() when $default != null:
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
case _IntensityCitySearchItem():
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
case _IntensityCitySearchItem() when $default != null:
return $default(_that.intensity,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityCitySearchItem implements IntensityCitySearchItem {
  const _IntensityCitySearchItem({required this.intensity, required this.earthquake});
  factory _IntensityCitySearchItem.fromJson(Map<String, dynamic> json) => _$IntensityCitySearchItemFromJson(json);

@override final  JmaIntensity intensity;
@override final  EarthquakePartial earthquake;

/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityCitySearchItemCopyWith<_IntensityCitySearchItem> get copyWith => __$IntensityCitySearchItemCopyWithImpl<_IntensityCitySearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityCitySearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityCitySearchItem&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensity,earthquake);

@override
String toString() {
  return 'IntensityCitySearchItem(intensity: $intensity, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$IntensityCitySearchItemCopyWith<$Res> implements $IntensityCitySearchItemCopyWith<$Res> {
  factory _$IntensityCitySearchItemCopyWith(_IntensityCitySearchItem value, $Res Function(_IntensityCitySearchItem) _then) = __$IntensityCitySearchItemCopyWithImpl;
@override @useResult
$Res call({
 JmaIntensity intensity, EarthquakePartial earthquake
});


@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$IntensityCitySearchItemCopyWithImpl<$Res>
    implements _$IntensityCitySearchItemCopyWith<$Res> {
  __$IntensityCitySearchItemCopyWithImpl(this._self, this._then);

  final _IntensityCitySearchItem _self;
  final $Res Function(_IntensityCitySearchItem) _then;

/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intensity = null,Object? earthquake = null,}) {
  return _then(_IntensityCitySearchItem(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of IntensityCitySearchItem
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
