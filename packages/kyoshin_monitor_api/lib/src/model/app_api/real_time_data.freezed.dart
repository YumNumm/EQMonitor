// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'real_time_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealTimeData {

 DateTime? get dateTime; String? get packetType; String? get kyoshinType; String? get baseData; String? get baseSerialNo; List<double?>? get items; Result? get result; Security? get security;
/// Create a copy of RealTimeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealTimeDataCopyWith<RealTimeData> get copyWith => _$RealTimeDataCopyWithImpl<RealTimeData>(this as RealTimeData, _$identity);

  /// Serializes this RealTimeData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealTimeData&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.packetType, packetType) || other.packetType == packetType)&&(identical(other.kyoshinType, kyoshinType) || other.kyoshinType == kyoshinType)&&(identical(other.baseData, baseData) || other.baseData == baseData)&&(identical(other.baseSerialNo, baseSerialNo) || other.baseSerialNo == baseSerialNo)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.result, result) || other.result == result)&&(identical(other.security, security) || other.security == security));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateTime,packetType,kyoshinType,baseData,baseSerialNo,const DeepCollectionEquality().hash(items),result,security);

@override
String toString() {
  return 'RealTimeData(dateTime: $dateTime, packetType: $packetType, kyoshinType: $kyoshinType, baseData: $baseData, baseSerialNo: $baseSerialNo, items: $items, result: $result, security: $security)';
}


}

/// @nodoc
abstract mixin class $RealTimeDataCopyWith<$Res>  {
  factory $RealTimeDataCopyWith(RealTimeData value, $Res Function(RealTimeData) _then) = _$RealTimeDataCopyWithImpl;
@useResult
$Res call({
 DateTime? dateTime, String? packetType, String? kyoshinType, String? baseData, String? baseSerialNo, List<double?>? items, Result? result, Security? security
});


$ResultCopyWith<$Res>? get result;$SecurityCopyWith<$Res>? get security;

}
/// @nodoc
class _$RealTimeDataCopyWithImpl<$Res>
    implements $RealTimeDataCopyWith<$Res> {
  _$RealTimeDataCopyWithImpl(this._self, this._then);

  final RealTimeData _self;
  final $Res Function(RealTimeData) _then;

/// Create a copy of RealTimeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateTime = freezed,Object? packetType = freezed,Object? kyoshinType = freezed,Object? baseData = freezed,Object? baseSerialNo = freezed,Object? items = freezed,Object? result = freezed,Object? security = freezed,}) {
  return _then(_self.copyWith(
dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,packetType: freezed == packetType ? _self.packetType : packetType // ignore: cast_nullable_to_non_nullable
as String?,kyoshinType: freezed == kyoshinType ? _self.kyoshinType : kyoshinType // ignore: cast_nullable_to_non_nullable
as String?,baseData: freezed == baseData ? _self.baseData : baseData // ignore: cast_nullable_to_non_nullable
as String?,baseSerialNo: freezed == baseSerialNo ? _self.baseSerialNo : baseSerialNo // ignore: cast_nullable_to_non_nullable
as String?,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<double?>?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result?,security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as Security?,
  ));
}
/// Create a copy of RealTimeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of RealTimeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityCopyWith<$Res>? get security {
    if (_self.security == null) {
    return null;
  }

  return $SecurityCopyWith<$Res>(_self.security!, (value) {
    return _then(_self.copyWith(security: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _RealTimeData implements RealTimeData {
  const _RealTimeData({required this.dateTime, required this.packetType, required this.kyoshinType, required this.baseData, required this.baseSerialNo, required final  List<double?>? items, required this.result, required this.security}): _items = items;
  factory _RealTimeData.fromJson(Map<String, dynamic> json) => _$RealTimeDataFromJson(json);

@override final  DateTime? dateTime;
@override final  String? packetType;
@override final  String? kyoshinType;
@override final  String? baseData;
@override final  String? baseSerialNo;
 final  List<double?>? _items;
@override List<double?>? get items {
  final value = _items;
  if (value == null) return null;
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Result? result;
@override final  Security? security;

/// Create a copy of RealTimeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealTimeDataCopyWith<_RealTimeData> get copyWith => __$RealTimeDataCopyWithImpl<_RealTimeData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealTimeDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealTimeData&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.packetType, packetType) || other.packetType == packetType)&&(identical(other.kyoshinType, kyoshinType) || other.kyoshinType == kyoshinType)&&(identical(other.baseData, baseData) || other.baseData == baseData)&&(identical(other.baseSerialNo, baseSerialNo) || other.baseSerialNo == baseSerialNo)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.result, result) || other.result == result)&&(identical(other.security, security) || other.security == security));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateTime,packetType,kyoshinType,baseData,baseSerialNo,const DeepCollectionEquality().hash(_items),result,security);

@override
String toString() {
  return 'RealTimeData(dateTime: $dateTime, packetType: $packetType, kyoshinType: $kyoshinType, baseData: $baseData, baseSerialNo: $baseSerialNo, items: $items, result: $result, security: $security)';
}


}

/// @nodoc
abstract mixin class _$RealTimeDataCopyWith<$Res> implements $RealTimeDataCopyWith<$Res> {
  factory _$RealTimeDataCopyWith(_RealTimeData value, $Res Function(_RealTimeData) _then) = __$RealTimeDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime? dateTime, String? packetType, String? kyoshinType, String? baseData, String? baseSerialNo, List<double?>? items, Result? result, Security? security
});


@override $ResultCopyWith<$Res>? get result;@override $SecurityCopyWith<$Res>? get security;

}
/// @nodoc
class __$RealTimeDataCopyWithImpl<$Res>
    implements _$RealTimeDataCopyWith<$Res> {
  __$RealTimeDataCopyWithImpl(this._self, this._then);

  final _RealTimeData _self;
  final $Res Function(_RealTimeData) _then;

/// Create a copy of RealTimeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateTime = freezed,Object? packetType = freezed,Object? kyoshinType = freezed,Object? baseData = freezed,Object? baseSerialNo = freezed,Object? items = freezed,Object? result = freezed,Object? security = freezed,}) {
  return _then(_RealTimeData(
dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,packetType: freezed == packetType ? _self.packetType : packetType // ignore: cast_nullable_to_non_nullable
as String?,kyoshinType: freezed == kyoshinType ? _self.kyoshinType : kyoshinType // ignore: cast_nullable_to_non_nullable
as String?,baseData: freezed == baseData ? _self.baseData : baseData // ignore: cast_nullable_to_non_nullable
as String?,baseSerialNo: freezed == baseSerialNo ? _self.baseSerialNo : baseSerialNo // ignore: cast_nullable_to_non_nullable
as String?,items: freezed == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<double?>?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result?,security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as Security?,
  ));
}

/// Create a copy of RealTimeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of RealTimeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityCopyWith<$Res>? get security {
    if (_self.security == null) {
    return null;
  }

  return $SecurityCopyWith<$Res>(_self.security!, (value) {
    return _then(_self.copyWith(security: value));
  });
}
}

// dart format on
