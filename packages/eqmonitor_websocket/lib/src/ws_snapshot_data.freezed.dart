// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_snapshot_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WsSnapshotShakeEntry {

 String get eventId; DateTime get createdAt; String get level; List<String> get changeReasons; bool get isReplay; int get pointCount; WsShakeRegionPayload get region;
/// Create a copy of WsSnapshotShakeEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsSnapshotShakeEntryCopyWith<WsSnapshotShakeEntry> get copyWith => _$WsSnapshotShakeEntryCopyWithImpl<WsSnapshotShakeEntry>(this as WsSnapshotShakeEntry, _$identity);

  /// Serializes this WsSnapshotShakeEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsSnapshotShakeEntry&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other.changeReasons, changeReasons)&&(identical(other.isReplay, isReplay) || other.isReplay == isReplay)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.region, region) || other.region == region));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,createdAt,level,const DeepCollectionEquality().hash(changeReasons),isReplay,pointCount,region);

@override
String toString() {
  return 'WsSnapshotShakeEntry(eventId: $eventId, createdAt: $createdAt, level: $level, changeReasons: $changeReasons, isReplay: $isReplay, pointCount: $pointCount, region: $region)';
}


}

/// @nodoc
abstract mixin class $WsSnapshotShakeEntryCopyWith<$Res>  {
  factory $WsSnapshotShakeEntryCopyWith(WsSnapshotShakeEntry value, $Res Function(WsSnapshotShakeEntry) _then) = _$WsSnapshotShakeEntryCopyWithImpl;
@useResult
$Res call({
 String eventId, DateTime createdAt, String level, List<String> changeReasons, bool isReplay, int pointCount, WsShakeRegionPayload region
});


$WsShakeRegionPayloadCopyWith<$Res> get region;

}
/// @nodoc
class _$WsSnapshotShakeEntryCopyWithImpl<$Res>
    implements $WsSnapshotShakeEntryCopyWith<$Res> {
  _$WsSnapshotShakeEntryCopyWithImpl(this._self, this._then);

  final WsSnapshotShakeEntry _self;
  final $Res Function(WsSnapshotShakeEntry) _then;

/// Create a copy of WsSnapshotShakeEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? createdAt = null,Object? level = null,Object? changeReasons = null,Object? isReplay = null,Object? pointCount = null,Object? region = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,changeReasons: null == changeReasons ? _self.changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,isReplay: null == isReplay ? _self.isReplay : isReplay // ignore: cast_nullable_to_non_nullable
as bool,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as WsShakeRegionPayload,
  ));
}
/// Create a copy of WsSnapshotShakeEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeRegionPayloadCopyWith<$Res> get region {
  
  return $WsShakeRegionPayloadCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}
}


/// Adds pattern-matching-related methods to [WsSnapshotShakeEntry].
extension WsSnapshotShakeEntryPatterns on WsSnapshotShakeEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsSnapshotShakeEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsSnapshotShakeEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsSnapshotShakeEntry value)  $default,){
final _that = this;
switch (_that) {
case _WsSnapshotShakeEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsSnapshotShakeEntry value)?  $default,){
final _that = this;
switch (_that) {
case _WsSnapshotShakeEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  DateTime createdAt,  String level,  List<String> changeReasons,  bool isReplay,  int pointCount,  WsShakeRegionPayload region)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsSnapshotShakeEntry() when $default != null:
return $default(_that.eventId,_that.createdAt,_that.level,_that.changeReasons,_that.isReplay,_that.pointCount,_that.region);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  DateTime createdAt,  String level,  List<String> changeReasons,  bool isReplay,  int pointCount,  WsShakeRegionPayload region)  $default,) {final _that = this;
switch (_that) {
case _WsSnapshotShakeEntry():
return $default(_that.eventId,_that.createdAt,_that.level,_that.changeReasons,_that.isReplay,_that.pointCount,_that.region);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  DateTime createdAt,  String level,  List<String> changeReasons,  bool isReplay,  int pointCount,  WsShakeRegionPayload region)?  $default,) {final _that = this;
switch (_that) {
case _WsSnapshotShakeEntry() when $default != null:
return $default(_that.eventId,_that.createdAt,_that.level,_that.changeReasons,_that.isReplay,_that.pointCount,_that.region);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsSnapshotShakeEntry implements WsSnapshotShakeEntry {
  const _WsSnapshotShakeEntry({required this.eventId, required this.createdAt, required this.level, final  List<String> changeReasons = const [], required this.isReplay, required this.pointCount, required this.region}): _changeReasons = changeReasons;
  factory _WsSnapshotShakeEntry.fromJson(Map<String, dynamic> json) => _$WsSnapshotShakeEntryFromJson(json);

@override final  String eventId;
@override final  DateTime createdAt;
@override final  String level;
 final  List<String> _changeReasons;
@override@JsonKey() List<String> get changeReasons {
  if (_changeReasons is EqualUnmodifiableListView) return _changeReasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_changeReasons);
}

@override final  bool isReplay;
@override final  int pointCount;
@override final  WsShakeRegionPayload region;

/// Create a copy of WsSnapshotShakeEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsSnapshotShakeEntryCopyWith<_WsSnapshotShakeEntry> get copyWith => __$WsSnapshotShakeEntryCopyWithImpl<_WsSnapshotShakeEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsSnapshotShakeEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsSnapshotShakeEntry&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other._changeReasons, _changeReasons)&&(identical(other.isReplay, isReplay) || other.isReplay == isReplay)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.region, region) || other.region == region));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,createdAt,level,const DeepCollectionEquality().hash(_changeReasons),isReplay,pointCount,region);

@override
String toString() {
  return 'WsSnapshotShakeEntry(eventId: $eventId, createdAt: $createdAt, level: $level, changeReasons: $changeReasons, isReplay: $isReplay, pointCount: $pointCount, region: $region)';
}


}

/// @nodoc
abstract mixin class _$WsSnapshotShakeEntryCopyWith<$Res> implements $WsSnapshotShakeEntryCopyWith<$Res> {
  factory _$WsSnapshotShakeEntryCopyWith(_WsSnapshotShakeEntry value, $Res Function(_WsSnapshotShakeEntry) _then) = __$WsSnapshotShakeEntryCopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime createdAt, String level, List<String> changeReasons, bool isReplay, int pointCount, WsShakeRegionPayload region
});


