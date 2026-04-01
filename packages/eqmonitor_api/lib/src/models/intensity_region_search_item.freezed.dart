// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_region_search_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityRegionSearchItem {

@JsonKey(name: 'event_id') String get eventId; IntensityRegionInfo get region; EarthquakePartial get earthquake;
/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityRegionSearchItemCopyWith<IntensityRegionSearchItem> get copyWith => _$IntensityRegionSearchItemCopyWithImpl<IntensityRegionSearchItem>(this as IntensityRegionSearchItem, _$identity);

  /// Serializes this IntensityRegionSearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityRegionSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.region, region) || other.region == region)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,region,earthquake);

@override
String toString() {
  return 'IntensityRegionSearchItem(eventId: $eventId, region: $region, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $IntensityRegionSearchItemCopyWith<$Res>  {
  factory $IntensityRegionSearchItemCopyWith(IntensityRegionSearchItem value, $Res Function(IntensityRegionSearchItem) _then) = _$IntensityRegionSearchItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_id') String eventId, IntensityRegionInfo region, EarthquakePartial earthquake
});


$IntensityRegionInfoCopyWith<$Res> get region;$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$IntensityRegionSearchItemCopyWithImpl<$Res>
    implements $IntensityRegionSearchItemCopyWith<$Res> {
  _$IntensityRegionSearchItemCopyWithImpl(this._self, this._then);

  final IntensityRegionSearchItem _self;
  final $Res Function(IntensityRegionSearchItem) _then;

/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? region = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as IntensityRegionInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<$Res> get region {
  
  return $IntensityRegionInfoCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityRegionSearchItem].
extension IntensityRegionSearchItemPatterns on IntensityRegionSearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityRegionSearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityRegionSearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityRegionSearchItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityRegionSearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityRegionSearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityRegionSearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  IntensityRegionInfo region,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityRegionSearchItem() when $default != null:
return $default(_that.eventId,_that.region,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  IntensityRegionInfo region,  EarthquakePartial earthquake)  $default,) {final _that = this;
switch (_that) {
case _IntensityRegionSearchItem():
return $default(_that.eventId,_that.region,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')  String eventId,  IntensityRegionInfo region,  EarthquakePartial earthquake)?  $default,) {final _that = this;
switch (_that) {
case _IntensityRegionSearchItem() when $default != null:
return $default(_that.eventId,_that.region,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityRegionSearchItem implements IntensityRegionSearchItem {
  const _IntensityRegionSearchItem({@JsonKey(name: 'event_id') required this.eventId, required this.region, required this.earthquake});
  factory _IntensityRegionSearchItem.fromJson(Map<String, dynamic> json) => _$IntensityRegionSearchItemFromJson(json);

@override@JsonKey(name: 'event_id') final  String eventId;
@override final  IntensityRegionInfo region;
@override final  EarthquakePartial earthquake;

/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityRegionSearchItemCopyWith<_IntensityRegionSearchItem> get copyWith => __$IntensityRegionSearchItemCopyWithImpl<_IntensityRegionSearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityRegionSearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityRegionSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.region, region) || other.region == region)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,region,earthquake);

@override
String toString() {
  return 'IntensityRegionSearchItem(eventId: $eventId, region: $region, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$IntensityRegionSearchItemCopyWith<$Res> implements $IntensityRegionSearchItemCopyWith<$Res> {
  factory _$IntensityRegionSearchItemCopyWith(_IntensityRegionSearchItem value, $Res Function(_IntensityRegionSearchItem) _then) = __$IntensityRegionSearchItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_id') String eventId, IntensityRegionInfo region, EarthquakePartial earthquake
});


@override $IntensityRegionInfoCopyWith<$Res> get region;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$IntensityRegionSearchItemCopyWithImpl<$Res>
    implements _$IntensityRegionSearchItemCopyWith<$Res> {
  __$IntensityRegionSearchItemCopyWithImpl(this._self, this._then);

  final _IntensityRegionSearchItem _self;
  final $Res Function(_IntensityRegionSearchItem) _then;

/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? region = null,Object? earthquake = null,}) {
  return _then(_IntensityRegionSearchItem(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as IntensityRegionInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<$Res> get region {
  
  return $IntensityRegionInfoCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of IntensityRegionSearchItem
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
