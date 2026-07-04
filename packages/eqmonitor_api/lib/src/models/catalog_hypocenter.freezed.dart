// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_hypocenter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogHypocenter {

/// 0が代表震源
 int get seq;@JsonKey(name: 'record_type') CatalogHypocenterRecordType get recordType;@JsonKey(includeIfNull: true, name: 'origin_time') DateTime? get originTime;@JsonKey(includeIfNull: true) num? get latitude;@JsonKey(includeIfNull: true) num? get longitude;@JsonKey(includeIfNull: true, name: 'depth_km') num? get depthKm;@JsonKey(name: 'depth_is_free') bool get depthIsFree;@JsonKey(includeIfNull: true) num? get magnitude1;@JsonKey(includeIfNull: true, name: 'magnitude1_type') String? get magnitude1Type;@JsonKey(includeIfNull: true) num? get magnitude2;@JsonKey(includeIfNull: true, name: 'magnitude2_type') String? get magnitude2Type;/// 歴史的階級(L/S/M/R/F/X)を含む生の震度階級コード
@JsonKey(includeIfNull: true, name: 'max_intensity_raw') String? get maxIntensityRaw;@JsonKey(includeIfNull: true, name: 'damage_scale') String? get damageScale;@JsonKey(includeIfNull: true, name: 'tsunami_scale') String? get tsunamiScale;@JsonKey(includeIfNull: true, name: 'determination_flag') String? get determinationFlag;
/// Create a copy of CatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogHypocenterCopyWith<CatalogHypocenter> get copyWith => _$CatalogHypocenterCopyWithImpl<CatalogHypocenter>(this as CatalogHypocenter, _$identity);

  /// Serializes this CatalogHypocenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogHypocenter&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.recordType, recordType) || other.recordType == recordType)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.depthIsFree, depthIsFree) || other.depthIsFree == depthIsFree)&&(identical(other.magnitude1, magnitude1) || other.magnitude1 == magnitude1)&&(identical(other.magnitude1Type, magnitude1Type) || other.magnitude1Type == magnitude1Type)&&(identical(other.magnitude2, magnitude2) || other.magnitude2 == magnitude2)&&(identical(other.magnitude2Type, magnitude2Type) || other.magnitude2Type == magnitude2Type)&&(identical(other.maxIntensityRaw, maxIntensityRaw) || other.maxIntensityRaw == maxIntensityRaw)&&(identical(other.damageScale, damageScale) || other.damageScale == damageScale)&&(identical(other.tsunamiScale, tsunamiScale) || other.tsunamiScale == tsunamiScale)&&(identical(other.determinationFlag, determinationFlag) || other.determinationFlag == determinationFlag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seq,recordType,originTime,latitude,longitude,depthKm,depthIsFree,magnitude1,magnitude1Type,magnitude2,magnitude2Type,maxIntensityRaw,damageScale,tsunamiScale,determinationFlag);

@override
String toString() {
  return 'CatalogHypocenter(seq: $seq, recordType: $recordType, originTime: $originTime, latitude: $latitude, longitude: $longitude, depthKm: $depthKm, depthIsFree: $depthIsFree, magnitude1: $magnitude1, magnitude1Type: $magnitude1Type, magnitude2: $magnitude2, magnitude2Type: $magnitude2Type, maxIntensityRaw: $maxIntensityRaw, damageScale: $damageScale, tsunamiScale: $tsunamiScale, determinationFlag: $determinationFlag)';
}


}

