// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parameter_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParameterSet {

/// Asset Pack の `manifest.json`（地図アセットも含む）。パラメータ固有のメタ
/// データが必要な場合は `manifest.findAsset(...)` を利用する。
 AssetPackManifest get manifest; JmaCodeTableParameter get jmaCodeTable; KyoshinObservationPointsParameter get kyoshinObservationPoints; EarthquakeParameter get earthquake; TsunamiParameter get tsunami; ShindoDbStationsParameter get shindoDbStations;
/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParameterSetCopyWith<ParameterSet> get copyWith => _$ParameterSetCopyWithImpl<ParameterSet>(this as ParameterSet, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParameterSet&&(identical(other.manifest, manifest) || other.manifest == manifest)&&(identical(other.jmaCodeTable, jmaCodeTable) || other.jmaCodeTable == jmaCodeTable)&&(identical(other.kyoshinObservationPoints, kyoshinObservationPoints) || other.kyoshinObservationPoints == kyoshinObservationPoints)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake)&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&(identical(other.shindoDbStations, shindoDbStations) || other.shindoDbStations == shindoDbStations));
}


@override
int get hashCode => Object.hash(runtimeType,manifest,jmaCodeTable,kyoshinObservationPoints,earthquake,tsunami,shindoDbStations);

@override
String toString() {
  return 'ParameterSet(manifest: $manifest, jmaCodeTable: $jmaCodeTable, kyoshinObservationPoints: $kyoshinObservationPoints, earthquake: $earthquake, tsunami: $tsunami, shindoDbStations: $shindoDbStations)';
}


}

/// @nodoc
abstract mixin class $ParameterSetCopyWith<$Res>  {
  factory $ParameterSetCopyWith(ParameterSet value, $Res Function(ParameterSet) _then) = _$ParameterSetCopyWithImpl;
@useResult
$Res call({
 AssetPackManifest manifest, JmaCodeTableParameter jmaCodeTable, KyoshinObservationPointsParameter kyoshinObservationPoints, EarthquakeParameter earthquake, TsunamiParameter tsunami, ShindoDbStationsParameter shindoDbStations
});


$JmaCodeTableParameterCopyWith<$Res> get jmaCodeTable;$KyoshinObservationPointsParameterCopyWith<$Res> get kyoshinObservationPoints;$EarthquakeParameterCopyWith<$Res> get earthquake;$TsunamiParameterCopyWith<$Res> get tsunami;$ShindoDbStationsParameterCopyWith<$Res> get shindoDbStations;

}
/// @nodoc
class _$ParameterSetCopyWithImpl<$Res>
    implements $ParameterSetCopyWith<$Res> {
  _$ParameterSetCopyWithImpl(this._self, this._then);

  final ParameterSet _self;
  final $Res Function(ParameterSet) _then;

/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? manifest = null,Object? jmaCodeTable = null,Object? kyoshinObservationPoints = null,Object? earthquake = null,Object? tsunami = null,Object? shindoDbStations = null,}) {
  return _then(_self.copyWith(
manifest: null == manifest ? _self.manifest : manifest // ignore: cast_nullable_to_non_nullable
as AssetPackManifest,jmaCodeTable: null == jmaCodeTable ? _self.jmaCodeTable : jmaCodeTable // ignore: cast_nullable_to_non_nullable
as JmaCodeTableParameter,kyoshinObservationPoints: null == kyoshinObservationPoints ? _self.kyoshinObservationPoints : kyoshinObservationPoints // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPointsParameter,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakeParameter,tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as TsunamiParameter,shindoDbStations: null == shindoDbStations ? _self.shindoDbStations : shindoDbStations // ignore: cast_nullable_to_non_nullable
as ShindoDbStationsParameter,
  ));
}
/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JmaCodeTableParameterCopyWith<$Res> get jmaCodeTable {
  
  return $JmaCodeTableParameterCopyWith<$Res>(_self.jmaCodeTable, (value) {
    return _then(_self.copyWith(jmaCodeTable: value));
  });
}/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinObservationPointsParameterCopyWith<$Res> get kyoshinObservationPoints {
  
  return $KyoshinObservationPointsParameterCopyWith<$Res>(_self.kyoshinObservationPoints, (value) {
    return _then(_self.copyWith(kyoshinObservationPoints: value));
  });
}/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterCopyWith<$Res> get earthquake {
  
  return $EarthquakeParameterCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiParameterCopyWith<$Res> get tsunami {
  
  return $TsunamiParameterCopyWith<$Res>(_self.tsunami, (value) {
    return _then(_self.copyWith(tsunami: value));
  });
}/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShindoDbStationsParameterCopyWith<$Res> get shindoDbStations {
  
  return $ShindoDbStationsParameterCopyWith<$Res>(_self.shindoDbStations, (value) {
    return _then(_self.copyWith(shindoDbStations: value));
  });
}
}


