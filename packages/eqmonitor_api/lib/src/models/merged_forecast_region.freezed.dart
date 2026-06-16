// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'merged_forecast_region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MergedForecastRegion {

 String get code; String get name; TsunamiWarningKind get kind;@JsonKey(includeIfNull: false, name: 'kind_code') String? get kindCode;@JsonKey(includeIfNull: false, name: 'last_kind') TsunamiWarningKind? get lastKind;@JsonKey(includeIfNull: false, name: 'first_height') TsunamiForecastFirstHeight? get firstHeight;@JsonKey(includeIfNull: false, name: 'max_height') TsunamiForecastMaxHeight? get maxHeight;@JsonKey(includeIfNull: false) List<TsunamiForecastStation>? get stations;@JsonKey(includeIfNull: false) Observation? get observation;@JsonKey(includeIfNull: false) Estimation? get estimation;
/// Create a copy of MergedForecastRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MergedForecastRegionCopyWith<MergedForecastRegion> get copyWith => _$MergedForecastRegionCopyWithImpl<MergedForecastRegion>(this as MergedForecastRegion, _$identity);

  /// Serializes this MergedForecastRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MergedForecastRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.kindCode, kindCode) || other.kindCode == kindCode)&&(identical(other.lastKind, lastKind) || other.lastKind == lastKind)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&const DeepCollectionEquality().equals(other.stations, stations)&&(identical(other.observation, observation) || other.observation == observation)&&(identical(other.estimation, estimation) || other.estimation == estimation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kind,kindCode,lastKind,firstHeight,maxHeight,const DeepCollectionEquality().hash(stations),observation,estimation);

@override
String toString() {
  return 'MergedForecastRegion(code: $code, name: $name, kind: $kind, kindCode: $kindCode, lastKind: $lastKind, firstHeight: $firstHeight, maxHeight: $maxHeight, stations: $stations, observation: $observation, estimation: $estimation)';
}


}

/// @nodoc
abstract mixin class $MergedForecastRegionCopyWith<$Res>  {
  factory $MergedForecastRegionCopyWith(MergedForecastRegion value, $Res Function(MergedForecastRegion) _then) = _$MergedForecastRegionCopyWithImpl;
@useResult
$Res call({
 String code, String name, TsunamiWarningKind kind,@JsonKey(includeIfNull: false, name: 'kind_code') String? kindCode,@JsonKey(includeIfNull: false, name: 'last_kind') TsunamiWarningKind? lastKind,@JsonKey(includeIfNull: false, name: 'first_height') TsunamiForecastFirstHeight? firstHeight,@JsonKey(includeIfNull: false, name: 'max_height') TsunamiForecastMaxHeight? maxHeight,@JsonKey(includeIfNull: false) List<TsunamiForecastStation>? stations,@JsonKey(includeIfNull: false) Observation? observation,@JsonKey(includeIfNull: false) Estimation? estimation
});


$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight;$TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight;$ObservationCopyWith<$Res>? get observation;$EstimationCopyWith<$Res>? get estimation;

}
/// @nodoc
class _$MergedForecastRegionCopyWithImpl<$Res>
    implements $MergedForecastRegionCopyWith<$Res> {
  _$MergedForecastRegionCopyWithImpl(this._self, this._then);

  final MergedForecastRegion _self;
  final $Res Function(MergedForecastRegion) _then;

/// Create a copy of MergedForecastRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kind = null,Object? kindCode = freezed,Object? lastKind = freezed,Object? firstHeight = freezed,Object? maxHeight = freezed,Object? stations = freezed,Object? observation = freezed,Object? estimation = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,kindCode: freezed == kindCode ? _self.kindCode : kindCode // ignore: cast_nullable_to_non_nullable
as String?,lastKind: freezed == lastKind ? _self.lastKind : lastKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind?,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastMaxHeight?,stations: freezed == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecastStation>?,observation: freezed == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as Observation?,estimation: freezed == estimation ? _self.estimation : estimation // ignore: cast_nullable_to_non_nullable
as Estimation?,
  ));
}
/// Create a copy of MergedForecastRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiForecastFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of MergedForecastRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiForecastMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}/// Create a copy of MergedForecastRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res>? get observation {
    if (_self.observation == null) {
    return null;
  }

  return $ObservationCopyWith<$Res>(_self.observation!, (value) {
    return _then(_self.copyWith(observation: value));
  });
}/// Create a copy of MergedForecastRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstimationCopyWith<$Res>? get estimation {
    if (_self.estimation == null) {
    return null;
  }

  return $EstimationCopyWith<$Res>(_self.estimation!, (value) {
    return _then(_self.copyWith(estimation: value));
  });
}
}


