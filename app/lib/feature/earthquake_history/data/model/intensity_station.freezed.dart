// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityStation {

 String get code; String get name; double? get sva; List<PrePeriod>? get prePeriods; JmaIntensity? get maxIntensity; JmaLpgmIntensity? get maxLpgmIntensity;
/// Create a copy of IntensityStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityStationCopyWith<IntensityStation> get copyWith => _$IntensityStationCopyWithImpl<IntensityStation>(this as IntensityStation, _$identity);

  /// Serializes this IntensityStation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other.prePeriods, prePeriods)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,sva,const DeepCollectionEquality().hash(prePeriods),maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'IntensityStation(code: $code, name: $name, sva: $sva, prePeriods: $prePeriods, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityStationCopyWith<$Res>  {
  factory $IntensityStationCopyWith(IntensityStation value, $Res Function(IntensityStation) _then) = _$IntensityStationCopyWithImpl;
@useResult
$Res call({
 String code, String name, double? sva, List<PrePeriod>? prePeriods, JmaIntensity? maxIntensity, JmaLpgmIntensity? maxLpgmIntensity
});




}
/// @nodoc
class _$IntensityStationCopyWithImpl<$Res>
    implements $IntensityStationCopyWith<$Res> {
  _$IntensityStationCopyWithImpl(this._self, this._then);

  final IntensityStation _self;
  final $Res Function(IntensityStation) _then;

/// Create a copy of IntensityStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? sva = freezed,Object? prePeriods = freezed,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,}) {
  return _then(IntensityStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double?,prePeriods: freezed == prePeriods ? _self.prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriod>?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityStation].
extension IntensityStationPatterns on IntensityStation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityStation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityStation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityStation value)  $default,){
final _that = this;
switch (_that) {
case _IntensityStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityStation value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityStation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  double? sva,  List<PrePeriod>? prePeriods,  JmaIntensity? maxIntensity,  JmaLpgmIntensity? maxLpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityStation() when $default != null:
return $default(_that.code,_that.name,_that.sva,_that.prePeriods,_that.maxIntensity,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  double? sva,  List<PrePeriod>? prePeriods,  JmaIntensity? maxIntensity,  JmaLpgmIntensity? maxLpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityStation():
return $default(_that.code,_that.name,_that.sva,_that.prePeriods,_that.maxIntensity,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  double? sva,  List<PrePeriod>? prePeriods,  JmaIntensity? maxIntensity,  JmaLpgmIntensity? maxLpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityStation() when $default != null:
return $default(_that.code,_that.name,_that.sva,_that.prePeriods,_that.maxIntensity,_that.maxLpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityStation implements IntensityStation {
  const _IntensityStation({required this.code, required this.name, required this.sva, required  List<PrePeriod>? prePeriods, required this.maxIntensity, required this.maxLpgmIntensity}): _prePeriods = prePeriods;
  factory _IntensityStation.fromJson(Map<String, dynamic> json) => _$IntensityStationFromJson(json);

@override final  String code;
@override final  String name;
@override final  double? sva;
 final  List<PrePeriod>? _prePeriods;
@override List<PrePeriod>? get prePeriods {
  final value = _prePeriods;
  if (value == null) return null;
  if (_prePeriods is EqualUnmodifiableListView) return _prePeriods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  JmaIntensity? maxIntensity;
@override final  JmaLpgmIntensity? maxLpgmIntensity;

/// Create a copy of IntensityStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityStationCopyWith<_IntensityStation> get copyWith => __$IntensityStationCopyWithImpl<_IntensityStation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityStationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other._prePeriods, _prePeriods)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,sva,const DeepCollectionEquality().hash(_prePeriods),maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'IntensityStation(code: $code, name: $name, sva: $sva, prePeriods: $prePeriods, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityStationCopyWith<$Res> implements $IntensityStationCopyWith<$Res> {
  factory _$IntensityStationCopyWith(_IntensityStation value, $Res Function(_IntensityStation) _then) = __$IntensityStationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, double? sva, List<PrePeriod>? prePeriods, JmaIntensity? maxIntensity, JmaLpgmIntensity? maxLpgmIntensity
});




}
/// @nodoc
class __$IntensityStationCopyWithImpl<$Res>
    implements _$IntensityStationCopyWith<$Res> {
  __$IntensityStationCopyWithImpl(this._self, this._then);

  final _IntensityStation _self;
  final $Res Function(_IntensityStation) _then;

/// Create a copy of IntensityStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? sva = freezed,Object? prePeriods = freezed,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,}) {
  return _then(_IntensityStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double?,prePeriods: freezed == prePeriods ? _self._prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriod>?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}


}


/// @nodoc
mixin _$PrePeriod {

 double get band; JmaLpgmIntensity get lpgmIntensity; double get sva;
/// Create a copy of PrePeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrePeriodCopyWith<PrePeriod> get copyWith => _$PrePeriodCopyWithImpl<PrePeriod>(this as PrePeriod, _$identity);

  /// Serializes this PrePeriod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrePeriod&&(identical(other.band, band) || other.band == band)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,band,lpgmIntensity,sva);

@override
String toString() {
  return 'PrePeriod(band: $band, lpgmIntensity: $lpgmIntensity, sva: $sva)';
}


}

/// @nodoc
abstract mixin class $PrePeriodCopyWith<$Res>  {
  factory $PrePeriodCopyWith(PrePeriod value, $Res Function(PrePeriod) _then) = _$PrePeriodCopyWithImpl;
@useResult
$Res call({
 double band, JmaLpgmIntensity lpgmIntensity, double sva
});




}
/// @nodoc
class _$PrePeriodCopyWithImpl<$Res>
    implements $PrePeriodCopyWith<$Res> {
  _$PrePeriodCopyWithImpl(this._self, this._then);

  final PrePeriod _self;
  final $Res Function(PrePeriod) _then;

/// Create a copy of PrePeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? band = null,Object? lpgmIntensity = null,Object? sva = null,}) {
  return _then(PrePeriod(
band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as double,lpgmIntensity: null == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity,sva: null == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PrePeriod].
extension PrePeriodPatterns on PrePeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrePeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrePeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrePeriod value)  $default,){
final _that = this;
switch (_that) {
case _PrePeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrePeriod value)?  $default,){
final _that = this;
switch (_that) {
case _PrePeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double band,  JmaLpgmIntensity lpgmIntensity,  double sva)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrePeriod() when $default != null:
return $default(_that.band,_that.lpgmIntensity,_that.sva);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double band,  JmaLpgmIntensity lpgmIntensity,  double sva)  $default,) {final _that = this;
switch (_that) {
case _PrePeriod():
return $default(_that.band,_that.lpgmIntensity,_that.sva);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double band,  JmaLpgmIntensity lpgmIntensity,  double sva)?  $default,) {final _that = this;
switch (_that) {
case _PrePeriod() when $default != null:
return $default(_that.band,_that.lpgmIntensity,_that.sva);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrePeriod implements PrePeriod {
  const _PrePeriod({required this.band, required this.lpgmIntensity, required this.sva});
  factory _PrePeriod.fromJson(Map<String, dynamic> json) => _$PrePeriodFromJson(json);

@override final  double band;
@override final  JmaLpgmIntensity lpgmIntensity;
@override final  double sva;

/// Create a copy of PrePeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrePeriodCopyWith<_PrePeriod> get copyWith => __$PrePeriodCopyWithImpl<_PrePeriod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrePeriodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrePeriod&&(identical(other.band, band) || other.band == band)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,band,lpgmIntensity,sva);

@override
String toString() {
  return 'PrePeriod(band: $band, lpgmIntensity: $lpgmIntensity, sva: $sva)';
}


}

/// @nodoc
abstract mixin class _$PrePeriodCopyWith<$Res> implements $PrePeriodCopyWith<$Res> {
  factory _$PrePeriodCopyWith(_PrePeriod value, $Res Function(_PrePeriod) _then) = __$PrePeriodCopyWithImpl;
@override @useResult
$Res call({
 double band, JmaLpgmIntensity lpgmIntensity, double sva
});




}
/// @nodoc
class __$PrePeriodCopyWithImpl<$Res>
    implements _$PrePeriodCopyWith<$Res> {
  __$PrePeriodCopyWithImpl(this._self, this._then);

  final _PrePeriod _self;
  final $Res Function(_PrePeriod) _then;

/// Create a copy of PrePeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? band = null,Object? lpgmIntensity = null,Object? sva = null,}) {
  return _then(_PrePeriod(
band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as double,lpgmIntensity: null == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity,sva: null == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