/// Adds pattern-matching-related methods to [ParameterSet].
extension ParameterSetPatterns on ParameterSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParameterSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParameterSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParameterSet value)  $default,){
final _that = this;
switch (_that) {
case _ParameterSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParameterSet value)?  $default,){
final _that = this;
switch (_that) {
case _ParameterSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AssetPackManifest manifest,  JmaCodeTableParameter jmaCodeTable,  KyoshinObservationPointsParameter kyoshinObservationPoints,  EarthquakeParameter earthquake,  TsunamiParameter tsunami,  ShindoDbStationsParameter shindoDbStations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParameterSet() when $default != null:
return $default(_that.manifest,_that.jmaCodeTable,_that.kyoshinObservationPoints,_that.earthquake,_that.tsunami,_that.shindoDbStations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AssetPackManifest manifest,  JmaCodeTableParameter jmaCodeTable,  KyoshinObservationPointsParameter kyoshinObservationPoints,  EarthquakeParameter earthquake,  TsunamiParameter tsunami,  ShindoDbStationsParameter shindoDbStations)  $default,) {final _that = this;
switch (_that) {
case _ParameterSet():
return $default(_that.manifest,_that.jmaCodeTable,_that.kyoshinObservationPoints,_that.earthquake,_that.tsunami,_that.shindoDbStations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AssetPackManifest manifest,  JmaCodeTableParameter jmaCodeTable,  KyoshinObservationPointsParameter kyoshinObservationPoints,  EarthquakeParameter earthquake,  TsunamiParameter tsunami,  ShindoDbStationsParameter shindoDbStations)?  $default,) {final _that = this;
switch (_that) {
case _ParameterSet() when $default != null:
return $default(_that.manifest,_that.jmaCodeTable,_that.kyoshinObservationPoints,_that.earthquake,_that.tsunami,_that.shindoDbStations);case _:
  return null;

}
}

}

/// @nodoc


class _ParameterSet implements ParameterSet {
  const _ParameterSet({required this.manifest, required this.jmaCodeTable, required this.kyoshinObservationPoints, required this.earthquake, required this.tsunami, required this.shindoDbStations});
  

/// Asset Pack の `manifest.json`（地図アセットも含む）。パラメータ固有のメタ
/// データが必要な場合は `manifest.findAsset(...)` を利用する。
@override final  AssetPackManifest manifest;
@override final  JmaCodeTableParameter jmaCodeTable;
@override final  KyoshinObservationPointsParameter kyoshinObservationPoints;
@override final  EarthquakeParameter earthquake;
@override final  TsunamiParameter tsunami;
@override final  ShindoDbStationsParameter shindoDbStations;

/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParameterSetCopyWith<_ParameterSet> get copyWith => __$ParameterSetCopyWithImpl<_ParameterSet>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParameterSet&&(identical(other.manifest, manifest) || other.manifest == manifest)&&(identical(other.jmaCodeTable, jmaCodeTable) || other.jmaCodeTable == jmaCodeTable)&&(identical(other.kyoshinObservationPoints, kyoshinObservationPoints) || other.kyoshinObservationPoints == kyoshinObservationPoints)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake)&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&(identical(other.shindoDbStations, shindoDbStations) || other.shindoDbStations == shindoDbStations));
}


