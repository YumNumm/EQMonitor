// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_region_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiRegionStation {

/// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
 String get code; String get name;@JsonKey(includeIfNull: false) TsunamiStationForecast? get forecast;@JsonKey(includeIfNull: false) TsunamiStationObservation? get observation;
/// Create a copy of TsunamiRegionStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiRegionStationCopyWith<TsunamiRegionStation> get copyWith => _$TsunamiRegionStationCopyWithImpl<TsunamiRegionStation>(this as TsunamiRegionStation, _$identity);

  /// Serializes this TsunamiRegionStation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiRegionStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.forecast, forecast) || other.forecast == forecast)&&(identical(other.observation, observation) || other.observation == observation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,forecast,observation);

@override
String toString() {
  return 'TsunamiRegionStation(code: $code, name: $name, forecast: $forecast, observation: $observation)';
}


}

/// @nodoc
abstract mixin class $TsunamiRegionStationCopyWith<$Res>  {
  factory $TsunamiRegionStationCopyWith(TsunamiRegionStation value, $Res Function(TsunamiRegionStation) _then) = _$TsunamiRegionStationCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JsonKey(includeIfNull: false) TsunamiStationForecast? forecast,@JsonKey(includeIfNull: false) TsunamiStationObservation? observation
});


$TsunamiStationForecastCopyWith<$Res>? get forecast;$TsunamiStationObservationCopyWith<$Res>? get observation;

}
/// @nodoc
class _$TsunamiRegionStationCopyWithImpl<$Res>
    implements $TsunamiRegionStationCopyWith<$Res> {
  _$TsunamiRegionStationCopyWithImpl(this._self, this._then);

  final TsunamiRegionStation _self;
  final $Res Function(TsunamiRegionStation) _then;

/// Create a copy of TsunamiRegionStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? forecast = freezed,Object? observation = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,forecast: freezed == forecast ? _self.forecast : forecast // ignore: cast_nullable_to_non_nullable
as TsunamiStationForecast?,observation: freezed == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as TsunamiStationObservation?,
  ));
}
/// Create a copy of TsunamiRegionStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationForecastCopyWith<$Res>? get forecast {
    if (_self.forecast == null) {
    return null;
  }

  return $TsunamiStationForecastCopyWith<$Res>(_self.forecast!, (value) {
    return _then(_self.copyWith(forecast: value));
  });
}/// Create a copy of TsunamiRegionStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationObservationCopyWith<$Res>? get observation {
    if (_self.observation == null) {
    return null;
  }

  return $TsunamiStationObservationCopyWith<$Res>(_self.observation!, (value) {
    return _then(_self.copyWith(observation: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiRegionStation].
extension TsunamiRegionStationPatterns on TsunamiRegionStation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiRegionStation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiRegionStation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiRegionStation value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiRegionStation value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionStation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(includeIfNull: false)  TsunamiStationForecast? forecast, @JsonKey(includeIfNull: false)  TsunamiStationObservation? observation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiRegionStation() when $default != null:
return $default(_that.code,_that.name,_that.forecast,_that.observation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(includeIfNull: false)  TsunamiStationForecast? forecast, @JsonKey(includeIfNull: false)  TsunamiStationObservation? observation)  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionStation():
return $default(_that.code,_that.name,_that.forecast,_that.observation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name, @JsonKey(includeIfNull: false)  TsunamiStationForecast? forecast, @JsonKey(includeIfNull: false)  TsunamiStationObservation? observation)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionStation() when $default != null:
return $default(_that.code,_that.name,_that.forecast,_that.observation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiRegionStation implements TsunamiRegionStation {
  const _TsunamiRegionStation({required this.code, required this.name, @JsonKey(includeIfNull: false) this.forecast, @JsonKey(includeIfNull: false) this.observation});
  factory _TsunamiRegionStation.fromJson(Map<String, dynamic> json) => _$TsunamiRegionStationFromJson(json);

/// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
@override final  String code;
@override final  String name;
@override@JsonKey(includeIfNull: false) final  TsunamiStationForecast? forecast;
@override@JsonKey(includeIfNull: false) final  TsunamiStationObservation? observation;

/// Create a copy of TsunamiRegionStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiRegionStationCopyWith<_TsunamiRegionStation> get copyWith => __$TsunamiRegionStationCopyWithImpl<_TsunamiRegionStation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiRegionStationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiRegionStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.forecast, forecast) || other.forecast == forecast)&&(identical(other.observation, observation) || other.observation == observation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,forecast,observation);

@override
String toString() {
  return 'TsunamiRegionStation(code: $code, name: $name, forecast: $forecast, observation: $observation)';
}


}

/// @nodoc
abstract mixin class _$TsunamiRegionStationCopyWith<$Res> implements $TsunamiRegionStationCopyWith<$Res> {
  factory _$TsunamiRegionStationCopyWith(_TsunamiRegionStation value, $Res Function(_TsunamiRegionStation) _then) = __$TsunamiRegionStationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JsonKey(includeIfNull: false) TsunamiStationForecast? forecast,@JsonKey(includeIfNull: false) TsunamiStationObservation? observation
});


@override $TsunamiStationForecastCopyWith<$Res>? get forecast;@override $TsunamiStationObservationCopyWith<$Res>? get observation;

}
/// @nodoc
class __$TsunamiRegionStationCopyWithImpl<$Res>
    implements _$TsunamiRegionStationCopyWith<$Res> {
  __$TsunamiRegionStationCopyWithImpl(this._self, this._then);

  final _TsunamiRegionStation _self;
  final $Res Function(_TsunamiRegionStation) _then;

/// Create a copy of TsunamiRegionStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? forecast = freezed,Object? observation = freezed,}) {
  return _then(_TsunamiRegionStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,forecast: freezed == forecast ? _self.forecast : forecast // ignore: cast_nullable_to_non_nullable
as TsunamiStationForecast?,observation: freezed == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as TsunamiStationObservation?,
  ));
}

/// Create a copy of TsunamiRegionStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationForecastCopyWith<$Res>? get forecast {
    if (_self.forecast == null) {
    return null;
  }

  return $TsunamiStationForecastCopyWith<$Res>(_self.forecast!, (value) {
    return _then(_self.copyWith(forecast: value));
  });
}/// Create a copy of TsunamiRegionStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationObservationCopyWith<$Res>? get observation {
    if (_self.observation == null) {
    return null;
  }

  return $TsunamiStationObservationCopyWith<$Res>(_self.observation!, (value) {
    return _then(_self.copyWith(observation: value));
  });
}
}

// dart format on
