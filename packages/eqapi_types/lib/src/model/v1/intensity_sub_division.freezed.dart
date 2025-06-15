// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_sub_division.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensitySubDivision {

 int get id; int get eventId; String get areaCode; JmaIntensity get maxIntensity; JmaLgIntensity? get maxLpgmIntensity;
/// Create a copy of IntensitySubDivision
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensitySubDivisionCopyWith<IntensitySubDivision> get copyWith => _$IntensitySubDivisionCopyWithImpl<IntensitySubDivision>(this as IntensitySubDivision, _$identity);

  /// Serializes this IntensitySubDivision to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensitySubDivision&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.areaCode, areaCode) || other.areaCode == areaCode)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,areaCode,maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'IntensitySubDivision(id: $id, eventId: $eventId, areaCode: $areaCode, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensitySubDivisionCopyWith<$Res>  {
  factory $IntensitySubDivisionCopyWith(IntensitySubDivision value, $Res Function(IntensitySubDivision) _then) = _$IntensitySubDivisionCopyWithImpl;
@useResult
$Res call({
 int id, int eventId, String areaCode, JmaIntensity maxIntensity, JmaLgIntensity? maxLpgmIntensity
});




}
/// @nodoc
class _$IntensitySubDivisionCopyWithImpl<$Res>
    implements $IntensitySubDivisionCopyWith<$Res> {
  _$IntensitySubDivisionCopyWithImpl(this._self, this._then);

  final IntensitySubDivision _self;
  final $Res Function(IntensitySubDivision) _then;

/// Create a copy of IntensitySubDivision
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? areaCode = null,Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,areaCode: null == areaCode ? _self.areaCode : areaCode // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLgIntensity?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _IntensitySubDivision implements IntensitySubDivision {
  const _IntensitySubDivision({required this.id, required this.eventId, required this.areaCode, required this.maxIntensity, required this.maxLpgmIntensity});
  factory _IntensitySubDivision.fromJson(Map<String, dynamic> json) => _$IntensitySubDivisionFromJson(json);

@override final  int id;
@override final  int eventId;
@override final  String areaCode;
@override final  JmaIntensity maxIntensity;
@override final  JmaLgIntensity? maxLpgmIntensity;

/// Create a copy of IntensitySubDivision
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensitySubDivisionCopyWith<_IntensitySubDivision> get copyWith => __$IntensitySubDivisionCopyWithImpl<_IntensitySubDivision>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensitySubDivisionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensitySubDivision&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.areaCode, areaCode) || other.areaCode == areaCode)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,areaCode,maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'IntensitySubDivision(id: $id, eventId: $eventId, areaCode: $areaCode, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensitySubDivisionCopyWith<$Res> implements $IntensitySubDivisionCopyWith<$Res> {
  factory _$IntensitySubDivisionCopyWith(_IntensitySubDivision value, $Res Function(_IntensitySubDivision) _then) = __$IntensitySubDivisionCopyWithImpl;
@override @useResult
$Res call({
 int id, int eventId, String areaCode, JmaIntensity maxIntensity, JmaLgIntensity? maxLpgmIntensity
});




}
/// @nodoc
class __$IntensitySubDivisionCopyWithImpl<$Res>
    implements _$IntensitySubDivisionCopyWith<$Res> {
  __$IntensitySubDivisionCopyWithImpl(this._self, this._then);

  final _IntensitySubDivision _self;
  final $Res Function(_IntensitySubDivision) _then;

/// Create a copy of IntensitySubDivision
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? areaCode = null,Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,}) {
  return _then(_IntensitySubDivision(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,areaCode: null == areaCode ? _self.areaCode : areaCode // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLgIntensity?,
  ));
}


}

// dart format on