@override
int get hashCode => Object.hash(runtimeType,manifest,jmaCodeTable,kyoshinObservationPoints,earthquake,tsunami,shindoDbStations);

@override
String toString() {
  return 'ParameterSet(manifest: $manifest, jmaCodeTable: $jmaCodeTable, kyoshinObservationPoints: $kyoshinObservationPoints, earthquake: $earthquake, tsunami: $tsunami, shindoDbStations: $shindoDbStations)';
}


}

/// @nodoc
abstract mixin class _$ParameterSetCopyWith<$Res> implements $ParameterSetCopyWith<$Res> {
  factory _$ParameterSetCopyWith(_ParameterSet value, $Res Function(_ParameterSet) _then) = __$ParameterSetCopyWithImpl;
@override @useResult
$Res call({
 AssetPackManifest manifest, JmaCodeTableParameter jmaCodeTable, KyoshinObservationPointsParameter kyoshinObservationPoints, EarthquakeParameter earthquake, TsunamiParameter tsunami, ShindoDbStationsParameter shindoDbStations
});


@override $JmaCodeTableParameterCopyWith<$Res> get jmaCodeTable;@override $KyoshinObservationPointsParameterCopyWith<$Res> get kyoshinObservationPoints;@override $EarthquakeParameterCopyWith<$Res> get earthquake;@override $TsunamiParameterCopyWith<$Res> get tsunami;@override $ShindoDbStationsParameterCopyWith<$Res> get shindoDbStations;

}
/// @nodoc
class __$ParameterSetCopyWithImpl<$Res>
    implements _$ParameterSetCopyWith<$Res> {
  __$ParameterSetCopyWithImpl(this._self, this._then);

  final _ParameterSet _self;
  final $Res Function(_ParameterSet) _then;

/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? manifest = null,Object? jmaCodeTable = null,Object? kyoshinObservationPoints = null,Object? earthquake = null,Object? tsunami = null,Object? shindoDbStations = null,}) {
  return _then(_ParameterSet(
manifest: null == manifest ? _self.manifest : manifest // ignore: cast_nullable_to_non_nullable
as AssetPackManifest,jmaCodeTable: null == jmaCodeTable ? _self.jmaCodeTable : jmaCodeTable // ignore: cast_nullable_to_non_nullable
as JmaCodeTableParameter,kyoshinObservationPoints: null == kyoshinObservationPoints ? _self.kyoshinObservationPoints : kyoshinObservationPoints // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPointsParameter,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakeParameter,tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as TsunamiParameter,shindoDbStations: null == shindoDbStations ? _self.shindoDbStations : shindoDbStations // ignore: cast_nullable_to_non_nullable
as ShindoDbStationsParameter,
  ));
}

/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JmaCodeTableParameterCopyWith<$Res> get jmaCodeTable {
  
  return $JmaCodeTableParameterCopyWith<$Res>(_self.jmaCodeTable, (value) {
    return _then(_self.copyWith(jmaCodeTable: value));
  });
}/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinObservationPointsParameterCopyWith<$Res> get kyoshinObservationPoints {
  
  return $KyoshinObservationPointsParameterCopyWith<$Res>(_self.kyoshinObservationPoints, (value) {
    return _then(_self.copyWith(kyoshinObservationPoints: value));
  });
}/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterCopyWith<$Res> get earthquake {
  
  return $EarthquakeParameterCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiParameterCopyWith<$Res> get tsunami {
  
  return $TsunamiParameterCopyWith<$Res>(_self.tsunami, (value) {
    return _then(_self.copyWith(tsunami: value));
  });
}/// Create a copy of ParameterSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShindoDbStationsParameterCopyWith<$Res> get shindoDbStations {
  
  return $ShindoDbStationsParameterCopyWith<$Res>(_self.shindoDbStations, (value) {
    return _then(_self.copyWith(shindoDbStations: value));
  });
}
}

// dart format on
