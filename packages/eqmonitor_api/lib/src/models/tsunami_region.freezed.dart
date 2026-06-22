// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiRegion {

/// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
 String get code; String get name; TsunamiWarningKind get kind;@JsonKey(name: 'last_kind') TsunamiWarningKind get lastKind; List<TsunamiRegionStation> get stations;@JsonKey(includeIfNull: false) TsunamiRegionForecast? get forecast;@JsonKey(includeIfNull: false) TsunamiRegionEstimation? get estimation;
/// Create a copy of TsunamiRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiRegionCopyWith<TsunamiRegion> get copyWith => _$TsunamiRegionCopyWithImpl<TsunamiRegion>(this as TsunamiRegion, _$identity);

  /// Serializes this TsunamiRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.lastKind, lastKind) || other.lastKind == lastKind)&&const DeepCollectionEquality().equals(other.stations, stations)&&(identical(other.forecast, forecast) || other.forecast == forecast)&&(identical(other.estimation, estimation) || other.estimation == estimation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kind,lastKind,const DeepCollectionEquality().hash(stations),forecast,estimation);

@override
String toString() {
  return 'TsunamiRegion(code: $code, name: $name, kind: $kind, lastKind: $lastKind, stations: $stations, forecast: $forecast, estimation: $estimation)';
}


}