@override $WsShakeRegionPayloadCopyWith<$Res> get region;

}
/// @nodoc
class __$WsSnapshotShakeEntryCopyWithImpl<$Res>
    implements _$WsSnapshotShakeEntryCopyWith<$Res> {
  __$WsSnapshotShakeEntryCopyWithImpl(this._self, this._then);

  final _WsSnapshotShakeEntry _self;
  final $Res Function(_WsSnapshotShakeEntry) _then;

/// Create a copy of WsSnapshotShakeEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? createdAt = null,Object? level = null,Object? changeReasons = null,Object? isReplay = null,Object? pointCount = null,Object? region = null,}) {
  return _then(_WsSnapshotShakeEntry(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,changeReasons: null == changeReasons ? _self._changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,isReplay: null == isReplay ? _self.isReplay : isReplay // ignore: cast_nullable_to_non_nullable
as bool,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as WsShakeRegionPayload,
  ));
}

/// Create a copy of WsSnapshotShakeEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeRegionPayloadCopyWith<$Res> get region {
  
  return $WsShakeRegionPayloadCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}
}


/// @nodoc
mixin _$WsSnapshotData {

 int get revision; DateTime get updatedAt; List<WsSnapshotShakeEntry> get shakes; List<EewItemWithRelations> get eews; List<EarthquakePartial> get earthquakes;
/// Create a copy of WsSnapshotData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsSnapshotDataCopyWith<WsSnapshotData> get copyWith => _$WsSnapshotDataCopyWithImpl<WsSnapshotData>(this as WsSnapshotData, _$identity);

  /// Serializes this WsSnapshotData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsSnapshotData&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.shakes, shakes)&&const DeepCollectionEquality().equals(other.eews, eews)&&const DeepCollectionEquality().equals(other.earthquakes, earthquakes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revision,updatedAt,const DeepCollectionEquality().hash(shakes),const DeepCollectionEquality().hash(eews),const DeepCollectionEquality().hash(earthquakes));

@override
String toString() {
  return 'WsSnapshotData(revision: $revision, updatedAt: $updatedAt, shakes: $shakes, eews: $eews, earthquakes: $earthquakes)';
}


}

/// @nodoc
abstract mixin class $WsSnapshotDataCopyWith<$Res>  {
  factory $WsSnapshotDataCopyWith(WsSnapshotData value, $Res Function(WsSnapshotData) _then) = _$WsSnapshotDataCopyWithImpl;
@useResult
$Res call({
 int revision, DateTime updatedAt, List<WsSnapshotShakeEntry> shakes, List<EewItemWithRelations> eews, List<EarthquakePartial> earthquakes
});




}
/// @nodoc
class _$WsSnapshotDataCopyWithImpl<$Res>
    implements $WsSnapshotDataCopyWith<$Res> {
  _$WsSnapshotDataCopyWithImpl(this._self, this._then);

  final WsSnapshotData _self;
  final $Res Function(WsSnapshotData) _then;

/// Create a copy of WsSnapshotData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? revision = null,Object? updatedAt = null,Object? shakes = null,Object? eews = null,Object? earthquakes = null,}) {
  return _then(_self.copyWith(
revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,shakes: null == shakes ? _self.shakes : shakes // ignore: cast_nullable_to_non_nullable
as List<WsSnapshotShakeEntry>,eews: null == eews ? _self.eews : eews // ignore: cast_nullable_to_non_nullable
as List<EewItemWithRelations>,earthquakes: null == earthquakes ? _self.earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartial>,
  ));
}

}


