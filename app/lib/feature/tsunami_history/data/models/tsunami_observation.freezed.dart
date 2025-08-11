// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_observation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiObservation {

 List<TsunamiObservationStation> get stations; String? get code; String? get name;
/// Create a copy of TsunamiObservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiObservationCopyWith<TsunamiObservation> get copyWith => _$TsunamiObservationCopyWithImpl<TsunamiObservation>(this as TsunamiObservation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiObservation&&const DeepCollectionEquality().equals(other.stations, stations)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(stations),code,name);

@override
String toString() {
  return 'TsunamiObservation(stations: $stations, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $TsunamiObservationCopyWith<$Res>  {
  factory $TsunamiObservationCopyWith(TsunamiObservation value, $Res Function(TsunamiObservation) _then) = _$TsunamiObservationCopyWithImpl;
@useResult
$Res call({
 List<TsunamiObservationStation> stations, String? code, String? name
});




}
/// @nodoc
class _$TsunamiObservationCopyWithImpl<$Res>
    implements $TsunamiObservationCopyWith<$Res> {
  _$TsunamiObservationCopyWithImpl(this._self, this._then);

  final TsunamiObservation _self;
  final $Res Function(TsunamiObservation) _then;

/// Create a copy of TsunamiObservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stations = null,Object? code = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservationStation>,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _TsunamiObservation implements TsunamiObservation {
  const _TsunamiObservation({required final  List<TsunamiObservationStation> stations, this.code, this.name}): _stations = stations;
  

 final  List<TsunamiObservationStation> _stations;
@override List<TsunamiObservationStation> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}

@override final  String? code;
@override final  String? name;

/// Create a copy of TsunamiObservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiObservationCopyWith<_TsunamiObservation> get copyWith => __$TsunamiObservationCopyWithImpl<_TsunamiObservation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiObservation&&const DeepCollectionEquality().equals(other._stations, _stations)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stations),code,name);

