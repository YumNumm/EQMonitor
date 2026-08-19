// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiState {

 String get id;@JsonKey(name: 'event_ids') List<String> get eventIds;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'is_canceled') bool get isCanceled;@JsonKey(name: 'updated_at') DateTime get updatedAt; List<TsunamiStateEarthquake> get earthquakes;@JsonKey(name: 'latest_telegrams') List<LatestTelegram> get latestTelegrams; List<TsunamiRegion> get regions;@JsonKey(name: 'offshore_stations') List<TsunamiOffshoreStation> get offshoreStations;
/// Create a copy of TsunamiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStateCopyWith<TsunamiState> get copyWith => _$TsunamiStateCopyWithImpl<TsunamiState>(this as TsunamiState, _$identity);

  /// Serializes this TsunamiState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiState&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.eventIds, eventIds)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.earthquakes, earthquakes)&&const DeepCollectionEquality().equals(other.latestTelegrams, latestTelegrams)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.offshoreStations, offshoreStations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(eventIds),isActive,isCanceled,updatedAt,const DeepCollectionEquality().hash(earthquakes),const DeepCollectionEquality().hash(latestTelegrams),const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(offshoreStations));

@override
String toString() {
  return 'TsunamiState(id: $id, eventIds: $eventIds, isActive: $isActive, isCanceled: $isCanceled, updatedAt: $updatedAt, earthquakes: $earthquakes, latestTelegrams: $latestTelegrams, regions: $regions, offshoreStations: $offshoreStations)';
}


}

/// @nodoc
abstract mixin class $TsunamiStateCopyWith<$Res>  {
  factory $TsunamiStateCopyWith(TsunamiState value, $Res Function(TsunamiState) _then) = _$TsunamiStateCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'event_ids') List<String> eventIds,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'is_canceled') bool isCanceled,@JsonKey(name: 'updated_at') DateTime updatedAt, List<TsunamiStateEarthquake> earthquakes,@JsonKey(name: 'latest_telegrams') List<LatestTelegram> latestTelegrams, List<TsunamiRegion> regions,@JsonKey(name: 'offshore_stations') List<TsunamiOffshoreStation> offshoreStations
});




}
/// @nodoc
class _$TsunamiStateCopyWithImpl<$Res>
    implements $TsunamiStateCopyWith<$Res> {
  _$TsunamiStateCopyWithImpl(this._self, this._then);

  final TsunamiState _self;
  final $Res Function(TsunamiState) _then;

/// Create a copy of TsunamiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventIds = null,Object? isActive = null,Object? isCanceled = null,Object? updatedAt = null,Object? earthquakes = null,Object? latestTelegrams = null,Object? regions = null,Object? offshoreStations = null,}) {
  return _then(TsunamiState(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventIds: null == eventIds ? _self.eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,earthquakes: null == earthquakes ? _self.earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<TsunamiStateEarthquake>,latestTelegrams: null == latestTelegrams ? _self.latestTelegrams : latestTelegrams // ignore: cast_nullable_to_non_nullable
as List<LatestTelegram>,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<TsunamiRegion>,offshoreStations: null == offshoreStations ? _self.offshoreStations : offshoreStations // ignore: cast_nullable_to_non_nullable
as List<TsunamiOffshoreStation>,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiState].
extension TsunamiStatePatterns on TsunamiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiState value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiState value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'is_canceled')  bool isCanceled, @JsonKey(name: 'updated_at')  DateTime updatedAt,  List<TsunamiStateEarthquake> earthquakes, @JsonKey(name: 'latest_telegrams')  List<LatestTelegram> latestTelegrams,  List<TsunamiRegion> regions, @JsonKey(name: 'offshore_stations')  List<TsunamiOffshoreStation> offshoreStations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiState() when $default != null:
return $default(_that.id,_that.eventIds,_that.isActive,_that.isCanceled,_that.updatedAt,_that.earthquakes,_that.latestTelegrams,_that.regions,_that.offshoreStations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'is_canceled')  bool isCanceled, @JsonKey(name: 'updated_at')  DateTime updatedAt,  List<TsunamiStateEarthquake> earthquakes, @JsonKey(name: 'latest_telegrams')  List<LatestTelegram> latestTelegrams,  List<TsunamiRegion> regions, @JsonKey(name: 'offshore_stations')  List<TsunamiOffshoreStation> offshoreStations)  $default,) {final _that = this;
switch (_that) {
case _TsunamiState():
return $default(_that.id,_that.eventIds,_that.isActive,_that.isCanceled,_that.updatedAt,_that.earthquakes,_that.latestTelegrams,_that.regions,_that.offshoreStations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'is_canceled')  bool isCanceled, @JsonKey(name: 'updated_at')  DateTime updatedAt,  List<TsunamiStateEarthquake> earthquakes, @JsonKey(name: 'latest_telegrams')  List<LatestTelegram> latestTelegrams,  List<TsunamiRegion> regions, @JsonKey(name: 'offshore_stations')  List<TsunamiOffshoreStation> offshoreStations)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiState() when $default != null:
return $default(_that.id,_that.eventIds,_that.isActive,_that.isCanceled,_that.updatedAt,_that.earthquakes,_that.latestTelegrams,_that.regions,_that.offshoreStations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiState implements TsunamiState {
  const _TsunamiState({required this.id, @JsonKey(name: 'event_ids') required  List<String> eventIds, @JsonKey(name: 'is_active') required this.isActive, @JsonKey(name: 'is_canceled') required this.isCanceled, @JsonKey(name: 'updated_at') required this.updatedAt, required  List<TsunamiStateEarthquake> earthquakes, @JsonKey(name: 'latest_telegrams') required  List<LatestTelegram> latestTelegrams, required  List<TsunamiRegion> regions, @JsonKey(name: 'offshore_stations') required  List<TsunamiOffshoreStation> offshoreStations}): _eventIds = eventIds,_earthquakes = earthquakes,_latestTelegrams = latestTelegrams,_regions = regions,_offshoreStations = offshoreStations;
  factory _TsunamiState.fromJson(Map<String, dynamic> json) => _$TsunamiStateFromJson(json);

@override final  String id;
 final  List<String> _eventIds;
@override@JsonKey(name: 'event_ids') List<String> get eventIds {
  if (_eventIds is EqualUnmodifiableListView) return _eventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIds);
}

@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'is_canceled') final  bool isCanceled;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
 final  List<TsunamiStateEarthquake> _earthquakes;
@override List<TsunamiStateEarthquake> get earthquakes {
  if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earthquakes);
}

 final  List<LatestTelegram> _latestTelegrams;