/// @nodoc
abstract mixin class $CatalogHypocenterCopyWith<$Res>  {
  factory $CatalogHypocenterCopyWith(CatalogHypocenter value, $Res Function(CatalogHypocenter) _then) = _$CatalogHypocenterCopyWithImpl;
@useResult
$Res call({
 int seq,@JsonKey(name: 'record_type') CatalogHypocenterRecordType recordType,@JsonKey(includeIfNull: true, name: 'origin_time') DateTime? originTime,@JsonKey(includeIfNull: true) num? latitude,@JsonKey(includeIfNull: true) num? longitude,@JsonKey(includeIfNull: true, name: 'depth_km') num? depthKm,@JsonKey(name: 'depth_is_free') bool depthIsFree,@JsonKey(includeIfNull: true) num? magnitude1,@JsonKey(includeIfNull: true, name: 'magnitude1_type') String? magnitude1Type,@JsonKey(includeIfNull: true) num? magnitude2,@JsonKey(includeIfNull: true, name: 'magnitude2_type') String? magnitude2Type,@JsonKey(includeIfNull: true, name: 'max_intensity_raw') String? maxIntensityRaw,@JsonKey(includeIfNull: true, name: 'damage_scale') String? damageScale,@JsonKey(includeIfNull: true, name: 'tsunami_scale') String? tsunamiScale,@JsonKey(includeIfNull: true, name: 'determination_flag') String? determinationFlag
});




}
/// @nodoc
class _$CatalogHypocenterCopyWithImpl<$Res>
    implements $CatalogHypocenterCopyWith<$Res> {
  _$CatalogHypocenterCopyWithImpl(this._self, this._then);

  final CatalogHypocenter _self;
  final $Res Function(CatalogHypocenter) _then;

/// Create a copy of CatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seq = null,Object? recordType = null,Object? originTime = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? depthKm = freezed,Object? depthIsFree = null,Object? magnitude1 = freezed,Object? magnitude1Type = freezed,Object? magnitude2 = freezed,Object? magnitude2Type = freezed,Object? maxIntensityRaw = freezed,Object? damageScale = freezed,Object? tsunamiScale = freezed,Object? determinationFlag = freezed,}) {
  return _then(_self.copyWith(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,recordType: null == recordType ? _self.recordType : recordType // ignore: cast_nullable_to_non_nullable
as CatalogHypocenterRecordType,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as num?,depthIsFree: null == depthIsFree ? _self.depthIsFree : depthIsFree // ignore: cast_nullable_to_non_nullable
as bool,magnitude1: freezed == magnitude1 ? _self.magnitude1 : magnitude1 // ignore: cast_nullable_to_non_nullable
as num?,magnitude1Type: freezed == magnitude1Type ? _self.magnitude1Type : magnitude1Type // ignore: cast_nullable_to_non_nullable
as String?,magnitude2: freezed == magnitude2 ? _self.magnitude2 : magnitude2 // ignore: cast_nullable_to_non_nullable
as num?,magnitude2Type: freezed == magnitude2Type ? _self.magnitude2Type : magnitude2Type // ignore: cast_nullable_to_non_nullable
as String?,maxIntensityRaw: freezed == maxIntensityRaw ? _self.maxIntensityRaw : maxIntensityRaw // ignore: cast_nullable_to_non_nullable
as String?,damageScale: freezed == damageScale ? _self.damageScale : damageScale // ignore: cast_nullable_to_non_nullable
as String?,tsunamiScale: freezed == tsunamiScale ? _self.tsunamiScale : tsunamiScale // ignore: cast_nullable_to_non_nullable
as String?,determinationFlag: freezed == determinationFlag ? _self.determinationFlag : determinationFlag // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogHypocenter].
extension CatalogHypocenterPatterns on CatalogHypocenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogHypocenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogHypocenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogHypocenter value)  $default,){
final _that = this;
switch (_that) {
case _CatalogHypocenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogHypocenter value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogHypocenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seq, @JsonKey(name: 'record_type')  CatalogHypocenterRecordType recordType, @JsonKey(includeIfNull: true, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: true)  num? latitude, @JsonKey(includeIfNull: true)  num? longitude, @JsonKey(includeIfNull: true, name: 'depth_km')  num? depthKm, @JsonKey(name: 'depth_is_free')  bool depthIsFree, @JsonKey(includeIfNull: true)  num? magnitude1, @JsonKey(includeIfNull: true, name: 'magnitude1_type')  String? magnitude1Type, @JsonKey(includeIfNull: true)  num? magnitude2, @JsonKey(includeIfNull: true, name: 'magnitude2_type')  String? magnitude2Type, @JsonKey(includeIfNull: true, name: 'max_intensity_raw')  String? maxIntensityRaw, @JsonKey(includeIfNull: true, name: 'damage_scale')  String? damageScale, @JsonKey(includeIfNull: true, name: 'tsunami_scale')  String? tsunamiScale, @JsonKey(includeIfNull: true, name: 'determination_flag')  String? determinationFlag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogHypocenter() when $default != null:
return $default(_that.seq,_that.recordType,_that.originTime,_that.latitude,_that.longitude,_that.depthKm,_that.depthIsFree,_that.magnitude1,_that.magnitude1Type,_that.magnitude2,_that.magnitude2Type,_that.maxIntensityRaw,_that.damageScale,_that.tsunamiScale,_that.determinationFlag);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seq, @JsonKey(name: 'record_type')  CatalogHypocenterRecordType recordType, @JsonKey(includeIfNull: true, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: true)  num? latitude, @JsonKey(includeIfNull: true)  num? longitude, @JsonKey(includeIfNull: true, name: 'depth_km')  num? depthKm, @JsonKey(name: 'depth_is_free')  bool depthIsFree, @JsonKey(includeIfNull: true)  num? magnitude1, @JsonKey(includeIfNull: true, name: 'magnitude1_type')  String? magnitude1Type, @JsonKey(includeIfNull: true)  num? magnitude2, @JsonKey(includeIfNull: true, name: 'magnitude2_type')  String? magnitude2Type, @JsonKey(includeIfNull: true, name: 'max_intensity_raw')  String? maxIntensityRaw, @JsonKey(includeIfNull: true, name: 'damage_scale')  String? damageScale, @JsonKey(includeIfNull: true, name: 'tsunami_scale')  String? tsunamiScale, @JsonKey(includeIfNull: true, name: 'determination_flag')  String? determinationFlag)  $default,) {final _that = this;
switch (_that) {
case _CatalogHypocenter():
return $default(_that.seq,_that.recordType,_that.originTime,_that.latitude,_that.longitude,_that.depthKm,_that.depthIsFree,_that.magnitude1,_that.magnitude1Type,_that.magnitude2,_that.magnitude2Type,_that.maxIntensityRaw,_that.damageScale,_that.tsunamiScale,_that.determinationFlag);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seq, @JsonKey(name: 'record_type')  CatalogHypocenterRecordType recordType, @JsonKey(includeIfNull: true, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: true)  num? latitude, @JsonKey(includeIfNull: true)  num? longitude, @JsonKey(includeIfNull: true, name: 'depth_km')  num? depthKm, @JsonKey(name: 'depth_is_free')  bool depthIsFree, @JsonKey(includeIfNull: true)  num? magnitude1, @JsonKey(includeIfNull: true, name: 'magnitude1_type')  String? magnitude1Type, @JsonKey(includeIfNull: true)  num? magnitude2, @JsonKey(includeIfNull: true, name: 'magnitude2_type')  String? magnitude2Type, @JsonKey(includeIfNull: true, name: 'max_intensity_raw')  String? maxIntensityRaw, @JsonKey(includeIfNull: true, name: 'damage_scale')  String? damageScale, @JsonKey(includeIfNull: true, name: 'tsunami_scale')  String? tsunamiScale, @JsonKey(includeIfNull: true, name: 'determination_flag')  String? determinationFlag)?  $default,) {final _that = this;
switch (_that) {
case _CatalogHypocenter() when $default != null:
return $default(_that.seq,_that.recordType,_that.originTime,_that.latitude,_that.longitude,_that.depthKm,_that.depthIsFree,_that.magnitude1,_that.magnitude1Type,_that.magnitude2,_that.magnitude2Type,_that.maxIntensityRaw,_that.damageScale,_that.tsunamiScale,_that.determinationFlag);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogHypocenter implements CatalogHypocenter {
  const _CatalogHypocenter({required this.seq, @JsonKey(name: 'record_type') required this.recordType, @JsonKey(includeIfNull: true, name: 'origin_time') required this.originTime, @JsonKey(includeIfNull: true) required this.latitude, @JsonKey(includeIfNull: true) required this.longitude, @JsonKey(includeIfNull: true, name: 'depth_km') required this.depthKm, @JsonKey(name: 'depth_is_free') required this.depthIsFree, @JsonKey(includeIfNull: true) required this.magnitude1, @JsonKey(includeIfNull: true, name: 'magnitude1_type') required this.magnitude1Type, @JsonKey(includeIfNull: true) required this.magnitude2, @JsonKey(includeIfNull: true, name: 'magnitude2_type') required this.magnitude2Type, @JsonKey(includeIfNull: true, name: 'max_intensity_raw') required this.maxIntensityRaw, @JsonKey(includeIfNull: true, name: 'damage_scale') required this.damageScale, @JsonKey(includeIfNull: true, name: 'tsunami_scale') required this.tsunamiScale, @JsonKey(includeIfNull: true, name: 'determination_flag') required this.determinationFlag});
  factory _CatalogHypocenter.fromJson(Map<String, dynamic> json) => _$CatalogHypocenterFromJson(json);

/// 0が代表震源
@override final  int seq;
@override@JsonKey(name: 'record_type') final  CatalogHypocenterRecordType recordType;
@override@JsonKey(includeIfNull: true, name: 'origin_time') final  DateTime? originTime;
@override@JsonKey(includeIfNull: true) final  num? latitude;
@override@JsonKey(includeIfNull: true) final  num? longitude;
@override@JsonKey(includeIfNull: true, name: 'depth_km') final  num? depthKm;
@override@JsonKey(name: 'depth_is_free') final  bool depthIsFree;
@override@JsonKey(includeIfNull: true) final  num? magnitude1;
@override@JsonKey(includeIfNull: true, name: 'magnitude1_type') final  String? magnitude1Type;
@override@JsonKey(includeIfNull: true) final  num? magnitude2;
@override@JsonKey(includeIfNull: true, name: 'magnitude2_type') final  String? magnitude2Type;
/// 歴史的階級(L/S/M/R/F/X)を含む生の震度階級コード
@override@JsonKey(includeIfNull: true, name: 'max_intensity_raw') final  String? maxIntensityRaw;
@override@JsonKey(includeIfNull: true, name: 'damage_scale') final  String? damageScale;
@override@JsonKey(includeIfNull: true, name: 'tsunami_scale') final  String? tsunamiScale;
@override@JsonKey(includeIfNull: true, name: 'determination_flag') final  String? determinationFlag;

/// Create a copy of CatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogHypocenterCopyWith<_CatalogHypocenter> get copyWith => __$CatalogHypocenterCopyWithImpl<_CatalogHypocenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogHypocenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogHypocenter&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.recordType, recordType) || other.recordType == recordType)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.depthIsFree, depthIsFree) || other.depthIsFree == depthIsFree)&&(identical(other.magnitude1, magnitude1) || other.magnitude1 == magnitude1)&&(identical(other.magnitude1Type, magnitude1Type) || other.magnitude1Type == magnitude1Type)&&(identical(other.magnitude2, magnitude2) || other.magnitude2 == magnitude2)&&(identical(other.magnitude2Type, magnitude2Type) || other.magnitude2Type == magnitude2Type)&&(identical(other.maxIntensityRaw, maxIntensityRaw) || other.maxIntensityRaw == maxIntensityRaw)&&(identical(other.damageScale, damageScale) || other.damageScale == damageScale)&&(identical(other.tsunamiScale, tsunamiScale) || other.tsunamiScale == tsunamiScale)&&(identical(other.determinationFlag, determinationFlag) || other.determinationFlag == determinationFlag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seq,recordType,originTime,latitude,longitude,depthKm,depthIsFree,magnitude1,magnitude1Type,magnitude2,magnitude2Type,maxIntensityRaw,damageScale,tsunamiScale,determinationFlag);

@override
String toString() {
  return 'CatalogHypocenter(seq: $seq, recordType: $recordType, originTime: $originTime, latitude: $latitude, longitude: $longitude, depthKm: $depthKm, depthIsFree: $depthIsFree, magnitude1: $magnitude1, magnitude1Type: $magnitude1Type, magnitude2: $magnitude2, magnitude2Type: $magnitude2Type, maxIntensityRaw: $maxIntensityRaw, damageScale: $damageScale, tsunamiScale: $tsunamiScale, determinationFlag: $determinationFlag)';
}


}

/// @nodoc
abstract mixin class _$CatalogHypocenterCopyWith<$Res> implements $CatalogHypocenterCopyWith<$Res> {
  factory _$CatalogHypocenterCopyWith(_CatalogHypocenter value, $Res Function(_CatalogHypocenter) _then) = __$CatalogHypocenterCopyWithImpl;
@override @useResult
$Res call({
 int seq,@JsonKey(name: 'record_type') CatalogHypocenterRecordType recordType,@JsonKey(includeIfNull: true, name: 'origin_time') DateTime? originTime,@JsonKey(includeIfNull: true) num? latitude,@JsonKey(includeIfNull: true) num? longitude,@JsonKey(includeIfNull: true, name: 'depth_km') num? depthKm,@JsonKey(name: 'depth_is_free') bool depthIsFree,@JsonKey(includeIfNull: true) num? magnitude1,@JsonKey(includeIfNull: true, name: 'magnitude1_type') String? magnitude1Type,@JsonKey(includeIfNull: true) num? magnitude2,@JsonKey(includeIfNull: true, name: 'magnitude2_type') String? magnitude2Type,@JsonKey(includeIfNull: true, name: 'max_intensity_raw') String? maxIntensityRaw,@JsonKey(includeIfNull: true, name: 'damage_scale') String? damageScale,@JsonKey(includeIfNull: true, name: 'tsunami_scale') String? tsunamiScale,@JsonKey(includeIfNull: true, name: 'determination_flag') String? determinationFlag
});




}
/// @nodoc
class __$CatalogHypocenterCopyWithImpl<$Res>
    implements _$CatalogHypocenterCopyWith<$Res> {
  __$CatalogHypocenterCopyWithImpl(this._self, this._then);

  final _CatalogHypocenter _self;
  final $Res Function(_CatalogHypocenter) _then;

/// Create a copy of CatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seq = null,Object? recordType = null,Object? originTime = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? depthKm = freezed,Object? depthIsFree = null,Object? magnitude1 = freezed,Object? magnitude1Type = freezed,Object? magnitude2 = freezed,Object? magnitude2Type = freezed,Object? maxIntensityRaw = freezed,Object? damageScale = freezed,Object? tsunamiScale = freezed,Object? determinationFlag = freezed,}) {
  return _then(_CatalogHypocenter(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,recordType: null == recordType ? _self.recordType : recordType // ignore: cast_nullable_to_non_nullable
as CatalogHypocenterRecordType,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as num?,depthIsFree: null == depthIsFree ? _self.depthIsFree : depthIsFree // ignore: cast_nullable_to_non_nullable
as bool,magnitude1: freezed == magnitude1 ? _self.magnitude1 : magnitude1 // ignore: cast_nullable_to_non_nullable
as num?,magnitude1Type: freezed == magnitude1Type ? _self.magnitude1Type : magnitude1Type // ignore: cast_nullable_to_non_nullable
as String?,magnitude2: freezed == magnitude2 ? _self.magnitude2 : magnitude2 // ignore: cast_nullable_to_non_nullable
as num?,magnitude2Type: freezed == magnitude2Type ? _self.magnitude2Type : magnitude2Type // ignore: cast_nullable_to_non_nullable
as String?,maxIntensityRaw: freezed == maxIntensityRaw ? _self.maxIntensityRaw : maxIntensityRaw // ignore: cast_nullable_to_non_nullable
as String?,damageScale: freezed == damageScale ? _self.damageScale : damageScale // ignore: cast_nullable_to_non_nullable
as String?,tsunamiScale: freezed == tsunamiScale ? _self.tsunamiScale : tsunamiScale // ignore: cast_nullable_to_non_nullable
as String?,determinationFlag: freezed == determinationFlag ? _self.determinationFlag : determinationFlag // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
