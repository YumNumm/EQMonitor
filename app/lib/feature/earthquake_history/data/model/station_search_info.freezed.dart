// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'station_search_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StationSearchInfo {

 String get code; String get name; JmaIntensity? get intensity; JmaLpgmIntensity? get lpgmIntensity; double? get sva; List<PrePeriod>? get prePeriods;
/// Create a copy of StationSearchInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationSearchInfoCopyWith<StationSearchInfo> get copyWith => _$StationSearchInfoCopyWithImpl<StationSearchInfo>(this as StationSearchInfo, _$identity);

  /// Serializes this StationSearchInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationSearchInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other.prePeriods, prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity,sva,const DeepCollectionEquality().hash(prePeriods));

@override
String toString() {
  return 'StationSearchInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class $StationSearchInfoCopyWith<$Res>  {
  factory $StationSearchInfoCopyWith(StationSearchInfo value, $Res Function(StationSearchInfo) _then) = _$StationSearchInfoCopyWithImpl;
@useResult
$Res call({
 String code, String name, JmaIntensity? intensity, JmaLpgmIntensity? lpgmIntensity, double? sva, List<PrePeriod>? prePeriods
});




}
/// @nodoc
class _$StationSearchInfoCopyWithImpl<$Res>
    implements $StationSearchInfoCopyWith<$Res> {
  _$StationSearchInfoCopyWithImpl(this._self, this._then);

  final StationSearchInfo _self;
  final $Res Function(StationSearchInfo) _then;

/// Create a copy of StationSearchInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double?,prePeriods: freezed == prePeriods ? _self.prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriod>?,
  ));
}

}


/// Adds pattern-matching-related methods to [StationSearchInfo].
extension StationSearchInfoPatterns on StationSearchInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StationSearchInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StationSearchInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StationSearchInfo value)  $default,){
final _that = this;
switch (_that) {
case _StationSearchInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StationSearchInfo value)?  $default,){
final _that = this;
switch (_that) {
case _StationSearchInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  JmaIntensity? intensity,  JmaLpgmIntensity? lpgmIntensity,  double? sva,  List<PrePeriod>? prePeriods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StationSearchInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  JmaIntensity? intensity,  JmaLpgmIntensity? lpgmIntensity,  double? sva,  List<PrePeriod>? prePeriods)  $default,) {final _that = this;
switch (_that) {
case _StationSearchInfo():
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  JmaIntensity? intensity,  JmaLpgmIntensity? lpgmIntensity,  double? sva,  List<PrePeriod>? prePeriods)?  $default,) {final _that = this;
switch (_that) {
case _StationSearchInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StationSearchInfo implements StationSearchInfo {
  const _StationSearchInfo({required this.code, required this.name, required this.intensity, required this.lpgmIntensity, required this.sva, required final  List<PrePeriod>? prePeriods}): _prePeriods = prePeriods;
  factory _StationSearchInfo.fromJson(Map<String, dynamic> json) => _$StationSearchInfoFromJson(json);

@override final  String code;
@override final  String name;
@override final  JmaIntensity? intensity;
@override final  JmaLpgmIntensity? lpgmIntensity;
@override final  double? sva;
 final  List<PrePeriod>? _prePeriods;
@override List<PrePeriod>? get prePeriods {
  final value = _prePeriods;
  if (value == null) return null;
  if (_prePeriods is EqualUnmodifiableListView) return _prePeriods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of StationSearchInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationSearchInfoCopyWith<_StationSearchInfo> get copyWith => __$StationSearchInfoCopyWithImpl<_StationSearchInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StationSearchInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationSearchInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other._prePeriods, _prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity,sva,const DeepCollectionEquality().hash(_prePeriods));

@override
String toString() {
  return 'StationSearchInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class _$StationSearchInfoCopyWith<$Res> implements $StationSearchInfoCopyWith<$Res> {
  factory _$StationSearchInfoCopyWith(_StationSearchInfo value, $Res Function(_StationSearchInfo) _then) = __$StationSearchInfoCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, JmaIntensity? intensity, JmaLpgmIntensity? lpgmIntensity, double? sva, List<PrePeriod>? prePeriods
});




}
/// @nodoc
class __$StationSearchInfoCopyWithImpl<$Res>
    implements _$StationSearchInfoCopyWith<$Res> {
  __$StationSearchInfoCopyWithImpl(this._self, this._then);

  final _StationSearchInfo _self;
  final $Res Function(_StationSearchInfo) _then;

/// Create a copy of StationSearchInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_StationSearchInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double?,prePeriods: freezed == prePeriods ? _self._prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriod>?,
  ));
}


}

// dart format on
