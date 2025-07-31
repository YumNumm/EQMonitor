// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiHeight {

/// 定量表現（メートル）
 double? get value;/// 以上フラグ
 bool? get isOver;/// 定性表現（「高い」「巨大」など）
 String? get condition;/// 到達時刻
 DateTime? get arrivalTime;/// 状況（「津波到達中と推測」など）
 String? get situation;
/// Create a copy of TsunamiHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiHeightCopyWith<TsunamiHeight> get copyWith => _$TsunamiHeightCopyWithImpl<TsunamiHeight>(this as TsunamiHeight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiHeight&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.situation, situation) || other.situation == situation));
}


@override
int get hashCode => Object.hash(runtimeType,value,isOver,condition,arrivalTime,situation);

@override
String toString() {
  return 'TsunamiHeight(value: $value, isOver: $isOver, condition: $condition, arrivalTime: $arrivalTime, situation: $situation)';
}


}

/// @nodoc
abstract mixin class $TsunamiHeightCopyWith<$Res>  {
  factory $TsunamiHeightCopyWith(TsunamiHeight value, $Res Function(TsunamiHeight) _then) = _$TsunamiHeightCopyWithImpl;
@useResult
$Res call({
 double? value, bool? isOver, String? condition, DateTime? arrivalTime, String? situation
});




}
/// @nodoc
class _$TsunamiHeightCopyWithImpl<$Res>
    implements $TsunamiHeightCopyWith<$Res> {
  _$TsunamiHeightCopyWithImpl(this._self, this._then);

  final TsunamiHeight _self;
  final $Res Function(TsunamiHeight) _then;

/// Create a copy of TsunamiHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,Object? isOver = freezed,Object? condition = freezed,Object? arrivalTime = freezed,Object? situation = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,situation: freezed == situation ? _self.situation : situation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _TsunamiHeight extends TsunamiHeight {
  const _TsunamiHeight({this.value, this.isOver, this.condition, this.arrivalTime, this.situation}): super._();
  

/// 定量表現（メートル）
@override final  double? value;
/// 以上フラグ
@override final  bool? isOver;
/// 定性表現（「高い」「巨大」など）
@override final  String? condition;
/// 到達時刻
@override final  DateTime? arrivalTime;
/// 状況（「津波到達中と推測」など）
@override final  String? situation;

/// Create a copy of TsunamiHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiHeightCopyWith<_TsunamiHeight> get copyWith => __$TsunamiHeightCopyWithImpl<_TsunamiHeight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiHeight&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.situation, situation) || other.situation == situation));
}


@override
int get hashCode => Object.hash(runtimeType,value,isOver,condition,arrivalTime,situation);

@override
String toString() {
  return 'TsunamiHeight(value: $value, isOver: $isOver, condition: $condition, arrivalTime: $arrivalTime, situation: $situation)';
}


}

/// @nodoc
abstract mixin class _$TsunamiHeightCopyWith<$Res> implements $TsunamiHeightCopyWith<$Res> {
  factory _$TsunamiHeightCopyWith(_TsunamiHeight value, $Res Function(_TsunamiHeight) _then) = __$TsunamiHeightCopyWithImpl;
@override @useResult
$Res call({
 double? value, bool? isOver, String? condition, DateTime? arrivalTime, String? situation
});




}
/// @nodoc
class __$TsunamiHeightCopyWithImpl<$Res>
    implements _$TsunamiHeightCopyWith<$Res> {
  __$TsunamiHeightCopyWithImpl(this._self, this._then);

  final _TsunamiHeight _self;
  final $Res Function(_TsunamiHeight) _then;

/// Create a copy of TsunamiHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,Object? isOver = freezed,Object? condition = freezed,Object? arrivalTime = freezed,Object? situation = freezed,}) {
  return _then(_TsunamiHeight(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,situation: freezed == situation ? _self.situation : situation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