/// Adds pattern-matching-related methods to [MergedForecastRegion].
extension MergedForecastRegionPatterns on MergedForecastRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MergedForecastRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MergedForecastRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MergedForecastRegion value)  $default,){
final _that = this;
switch (_that) {
case _MergedForecastRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MergedForecastRegion value)?  $default,){
final _that = this;
switch (_that) {
case _MergedForecastRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  TsunamiWarningKind kind, @JsonKey(includeIfNull: false, name: 'kind_code')  String? kindCode, @JsonKey(includeIfNull: false, name: 'last_kind')  TsunamiWarningKind? lastKind, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiForecastFirstHeight? firstHeight, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiForecastMaxHeight? maxHeight, @JsonKey(includeIfNull: false)  List<TsunamiForecastStation>? stations, @JsonKey(includeIfNull: false)  Observation? observation, @JsonKey(includeIfNull: false)  Estimation? estimation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MergedForecastRegion() when $default != null:
return $default(_that.code,_that.name,_that.kind,_that.kindCode,_that.lastKind,_that.firstHeight,_that.maxHeight,_that.stations,_that.observation,_that.estimation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  TsunamiWarningKind kind, @JsonKey(includeIfNull: false, name: 'kind_code')  String? kindCode, @JsonKey(includeIfNull: false, name: 'last_kind')  TsunamiWarningKind? lastKind, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiForecastFirstHeight? firstHeight, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiForecastMaxHeight? maxHeight, @JsonKey(includeIfNull: false)  List<TsunamiForecastStation>? stations, @JsonKey(includeIfNull: false)  Observation? observation, @JsonKey(includeIfNull: false)  Estimation? estimation)  $default,) {final _that = this;
switch (_that) {
case _MergedForecastRegion():
return $default(_that.code,_that.name,_that.kind,_that.kindCode,_that.lastKind,_that.firstHeight,_that.maxHeight,_that.stations,_that.observation,_that.estimation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  TsunamiWarningKind kind, @JsonKey(includeIfNull: false, name: 'kind_code')  String? kindCode, @JsonKey(includeIfNull: false, name: 'last_kind')  TsunamiWarningKind? lastKind, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiForecastFirstHeight? firstHeight, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiForecastMaxHeight? maxHeight, @JsonKey(includeIfNull: false)  List<TsunamiForecastStation>? stations, @JsonKey(includeIfNull: false)  Observation? observation, @JsonKey(includeIfNull: false)  Estimation? estimation)?  $default,) {final _that = this;
switch (_that) {
case _MergedForecastRegion() when $default != null:
return $default(_that.code,_that.name,_that.kind,_that.kindCode,_that.lastKind,_that.firstHeight,_that.maxHeight,_that.stations,_that.observation,_that.estimation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MergedForecastRegion implements MergedForecastRegion {
  const _MergedForecastRegion({required this.code, required this.name, required this.kind, @JsonKey(includeIfNull: false, name: 'kind_code') this.kindCode, @JsonKey(includeIfNull: false, name: 'last_kind') this.lastKind, @JsonKey(includeIfNull: false, name: 'first_height') this.firstHeight, @JsonKey(includeIfNull: false, name: 'max_height') this.maxHeight, @JsonKey(includeIfNull: false) final  List<TsunamiForecastStation>? stations, @JsonKey(includeIfNull: false) this.observation, @JsonKey(includeIfNull: false) this.estimation}): _stations = stations;
  factory _MergedForecastRegion.fromJson(Map<String, dynamic> json) => _$MergedForecastRegionFromJson(json);

@override final  String code;
@override final  String name;
@override final  TsunamiWarningKind kind;
@override@JsonKey(includeIfNull: false, name: 'kind_code') final  String? kindCode;
@override@JsonKey(includeIfNull: false, name: 'last_kind') final  TsunamiWarningKind? lastKind;
@override@JsonKey(includeIfNull: false, name: 'first_height') final  TsunamiForecastFirstHeight? firstHeight;
@override@JsonKey(includeIfNull: false, name: 'max_height') final  TsunamiForecastMaxHeight? maxHeight;
 final  List<TsunamiForecastStation>? _stations;
@override@JsonKey(includeIfNull: false) List<TsunamiForecastStation>? get stations {
  final value = _stations;
  if (value == null) return null;
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeIfNull: false) final  Observation? observation;
@override@JsonKey(includeIfNull: false) final  Estimation? estimation;

/// Create a copy of MergedForecastRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MergedForecastRegionCopyWith<_MergedForecastRegion> get copyWith => __$MergedForecastRegionCopyWithImpl<_MergedForecastRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MergedForecastRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MergedForecastRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.kindCode, kindCode) || other.kindCode == kindCode)&&(identical(other.lastKind, lastKind) || other.lastKind == lastKind)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&const DeepCollectionEquality().equals(other._stations, _stations)&&(identical(other.observation, observation) || other.observation == observation)&&(identical(other.estimation, estimation) || other.estimation == estimation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kind,kindCode,lastKind,firstHeight,maxHeight,const DeepCollectionEquality().hash(_stations),observation,estimation);

@override
String toString() {
  return 'MergedForecastRegion(code: $code, name: $name, kind: $kind, kindCode: $kindCode, lastKind: $lastKind, firstHeight: $firstHeight, maxHeight: $maxHeight, stations: $stations, observation: $observation, estimation: $estimation)';
}


}

/// @nodoc
abstract mixin class _$MergedForecastRegionCopyWith<$Res> implements $MergedForecastRegionCopyWith<$Res> {
  factory _$MergedForecastRegionCopyWith(_MergedForecastRegion value, $Res Function(_MergedForecastRegion) _then) = __$MergedForecastRegionCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, TsunamiWarningKind kind,@JsonKey(includeIfNull: false, name: 'kind_code') String? kindCode,@JsonKey(includeIfNull: false, name: 'last_kind') TsunamiWarningKind? lastKind,@JsonKey(includeIfNull: false, name: 'first_height') TsunamiForecastFirstHeight? firstHeight,@JsonKey(includeIfNull: false, name: 'max_height') TsunamiForecastMaxHeight? maxHeight,@JsonKey(includeIfNull: false) List<TsunamiForecastStation>? stations,@JsonKey(includeIfNull: false) Observation? observation,@JsonKey(includeIfNull: false) Estimation? estimation
});


@override $TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight;@override $TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight;@override $ObservationCopyWith<$Res>? get observation;@override $EstimationCopyWith<$Res>? get estimation;

}
/// @nodoc
class __$MergedForecastRegionCopyWithImpl<$Res>
    implements _$MergedForecastRegionCopyWith<$Res> {
  __$MergedForecastRegionCopyWithImpl(this._self, this._then);

  final _MergedForecastRegion _self;
  final $Res Function(_MergedForecastRegion) _then;

/// Create a copy of MergedForecastRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kind = null,Object? kindCode = freezed,Object? lastKind = freezed,Object? firstHeight = freezed,Object? maxHeight = freezed,Object? stations = freezed,Object? observation = freezed,Object? estimation = freezed,}) {
  return _then(_MergedForecastRegion(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,kindCode: freezed == kindCode ? _self.kindCode : kindCode // ignore: cast_nullable_to_non_nullable
as String?,lastKind: freezed == lastKind ? _self.lastKind : lastKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind?,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastMaxHeight?,stations: freezed == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecastStation>?,observation: freezed == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as Observation?,estimation: freezed == estimation ? _self.estimation : estimation // ignore: cast_nullable_to_non_nullable
as Estimation?,
  ));
}

/// Create a copy of MergedForecastRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiForecastFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of MergedForecastRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiForecastMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}/// Create a copy of MergedForecastRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res>? get observation {
    if (_self.observation == null) {
    return null;
  }

  return $ObservationCopyWith<$Res>(_self.observation!, (value) {
    return _then(_self.copyWith(observation: value));
  });
}/// Create a copy of MergedForecastRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstimationCopyWith<$Res>? get estimation {
    if (_self.estimation == null) {
    return null;
  }

  return $EstimationCopyWith<$Res>(_self.estimation!, (value) {
    return _then(_self.copyWith(estimation: value));
  });
}
}

// dart format on
