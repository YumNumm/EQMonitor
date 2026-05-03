// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_prefecture_search_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityPrefectureSearchItem {

@JsonKey(name: 'event_id') String get eventId; JmaIntensity get intensity; EarthquakePartial get earthquake;
/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityPrefectureSearchItemCopyWith<IntensityPrefectureSearchItem> get copyWith => _$IntensityPrefectureSearchItemCopyWithImpl<IntensityPrefectureSearchItem>(this as IntensityPrefectureSearchItem, _$identity);

  /// Serializes this IntensityPrefectureSearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityPrefectureSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,intensity,earthquake);

@override
String toString() {
  return 'IntensityPrefectureSearchItem(eventId: $eventId, intensity: $intensity, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $IntensityPrefectureSearchItemCopyWith<$Res>  {
  factory $IntensityPrefectureSearchItemCopyWith(IntensityPrefectureSearchItem value, $Res Function(IntensityPrefectureSearchItem) _then) = _$IntensityPrefectureSearchItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_id') String eventId, JmaIntensity intensity, EarthquakePartial earthquake
});


$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$IntensityPrefectureSearchItemCopyWithImpl<$Res>
    implements $IntensityPrefectureSearchItemCopyWith<$Res> {
  _$IntensityPrefectureSearchItemCopyWithImpl(this._self, this._then);

  final IntensityPrefectureSearchItem _self;
  final $Res Function(IntensityPrefectureSearchItem) _then;

/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? intensity = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityPrefectureSearchItem].
extension IntensityPrefectureSearchItemPatterns on IntensityPrefectureSearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityPrefectureSearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityPrefectureSearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityPrefectureSearchItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityPrefectureSearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityPrefectureSearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityPrefectureSearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  JmaIntensity intensity,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityPrefectureSearchItem() when $default != null:
return $default(_that.eventId,_that.intensity,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  JmaIntensity intensity,  EarthquakePartial earthquake)  $default,) {final _that = this;
switch (_that) {
case _IntensityPrefectureSearchItem():
return $default(_that.eventId,_that.intensity,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')  String eventId,  JmaIntensity intensity,  EarthquakePartial earthquake)?  $default,) {final _that = this;
switch (_that) {
case _IntensityPrefectureSearchItem() when $default != null:
return $default(_that.eventId,_that.intensity,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityPrefectureSearchItem implements IntensityPrefectureSearchItem {
  const _IntensityPrefectureSearchItem({@JsonKey(name: 'event_id') required this.eventId, required this.intensity, required this.earthquake});
  factory _IntensityPrefectureSearchItem.fromJson(Map<String, dynamic> json) => _$IntensityPrefectureSearchItemFromJson(json);

@override@JsonKey(name: 'event_id') final  String eventId;
@override final  JmaIntensity intensity;
@override final  EarthquakePartial earthquake;

/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityPrefectureSearchItemCopyWith<_IntensityPrefectureSearchItem> get copyWith => __$IntensityPrefectureSearchItemCopyWithImpl<_IntensityPrefectureSearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityPrefectureSearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityPrefectureSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,intensity,earthquake);

@override
String toString() {
  return 'IntensityPrefectureSearchItem(eventId: $eventId, intensity: $intensity, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$IntensityPrefectureSearchItemCopyWith<$Res> implements $IntensityPrefectureSearchItemCopyWith<$Res> {
  factory _$IntensityPrefectureSearchItemCopyWith(_IntensityPrefectureSearchItem value, $Res Function(_IntensityPrefectureSearchItem) _then) = __$IntensityPrefectureSearchItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_id') String eventId, JmaIntensity intensity, EarthquakePartial earthquake
});


@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$IntensityPrefectureSearchItemCopyWithImpl<$Res>
    implements _$IntensityPrefectureSearchItemCopyWith<$Res> {
  __$IntensityPrefectureSearchItemCopyWithImpl(this._self, this._then);

  final _IntensityPrefectureSearchItem _self;
  final $Res Function(_IntensityPrefectureSearchItem) _then;

/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? intensity = null,Object? earthquake = null,}) {
  return _then(_IntensityPrefectureSearchItem(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of IntensityPrefectureSearchItem
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