@override
String toString() {
  return 'TsunamiObservation(stations: $stations, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$TsunamiObservationCopyWith<$Res> implements $TsunamiObservationCopyWith<$Res> {
  factory _$TsunamiObservationCopyWith(_TsunamiObservation value, $Res Function(_TsunamiObservation) _then) = __$TsunamiObservationCopyWithImpl;
@override @useResult
$Res call({
 List<TsunamiObservationStation> stations, String? code, String? name
});




}
/// @nodoc
class __$TsunamiObservationCopyWithImpl<$Res>
    implements _$TsunamiObservationCopyWith<$Res> {
  __$TsunamiObservationCopyWithImpl(this._self, this._then);

  final _TsunamiObservation _self;
  final $Res Function(_TsunamiObservation) _then;

/// Create a copy of TsunamiObservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stations = null,Object? code = freezed,Object? name = freezed,}) {
  return _then(_TsunamiObservation(
stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservationStation>,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TsunamiObservationStation {

 String get code; String get name; TsunamiStationFirstHeight? get firstHeight; TsunamiStationMaxHeight? get maxHeight; String? get condition;
/// Create a copy of TsunamiObservationStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiObservationStationCopyWith<TsunamiObservationStation> get copyWith => _$TsunamiObservationStationCopyWithImpl<TsunamiObservationStation>(this as TsunamiObservationStation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiObservationStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&(identical(other.condition, condition) || other.condition == condition));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,firstHeight,maxHeight,condition);

@override
String toString() {
  return 'TsunamiObservationStation(code: $code, name: $name, firstHeight: $firstHeight, maxHeight: $maxHeight, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $TsunamiObservationStationCopyWith<$Res>  {
  factory $TsunamiObservationStationCopyWith(TsunamiObservationStation value, $Res Function(TsunamiObservationStation) _then) = _$TsunamiObservationStationCopyWithImpl;
@useResult
$Res call({
 String code, String name, TsunamiStationFirstHeight? firstHeight, TsunamiStationMaxHeight? maxHeight, String? condition
});


$TsunamiStationFirstHeightCopyWith<$Res>? get firstHeight;$TsunamiStationMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class _$TsunamiObservationStationCopyWithImpl<$Res>
    implements $TsunamiObservationStationCopyWith<$Res> {
  _$TsunamiObservationStationCopyWithImpl(this._self, this._then);

  final TsunamiObservationStation _self;
  final $Res Function(TsunamiObservationStation) _then;

/// Create a copy of TsunamiObservationStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? firstHeight = freezed,Object? maxHeight = freezed,Object? condition = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationMaxHeight?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TsunamiObservationStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiStationFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiObservationStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiStationMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// @nodoc


class _TsunamiObservationStation implements TsunamiObservationStation {
  const _TsunamiObservationStation({required this.code, required this.name, this.firstHeight, this.maxHeight, this.condition});
  

@override final  String code;
@override final  String name;
@override final  TsunamiStationFirstHeight? firstHeight;
@override final  TsunamiStationMaxHeight? maxHeight;
@override final  String? condition;

/// Create a copy of TsunamiObservationStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiObservationStationCopyWith<_TsunamiObservationStation> get copyWith => __$TsunamiObservationStationCopyWithImpl<_TsunamiObservationStation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiObservationStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&(identical(other.condition, condition) || other.condition == condition));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,firstHeight,maxHeight,condition);

@override
String toString() {
  return 'TsunamiObservationStation(code: $code, name: $name, firstHeight: $firstHeight, maxHeight: $maxHeight, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$TsunamiObservationStationCopyWith<$Res> implements $TsunamiObservationStationCopyWith<$Res> {
  factory _$TsunamiObservationStationCopyWith(_TsunamiObservationStation value, $Res Function(_TsunamiObservationStation) _then) = __$TsunamiObservationStationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, TsunamiStationFirstHeight? firstHeight, TsunamiStationMaxHeight? maxHeight, String? condition
});


@override $TsunamiStationFirstHeightCopyWith<$Res>? get firstHeight;@override $TsunamiStationMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class __$TsunamiObservationStationCopyWithImpl<$Res>
    implements _$TsunamiObservationStationCopyWith<$Res> {
  __$TsunamiObservationStationCopyWithImpl(this._self, this._then);

  final _TsunamiObservationStation _self;
  final $Res Function(_TsunamiObservationStation) _then;

/// Create a copy of TsunamiObservationStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? firstHeight = freezed,Object? maxHeight = freezed,Object? condition = freezed,}) {
  return _then(_TsunamiObservationStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationMaxHeight?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TsunamiObservationStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiStationFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiObservationStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiStationMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}

/// @nodoc
mixin _$TsunamiStationFirstHeight {

 DateTime? get arrivalTime; String? get initial; String? get condition;
/// Create a copy of TsunamiStationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationFirstHeightCopyWith<TsunamiStationFirstHeight> get copyWith => _$TsunamiStationFirstHeightCopyWithImpl<TsunamiStationFirstHeight>(this as TsunamiStationFirstHeight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStationFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.condition, condition) || other.condition == condition));
}


@override
int get hashCode => Object.hash(runtimeType,arrivalTime,initial,condition);

@override
String toString() {
  return 'TsunamiStationFirstHeight(arrivalTime: $arrivalTime, initial: $initial, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationFirstHeightCopyWith<$Res>  {
  factory $TsunamiStationFirstHeightCopyWith(TsunamiStationFirstHeight value, $Res Function(TsunamiStationFirstHeight) _then) = _$TsunamiStationFirstHeightCopyWithImpl;
@useResult
$Res call({
 DateTime? arrivalTime, String? initial, String? condition
});




}
/// @nodoc
class _$TsunamiStationFirstHeightCopyWithImpl<$Res>
    implements $TsunamiStationFirstHeightCopyWith<$Res> {
  _$TsunamiStationFirstHeightCopyWithImpl(this._self, this._then);

  final TsunamiStationFirstHeight _self;
  final $Res Function(TsunamiStationFirstHeight) _then;

/// Create a copy of TsunamiStationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = freezed,Object? initial = freezed,Object? condition = freezed,}) {
  return _then(_self.copyWith(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,initial: freezed == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as String?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _TsunamiStationFirstHeight implements TsunamiStationFirstHeight {
  const _TsunamiStationFirstHeight({this.arrivalTime, this.initial, this.condition});
  

@override final  DateTime? arrivalTime;
@override final  String? initial;
@override final  String? condition;

/// Create a copy of TsunamiStationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationFirstHeightCopyWith<_TsunamiStationFirstHeight> get copyWith => __$TsunamiStationFirstHeightCopyWithImpl<_TsunamiStationFirstHeight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStationFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.condition, condition) || other.condition == condition));
}


@override
int get hashCode => Object.hash(runtimeType,arrivalTime,initial,condition);

@override
String toString() {
  return 'TsunamiStationFirstHeight(arrivalTime: $arrivalTime, initial: $initial, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationFirstHeightCopyWith<$Res> implements $TsunamiStationFirstHeightCopyWith<$Res> {
  factory _$TsunamiStationFirstHeightCopyWith(_TsunamiStationFirstHeight value, $Res Function(_TsunamiStationFirstHeight) _then) = __$TsunamiStationFirstHeightCopyWithImpl;
@override @useResult
$Res call({
 DateTime? arrivalTime, String? initial, String? condition
});




}
/// @nodoc
class __$TsunamiStationFirstHeightCopyWithImpl<$Res>
    implements _$TsunamiStationFirstHeightCopyWith<$Res> {
  __$TsunamiStationFirstHeightCopyWithImpl(this._self, this._then);

  final _TsunamiStationFirstHeight _self;
  final $Res Function(_TsunamiStationFirstHeight) _then;

/// Create a copy of TsunamiStationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = freezed,Object? initial = freezed,Object? condition = freezed,}) {
  return _then(_TsunamiStationFirstHeight(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,initial: freezed == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as String?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TsunamiStationMaxHeight {

 DateTime? get dateTime; double? get value; bool? get isOver; bool? get isRising; String? get condition; String? get revise;
/// Create a copy of TsunamiStationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationMaxHeightCopyWith<TsunamiStationMaxHeight> get copyWith => _$TsunamiStationMaxHeightCopyWithImpl<TsunamiStationMaxHeight>(this as TsunamiStationMaxHeight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStationMaxHeight&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.isRising, isRising) || other.isRising == isRising)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.revise, revise) || other.revise == revise));
}


@override
int get hashCode => Object.hash(runtimeType,dateTime,value,isOver,isRising,condition,revise);

@override
String toString() {
  return 'TsunamiStationMaxHeight(dateTime: $dateTime, value: $value, isOver: $isOver, isRising: $isRising, condition: $condition, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationMaxHeightCopyWith<$Res>  {
  factory $TsunamiStationMaxHeightCopyWith(TsunamiStationMaxHeight value, $Res Function(TsunamiStationMaxHeight) _then) = _$TsunamiStationMaxHeightCopyWithImpl;
@useResult
$Res call({
 DateTime? dateTime, double? value, bool? isOver, bool? isRising, String? condition, String? revise
});




}
/// @nodoc
class _$TsunamiStationMaxHeightCopyWithImpl<$Res>
    implements $TsunamiStationMaxHeightCopyWith<$Res> {
  _$TsunamiStationMaxHeightCopyWithImpl(this._self, this._then);

  final TsunamiStationMaxHeight _self;
  final $Res Function(TsunamiStationMaxHeight) _then;

/// Create a copy of TsunamiStationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateTime = freezed,Object? value = freezed,Object? isOver = freezed,Object? isRising = freezed,Object? condition = freezed,Object? revise = freezed,}) {
  return _then(_self.copyWith(
dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,isRising: freezed == isRising ? _self.isRising : isRising // ignore: cast_nullable_to_non_nullable
as bool?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _TsunamiStationMaxHeight extends TsunamiStationMaxHeight {
  const _TsunamiStationMaxHeight({this.dateTime, this.value, this.isOver, this.isRising, this.condition, this.revise}): super._();
  

@override final  DateTime? dateTime;
@override final  double? value;
@override final  bool? isOver;
@override final  bool? isRising;
@override final  String? condition;
@override final  String? revise;

/// Create a copy of TsunamiStationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationMaxHeightCopyWith<_TsunamiStationMaxHeight> get copyWith => __$TsunamiStationMaxHeightCopyWithImpl<_TsunamiStationMaxHeight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStationMaxHeight&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.isRising, isRising) || other.isRising == isRising)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.revise, revise) || other.revise == revise));
}


@override
int get hashCode => Object.hash(runtimeType,dateTime,value,isOver,isRising,condition,revise);

@override
String toString() {
  return 'TsunamiStationMaxHeight(dateTime: $dateTime, value: $value, isOver: $isOver, isRising: $isRising, condition: $condition, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationMaxHeightCopyWith<$Res> implements $TsunamiStationMaxHeightCopyWith<$Res> {
  factory _$TsunamiStationMaxHeightCopyWith(_TsunamiStationMaxHeight value, $Res Function(_TsunamiStationMaxHeight) _then) = __$TsunamiStationMaxHeightCopyWithImpl;
@override @useResult
$Res call({
 DateTime? dateTime, double? value, bool? isOver, bool? isRising, String? condition, String? revise
});




}
/// @nodoc
class __$TsunamiStationMaxHeightCopyWithImpl<$Res>
    implements _$TsunamiStationMaxHeightCopyWith<$Res> {
  __$TsunamiStationMaxHeightCopyWithImpl(this._self, this._then);

  final _TsunamiStationMaxHeight _self;
  final $Res Function(_TsunamiStationMaxHeight) _then;

/// Create a copy of TsunamiStationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateTime = freezed,Object? value = freezed,Object? isOver = freezed,Object? isRising = freezed,Object? condition = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiStationMaxHeight(
dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,isRising: freezed == isRising ? _self.isRising : isRising // ignore: cast_nullable_to_non_nullable
as bool?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TsunamiObservationInfo {

 List<TsunamiObservation>? get observations; List<TsunamiEstimation>? get estimations; String? get text; TsunamiComments? get comments;
/// Create a copy of TsunamiObservationInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiObservationInfoCopyWith<TsunamiObservationInfo> get copyWith => _$TsunamiObservationInfoCopyWithImpl<TsunamiObservationInfo>(this as TsunamiObservationInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiObservationInfo&&const DeepCollectionEquality().equals(other.observations, observations)&&const DeepCollectionEquality().equals(other.estimations, estimations)&&(identical(other.text, text) || other.text == text)&&(identical(other.comments, comments) || other.comments == comments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(observations),const DeepCollectionEquality().hash(estimations),text,comments);

@override
String toString() {
  return 'TsunamiObservationInfo(observations: $observations, estimations: $estimations, text: $text, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $TsunamiObservationInfoCopyWith<$Res>  {
  factory $TsunamiObservationInfoCopyWith(TsunamiObservationInfo value, $Res Function(TsunamiObservationInfo) _then) = _$TsunamiObservationInfoCopyWithImpl;
@useResult
$Res call({
 List<TsunamiObservation>? observations, List<TsunamiEstimation>? estimations, String? text, TsunamiComments? comments
});


$TsunamiCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$TsunamiObservationInfoCopyWithImpl<$Res>
    implements $TsunamiObservationInfoCopyWith<$Res> {
  _$TsunamiObservationInfoCopyWithImpl(this._self, this._then);

  final TsunamiObservationInfo _self;
  final $Res Function(TsunamiObservationInfo) _then;

/// Create a copy of TsunamiObservationInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? observations = freezed,Object? estimations = freezed,Object? text = freezed,Object? comments = freezed,}) {
  return _then(_self.copyWith(
observations: freezed == observations ? _self.observations : observations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservation>?,estimations: freezed == estimations ? _self.estimations : estimations // ignore: cast_nullable_to_non_nullable
as List<TsunamiEstimation>?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TsunamiComments?,
  ));
}
/// Create a copy of TsunamiObservationInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TsunamiCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}


/// @nodoc


class _TsunamiObservationInfo implements TsunamiObservationInfo {
  const _TsunamiObservationInfo({final  List<TsunamiObservation>? observations, final  List<TsunamiEstimation>? estimations, this.text, this.comments}): _observations = observations,_estimations = estimations;
  

 final  List<TsunamiObservation>? _observations;
@override List<TsunamiObservation>? get observations {
  final value = _observations;
  if (value == null) return null;
  if (_observations is EqualUnmodifiableListView) return _observations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TsunamiEstimation>? _estimations;
@override List<TsunamiEstimation>? get estimations {
  final value = _estimations;
  if (value == null) return null;
  if (_estimations is EqualUnmodifiableListView) return _estimations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? text;
@override final  TsunamiComments? comments;

/// Create a copy of TsunamiObservationInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiObservationInfoCopyWith<_TsunamiObservationInfo> get copyWith => __$TsunamiObservationInfoCopyWithImpl<_TsunamiObservationInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiObservationInfo&&const DeepCollectionEquality().equals(other._observations, _observations)&&const DeepCollectionEquality().equals(other._estimations, _estimations)&&(identical(other.text, text) || other.text == text)&&(identical(other.comments, comments) || other.comments == comments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_observations),const DeepCollectionEquality().hash(_estimations),text,comments);

@override
String toString() {
  return 'TsunamiObservationInfo(observations: $observations, estimations: $estimations, text: $text, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$TsunamiObservationInfoCopyWith<$Res> implements $TsunamiObservationInfoCopyWith<$Res> {
  factory _$TsunamiObservationInfoCopyWith(_TsunamiObservationInfo value, $Res Function(_TsunamiObservationInfo) _then) = __$TsunamiObservationInfoCopyWithImpl;
@override @useResult
$Res call({
 List<TsunamiObservation>? observations, List<TsunamiEstimation>? estimations, String? text, TsunamiComments? comments
});


@override $TsunamiCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class __$TsunamiObservationInfoCopyWithImpl<$Res>
    implements _$TsunamiObservationInfoCopyWith<$Res> {
  __$TsunamiObservationInfoCopyWithImpl(this._self, this._then);

  final _TsunamiObservationInfo _self;
  final $Res Function(_TsunamiObservationInfo) _then;

/// Create a copy of TsunamiObservationInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? observations = freezed,Object? estimations = freezed,Object? text = freezed,Object? comments = freezed,}) {
  return _then(_TsunamiObservationInfo(
observations: freezed == observations ? _self._observations : observations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservation>?,estimations: freezed == estimations ? _self._estimations : estimations // ignore: cast_nullable_to_non_nullable
as List<TsunamiEstimation>?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TsunamiComments?,
  ));
}

/// Create a copy of TsunamiObservationInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TsunamiCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

/// @nodoc
mixin _$TsunamiEstimation {

 String get code; String get name; TsunamiHeight? get firstHeight; TsunamiHeight? get maxHeight; String? get revise;
/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiEstimationCopyWith<TsunamiEstimation> get copyWith => _$TsunamiEstimationCopyWithImpl<TsunamiEstimation>(this as TsunamiEstimation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiEstimation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&(identical(other.revise, revise) || other.revise == revise));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,firstHeight,maxHeight,revise);

@override
String toString() {
  return 'TsunamiEstimation(code: $code, name: $name, firstHeight: $firstHeight, maxHeight: $maxHeight, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiEstimationCopyWith<$Res>  {
  factory $TsunamiEstimationCopyWith(TsunamiEstimation value, $Res Function(TsunamiEstimation) _then) = _$TsunamiEstimationCopyWithImpl;
@useResult
$Res call({
 String code, String name, TsunamiHeight? firstHeight, TsunamiHeight? maxHeight, String? revise
});


$TsunamiHeightCopyWith<$Res>? get firstHeight;$TsunamiHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class _$TsunamiEstimationCopyWithImpl<$Res>
    implements $TsunamiEstimationCopyWith<$Res> {
  _$TsunamiEstimationCopyWithImpl(this._self, this._then);

  final TsunamiEstimation _self;
  final $Res Function(TsunamiEstimation) _then;

/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? firstHeight = freezed,Object? maxHeight = freezed,Object? revise = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiHeight?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// @nodoc


class _TsunamiEstimation implements TsunamiEstimation {
  const _TsunamiEstimation({required this.code, required this.name, this.firstHeight, this.maxHeight, this.revise});
  

@override final  String code;
@override final  String name;
@override final  TsunamiHeight? firstHeight;
@override final  TsunamiHeight? maxHeight;
@override final  String? revise;

/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiEstimationCopyWith<_TsunamiEstimation> get copyWith => __$TsunamiEstimationCopyWithImpl<_TsunamiEstimation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiEstimation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&(identical(other.revise, revise) || other.revise == revise));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,firstHeight,maxHeight,revise);

@override
String toString() {
  return 'TsunamiEstimation(code: $code, name: $name, firstHeight: $firstHeight, maxHeight: $maxHeight, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiEstimationCopyWith<$Res> implements $TsunamiEstimationCopyWith<$Res> {
  factory _$TsunamiEstimationCopyWith(_TsunamiEstimation value, $Res Function(_TsunamiEstimation) _then) = __$TsunamiEstimationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, TsunamiHeight? firstHeight, TsunamiHeight? maxHeight, String? revise
});


@override $TsunamiHeightCopyWith<$Res>? get firstHeight;@override $TsunamiHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class __$TsunamiEstimationCopyWithImpl<$Res>
    implements _$TsunamiEstimationCopyWith<$Res> {
  __$TsunamiEstimationCopyWithImpl(this._self, this._then);

  final _TsunamiEstimation _self;
  final $Res Function(_TsunamiEstimation) _then;

/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? firstHeight = freezed,Object? maxHeight = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiEstimation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiHeight?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}

// dart format on