/// @nodoc
abstract mixin class $TsunamiRegionCopyWith<$Res>  {
  factory $TsunamiRegionCopyWith(TsunamiRegion value, $Res Function(TsunamiRegion) _then) = _$TsunamiRegionCopyWithImpl;
@useResult
$Res call({
 String code, String name, TsunamiWarningKind kind,@JsonKey(name: 'last_kind') TsunamiWarningKind lastKind, List<TsunamiRegionStation> stations,@JsonKey(includeIfNull: false) TsunamiRegionForecast? forecast,@JsonKey(includeIfNull: false) TsunamiRegionEstimation? estimation
});


$TsunamiWarningKindCopyWith<$Res> get kind;$TsunamiWarningKindCopyWith<$Res> get lastKind;$TsunamiRegionForecastCopyWith<$Res>? get forecast;$TsunamiRegionEstimationCopyWith<$Res>? get estimation;

}
/// @nodoc
class _$TsunamiRegionCopyWithImpl<$Res>
    implements $TsunamiRegionCopyWith<$Res> {
  _$TsunamiRegionCopyWithImpl(this._self, this._then);

  final TsunamiRegion _self;
  final $Res Function(TsunamiRegion) _then;

/// Create a copy of TsunamiRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kind = null,Object? lastKind = null,Object? stations = null,Object? forecast = freezed,Object? estimation = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,lastKind: null == lastKind ? _self.lastKind : lastKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiRegionStation>,forecast: freezed == forecast ? _self.forecast : forecast // ignore: cast_nullable_to_non_nullable
as TsunamiRegionForecast?,estimation: freezed == estimation ? _self.estimation : estimation // ignore: cast_nullable_to_non_nullable
as TsunamiRegionEstimation?,
  ));
}
/// Create a copy of TsunamiRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiWarningKindCopyWith<$Res> get kind {
  
  return $TsunamiWarningKindCopyWith<$Res>(_self.kind, (value) {
    return _then(_self.copyWith(kind: value));
  });
}/// Create a copy of TsunamiRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiWarningKindCopyWith<$Res> get lastKind {
  
  return $TsunamiWarningKindCopyWith<$Res>(_self.lastKind, (value) {
    return _then(_self.copyWith(lastKind: value));
  });
}/// Create a copy of TsunamiRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiRegionForecastCopyWith<$Res>? get forecast {
    if (_self.forecast == null) {
    return null;
  }

  return $TsunamiRegionForecastCopyWith<$Res>(_self.forecast!, (value) {
    return _then(_self.copyWith(forecast: value));
  });
}/// Create a copy of TsunamiRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiRegionEstimationCopyWith<$Res>? get estimation {
    if (_self.estimation == null) {
    return null;
  }

  return $TsunamiRegionEstimationCopyWith<$Res>(_self.estimation!, (value) {
    return _then(_self.copyWith(estimation: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiRegion].
extension TsunamiRegionPatterns on TsunamiRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiRegion value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiRegion value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  TsunamiWarningKind kind, @JsonKey(name: 'last_kind')  TsunamiWarningKind lastKind,  List<TsunamiRegionStation> stations, @JsonKey(includeIfNull: false)  TsunamiRegionForecast? forecast, @JsonKey(includeIfNull: false)  TsunamiRegionEstimation? estimation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiRegion() when $default != null:
return $default(_that.code,_that.name,_that.kind,_that.lastKind,_that.stations,_that.forecast,_that.estimation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  TsunamiWarningKind kind, @JsonKey(name: 'last_kind')  TsunamiWarningKind lastKind,  List<TsunamiRegionStation> stations, @JsonKey(includeIfNull: false)  TsunamiRegionForecast? forecast, @JsonKey(includeIfNull: false)  TsunamiRegionEstimation? estimation)  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegion():
return $default(_that.code,_that.name,_that.kind,_that.lastKind,_that.stations,_that.forecast,_that.estimation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  TsunamiWarningKind kind, @JsonKey(name: 'last_kind')  TsunamiWarningKind lastKind,  List<TsunamiRegionStation> stations, @JsonKey(includeIfNull: false)  TsunamiRegionForecast? forecast, @JsonKey(includeIfNull: false)  TsunamiRegionEstimation? estimation)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegion() when $default != null:
return $default(_that.code,_that.name,_that.kind,_that.lastKind,_that.stations,_that.forecast,_that.estimation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiRegion implements TsunamiRegion {
  const _TsunamiRegion({required this.code, required this.name, required this.kind, @JsonKey(name: 'last_kind') required this.lastKind, required final  List<TsunamiRegionStation> stations, @JsonKey(includeIfNull: false) this.forecast, @JsonKey(includeIfNull: false) this.estimation}): _stations = stations;
  factory _TsunamiRegion.fromJson(Map<String, dynamic> json) => _$TsunamiRegionFromJson(json);

/// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
@override final  String code;
@override final  String name;
@override final  TsunamiWarningKind kind;
@override@JsonKey(name: 'last_kind') final  TsunamiWarningKind lastKind;
 final  List<TsunamiRegionStation> _stations;
@override List<TsunamiRegionStation> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}

@override@JsonKey(includeIfNull: false) final  TsunamiRegionForecast? forecast;
@override@JsonKey(includeIfNull: false) final  TsunamiRegionEstimation? estimation;

/// Create a copy of TsunamiRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiRegionCopyWith<_TsunamiRegion> get copyWith => __$TsunamiRegionCopyWithImpl<_TsunamiRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.lastKind, lastKind) || other.lastKind == lastKind)&&const DeepCollectionEquality().equals(other._stations, _stations)&&(identical(other.forecast, forecast) || other.forecast == forecast)&&(identical(other.estimation, estimation) || other.estimation == estimation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kind,lastKind,const DeepCollectionEquality().hash(_stations),forecast,estimation);

@override
String toString() {
  return 'TsunamiRegion(code: $code, name: $name, kind: $kind, lastKind: $lastKind, stations: $stations, forecast: $forecast, estimation: $estimation)';
}


}

/// @nodoc
abstract mixin class _$TsunamiRegionCopyWith<$Res> implements $TsunamiRegionCopyWith<$Res> {
  factory _$TsunamiRegionCopyWith(_TsunamiRegion value, $Res Function(_TsunamiRegion) _then) = __$TsunamiRegionCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, TsunamiWarningKind kind,@JsonKey(name: 'last_kind') TsunamiWarningKind lastKind, List<TsunamiRegionStation> stations,@JsonKey(includeIfNull: false) TsunamiRegionForecast? forecast,@JsonKey(includeIfNull: false) TsunamiRegionEstimation? estimation
});


@override $TsunamiWarningKindCopyWith<$Res> get kind;@override $TsunamiWarningKindCopyWith<$Res> get lastKind;@override $TsunamiRegionForecastCopyWith<$Res>? get forecast;@override $TsunamiRegionEstimationCopyWith<$Res>? get estimation;

}
/// @nodoc
class __$TsunamiRegionCopyWithImpl<$Res>
    implements _$TsunamiRegionCopyWith<$Res> {
  __$TsunamiRegionCopyWithImpl(this._self, this._then);

  final _TsunamiRegion _self;
  final $Res Function(_TsunamiRegion) _then;

/// Create a copy of TsunamiRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kind = null,Object? lastKind = null,Object? stations = null,Object? forecast = freezed,Object? estimation = freezed,}) {
  return _then(_TsunamiRegion(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,lastKind: null == lastKind ? _self.lastKind : lastKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiRegionStation>,forecast: freezed == forecast ? _self.forecast : forecast // ignore: cast_nullable_to_non_nullable
as TsunamiRegionForecast?,estimation: freezed == estimation ? _self.estimation : estimation // ignore: cast_nullable_to_non_nullable
as TsunamiRegionEstimation?,
  ));
}

/// Create a copy of TsunamiRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiWarningKindCopyWith<$Res> get kind {
  
  return $TsunamiWarningKindCopyWith<$Res>(_self.kind, (value) {
    return _then(_self.copyWith(kind: value));
  });
}/// Create a copy of TsunamiRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiWarningKindCopyWith<$Res> get lastKind {
  
  return $TsunamiWarningKindCopyWith<$Res>(_self.lastKind, (value) {
    return _then(_self.copyWith(lastKind: value));
  });
}/// Create a copy of TsunamiRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiRegionForecastCopyWith<$Res>? get forecast {
    if (_self.forecast == null) {
    return null;
  }

  return $TsunamiRegionForecastCopyWith<$Res>(_self.forecast!, (value) {
    return _then(_self.copyWith(forecast: value));
  });
}/// Create a copy of TsunamiRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiRegionEstimationCopyWith<$Res>? get estimation {
    if (_self.estimation == null) {
    return null;
  }

  return $TsunamiRegionEstimationCopyWith<$Res>(_self.estimation!, (value) {
    return _then(_self.copyWith(estimation: value));
  });
}
}

// dart format on
