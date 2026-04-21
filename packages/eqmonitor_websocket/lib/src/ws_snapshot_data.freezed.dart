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
mixin _$WsSnapshotData {

 int get revision; DateTime get updatedAt; List<EewItemWithRelations> get eews; List<EarthquakePartial> get earthquakes;
/// Create a copy of WsSnapshotData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsSnapshotDataCopyWith<WsSnapshotData> get copyWith => _$WsSnapshotDataCopyWithImpl<WsSnapshotData>(this as WsSnapshotData, _$identity);

  /// Serializes this WsSnapshotData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsSnapshotData&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.eews, eews)&&const DeepCollectionEquality().equals(other.earthquakes, earthquakes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revision,updatedAt,const DeepCollectionEquality().hash(eews),const DeepCollectionEquality().hash(earthquakes));

@override
String toString() {
  return 'WsSnapshotData(revision: $revision, updatedAt: $updatedAt, eews: $eews, earthquakes: $earthquakes)';
}


}

/// @nodoc
abstract mixin class $WsSnapshotDataCopyWith<$Res>  {
  factory $WsSnapshotDataCopyWith(WsSnapshotData value, $Res Function(WsSnapshotData) _then) = _$WsSnapshotDataCopyWithImpl;
@useResult
$Res call({
 int revision, DateTime updatedAt, List<EewItemWithRelations> eews, List<EarthquakePartial> earthquakes
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
@pragma('vm:prefer-inline') @override $Res call({Object? revision = null,Object? updatedAt = null,Object? eews = null,Object? earthquakes = null,}) {
  return _then(_self.copyWith(
revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,eews: null == eews ? _self.eews : eews // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int revision,  DateTime updatedAt,  List<EewItemWithRelations> eews,  List<EarthquakePartial> earthquakes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsSnapshotData() when $default != null:
return $default(_that.revision,_that.updatedAt,_that.eews,_that.earthquakes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int revision,  DateTime updatedAt,  List<EewItemWithRelations> eews,  List<EarthquakePartial> earthquakes)  $default,) {final _that = this;
switch (_that) {
case _WsSnapshotData():
return $default(_that.revision,_that.updatedAt,_that.eews,_that.earthquakes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int revision,  DateTime updatedAt,  List<EewItemWithRelations> eews,  List<EarthquakePartial> earthquakes)?  $default,) {final _that = this;
switch (_that) {
case _WsSnapshotData() when $default != null:
return $default(_that.revision,_that.updatedAt,_that.eews,_that.earthquakes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsSnapshotData implements WsSnapshotData {
  const _WsSnapshotData({required this.revision, required this.updatedAt, final  List<EewItemWithRelations> eews = const [], final  List<EarthquakePartial> earthquakes = const []}): _eews = eews,_earthquakes = earthquakes;
  factory _WsSnapshotData.fromJson(Map<String, dynamic> json) => _$WsSnapshotDataFromJson(json);

@override final  int revision;
@override final  DateTime updatedAt;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsSnapshotData&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._eews, _eews)&&const DeepCollectionEquality().equals(other._earthquakes, _earthquakes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revision,updatedAt,const DeepCollectionEquality().hash(_eews),const DeepCollectionEquality().hash(_earthquakes));

@override
String toString() {
  return 'WsSnapshotData(revision: $revision, updatedAt: $updatedAt, eews: $eews, earthquakes: $earthquakes)';
}


}

/// @nodoc
abstract mixin class _$WsSnapshotDataCopyWith<$Res> implements $WsSnapshotDataCopyWith<$Res> {
  factory _$WsSnapshotDataCopyWith(_WsSnapshotData value, $Res Function(_WsSnapshotData) _then) = __$WsSnapshotDataCopyWithImpl;
@override @useResult
$Res call({
 int revision, DateTime updatedAt, List<EewItemWithRelations> eews, List<EarthquakePartial> earthquakes
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
@override @pragma('vm:prefer-inline') $Res call({Object? revision = null,Object? updatedAt = null,Object? eews = null,Object? earthquakes = null,}) {
  return _then(_WsSnapshotData(
revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,eews: null == eews ? _self._eews : eews // ignore: cast_nullable_to_non_nullable
as List<EewItemWithRelations>,earthquakes: null == earthquakes ? _self._earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartial>,
  ));
}


}

// dart format on