/// Adds pattern-matching-related methods to [WsSnapshotData].
extension WsSnapshotDataPatterns on WsSnapshotData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsSnapshotData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsSnapshotData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsSnapshotData value)  $default,){
final _that = this;
switch (_that) {
case _WsSnapshotData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsSnapshotData value)?  $default,){
final _that = this;
switch (_that) {
case _WsSnapshotData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int revision,  DateTime updatedAt,  List<WsSnapshotShakeEntry> shakes,  List<EewItemWithRelations> eews,  List<EarthquakePartial> earthquakes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsSnapshotData() when $default != null:
return $default(_that.revision,_that.updatedAt,_that.shakes,_that.eews,_that.earthquakes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int revision,  DateTime updatedAt,  List<WsSnapshotShakeEntry> shakes,  List<EewItemWithRelations> eews,  List<EarthquakePartial> earthquakes)  $default,) {final _that = this;
switch (_that) {
case _WsSnapshotData():
return $default(_that.revision,_that.updatedAt,_that.shakes,_that.eews,_that.earthquakes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int revision,  DateTime updatedAt,  List<WsSnapshotShakeEntry> shakes,  List<EewItemWithRelations> eews,  List<EarthquakePartial> earthquakes)?  $default,) {final _that = this;
switch (_that) {
case _WsSnapshotData() when $default != null:
return $default(_that.revision,_that.updatedAt,_that.shakes,_that.eews,_that.earthquakes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsSnapshotData implements WsSnapshotData {
  const _WsSnapshotData({required this.revision, required this.updatedAt, final  List<WsSnapshotShakeEntry> shakes = const [], final  List<EewItemWithRelations> eews = const [], final  List<EarthquakePartial> earthquakes = const []}): _shakes = shakes,_eews = eews,_earthquakes = earthquakes;
  factory _WsSnapshotData.fromJson(Map<String, dynamic> json) => _$WsSnapshotDataFromJson(json);

@override final  int revision;
@override final  DateTime updatedAt;
 final  List<WsSnapshotShakeEntry> _shakes;
@override@JsonKey() List<WsSnapshotShakeEntry> get shakes {
  if (_shakes is EqualUnmodifiableListView) return _shakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shakes);
}

 final  List<EewItemWithRelations> _eews;
@override@JsonKey() List<EewItemWithRelations> get eews {
  if (_eews is EqualUnmodifiableListView) return _eews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eews);
}

 final  List<EarthquakePartial> _earthquakes;
@override@JsonKey() List<EarthquakePartial> get earthquakes {
  if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earthquakes);
}


/// Create a copy of WsSnapshotData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsSnapshotDataCopyWith<_WsSnapshotData> get copyWith => __$WsSnapshotDataCopyWithImpl<_WsSnapshotData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsSnapshotDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsSnapshotData&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._shakes, _shakes)&&const DeepCollectionEquality().equals(other._eews, _eews)&&const DeepCollectionEquality().equals(other._earthquakes, _earthquakes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revision,updatedAt,const DeepCollectionEquality().hash(_shakes),const DeepCollectionEquality().hash(_eews),const DeepCollectionEquality().hash(_earthquakes));

@override
String toString() {
  return 'WsSnapshotData(revision: $revision, updatedAt: $updatedAt, shakes: $shakes, eews: $eews, earthquakes: $earthquakes)';
}


}

/// @nodoc
abstract mixin class _$WsSnapshotDataCopyWith<$Res> implements $WsSnapshotDataCopyWith<$Res> {
  factory _$WsSnapshotDataCopyWith(_WsSnapshotData value, $Res Function(_WsSnapshotData) _then) = __$WsSnapshotDataCopyWithImpl;
@override @useResult
$Res call({
 int revision, DateTime updatedAt, List<WsSnapshotShakeEntry> shakes, List<EewItemWithRelations> eews, List<EarthquakePartial> earthquakes
});




}
/// @nodoc
class __$WsSnapshotDataCopyWithImpl<$Res>
    implements _$WsSnapshotDataCopyWith<$Res> {
  __$WsSnapshotDataCopyWithImpl(this._self, this._then);

  final _WsSnapshotData _self;
  final $Res Function(_WsSnapshotData) _then;

/// Create a copy of WsSnapshotData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? revision = null,Object? updatedAt = null,Object? shakes = null,Object? eews = null,Object? earthquakes = null,}) {
  return _then(_WsSnapshotData(
revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,shakes: null == shakes ? _self._shakes : shakes // ignore: cast_nullable_to_non_nullable
as List<WsSnapshotShakeEntry>,eews: null == eews ? _self._eews : eews // ignore: cast_nullable_to_non_nullable
as List<EewItemWithRelations>,earthquakes: null == earthquakes ? _self._earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartial>,
  ));
}


}

// dart format on