@override@JsonKey(name: 'latest_telegrams') List<LatestTelegram> get latestTelegrams {
  if (_latestTelegrams is EqualUnmodifiableListView) return _latestTelegrams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_latestTelegrams);
}

 final  List<TsunamiRegion> _regions;
@override List<TsunamiRegion> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  List<TsunamiOffshoreStation> _offshoreStations;
@override@JsonKey(name: 'offshore_stations') List<TsunamiOffshoreStation> get offshoreStations {
  if (_offshoreStations is EqualUnmodifiableListView) return _offshoreStations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_offshoreStations);
}


/// Create a copy of TsunamiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStateCopyWith<_TsunamiState> get copyWith => __$TsunamiStateCopyWithImpl<_TsunamiState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiState&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._earthquakes, _earthquakes)&&const DeepCollectionEquality().equals(other._latestTelegrams, _latestTelegrams)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._offshoreStations, _offshoreStations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_eventIds),isActive,isCanceled,updatedAt,const DeepCollectionEquality().hash(_earthquakes),const DeepCollectionEquality().hash(_latestTelegrams),const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_offshoreStations));

@override
String toString() {
  return 'TsunamiState(id: $id, eventIds: $eventIds, isActive: $isActive, isCanceled: $isCanceled, updatedAt: $updatedAt, earthquakes: $earthquakes, latestTelegrams: $latestTelegrams, regions: $regions, offshoreStations: $offshoreStations)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStateCopyWith<$Res> implements $TsunamiStateCopyWith<$Res> {
  factory _$TsunamiStateCopyWith(_TsunamiState value, $Res Function(_TsunamiState) _then) = __$TsunamiStateCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'event_ids') List<String> eventIds,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'is_canceled') bool isCanceled,@JsonKey(name: 'updated_at') DateTime updatedAt, List<TsunamiStateEarthquake> earthquakes,@JsonKey(name: 'latest_telegrams') List<LatestTelegram> latestTelegrams, List<TsunamiRegion> regions,@JsonKey(name: 'offshore_stations') List<TsunamiOffshoreStation> offshoreStations
});




}
/// @nodoc
class __$TsunamiStateCopyWithImpl<$Res>
    implements _$TsunamiStateCopyWith<$Res> {
  __$TsunamiStateCopyWithImpl(this._self, this._then);

  final _TsunamiState _self;
  final $Res Function(_TsunamiState) _then;

/// Create a copy of TsunamiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventIds = null,Object? isActive = null,Object? isCanceled = null,Object? updatedAt = null,Object? earthquakes = null,Object? latestTelegrams = null,Object? regions = null,Object? offshoreStations = null,}) {
  return _then(_TsunamiState(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,earthquakes: null == earthquakes ? _self._earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<TsunamiStateEarthquake>,latestTelegrams: null == latestTelegrams ? _self._latestTelegrams : latestTelegrams // ignore: cast_nullable_to_non_nullable
as List<LatestTelegram>,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<TsunamiRegion>,offshoreStations: null == offshoreStations ? _self._offshoreStations : offshoreStations // ignore: cast_nullable_to_non_nullable
as List<TsunamiOffshoreStation>,
  ));
}


}

// dart format on
